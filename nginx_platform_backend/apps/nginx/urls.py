from django.urls import path, re_path, include
from django.conf import settings
from . import views
from . import views_nginx_operation
from . import views_consul
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
# ng配置接口
router.register('ngconf', views.NginxConfigViewSet, 'ngconf')
# ng集群类型接口
router.register('ngmodel', views.NginxModelViewSet, 'ngmodel')
# ng操作日志接口(未开放按钮)
router.register('ngops', views.NginxOpsViewSet, 'nginstaceops')

print(router.urls)
urlpatterns = [
    path('', include(router.urls)),
    # nginx 操作模块
    path('ops/sync/', views_nginx_operation.NginxSyncView.as_view(), name='opsng-ops-sync'),
    path('ops/reload/', views_nginx_operation.NginxReloadView.as_view(), name='opsng-ops-reload'),
    path('ops/remove/', views_nginx_operation.NginxRemoveView.as_view(), name='opsng-ops-remove'),
    # consul 操作模块
    path('consul/status/', views_consul.consulStatusView.as_view(), name='opsng-consul-select'),
    path('consul/add/', views_consul.consuladdView.as_view(), name='opsng-consul-add'),
    path('consul/sub/', views_consul.consulsubView.as_view(), name='opsng-consul-sub'),
]