# -*- coding: utf-8 -*-

import json
import shutil
from collections import namedtuple
from ansible.parsing.dataloader import DataLoader
from ansible.vars.manager import VariableManager
from ansible.inventory.manager import InventoryManager
from ansible.playbook.play import Play
from ansible.executor.task_queue_manager import TaskQueueManager
from ansible.plugins.callback import CallbackBase
from ansible.executor.playbook_executor import PlaybookExecutor
from ansible.utils.ssh_functions import check_for_controlpersist
import ansible.constants as C
import redis
import datetime
import logging, logging.handlers

ansible_remote_user = 'root'

class ResultCallback(CallbackBase):
    """一个简单的回调插件 """
    def v2_runner_on_ok(self, result, **kwargs):
        """打印结果的json表示形式 """
        host = result._host
        print(json.dumps({host.name: result._result}, indent=4))

#调用需要传入 3 个参数，分别是 执行主机列表、任务列表、inventory 文件，
def AnsibleApi(hosts, tasks, sources):
    Options = namedtuple('Options',
                         ['remote_user',
                          'connection',
                          'module_path',
                          'forks',
                          'become',
                          'become_method',
                          'become_user',
                          'check',
                          'diff'])
    options = Options(remote_user=ansible_remote_user,
                      connection='paramiko',
                      module_path=['/to/mymodules'],
                      forks=10,
                      become=None,
                      become_method=None,
                      become_user=None,
                      check=False,
                      diff=False)
    loader = DataLoader()
    passwords = dict(vault_pass='secret')
    inventory = InventoryManager(loader=loader, sources=sources)
    variable_manager = VariableManager(loader=loader, inventory=inventory)
    play_source =  dict(name = "Ansible Play",
                        hosts = hosts,
                        gather_facts = 'no',
                        tasks = tasks)
    play = Play().load(play_source,
                       variable_manager=variable_manager,
                       loader=loader)
    tqm = None
    try:
        tqm = TaskQueueManager(
                  inventory=inventory,
                  variable_manager=variable_manager,
                  loader=loader,
                  options=options,
                  passwords=passwords,
                  stdout_callback=ResultCallback(),
              )
        result = tqm.run(play)
        print('11111', result)
    finally:
        if tqm is not None:
            tqm.cleanup()
        shutil.rmtree(C.DEFAULT_LOCAL_TMP, True)

if __name__ == '__main__':
    tasks = []
    # tasks.append(dict(action=dict(module='shell', args='ls'), register='shell_out'))
    # tasks.append(dict(action=dict(module='debug', args=dict(msg='{{shell_out.stdout}}'))))
    # sources = 'scripts/inventory'
    AnsibleApi("10.0.0.80",[dict(action=dict(module='shell', args='bash /root/scripts/sync-check.sh'), register='shell_out')],"/etc/ansible/hosts")
