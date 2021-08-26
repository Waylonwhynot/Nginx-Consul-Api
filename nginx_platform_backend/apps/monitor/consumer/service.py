import json
import time
from datetime import datetime

import psutil
from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from django.conf import settings

from monitor.prometheus.Base import BaseMonitor
from utils.response import APIResponse
class ResourcesConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # 建立连接
        if not self.scope['user']:
            await self.close()
        else:
            await self.channel_layer.group_add(
                self.scope['user'].username,
                self.channel_name,
            )
            await self.accept()

    async def receive(self, text_data=None, bytes_data=None):
        # 接收消息
        data = await self.get_data()
        await self.channel_layer.group_send(
            self.scope['user'].username,
            {
                'type': 'service.message',
                'message': json.dumps(data),
            }
        )

    async def disconnect(self, code):
        # 关闭
        await self.channel_layer.group_discard(
            self.scope['user'].username,
            self.channel_name
        )

    async def service_message(self, event):
        # 发送信息
        await self.send(event['message'])

    @database_sync_to_async
    def get_data(self):
        # cpu信息
        cpu_percent = psutil.cpu_percent(0.1)
        cpu_count = psutil.cpu_count(False)
        # 内存信息
        mem = psutil.virtual_memory()
        men_total = mem.total
        men_free = mem.free
        men_used = mem.used
        men_percent = mem.percent
        # 项目不间断运行时间
        date_now = datetime.now()
        run_time = date_now - datetime.fromtimestamp(settings.PROJECT_START_TIME)
        # 系统时间
        now_date, now_time = date_now.strftime('%Y-%m-%d'), datetime.now().strftime('%H:%M:%S')
        days = run_time.days
        hours = round(run_time.seconds / 60 / 60, 1)
        # 磁盘信息
        disk = psutil.disk_usage('/')
        disk_total = disk.total
        disk_free = disk.free
        disk_used = disk.used
        disk_percent = disk.percent
        data = {'cpu': {'percent': float(cpu_percent), 'count': str(cpu_count) + ' Cores'},
                'mem': {'total': str(round(men_total / 1024 / 1024 / 1024, 2)) + ' GB',
                        'free': str(round(men_free / 1024 / 1024 / 1024, 2)) + ' GB',
                        'used': str(round(men_used / 1024 / 1024 / 1024, 2)) + ' GB',
                        'percent': float(men_percent)
                        },
                'disk': {'total': str(round(disk_total / 1024 / 1024 / 1024, 2)) + ' GB',
                         'free': str(round(disk_free / 1024 / 1024 / 1024, 2)) + ' GB',
                         'used': str(round(disk_used / 1024 / 1024 / 1024, 2)) + ' GB',
                         'percent': float(disk_percent)
                         },
                'sys': {'run_time': f'{days} 天 {hours} 小时'},
                'time': {'date': now_date, 'time': now_time}
                }
        return data

class ResourcesNginxConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # 建立连接
        if not self.scope['user']:
            await self.close()
        else:
            await self.channel_layer.group_add(
                self.scope['user'].username,
                self.channel_name,
            )
            await self.accept()

    async def receive(self, text_data=None, bytes_data=None):
        # 接收消息
        data = await self.get_data()
        await self.channel_layer.group_send(
            self.scope['user'].username,
            {
                'type': 'service.message',
                'message': json.dumps(data),
            }
        )

    async def disconnect(self, code):
        # 关闭
        await self.channel_layer.group_discard(
            self.scope['user'].username,
            self.channel_name
        )

    async def service_message(self, event):
        # 发送信息
        await self.send(event['message'])

    @database_sync_to_async
    def get_data(self):
        service_info = dict()
        for up_server in self.get_up_down_ip()['up']:
            uptime = self.get_up_time()[up_server]
            os = self.get_os_release()[up_server]
            cpu_cores = self.get_cpu_cores()[up_server]
            cpu_usage = self.get_cpu_usage()[up_server]
            mem_usage = self.get_mem_usage()[up_server]
            file_usage = self.get_file_usage()[up_server]
            net_in_usage = self.get_net_in_usage()[up_server]
            net_out_usage = self.get_net_out_usage()[up_server]
            service_info[up_server] = {
                'uptime':uptime,
                'os':os,
                'cpu_cores':cpu_cores,
                'cpu_usage':cpu_usage,
                'mem_usage':mem_usage,
                'file_usage':file_usage,
                'net_in_usage': net_in_usage,
                'net_out_usage': net_out_usage
            }
        service_info['time'] = datetime.now().strftime('%H:%M:%S')
        # service_info['up_and_down'] = self.get_up_down_ip()
        # service_info['uptime'] = self.get_up_time()
        # service_info['os'] = self.get_os_release()
        # service_info['cpu_cores'] = self.get_cpu_cores()
        # service_info['cpu_usage'] = self.get_cpu_usage()
        # service_info['mem_usage'] = self.get_mem_usage()
        # service_info['file_usage'] = self.get_file_usage()
        return service_info

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
        data = {}
        for address in up_list:
            uptime = base_monitor.get_up_time(address=address)
            data[address] = uptime
        return data

    @staticmethod
    def get_os_release():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        data = {}
        for address in up_list:
            os = base_monitor.get_os_release(address=address)
            data[address] = os
        return data

    @staticmethod
    def get_cpu_cores():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        data = {}
        for address in up_list:
            cpu_cores = base_monitor.get_cpu_cores(address=address)
            data[address] = cpu_cores
        return data

    @staticmethod
    def get_cpu_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        data = {}
        for address in up_list:
            result = base_monitor.get_cpu_usage(address=address, start_time=start_time, end_time=end_time)
            instance = result[0]['metric']['instance']
            cpu_usage = str(round(float(result[0]['values'][-1][-1]), 2)) + '%'
            data[instance] = cpu_usage
        return data

    @staticmethod
    def get_mem_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        data = {}
        for address in up_list:
            result = base_monitor.get_mem_usage(address=address, start_time=start_time, end_time=end_time)
            mem_usage = str(round(float(result[0]['values'][-1][-1]), 2)) + '%'
            data[address] = mem_usage
        return data


    @staticmethod
    def get_file_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        data = {}
        for address in up_list:
            result = base_monitor.get_file_usage(address=address, start_time=start_time, end_time=end_time)
            # file_usage = str(round(float(result[0]['values'][-1][-1]), 2))
            file_usage = str(float(result[0]['values'][-1][-1]))
            data[address] = file_usage
        return data

    @staticmethod
    def get_net_in_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        data = {}
        for address in up_list:
            result = base_monitor.get_net_in_usage(address=address, start_time=start_time, end_time=end_time)
            # file_usage = str(round(float(result[0]['values'][-1][-1]), 2))
            net_in_usage = str(round(float(result[0]['values'][-1][-1])/1024, 0))
            data[address] = net_in_usage
        return data

    @staticmethod
    def get_net_out_usage():
        base_monitor = BaseMonitor()
        up_down_list = base_monitor.target()
        up_list = up_down_list['up']
        start_time = int(time.time() - 900)
        end_time = int(time.time())
        data = {}
        for address in up_list:
            result = base_monitor.get_out_in_usage(address=address, start_time=start_time, end_time=end_time)
            # file_usage = str(round(float(result[0]['values'][-1][-1]), 2))
            net_out_usage = str(round(float(result[0]['values'][-1][-1])/1024, 0))
            data[address] = net_out_usage
        return data