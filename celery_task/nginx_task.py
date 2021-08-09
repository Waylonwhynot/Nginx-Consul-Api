#!/usr/bin/env python
# -*- coding:utf-8 -*-


# from __future__ import absolute_import
# from celery import task, shared_task
from .celery import app

# from nginx_platform_backend.apps.nginx.models import NginxConf, NginxAction, NginxInstanceOps, NginxModel
from nginx_platform_backend.libs.ansible_hepler import my_runner
from nginx_platform_backend.libs.dns_query.query_dns import DnsQuery
from django.core.cache import cache
import logging
error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


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


@app.task()
def add(x, y):
    """
    task 测试
    :param x:
    :param y:
    :return:
    """
    print("%d + %d = %d" % (x, y, x + y))
    return x + y


@app.task()
def nginxSyncAction(confId, opsId, srcFile):
    """
    异步sync Nginx配置
    1） if 如果是consul类型，判断第一次执行运行生成dump命令
    2） 同步配置文件
    3） 执行结果判断
    :param kwargs: {"id": "ops id"}
    :return:
    """
    from nginx_platform_backend.apps.nginx import models
    try:
        confObj = models.NginxConf.objects.filter(pk=confId).first()
        opsObj = models.NginxInstanceOps.objects.filter(pk=opsId).first()
        inData = {
            "action_2_ops": opsObj,
            "operator": opsObj.operator,
        }
        print(inData)
        # 判断是否需要创建consul类型的dump文件
        if confObj.conf_add_status != True and confObj.type.nginx_type == 'consul':
            add_data = {
                "ansibleIp": confObj.type.managerIp,
                "type": 'add_dump',
                "addCmd": confObj.type.dumpCmd,
                "domain": confObj.name + ".conf"
            }
            # 执行命令
            print(add_data)
            ret = my_runner.NginxAnsibleCmd(**add_data)
            print('第四步骤', ret)
            code, result = ret.get('data')
            inData['action'] = "dump_path"
            inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
            if code == 0:
                inData['action_status'] = "success"
                models.NginxAction.objects.create(**inData)
                # 更新conf, 创建dump文件仅一次
                confObj.conf_add_status = True
                confObj.save()
            else:
                inData['action_status'] = "failed"
                models.NginxAction.objects.create(**inData)
                opsObj.ops_status = "failed"
                opsObj.save()
                confObj.action_ops = 'failed'
                confObj.save()
                return {"status": 500, "msg": "创建dump文件失败!!!"}
        # 非consul类型, 执行sync操作, 首先执行scp配置文件
        syncData = {
            "ansibleIp": confObj.type.managerIp,
            "type": 'sync',
            "srcFile": srcFile,
            "destPath": confObj.type.confPath,
            "syncCmd": confObj.type.syncCmd
        }

        # 执行sync命令
        ret = my_runner.NginxAnsibleCmd(**syncData)
        code, result = ret.get('data')
        inData['action'] = "sync"
        inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
        # 返回结果判断
        if code == 0 and ret.get('status') == 200 and "FAILED" not in result['stdout'] and "[emerg]" not in result['stdout']:
            inData['action_status'] = "success"
            models.NginxAction.objects.create(**inData)
            opsObj.ops_status = 'success'
            opsObj.save()
            confObj.action_ops = 'success'
            confObj.save()
            cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "变更"}
            CacheLog(**cacheData)
            return {"status": 200, "msg": "执行sync操作成功~"}
        else:
            inData['action_status'] = "failed"
            models.NginxAction.objects.create(**inData)
            opsObj.ops_status = 'failed'
            opsObj.save()
            confObj.action_ops = 'failed'
            confObj.save()
            cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "变更"}
            CacheLog(**cacheData)
            return {"status": 500, "msg": "执行sync操作失败!!"}
    except Exception as e:
        error_logger.error(str(e))
        opsObj.ops_status = 'failed'
        opsObj.save()
        confObj.action_ops = 'failed'
        confObj.save()
        return {"status": 500, "msg": "异常信息：" + str(e)}
    finally:
        # 返回处理
        pass


