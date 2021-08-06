from django.urls import path, re_path, include
from django.conf import settings
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register('ngconf', views.NginxConfigViewSet, 'NginxConfigViewSet')

print(router.urls)
urlpatterns = [
    path('', include(router.urls)),
]