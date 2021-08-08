# -*- coding: utf-8 -*-

import json
from ansible.plugins.callback import CallbackBase


class ResultCallback(CallbackBase):
    """
    自定义回调方法
    """
    def __init__(self):
        super(ResultCallback, self).__init__()
        self.exception_message = None
        self.debug_message = None
        self.task_num = None
        self.plan_id = None
        self.type = None
        self.retry_host = None

    def v2_runner_on_ok(self, result):
        """
        任务执行成功
        """
        # TODO: 写入日志，保存状态
        host = result._host.get_name()
        res = result._result
        print(json.dumps({host: res}, indent=4))

    def v2_runner_on_failed(self, result, ignore_errors=False):
        """
        任务执行失败
        """
        # TODO: 写入日志，保存状态
        host = result._host.get_name()
        res = result._result
        print(json.dumps({host: res}, indent=4))

    def v2_runner_on_unreachable(self, result):
        """
        主机不可达
        """
        # TODO: 写入日志，保存状态
        host = result._host.get_name()
        res = result._result
        print(json.dumps({host: res}, indent=4))

    def v2_playbook_on_stats(self, stats):
        """
        任务执行结果汇总
        """
        # res = {host: stats.summarize(host) for host in stats.processed.keys()}
        print(
            json.dumps(
                {
                    host: stats.summarize(host)
                    for host in stats.processed.keys()
                },
                indent=4))

    def v2_playbook_on_play_start(self, play):
        """
        获取 playbook 变量
        """
        if play:
            pass
            # var = play.get_variable_manager()
            # extra_vars = var.extra_vars
            # if 'plan_id' in extra_vars.keys():
            #     self.plan_id = int(extra_vars['plan_id'])


class CallbackModule(CallbackBase):
    """
    官方回调方法

    Reference: https://github.com/ansible/ansible/blob/v2.0.0.2-1/lib/ansible/plugins/callback/default.py
    """

    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'stored'
    CALLBACK_NAME = 'database'

    def __init__(self):
        super(CallbackModule, self).__init__()
        self.state = None
        self.result = None

    def v2_runner_on_failed(self, result, ignore_errors=False):
        self.state = 'failed'
        self.result = result._result

    def v2_runner_on_ok(self, result):
        self.state = 'ok'
        self.result = result._result

    def v2_runner_on_skipped(self, result):
        self.state = 'skipped'
        self.result = result._result

    def v2_runner_on_no_hosts(self, task):
        print('skipping: no hosts matched')

    def v2_playbook_on_task_start(self, task, is_conditional):
        print("TASK [%s]" % task.get_name().strip())

    def v2_playbook_on_play_start(self, play):
        name = play.get_name().strip()
        if not name:
            msg = "PLAY"
        else:
            msg = "PLAY [%s]" % name
        print(msg)

    def v2_playbook_on_stats(self, stats):
        msg = ''
        hosts = sorted(stats.processed.keys())
        for h in hosts:
            t = stats.summarize(h)

            msg = "PLAY RECAP [%s] : %s %s %s %s %s" % (
                h,
                "ok: %s" % (t['ok']),
                "changed: %s" % (t['changed']),
                "unreachable: %s" % (t['unreachable']),
                "skipped: %s" % (t['skipped']),
                "failed: %s" % (t['failures']),
            )
        print(msg)
