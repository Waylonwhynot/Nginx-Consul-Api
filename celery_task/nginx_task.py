#!/usr/bin/env python
# -*- coding:utf-8 -*-
from libs.ansible_hepler import my_runner
from .celery import app

from django.core.cache import cache
from utils.logging import get_logger
error_logger = get_logger('log_error')
info_logger = get_logger('log_info')
from nginx import models

def CacheLog(**kwargs):
    """
    操作记录写入缓存， 批量推送成功消息
    [{"domain": "xxx.com", "type": "修改/新增"}, ]
    :return:
    """
    data = {'domain': kwargs['domain'], 'type': kwargs['type']}
    if cache.has_key(kwargs['group']):
        lst = cache.get(kwargs['group'])
        lst.append(data)
        cache.set(kwargs['group'], lst, timeout=None)
    else:
        cache.set(kwargs['group'], [data], timeout=None)

@app.task
def nginxReloadAction(confId, opsId):
    """
    nginx reload操作reload操作
    :param confId:
    :param opsId:
    :return:
    """
    try:
        confObj = models.NginxConf.objects.filter(pk=confId).first()
        opsObj = models.NginxInstanceOps.objects.filter(pk=opsId).first()
        print("异步第一步:", confObj, opsObj)
        inData = {
            "action_2_ops": opsObj,
            "operator": opsObj.operator,
            "action":  "reload"
        }
        print("构造数据:",inData)
        # 执行Reload操作
        reloadData = {
            "ansibleIp": confObj.type.managerIp,
            "type": 'reload',
            "reloadCmd": confObj.type.reloadCmd
        }
        print("reload数据:", reloadData)
        ret = my_runner.NginxAnsibleCmd(**reloadData)
        print("ansible执行结果:", ret)
        code, result = ret.get('data')
        print('11111111111111111111111111', code, result)
        inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
        print('22222222222222222222222222', inData)
        print('333333333333', 'code',  ret.get('status'), "FAILED" not in result['stdout'], "[emerg]" not in result['stdout'])
        if code == 0 and ret.get('status') == 20000 and "FAILED" not in result['stdout'] and "[emerg]" not in result['stdout']:
            print('44444444444444444444444444')
            inData['action_status'] = "success"
            models.NginxAction.objects.create(**inData)
            # 更新ops 状态
            opsObj.ops_status = 'success'
            opsObj.save()
            # 初始化换成参数
            if ret.get('code') == 20000:
                cache.delete(opsObj.ops_2_conf.type.group_ops)

            return {"code": 20000, "message": "执行Reload操作成功~"}
        else:
            inData['action_status'] = "failed"
            models.NginxAction.objects.create(**inData)
            # 更新ops表状态
            opsObj.ops_status = 'failed'
            opsObj.save()
            return {"code": 500, "message": "执行Reload操作失败"}
    except Exception as e:
        print(str(e))
        info_logger.error(str(e))
        # 更新ops表状态
        opsObj.ops_status = 'failed'
        opsObj.save()
        print('555555555555555555555')
        return {"code": 500, "message": "异常信息：" + str(e)}



# @app.task
# def nginxSyncAction(confId, opsId, srcFile):
#     """
#     异步sync Nginx配置
#     1） if 如果是consul类型，判断第一次执行运行生成dump命令
#     2） 同步配置文件
#     3） 执行结果判断
#     :param kwargs: {"id": "ops id"}
#     :return:
#     """
#     from nginx_platform_backend.apps.nginx import models
#     try:
#         confObj = models.NginxConf.objects.filter(pk=confId).first()
#         opsObj = models.NginxInstanceOps.objects.filter(pk=opsId).first()
#         inData = {
#             "action_2_ops": opsObj,
#             "operator": opsObj.operator,
#         }
#         print(inData)
#         # 判断是否需要创建consul类型的dump文件
#         if confObj.conf_add_status != True and confObj.type.nginx_type == 'consul':
#             add_data = {
#                 "ansibleIp": confObj.type.managerIp,
#                 "type": 'add_dump',
#                 "addCmd": confObj.type.dumpCmd,
#                 "domain": confObj.name + ".conf"
#             }
#             # 执行命令
#             print(add_data)
#             ret = my_runner.NginxAnsibleCmd(**add_data)
#             print('第四步骤', ret)
#             code, result = ret.get('data')
#             inData['action'] = "dump_path"
#             inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
#             if code == 0:
#                 inData['action_status'] = "success"
#                 models.NginxAction.objects.create(**inData)
#                 # 更新conf, 创建dump文件仅一次
#                 confObj.conf_add_status = True
#                 confObj.save()
#             else:
#                 inData['action_status'] = "failed"
#                 models.NginxAction.objects.create(**inData)
#                 opsObj.ops_status = "failed"
#                 opsObj.save()
#                 confObj.action_ops = 'failed'
#                 confObj.save()
#                 return {"status": 500, "msg": "创建dump文件失败!!!"}
#         # 非consul类型, 执行sync操作, 首先执行scp配置文件
#         syncData = {
#             "ansibleIp": confObj.type.managerIp,
#             "type": 'sync',
#             "srcFile": srcFile,
#             "destPath": confObj.type.confPath,
#             "syncCmd": confObj.type.syncCmd
#         }
#
#         # 执行sync命令
#         ret = my_runner.NginxAnsibleCmd(**syncData)
#         code, result = ret.get('data')
#         inData['action'] = "sync"
#         inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
#         # 返回结果判断
#         if code == 0 and ret.get('status') == 200 and "FAILED" not in result['stdout'] and "[emerg]" not in result['stdout']:
#             inData['action_status'] = "success"
#             models.NginxAction.objects.create(**inData)
#             opsObj.ops_status = 'success'
#             opsObj.save()
#             confObj.action_ops = 'success'
#             confObj.save()
#             cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "变更"}
#             CacheLog(**cacheData)
#             return {"status": 200, "msg": "执行sync操作成功~"}
#         else:
#             inData['action_status'] = "failed"
#             models.NginxAction.objects.create(**inData)
#             opsObj.ops_status = 'failed'
#             opsObj.save()
#             confObj.action_ops = 'failed'
#             confObj.save()
#             cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "变更"}
#             CacheLog(**cacheData)
#             return {"status": 500, "msg": "执行sync操作失败!!"}
#     except Exception as e:
#         error_logger.error(str(e))
#         opsObj.ops_status = 'failed'
#         opsObj.save()
#         confObj.action_ops = 'failed'
#         confObj.save()
#         return {"status": 500, "msg": "异常信息：" + str(e)}
#     finally:
#         # 返回处理
#         pass




# def dns_check(domain):
#     from socket import gethostbyname
#     try:
#         host = gethostbyname(domain)
#         if host:
#             return {"status": 200, "data": host}
#     except Exception as e:
#         return {"status": 500, "data": "解析不存在!!"}


