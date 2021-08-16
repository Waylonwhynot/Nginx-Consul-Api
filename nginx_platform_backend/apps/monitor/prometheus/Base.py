# -*- coding: utf-8 -*-

import requests
from django.conf import settings


class BaseMonitor:
    def __init__(self):
        self.usr = settings.PROMETHEUS_URL
        self.up_list = []
        self.down_list = []

    def target(self):
        """
        获取监控节点
        """
        url = self.usr + '/api/v1/targets'
        response = requests.request('GET', url)
        if response.status_code == 200:
            targets = response.json()['data']['activeTargets']
            for target in targets:
                if target['health'] == 'up' and target['labels']['job'] == 'nginx':
                    self.up_list.append(target['discoveredLabels']['__address__'])
                elif target['health'] == 'down' and target['labels']['job'] == 'nginx':
                    self.down_list.append(target['discoveredLabels']['__address__'])
            return {'up': self.up_list, 'down': self.down_list}
        else:
            return None

    def getQueryValue(self, query):
        """
        执行查询语句(查询单个值)
        :param query: 查询的语句
        :return: 查询到的值
        """
        base_url = self.usr + '/api/v1/query?query='
        inquire = base_url + query
        print(inquire)
        response = requests.request('GET', inquire)
        if response.status_code == 200:
            result = response.json()['data']['result'][0]
            # print("原始查询结果:", result)
            return result
        else:
            return None

    def get_os_release(self, address):
        """
        获取系统内核版本
        :param address:
        :return:
        """
        query = 'node_uname_info{job="nginx",instance="' + address + '"}'
        result = self.getQueryValue(query)
        value = result['metric']['release']
        return value

    def get_up_time(self, address):
        """
        获取系统启动时长
        :return:
        """
        query = 'sum(time()-node_boot_time_seconds{job="nginx",instance="' + address + '"}) by (instance)'
        result = self.getQueryValue(query)
        value = int(float(result['value'][1]))
        time_hour, time_sec = divmod(value, 3600)
        time_day, time_hour = divmod(time_hour, 24)
        time_mon, time_day = divmod(time_day, 30)
        return str(time_mon) + '月 ' + str(time_day) + '天 ' + str(time_hour) + '小时'

    def get_cpu_cores(self, address):
        """
        获取CPU核心数
        :param address:
        :return:
        """
        query = 'count(node_cpu_seconds_total{job="nginx",mode="system",instance="' + address + '"}) by (instance)'
        result = self.getQueryValue(query)
        value = result['value'][1]
        return value

        # return '&start=' + str(start) + '&end=' + str(end) + '&step=' + str(step)

    def getQueryRange(self, query, time_range):
        """
        执行查询语句(查询时间范围)
        :param time_range: 查询时间范围
        :param query: 查询的语句
        :return: 查询到的值
        """
        base_url = self.usr + '/api/v1/query_range?query='
        inquire = base_url + query + time_range
        print(inquire)
        response = requests.request('GET', inquire)
        if response.status_code == 200:
            result = response.json()['data']['result']
            # print("原始查询结果:", result)
            return result
        else:
            return None

    def timeQuery(self, start, end, step):
        """
        范围查询语句构造时间查询格式
        :param start_time:
        :param end_time:
        :return:
        """
        return '&start=' + str(start) + '&end=' + str(end) + '&step=' + str(step)

    def get_cpu_usage(self, address, start_time, end_time, step=15):
        query = '(1-avg(rate(node_cpu_seconds_total{job="nginx",mode="idle",instance="' + address + '"}[2m])) by (instance)) * 100'
        time_range = self.timeQuery(start_time, end_time, step)
        result = self.getQueryRange(query, time_range)
        return result

    def get_mem_usage(self, address, start_time, end_time, step=15):
        query = '(1 - (node_memory_MemAvailable_bytes{instance="' + address + '"} / (node_memory_MemTotal_bytes{instance="' + address + '"})))* 100'
        time_range = self.timeQuery(start_time, end_time, step)
        result = self.getQueryRange(query, time_range)
        return result
