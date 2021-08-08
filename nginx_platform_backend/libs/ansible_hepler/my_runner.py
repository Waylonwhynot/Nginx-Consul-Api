#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
@author: nick
@time：2021/1/12 15:39
"""
import logging
import sys
from pathlib import Path
from multiprocessing import current_process
sys.path.append(str(Path(__file__).resolve().parents[3]))
from libs.ansible_hepler.runner import Runner

error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')


def NginxAnsibleCmd(**kwargs):
    """
    远程执行sync, reload nginx
    :param kwargs:
    :return:
    """
    import socket
    # 获取程序本地运行IP，获取生成配置文件使用
    try:
        processIp = socket.gethostbyname(socket.gethostname())
    except Exception as e:
        error_logger.error(str(e))
        return {'status': 500, 'msg': "获取系统IP错误!! 详情:" + str(e)}
    try:
        current_process()._config = {'semprefix': '/mp'}
        res = [{'username': 'root', 'hostname': kwargs['ansibleIp']}]
        tqm = Runner(res)
        # 判断操作类型, sync or reload
        if kwargs['type'] == 'sync':
            command = "scp -P 23245 root@{0}:{1} {2} && bash {3}".format(processIp, kwargs['srcFile'],
                                                                         kwargs['destPath'], kwargs['syncCmd'])
        elif kwargs['type'] == "add_dump":
            command = "bash {0} {1}".format(kwargs['addCmd'], kwargs['domain'])
        elif kwargs['type'] == "reload":
            command = kwargs['reloadCmd']
        elif kwargs['type'] == 'rmConf':
            command = "bash {0} {1}".format(kwargs['rmCmd'], kwargs['rmConf'])
        elif kwargs['type'] == 'justSync':
            command = "bash {0}".format(kwargs['syncCmd'])
        else:
            return {'status': 500, 'msg': "type非法参数!!"}
        ret = tqm.run(module_args=command)
        return {"status": 200, "data": ret}
    except Exception as e:
        error_logger.error(str(e))
        return {'status': 500, 'msg': str(e)}
