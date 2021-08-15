import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nginx_platform_backend.settings.dev')
from channels.routing import ProtocolTypeRouter, URLRouter
from django.urls import re_path

from nginx_platform_backend.utils.websocket import TokenAuthMiddleware
from monitor.consumer import service

django.setup()
# 配置websocket路由
application = ProtocolTypeRouter({
    'websocket': TokenAuthMiddleware(
        URLRouter([
            re_path(r'^monitor/service', service.ResourcesConsumer),
        ])
    )
})
