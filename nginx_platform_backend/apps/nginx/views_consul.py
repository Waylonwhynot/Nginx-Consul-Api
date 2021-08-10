from rest_framework.views import APIView

from libs import basic_function
from nginx.models import NginxConf
import requests
import logging

error_logger = logging.getLogger('log_error')
info_logger = logging.getLogger('log_info')
from rest_framework.response import Response
import json


class consulStatusView(APIView):
    """
    consul 状态查看
    http://192.168.11.252:8530/v1/kv/upstreams/luffy_server/?recurse
    """

    def get(self, request):
        reqData = request.GET
        print(reqData.get('id'))
        obj = NginxConf.objects.filter(pk=reqData.get('id')).first()
        print(obj.type.consulApi)
        if obj.type.consulApi:
            try:
                print(obj.name)
                domain = '.'.join(obj.name.split('.')[0:-2]) + '_server'
                print(domain)
                url = obj.type.consulApi + domain + '?recurse'
                ret = requests.get(url, timeout=10)
                return Response({'code': 20000, "data": json.loads(ret.text)})
            except Exception as e:
                error_logger.error(str(e))
                return Response({'code': 500, "msg": str(e)})

        else:
            return Response({'code': 400, 'msg': "conuslApi url is null !!"})


class consuladdView(APIView):
    """
    consul 新增接口
    """

    def post(self, request):
        reqData = request.data
        print(reqData)
        pk = reqData.get('id')
        ipList = reqData.get('ips')
        port = str(reqData.get('port')).replace(' ', '')
        print(pk, ipList, port)

        if len(ipList) == 0 or port.strip() == '':
            return Response({'code': 500, 'message': 'ip 或 port不能为空！！'})

        # 校验数据是否正确
        addList = []
        for ipnew in ipList:
            if len(ipnew) == 0:
                pass
            else:
                ipnew = str(ipnew).replace(' ', '')
                print(ipnew)
                ip_verify = basic_function.checkIp(ipnew)
                if not ip_verify:
                    result = 'Error: ip: {0} 不合法'.format(ipnew)
                    return Response({'code': 500, "message": result})
                addList.append(str(ipnew).replace(' ', ''))
        port_verify = basic_function.checkPort(port)
        if not port_verify or int(port) > 65535:
            result = 'Error: port: {0} 不合法'.format(port)
            return Response({'code': 500, "message": result})

        # 获取nginx数据
        obj = NginxConf.objects.filter(pk=pk).first()
        domain = '.'.join(obj.name.split('.')[0:-2]) + '_server'
        consulApi = obj.type.consulApi
        try:
            # import time
            for purl in addList:
                url = str(consulApi) + domain + '/' + str(purl) + ':' + str(port)
                command = '{"weight":1, "max_fails":2, "fail_timeout":10}'
                ret = requests.put(url, data=command, timeout=5)
                # time.sleep(1)
                if ret.status_code != 200:
                    return Response({'code': 500, 'message': '增加ip' + str(purl) + '失败!!'})
        except Exception as e:
            error_logger.error(str(e))
            return Response({'code': 500, 'msg': str(e)})
        return Response({'code': 20000, 'message': "添加成功！"})


class consulsubView(APIView):
    """
    consul 标记upstream down接口
    """

    def post(self, request):
        reqData = request.data
        print(reqData)
        pk = reqData.get('id')
        ipList = reqData.get('ips')
        port = str(reqData.get('port')).replace(' ', '')
        print(pk, ipList, port)

        if len(ipList) == 0 or port.strip() == '':
            return Response({'code': 500, 'message': 'ip 或 port不能为空！！'})

        # 校验数据是否正确
        addList = []
        for ipnew in ipList:
            if len(ipnew) == 0:
                pass
            else:
                ipnew = str(ipnew).replace(' ', '')
                print(ipnew)
                ip_verify = basic_function.checkIp(ipnew)
                if not ip_verify:
                    result = 'Error: ip: {0} 不合法'.format(ipnew)
                    return Response({'code': 500, "message": result})
                addList.append(str(ipnew).replace(' ', ''))
        port_verify = basic_function.checkPort(port)
        if not port_verify or int(port) > 65535:
            result = 'Error: port: {0} 不合法'.format(port)
            return Response({'code': 500, "message": result})

        # 获取nginx数据
        obj = NginxConf.objects.filter(pk=pk).first()
        domain = '.'.join(obj.name.split('.')[0:-2]) + '_server'
        consulApi = obj.type.consulApi
        # print(consulApi)
        try:
            # import time
            for purl in addList:
                url = str(consulApi) + domain + '/' + str(purl) + ':' + str(port)
                # command = '{"weight":1, "max_fails":2, "fail_timeout":10, "down":1}'
                print(url)
                ret = requests.delete(url, timeout=5)
                # time.sleep(1)
                if ret.status_code != 200:
                    return Response({'code': 500, 'message': '增加ip' + str(purl) + '失败!!'})
        except Exception as e:
            error_logger.error(str(e))
            return Response({'code': 500, 'msg': str(e)})
        return Response({'code': 20000, 'message': "添加成功！"})
