#!/usr/bin/env python
# -*- coding:utf-8 -*-


import logging
from django.db.models import Q
from rest_framework.response import Response
from rest_framework.views import APIView

from utils.response import APIResponse
from .serializer import NginxOpsSerializer, NginxActionSerializer
from . import models
from celery_task.nginx_task import nginxSyncAction
from .tools import nginxtools

error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


class NginxSyncView(APIView):
    """
    nginx sync操作
    (1)接收前端数据, 判断当前配置文件是否有正在执行的操作, 如果没有, 把当前状态改为running
    (2)Nginx操作表 增加一条记录{"ops_2_conf": 17, "operator": "super admin", "action_name": "sync"}
    (3)生成文件, 构造数据, {"action_2_ops": opsObj, "action": "SetConf", "msg": "文件写入", "operator": "super admin"}
    (4)NginxAction(生成和移除配置表) 表中增加一条记录, 信息大致为文件写入
    (5)查询到www域名,文件内容,写入本地/srv/nginxtemp/
    (6)写入成功; 构造数据 {"msg": 路径/配置文件写入成功, "action_status": "success"};
    (7)NginxAction表 更新数据 成功
    (8) 同步配置, 异步任务, 然后查看异步任务状态
    """
    def post(self, request):
        reqData = request.data
        # {id: 17, operator: super admin, action_name: "sync"}
        # 如果当前NginxConf 状态是running，程序退出
        print('第一步',reqData)
        ngConfObj = models.NginxConf.objects.filter(pk=reqData.get('id')).first()
        print('第二步', ngConfObj.action_ops)
        if ngConfObj.action_ops == "running":
            return Response({'status': 500, 'msg': "当前站点已有任务运行，大佬请稍等!!!"})
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
            job_id = ret.id  # 这条数据的id
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'status': 500, 'msg': "创建sync任务失败，详情: " + createRes.errors})
        # 生成文件
        opsObj = models.NginxInstanceOps.objects.filter(pk=job_id).first()
        fileData = {
            "action_2_ops": opsObj,
            "action": "SetConf",
            "msg": "文件写入",
            "operator": opsObj.operator,
        }

        try:
            # 新增记录
            models.NginxAction.objects.create(**fileData)
            confObj = models.NginxConf.objects.filter(pk=opsObj.ops_2_conf.id).first()
            domain = str(confObj.name).replace(' ', '')
            content = confObj.content
            ngWrite = nginxtools.WriteNginxConf()
            res = ngWrite.writeFile(domain, content)
            print(res)
            if res.get('status') == 200:
                upData = {
                    "msg": res.get('msg'),
                    "action_status": "success"
                }
                print('第三步', upData)
                models.NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)

                # 同步配置
                srcFile = "/srv/nginxtemp/" + domain + ".conf"
                nginxSyncAction.apply_async(args=(confObj.id, opsObj.id, srcFile))
                ###################################################

                print('异步任务已经执行')
                print(confObj.id, opsObj.id, srcFile)
                return Response({'status': 20000, "msg": "请查看任务状态!!", "data": {"id": opsObj.id}})

                # return APIResponse(message='请查看任务状态', data={"id": opsObj.id})
            else:
                upData = {
                    "msg": res.get('msg'),
                    "action_status": "failed"
                }
                models.NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)
                opsObj.ops_status = "failed"
                opsObj.save()
                ngConfObj.action_ops = 'failed'
                ngConfObj.save()
                return Response({'status': 500, 'msg': "SET 1, 写入文件错误！！", "data": {"id": opsObj.id}})
        except Exception as e:
            error_logger.error(str(e))
            opsObj.ops_status = "failed"
            opsObj.save()
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'status': 500, 'msg': str(e), "data": {"id": opsObj.id}})


# class NginxReloadView(APIView):
#     """
#     nginx reload 操作模块
#     """
#     def post(self, request):
#         reqData = request.data
#         # 如果当前NginxConf 状态非running，程序退出
#         ngConfObj = NginxConf.objects.filter(pk=reqData.get('id')).first()
#         if ngConfObj.action_ops == "running":
#             return Response({'status': 500, 'msg': "当前站点已有任务运行，大佬请稍等!!!"})
#
#         # 新增NginxInstanceOps
#         createData = {
#             "ops_2_conf": reqData.get('id'),
#             "operator": reqData.get('operator'),
#             "action_name": "reload"
#         }
#         createRes = NginxOpsSerializer(data=createData)
#         if createRes.is_valid():
#             ret = createRes.save()
#             job_id = ret.id
#             opsObj = NginxInstanceOps.objects.filter(pk=job_id).first()
#         else:
#             ngConfObj.action_ops = 'failed'
#             ngConfObj.save()
#             return Response({'status': 500, 'msg': "创建reload任务失败，详情: " + createRes.errors})
#         # reload 操作异步
#         # ret = tasks.nginxReloadAction(ngConfObj.id, opsObj.id)
#         # print(ret)
#         nginx_task.nginxReloadAction.apply_async(args=(ngConfObj.id, opsObj.id))
#
#         return Response({'status': 200, "msg": "请查看异步任务状态!!", "data": {"id": opsObj.id}})
#
#
# class NginxRemoveView(APIView):
#     """
#     nginx 站点下线操作模块
#     """
#
#     def post(self, request):
#         reqData = request.data
#         # 如果当前NginxConf 状态非running，程序退出
#         ngConfObj = NginxConf.objects.filter(pk=reqData.get('id')).first()
#         if ngConfObj.action_ops == "running":
#             return Response({'status': 500, 'msg': "当前站点已有任务运行，大佬请稍等!!!"})
#
#         # 新增NginxInstanceOps
#         createData = {
#             "ops_2_conf": reqData.get('id'),
#             "operator": reqData.get('operator'),
#             "action_name": "remove"
#         }
#         createRes = NginxOpsSerializer(data=createData)
#         if createRes.is_valid():
#             ret = createRes.save()
#             job_id = ret.id
#             opsObj = NginxInstanceOps.objects.filter(pk=job_id).first()
#         else:
#             ngConfObj.action_ops = 'failed'
#             ngConfObj.save()
#             return Response({'status': 500, 'msg': "创建remove任务失败，详情: " + createRes.errors})
#         # reload 操作异步
#         # ret = tasks.nginxRemoveAction(ngConfObj.id, opsObj.id)
#         # print(ret)
#         nginx_task.nginxRemoveAction.apply_async(args=(ngConfObj.id, opsObj.id))
#
#         return Response({'status': 200, "msg": "请查看异步任务状态!!", "data": {"id": opsObj.id}})
#
#
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
