# -*- coding:utf-8 -*-

from ansible.parsing.dataloader import DataLoader
from ansible.vars import VariableManager
from ansible.executor.playbook_executor import PlaybookExecutor
from ansible import constants as C
from ansible.utils.ssh_functions import check_for_controlpersist
from ansible.executor.task_queue_manager import TaskQueueManager
from .inventory import MyInventory
from .callback import ResultCallback
from .options import Options


class CallBackPlaybookExecutor(PlaybookExecutor):
    """
    封装 PlaybookExecutor， 添加 stdout_callback 回调方法
    """
    def __init__(self,
                 playbooks,
                 inventory,
                 variable_manager,
                 loader,
                 options,
                 passwords,
                 stdout_callback=None):
        self._playbooks = playbooks
        self._inventory = inventory
        self._variable_manager = variable_manager
        self._loader = loader
        self._options = options
        self.passwords = passwords
        self._unreachable_hosts = dict()

        if options.listhosts or options.listtasks or options.listtags or options.syntax:
            self._tqm = None
        else:
            self._tqm = TaskQueueManager(inventory=inventory,
                                         variable_manager=variable_manager,
                                         loader=loader,
                                         options=options,
                                         passwords=self.passwords,
                                         stdout_callback=stdout_callback)

        check_for_controlpersist(C.ANSIBLE_SSH_EXECUTABLE)


class PlayBook(object):
    """
    Ansible PlayBook 工具类
    """
    def __init__(self, resource, *args, **kwargs):
        """
        初始化
        """
        self.inventory = None
        self.variable_manager = None
        self.loader = None
        self.options = None
        self.results_callback = None
        self.passwords = None
        self.playbook = None
        self.res = None
        self.__initialize_data(resource)
        self.results_callback = ResultCallback()

    def __initialize_data(self, resource):
        self.loader = DataLoader()
        self.variable_manager = VariableManager()
        self.options = Options()
        self.options.connection = 'ssh'
        self.options.forks = 4
        self.inventory = MyInventory(resource=resource,
                                     loader=self.loader,
                                     variable_manager=self.variable_manager)
        self.variable_manager.set_inventory(self.inventory)

    def init_playbook(self, files, extra_vars_dict={}):
        """
        初始化 playbook 并获取执行实例
        """
        if extra_vars_dict:
            self.variable_manager.extra_vars = extra_vars_dict
        self.playbook = CallBackPlaybookExecutor(
            playbooks=files,
            inventory=self.inventory,
            variable_manager=self.variable_manager,
            loader=self.loader,
            options=self.options,
            passwords=self.passwords,
            stdout_callback=self.results_callback)

    def run(self):
        self.playbook.run()
