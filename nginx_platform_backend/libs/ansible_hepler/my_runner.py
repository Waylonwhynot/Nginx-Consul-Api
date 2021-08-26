# -*- coding:utf-8 -*-

import sys
from pathlib import Path
from multiprocessing import current_process
sys.path.append(str(Path(__file__).resolve().parents[3]))
from libs.ansible_hepler.runner import Runner
from utils.logging import get_logger
error_logger = get_logger('log_error')
info_logger = get_logger('log_info')


def NginxAnsibleCmd(**kwargs):

    """
    远程执行sync, reload nginx
    :param kwargs:
    :return:
    """
    # import socket
    # 获取程序本地运行IP，获取生成配置文件使用
    # try:
    #     processIp = socket.gethostbyname(socket.gethostname())
    #     print(processIp)
    # except Exception as e:
    #     error_logger.error(str(e))
    #     return {'status': 500, 'msg': "获取系统IP错误!! 详情:" + str(e)}
    try:
        current_process()._config = {'semprefix': '/mp'}
        print(current_process()._config)
        res = [{'username': 'root', 'hostname': kwargs['ansibleIp']}]
        tqm = Runner(res)
        # 判断操作类型, sync or reload
        if kwargs['type'] == 'sync':
            # {'ansibleIp': '10.0.0.80', 'type': 'sync', 'srcFile': '/tmp/luffy.ob1api.com.conf', 'destPath': '/etc/nginx/conf.d/', 'syncCmd': ''}
            import subprocess
            val = subprocess.check_call('scp -P 22 {0} root@{1}:{2}'.format(kwargs['srcFile'], kwargs['ansibleIp'], kwargs['destPath']), shell=True)
            if val is not 0:
                return
            command = "bash {0}".format(kwargs['syncCmd'])
            # command = "scp -P 22 {0} root@{1}:{2} && bash {3}".format(kwargs['srcFile'], "10.0.0.1", kwargs['destPath'], kwargs['syncCmd'])
            print(command)
        elif kwargs['type'] == "add_dump":
            command = "bash {0} {1}".format(kwargs['addCmd'], kwargs['domain'])
            print(command)
            # 远程到 ansible 主机 dump 文件 ; 操作ansible主机上的脚本
        elif kwargs['type'] == "reload":
            command = kwargs['reloadCmd']
            print(command)
        elif kwargs['type'] == 'rmConf':
            command = "bash {0} {1}".format(kwargs['rmCmd'], kwargs['rmConf'])
        elif kwargs['type'] == 'justSync':
            command = "bash {0}".format(kwargs['syncCmd'])
        else:
            return {'status': 500, 'msg': "type非法参数!!"}
        ret = tqm.run(module_args=command)
        # print(ret)
        return {"status": 20000, "data": ret}
    except Exception as e:
        error_logger.info(str(e))
        return {'status': 500, 'msg': str(e)}