# @app.task()
# def nginxReloadAction(confId, opsId):
#     """
#     nginx reload操作reload操作
#     :param confId:
#     :param opsId:
#     :return:
#     """
#     from nginx_platform_backend.apps.nginx import models
#     try:
#         confObj = NginxConf.objects.filter(pk=confId).first()
#         opsObj = NginxInstanceOps.objects.filter(pk=opsId).first()
#         # # 微信消息
#         # wxData = {
#         #     "type": "集群reload",
#         #     "name": confObj.name,
#         #     "nginx": confObj.type.name,
#         #     "time": opsObj.create_time.strftime("%Y-%m-%d %H:%M"),
#         #     "id": opsObj.id,
#         #     "user": opsObj.operator
#         # }
#
#         inData = {
#             "action_2_ops": opsObj,
#             "operator": opsObj.operator,
#             "action":  "reload"
#         }
#         # 执行Reload操作
#         reloadData = {
#             "ansibleIp": confObj.type.managerIp,
#             "type": 'reload',
#             "reloadCmd": confObj.type.reloadCmd
#         }
#         ret = my_runner.NginxAnsibleCmd(**reloadData)
#         code, result = ret.get('data')
#         inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
#         if code == 0 and ret.get('status') == 200 and "FAILED" not in result['stdout'] and "[emerg]" not in result['stdout']:
#             inData['action_status'] = "success"
#             NginxAction.objects.create(**inData)
#             # 更新ops 状态
#             opsObj.ops_status = 'success'
#             opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "success"
#             # wxData['action'] = "reload"
#             # wxData['msg'] = "执行Reload操作成功~"
#             # sendMessage(**wxData)
#             # 微信通知研发大佬
#             # from libs.weixin.weixin_api import sendDevLoop
#             # data = {"group": opsObj.ops_2_conf.type.group_ops, "ops": opsObj.operator, "nginx": opsObj.ops_2_conf.type.name}
#             # ret = sendDevLoop(**data)
#             # 初始化换成参数
#             if ret.get('code') == 200:
#                 cache.delete(opsObj.ops_2_conf.type.group_ops)
#
#             return {"status": 200, "msg": "执行Reload操作成功~"}
#         else:
#             inData['action_status'] = "failed"
#             NginxAction.objects.create(**inData)
#             # 更新ops表状态
#             opsObj.ops_status = 'failed'
#             opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "failed"
#             # wxData['action'] = "reload"
#             # wxData['msg'] = "执行Reload操作失败"
#             # sendMessage(**wxData)
#             return {"status": 500, "msg": "执行Reload操作失败"}
#     except Exception as e:
#         error_logger.error(str(e))
#         # 更新ops表状态
#         opsObj.ops_status = 'failed'
#         opsObj.save()
#         # # 微信推送
#         # wxData['status'] = "failed"
#         # wxData['action'] = "异常退出"
#         # wxData['msg'] = str(e)
#         # sendMessage(**wxData)
#         return {"status": 500, "msg": "异常信息：" + str(e)}


def dns_check(domain):
    from socket import gethostbyname
    try:
        host = gethostbyname(domain)
        if host:
            return {"status": 200, "data": host}
    except Exception as e:
        return {"status": 500, "data": "解析不存在!!"}

