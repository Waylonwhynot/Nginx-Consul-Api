#!/usr/bin/env python
# -*- coding:utf-8 -*-

import re


def checkIp(ip):
    """
    验证IP是否合法
    :param ip:
    :return:
    """
    rule = re.compile('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')
    if rule.match(ip):
        return True
    else:
        return False


def checkPort(port):
    """
    验证端口是否合法
    :param port:
    :return:
    """
    if port.isdigit():
        return True
    else:
        return False
