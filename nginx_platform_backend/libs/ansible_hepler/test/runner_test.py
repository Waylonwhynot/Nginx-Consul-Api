# -*- coding: utf-8 -*-

import os
import sys
import json
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parents[3]))

from libs.ansible_hepler.runner import Runner
from libs.ansible_hepler.playbook import PlayBook

PLAYBOOK_YML = os.path.join(os.getcwd(), 'test.yml')


def ansible_command_runner():
    """
    执行命令示例
    localhost 执行 uptime
    """
    res = [{'username': 'root', 'hostname': '10.114.23.63'}]
    tqm = Runner(res)
    # return tqm.run(module_args='bash /root/scritps/admin/admin-realod.sh')
    # ret = tqm.run(module_args='uptime && bash /root/scritps/admin/admin-sync-check.sh')
    # ret = tqm.run(module_args='bash /root/scritps/admin/admin_add_dumpfile.sh nick.ppdai.com')
    # ret = tqm.run(module_args='ls /tmp/aaaa && /root/scritps/admin/admin-sync-check.sh')
    ret = tqm.run(module_args='ls /tmp')
    # ret = tqm.run(module_args='scp -P 23245 root@10.114.23.198:/srv/nginxtemp/registryadm.ppdaicorp.com.conf /etc/nginx/conf.d && bash /root/scritps/admin/admin-sync-check.sh')
    # ret = tqm.run(module_args='scp -P 23245 root@10.114.23.198:/srv/nginxtemp/registryadm.ppdaicorp.com.conf /tmp && bash /root/scritps/admin/admin-sync-check.sh')
    # ret = tqm.run("ls /tmp")
    return {"status": 200, "data": ret}


def ansible_playbook_runner():
    """
    执行 playbook 示例
    localhost 执行 test.yml
    """
    # 执行主机列表
    res = [{'hostname': '10.114.23.63'}]
    # PlayBook 参数
    extra_vars_dict = {'hostname': '10.114.23.63'}
    playbook = PlayBook(res)
    playbook.init_playbook([PLAYBOOK_YML], extra_vars_dict)
    playbook.run()


def main():
    ret = ansible_command_runner()
    # ret, result = ansible_command_runner()
    print("run cmd with ansible.")
    # # assert ret == 0
    code, result = ret.get('data')
    print("===== ret =====")
    print(ret)
    if code == 0:
        print("--------> OK <------")
    else:
        print("!!!! error !!!!!")
    print("===== resutl =====")
    print(result)
    print("-----------"*20)
    print("run {} cmd stdout: {}".format(result['cmd'], result['stdout']))


    # print("run {} cmd stdout: {}".format(result['cmd'], result['stdout']))
    # # print(json.dumps(result, indent=4))
    # print("run playbook with ansible.")
    # ansible_playbook_runner()
    # res = ansible_command_runner()
    # print(res)


if __name__ == "__main__":
    main()
