from django.urls import path, re_path, include
from django.conf import settings
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
# ng配置接口
router.register('ngconf', views.NginxConfigViewSet, 'ngconf')
# ng集群类型接口
router.register('ngmodel', views.NginxModelViewSet, 'ngmodel')
# ng操作日志接口
router.register('ngops', views.NginxOpsViewSet, 'ngops')

print(router.urls)
urlpatterns = [
    path('', include(router.urls)),
]