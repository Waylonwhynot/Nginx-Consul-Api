import platform
import socket
import time
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from utils.response import APIResponse
from monitor.prometheus.Base import BaseMonitor


class ServiceMonitorAPIView(APIView):
    """
    get:
    监控--服务监控

    获取服务器信息, status: 200(成功), return: 服务器信息
    """

    def get(self, request):
        service_info = dict()
        service_info['platform'] = platform.platform()
        service_info['ip'] = self.get_host_ip()
        return APIResponse(data=service_info)

    @staticmethod
    def get_host_ip():
        """
        查询本机ip地址
        :return: ip
        """
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            s.connect(('8.8.8.8', 80))
            ip = s.getsockname()[0]
        finally:
            s.close()
        return ip


class MonitorNginxAPIView(APIView):
    """
    get:
    监控--Nginx基础监控，后面可加上端口监控+接口监控

    获取基础监控指标信息，后续可添加NGINX服务指标信息
    """

    def get(self, request):
        service_info = dict()
        service_info['up_and_down'] = self.get_up_down_ip()
        service_info['uptime'] = self.get_up_time()
        service_info['os'] = self.get_os_release()
        service_info['cpu_cores'] = self.get_cpu_cores()
        service_info['cpu_usage'] = self.get_cpu_usage()
        service_info['mem_usage'] = self.get_mem_usage()
        return APIResponse(data=service_info)

    @staticmethod
    def get_up_down_ip():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        return up_down_list

    @staticmethod
    def get_up_time():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        for address in up_list:
            uptime = base_monitor.get_up_time(address=address)
            data = {address: uptime}
        return data

    @staticmethod
    def get_os_release():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        for address in up_list:
            os = base_monitor.get_os_release(address=address)
            data = {address: os}
        return data

    @staticmethod
    def get_cpu_cores():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        for address in up_list:
            cpu_cores = base_monitor.get_cpu_cores(address=address)
            data = {address: cpu_cores}
        return data

    @staticmethod
    def get_cpu_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        for address in up_list:
            result = base_monitor.get_cpu_usage(address=address, start_time=start_time , end_time=end_time)
            instance = result[0]['metric']['instance']
            cpu_usage = str(round(float(result[0]['values'][-1][-1]), 2)) + '%'
            data = {instance: cpu_usage}
        return data

    @staticmethod
    def get_mem_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        for address in up_list:
            result = base_monitor.get_mem_usage(address=address, start_time=start_time , end_time=end_time)
            mem_usage = str(round(float(result[0]['values'][-1][-1]), 2)) + '%'
            data = {address: mem_usage}
        return data