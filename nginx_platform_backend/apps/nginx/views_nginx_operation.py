#!/usr/bin/env python
# -*- coding:utf-8 -*-


import logging
from django.db.models import Q
from rest_framework.response import Response
from rest_framework.views import APIView
from apps.nginx.serializer import NginxOpsSerializer, NginxActionSerializer
from apps.nginx.models import NginxInstanceOps, NginxConf, NginxAction
from celery_task import nginx_task
from apps.nginx.tools import nginxtools

error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


class NginxSyncView(APIView):
    """
    nginx sync操作
    """
    def post(self, request):
        reqData = request.data
        # {id: 17, operator: super admin, action_name: "sync"}
        # 如果当前NginxConf 状态是running，程序退出
        ngConfObj = NginxConf.objects.filter(pk=reqData.get('id')).first()
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
        opsObj = NginxInstanceOps.objects.filter(pk=job_id).first()
        fileData = {
            "action_2_ops": opsObj,
            "action": "SetConf",
            "msg": "文件写入",
            "operator": opsObj.operator,
        }
        # {"action_2_ops": opsObj, "action": "SetConf", "msg": "文件写入", "operator": "super admin"}

        try:
            # 新增记录
            NginxAction.objects.create(**fileData)
            confObj = NginxConf.objects.filter(pk=opsObj.ops_2_conf.id).first()
            domain = str(confObj.name).replace(' ', '')
            content = confObj.content
            ngWrite = nginxtools.WriteNginxConf()
            res = ngWrite.writeFile(domain, content)
            if res.get('status') == 200:
                upData = {
                    "msg": res.get('msg'),
                    "action_status": "success"
                }
                NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)

                # 同步配置
                srcFile = "/srv/nginxtemp/" + domain + ".conf"
                # ret = tasks.nginxSyncAction(confObj.id, opsObj.id, srcFile)
                nginx_task.nginxSyncAction.apply_async(args=(confObj.id, opsObj.id, srcFile))
                return Response({'status': 200, "msg": "请查看异步任务状态!!", "data": {"id": opsObj.id}})
            else:
                upData = {
                    "msg": res.get('msg'),
                    "action_status": "failed"
                }
                NginxAction.objects.filter(Q(action_2_ops=opsObj.id) & Q(action='SetConf')).update(**upData)
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


class NginxReloadView(APIView):
    """
    nginx reload 操作模块
    """
    def post(self, request):
        reqData = request.data
        # 如果当前NginxConf 状态非running，程序退出
        ngConfObj = NginxConf.objects.filter(pk=reqData.get('id')).first()
        if ngConfObj.action_ops == "running":
            return Response({'status': 500, 'msg': "当前站点已有任务运行，大佬请稍等!!!"})

        # 新增NginxInstanceOps
        createData = {
            "ops_2_conf": reqData.get('id'),
            "operator": reqData.get('operator'),
            "action_name": "reload"
        }
        createRes = NginxOpsSerializer(data=createData)
        if createRes.is_valid():
            ret = createRes.save()
            job_id = ret.id
            opsObj = NginxInstanceOps.objects.filter(pk=job_id).first()
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'status': 500, 'msg': "创建reload任务失败，详情: " + createRes.errors})
        # reload 操作异步
        # ret = tasks.nginxReloadAction(ngConfObj.id, opsObj.id)
        # print(ret)
        nginx_task.nginxReloadAction.apply_async(args=(ngConfObj.id, opsObj.id))

        return Response({'status': 200, "msg": "请查看异步任务状态!!", "data": {"id": opsObj.id}})


class NginxRemoveView(APIView):
    """
    nginx 站点下线操作模块
    """

    def post(self, request):
        reqData = request.data
        # 如果当前NginxConf 状态非running，程序退出
        ngConfObj = NginxConf.objects.filter(pk=reqData.get('id')).first()
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
            opsObj = NginxInstanceOps.objects.filter(pk=job_id).first()
        else:
            ngConfObj.action_ops = 'failed'
            ngConfObj.save()
            return Response({'status': 500, 'msg': "创建remove任务失败，详情: " + createRes.errors})
        # reload 操作异步
        # ret = tasks.nginxRemoveAction(ngConfObj.id, opsObj.id)
        # print(ret)
        nginx_task.nginxRemoveAction.apply_async(args=(ngConfObj.id, opsObj.id))

        return Response({'status': 200, "msg": "请查看异步任务状态!!", "data": {"id": opsObj.id}})


class NginxOpsDetailView(APIView):
    """
    nginx reload, sync, remove detail 模块
    """
    def get(self, request):
        reqData = request.GET
        ops_obj = NginxInstanceOps.objects.filter(pk=reqData.get('id')).first()
        log_objs = NginxAction.objects.filter(action_2_ops=ops_obj).order_by("id")
        serializer = NginxActionSerializer(log_objs, many=True)
        logs = serializer.data
        serializer_detail = NginxOpsSerializer(ops_obj)
        return Response({"status": 200, "data": logs, "detail": serializer_detail.data})
