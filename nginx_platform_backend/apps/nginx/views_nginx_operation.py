#!/usr/bin/env python
# -*- coding:utf-8 -*-



from django.db.models import Q
from rest_framework.response import Response
from rest_framework.views import APIView

from utils.response import APIResponse
from .serializer import NginxOpsSerializer, NginxActionSerializer
from . import models
from celery_task.nginx_task import nginxReloadAction, nginxSyncAction
from .tools import nginxtools
from utils.logging import get_logger

logger = get_logger('nginx')

class NginxSyncView(APIView):
    """
    nginx sync操作
    """
    def post(self, request):
        reqData = request.data
        # {id: 17, operator: super admin, action_name: "sync"}
        # 如果当前NginxConf 状态是running，程序退出
        print('第一步',reqData)
        # {'id': 2, 'operator': 'admin', 'action_name': 'sync'}
        ngConfObj = models.NginxConf.objects.filter(pk=reqData.get('id')).first()
        print('第二步', ngConfObj.action_ops)
        # failed
        if ngConfObj.action_ops == "running":
            return Response({'code': 500, 'message': "当前站点已有任务运行，大佬请稍等!!!"})
        # 修改NginxConf 状态为running
        ngConfObj.action_ops = 'running'
        ngConfObj.save()
        # 新增NginxInstanceOps
        createData = {
            "ops_2_conf": reqData.get('id'),
            "operator": reqData.get('operator'),
            "action_name": "sync"
        }
        # {"ops_2_conf": 17, "operator": "super admin", "action_name": "sync"}
        createRes = NginxOpsSerializer(data=createData)
        if createRes.is_valid():
            ret = createRes.save()
            job_id = ret.id  # 生成这条job的id = 这条数据的id
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'code': 500, 'message': "创建sync任务失败，详情: " + createRes.errors})
        # 生成文件
        opsObj = models.NginxInstanceOps.objects.filter(pk=job_id).first()
        fileData = {
            "action_2_ops": opsObj,
            "action": "SetConf",
            "msg": "文件写入",
            "operator": opsObj.operator,
        }

        try: # 操作详情新增记录
            # 新增记录
            models.NginxAction.objects.create(**fileData)
            confObj = models.NginxConf.objects.filter(pk=opsObj.ops_2_conf.id).first()
            domain = str(confObj.name).replace(' ', '')
            content = confObj.content
            ngWrite = nginxtools.WriteNginxConf()
            res = ngWrite.writeFile(domain, content)
            print(res)
            # {'status': 20000, 'msg': '/tmp/luffy.ob1api.com.conf 写入成功'}
            if res.get('status') == 20000:
                upData = {
                    "msg": res.get('msg'),
                    "action_status": "success"
                }
                print('第三步', upData)
                # {'msg': '/tmp/luffy.ob1api.com.conf 写入成功', 'action_status': 'success'}
                # 更新操作详情表的状态为成功写入
                models.NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)

                # 同步配置
                srcFile = "/tmp/" + domain + ".conf"
                # nginxSyncAction.delay(args=(confObj.id, opsObj.id, srcFile))\
                print('异步任务已经执行')
                nginxSyncAction.delay(confObj.id, opsObj.id, srcFile)
                ###################################################
                return Response({'code': 20000, "message": "请查看任务状态!!", "data": {"id": opsObj.id}})

                # return APIResponse(message='请查看任务状态', data={"id": opsObj.id})
            else:
                upData = {
                    "msg": res.get('message'),
                    "action_status": "failed"
                }
                models.NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)
                opsObj.ops_status = "failed"
                opsObj.save()
                ngConfObj.action_ops = 'failed'
                ngConfObj.save()
                return Response({'code': 500, 'message': "SET 1, 写入文件错误！！", "data": {"id": opsObj.id}})
        except Exception as e:
            logger.error(str(e))
            opsObj.ops_status = "failed"
            opsObj.save()
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'code': 500, 'message': str(e), "data": {"id": opsObj.id}})


