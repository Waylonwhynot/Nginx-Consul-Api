# -*- coding: utf-8 -*-

from ansible.inventory import Inventory
from ansible.inventory.group import Group
from ansible.inventory.host import Host


class MyInventory(Inventory):
    """
    动态添加主机和主机组

    resource 数据格式：
        {
            group1": {
                "hosts": [{"hostname": "x.x.x.x", "port": "22", "username": "test", "password": "pass"}, ...],
                "vars": {"var1": value1, "var2": value2, ...}
            }
        }
        如果你只传入1个列表，这默认该列表内的所有主机属于 default_group 组,比如
        [{"hostname": "x.x.x.x", "port": "22", "username": "test", "password": "pass"}, ...]
    """
    def __init__(self, resource, loader, variable_manager, host_list=[]):
        super(MyInventory, self).__init__(loader=loader,
                                          variable_manager=variable_manager,
                                          host_list=host_list)
        self.resource = resource
        self.gen_inventory()

    def my_add_group(self, hosts, groupname, groupvars=None):
        """
        add hosts to a group
        """
        my_group = Group(name=groupname)

        # if group variables exists, add them to group
        if groupvars:
            for key, value in groupvars.items():
                my_group.set_variable(key, value)

        # add hosts to group
        for host in hosts:
            # set connection variables
            hostname = host.get("hostname")
            hostip = host.get('ip', hostname)
            hostport = host.get("port")
            username = host.get("username")
            password = host.get("password")
            ssh_key = host.get("ssh_key")
            my_host = Host(name=hostname, port=hostport)
            my_host.set_variable('ansible_ssh_host', hostip)
            my_host.set_variable('ansible_ssh_port', hostport)
            my_host.set_variable('ansible_ssh_user', username)
            my_host.set_variable('ansible_ssh_pass', password)
            my_host.set_variable('ansible_ssh_private_key_file', ssh_key)

            # set other variables
            for key, value in host.items():
                if key not in ["hostname", "port", "username", "password"]:
                    my_host.set_variable(key, value)
            # add to group
            my_group.add_host(my_host)

        self.add_group(my_group)

    def gen_inventory(self):
        """
        add hosts to inventory.
        """
        if isinstance(self.resource, list):
            self.my_add_group(self.resource, 'default_group')

        elif isinstance(self.resource, dict):
            for groupname, hosts_and_vars in self.resource.iteritems():
                self.my_add_group(hosts_and_vars.get("hosts"), groupname,
                                  hosts_and_vars.get("vars"))
