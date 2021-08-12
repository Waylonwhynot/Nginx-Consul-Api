# -*- coding:utf-8 -*-

from ansible.executor.task_queue_manager import TaskQueueManager
from ansible.parsing.dataloader import DataLoader
from ansible.playbook.play import Play
from ansible.vars import VariableManager
from .inventory import MyInventory
from .callback import CallbackModule
from .options import Options


class Runner(object):
    """
    Ansible Runner 工具类
    """
    def __init__(self, resource):
        """
        初始化
        """
        self.options = Options()
        self.options.connection = 'ssh'
        self.options.become = True
        self.options.become_method = 'sudo'
        self.options.become_user = 'root'

        passwords = {'become_pass': ''}
        self.loader = DataLoader()
        self.variable_manager = VariableManager()
        self.inventory = MyInventory(resource=resource,
                                     loader=self.loader,
                                     variable_manager=self.variable_manager)
        self.variable_manager.set_inventory(self.inventory)
        self.results_callback = CallbackModule()
        self.tqm = TaskQueueManager(
            inventory=self.inventory,
            variable_manager=self.variable_manager,
            loader=self.loader,
            options=self.options,
            passwords=passwords,
            stdout_callback=self.results_callback,
        )

    def run(self, module_name='shell', module_args=''):
        play_source = dict(
            name='Ansible Play',
            hosts='*',
            gather_facts='no',
            tasks=[
                dict(action=dict(module=module_name, args=module_args)),
            ])

        self.play = Play().load(play_source,
                                variable_manager=self.variable_manager,
                                loader=self.loader)
        try:
            ret = self.tqm.run(self.play)
            return ret, self.results_callback.result
        finally:
            self.tqm.cleanup()

