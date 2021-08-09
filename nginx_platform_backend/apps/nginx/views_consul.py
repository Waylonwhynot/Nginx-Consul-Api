from rest_framework.views import APIView

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
                return Response({'status': 200, "data": json.loads(ret.text)})
            except Exception as e:
                error_logger.error(str(e))
                return Response({'status': 500, "msg": str(e)})

        else:
            return Response({'status': 400, 'msg': "conuslApi url is null !!"})