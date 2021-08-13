from django.urls import path
from .views import service

urlpatterns = [
    path('service/', service.ServiceMonitorAPIView.as_view()),  # 服务监控
]