# @app.task()
# def nginxRemoveAction(confId, opsId):
#     """
#     nginx 下线操作
#     1） 判断程序节点 dns域名解析是否存在
#     2） 判断ES，3天日志是否有访问量
#     3） sync操作
#     4)  修改conf表，状态修改成closed
#     :param confId:
#     :param opsId:
#     :return:
#     """
#     from nginx_platform_backend.apps.nginx import models
#     try:
#         confObj = NginxConf.objects.filter(pk=confId).first()
#         opsObj = NginxInstanceOps.objects.filter(pk=opsId).first()
#         inData = {"action_2_ops": opsObj, "operator": opsObj.operator}
#         # 微信消息
#         # wxData = {
#         #     "type": "下线",
#         #     "name": confObj.name,
#         #     "nginx": confObj.type.name,
#         #     "time": opsObj.create_time.strftime("%Y-%m-%d %H:%M"),
#         #     "id": opsObj.id,
#         #     "user": opsObj.operator
#         # }
#         # DNS验证
#         inData['action'] = "dns_check"
#         # dns_ret = dns_check(confObj.name)
#         dns_ret = DnsQuery(**{'domain': confObj.name})
#         if dns_ret.get('code') == 200:
#             inData['action_status'] = "success"
#             inData['msg'] = "DNS验证, " + confObj.name + "详情:" + dns_ret.get('msg')
#             NginxAction.objects.create(**inData)
#         else:
#             inData['action_status'] = "failed"
#             inData['msg'] = "DNS验证, " + confObj.name + "解析详情: " + str(dns_ret.get('data'))
#             NginxAction.objects.create(**inData)
#             # 更新ops表状态
#             opsObj.ops_status = 'failed'
#             opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "failed"
#             # wxData['action'] = "DNS验证"
#             # wxData['msg'] = "解析详情：" + str(dns_ret.get('data'))
#             # sendMessage(**wxData)
#             return {"status": 500, "msg": "DNS验证失败!!"}
#         # # ES验证
#         # inData['action'] = "es_check"
#         # es_check = confObj.type.nginx_2_index
#         # if es_check:
#         #     es_ip = confObj.type.nginx_2_index.index_2_es.ip
#         #     es_port = confObj.type.nginx_2_index.index_2_es.port
#         #     es_user = confObj.type.nginx_2_index.index_2_es.user
#         #     es_pwd = confObj.type.nginx_2_index.index_2_es.pwd
#         #     myEs = MyEs(**{'host': es_ip, 'port': es_port, 'user': es_user, 'pwd': es_pwd})
#         #     es = myEs.initEs()
#         #     es_ret = myEs.domainLastCount(es, confObj.type.nginx_2_index.name, confObj.name)
#         #     # 判断是否有请求
#         #     if es_ret.get('code') == 200 and int(es_ret.get('data')) == 0:
#         #         inData['action_status'] = "success"
#         #         inData['msg'] = "ES日志验证通过, 统计数量: " + str(es_ret.get('data'))
#         #         NginxAction.objects.create(**inData)
#         #     else:
#         #         inData['action_status'] = "failed"
#         #         inData['msg'] = "ES日志验证失败，请查看kibana!! 统计数量: " + str(es_ret.get('data'))
#         #         NginxAction.objects.create(**inData)
#         #         # 更新ops表状态
#         #         opsObj.ops_status = 'failed'
#         #         opsObj.save()
#         #         # # 微信推送
#         #         # wxData['status'] = "failed"
#         #         # wxData['action'] = "ES访问检查"
#         #         # wxData['msg'] = "近3天还有请求日志，请查看ES"
#         #         # sendMessage(**wxData)
#         #         return {"status": 500, "msg": "DNS验证失败!!"}
#         # else:
#         #     inData['action_status'] = "failed"
#         #     inData['msg'] = "ES索引未配置"
#         #     NginxAction.objects.create(**inData)
#         #     # 更新ops表状态
#         #     opsObj.ops_status = 'failed'
#         #     opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "failed"
#             # wxData['action'] = "ES访问检查"
#             # wxData['msg'] = "ES索引未配置"
#             # sendMessage(**wxData)
#             # return {"status": 500, "msg": "ES索引未配置"}
#
#         # 执行下线操作SET 1 移除配置
#         removeData = {
#             "ansibleIp": confObj.type.managerIp,
#             "type": 'rmConf',
#             "rmCmd": confObj.type.rmCmd,
#             "rmConf": confObj.name + ".conf"
#         }
#         removeRet = my_runner.NginxAnsibleCmd(**removeData)
#         code, result = removeRet.get('data')
#         inData['action'] = 'rm_conf'
#         inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
#         if code == 0 and removeRet.get('status') == 200 and "FAILED" not in result['stdout'] and "[emerg]" not in result[
#             'stdout']:
#             inData['action_status'] = "success"
#             NginxAction.objects.create(**inData)
#         else:
#             inData['action_status'] = "failed"
#             NginxAction.objects.create(**inData)
#             # 更新ops表状态
#             opsObj.ops_status = 'failed'
#             opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "failed"
#             # wxData['action'] = "移除配置"
#             # wxData['msg'] = "执行移除配置操作失败!!!"
#             # sendMessage(**wxData)
#             return {"status": 500, "msg": "执行移除配置操作失败!!!"}
#
#         # SET 2 sync 配置
#         syncData = {
#             "ansibleIp": confObj.type.managerIp,
#             "type": 'justSync',
#             "syncCmd": confObj.type.syncCmd
#         }
#         # 执行sync命令
#         ret = my_runner.NginxAnsibleCmd(**syncData)
#         code, result = ret.get('data')
#         inData['action'] = "sync"
#         inData['msg'] = "run {} \r\n===>stdout<=== \r\n {}".format(result['cmd'], result['stdout'])
#         # 返回结果判断
#         if code == 0 and ret.get('status') == 200 and "FAILED" not in result['stdout'] and "[emerg]" not in result[
#             'stdout']:
#             inData['action_status'] = "success"
#             NginxAction.objects.create(**inData)
#             # 更新ops表状态
#             opsObj.ops_status = 'success'
#             opsObj.save()
#             # 将conf表，状态关闭
#             confObj.status = 'closed'
#             confObj.save()
#             # # 微信推送
#             # wxData['status'] = "success"
#             # wxData['action'] = "sync"
#             # wxData['msg'] = "下线站点，同步完成~"
#             # sendMessage(**wxData)
#             # 写入缓存
#             cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "下线"}
#             CacheLog(**cacheData)
#             return {"status": 200, "msg": "执行sync操作成功~"}
#         else:
#             inData['action_status'] = "failed"
#             NginxAction.objects.create(**inData)
#             # 更新ops表状态
#             opsObj.ops_status = 'failed'
#             opsObj.save()
#             # # 微信推送
#             # wxData['status'] = "failed"
#             # wxData['action'] = "同步配置"
#             # wxData['msg'] = "执行sync操作失败!!"
#             # sendMessage(**wxData)
#             # 写入缓存
#             cacheData = {"group": opsObj.ops_2_conf.type.group_ops, "domain": opsObj.ops_2_conf.name, "type": "变更"}
#             CacheLog(**cacheData)
#             return {"status": 500, "msg": "执行sync操作失败!!"}
#     except Exception as e:
#         error_logger.error(str(e))
#         # 更新ops 状态
#         opsObj.ops_status = 'failed'
#         opsObj.save()
#         # # 微信推送
#         # wxData['status'] = "failed"
#         # wxData['action'] = "异常退出"
#         # wxData['msg'] = str(e)
#         # sendMessage(**wxData)
#         return {"status": 500, "msg": "异常信息：" + str(e)}