class NginxReloadView(APIView):
    """
    nginx reload 操作模块
    (1)request.data = {"id":配置id, "operator": this.name, "action_name": 'reload'}
    (2)查询当前配置文件的状态 如果是running 就退出
    (3)新增操作记录({哪个配置文件, 操作人, 动作})
    (4)反序列化验证,通过后保存数据; job_id = 操作日志记录id
    (5)# reload 操作异步  参数 (配置文件id, 操作事件id)
       # ret = tasks.nginxReloadAction(ngConfObj.id, opsObj.id)
       # print(ret)
       调用远程ansible 主机 执行命令
    """
    def post(self, request):
        reqData = request.data
        print(reqData)
        # 如果当前NginxConf 状态非running，程序退出
        ngConfObj = models.NginxConf.objects.filter(pk=reqData.get('id')).first()
        if ngConfObj.action_ops == "running":
            return Response({'code': 500, 'message': "当前站点已有任务运行，大佬请稍等!!!"})

        # 新增NginxInstanceOps
        createData = {
            "ops_2_conf": reqData.get('id'),
            "operator": reqData.get('operator'),
            "action_name": "reload"
        }
        print(createData)
        createRes = NginxOpsSerializer(data=createData)
        if createRes.is_valid():
            ret = createRes.save()
            job_id = ret.id
            opsObj = models.NginxInstanceOps.objects.filter(pk=job_id).first()
            print(opsObj)
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'code': 500, 'message': "创建reload任务失败，详情: " + createRes.errors})
        # reload 操作异步
        # ret = tasks.nginxReloadAction(ngConfObj.id, opsObj.id)
        # print(ret)
        nginxReloadAction.delay(confId=ngConfObj.id, opsId=opsObj.id)
        # nginxReloadAction(confId=ngConfObj.id, opsId=opsObj.id)

        return Response({'code': 20000, "message": "请查看异步任务状态!!", "data": {"id": opsObj.id}})


class NginxRemoveView(APIView):
    """
    nginx 站点下线操作模块
    nginx reload 操作模块
    (1)request.data = {"id":配置id, "operator": this.name, "action_name": 'reload'}
    (2)查询当前配置文件的状态 如果是running 就退出
    (3)新增操作记录({哪个配置文件, 操作人, 动作})
    (4)反序列化验证,通过后保存数据; job_id = 操作日志记录id
    (5)# reload 操作异步  参数 (配置文件id, 操作事件id)
       # ret = tasks.nginxReloadAction(ngConfObj.id, opsObj.id)
       # print(ret)
       调用远程ansible 主机 执行命令
    """

    def post(self, request):
        reqData = request.data
        print(reqData)
        # 如果当前NginxConf 状态非running，程序退出
        ngConfObj = models.NginxConf.objects.filter(pk=reqData.get('id')).first()
        if ngConfObj.action_ops == "running":
            return Response({'status': 500, 'msg': "当前站点已有任务运行，大佬请稍等!!!"})

        # 新增NginxInstanceOps
        createData = {
            "ops_2_conf": reqData.get('id'),
            "operator": reqData.get('operator'),
            "action_name": "remove"
        }
        createRes = NginxOpsSerializer(data=createData)
        if createRes.is_valid():
            ret = createRes.save()
            job_id = ret.id
            opsObj = models.NginxInstanceOps.objects.filter(pk=job_id).first()
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'code': 500, 'message': "创建remove任务失败，详情: " + createRes.errors})
        # reload 操作异步
        # ret = tasks.nginxRemoveAction(ngConfObj.id, opsObj.id)
        # print(ret)
        nginx_task.nginxRemoveAction.apply_async(args=(ngConfObj.id, opsObj.id))

        return Response({'code': 200, "message": "请查看异步任务状态!!", "data": {"id": opsObj.id}})


class NginxOpsDetailView(APIView):
    """
    nginx reload, sync, remove detail 模块
    """
    def get(self, request):
        reqData = request.GET
        ops_obj = models.NginxInstanceOps.objects.filter(pk=reqData.get('id')).first()
        log_objs = models.NginxAction.objects.filter(action_2_ops=ops_obj).order_by("id")
        print(ops_obj, log_objs)
        serializer = NginxActionSerializer(log_objs, many=True)
        logs = serializer.data
        serializer_detail = NginxOpsSerializer(ops_obj)
        return Response({"status": 200, "data": logs, "detail": serializer_detail.data})
