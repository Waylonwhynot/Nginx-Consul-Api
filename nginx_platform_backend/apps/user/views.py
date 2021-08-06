from django.shortcuts import render
from rest_framework.viewsets import GenericViewSet
from rest_framework.mixins import ListModelMixin
from .serializer import MenuListSerializer,OrgListSerializer,RoleSerializer,PermissionSerializer,UserSerializer
from . import models
from libs.views import MyListModelMixin
from .SearchBackend import SearchByName
from rest_framework.filters import SearchFilter

# Create your views here.

class MenuListView(GenericViewSet,MyListModelMixin):
    queryset = models.Menu.objects.filter(pid=None)
    serializer_class = MenuListSerializer

    # 纯自己写
    filter_backends = [SearchFilter]

    # 继承它GenericAPIView可以配置它filter_backends=自己定义的搜索类，重写filter_queryset方法，就能完成搜索
    search_fields = ['name', 'id',]

class UserListView(GenericViewSet,MyListModelMixin):
    queryset = models.UserProfile.objects.all()
    serializer_class = UserSerializer

class OrganizationView(GenericViewSet,MyListModelMixin):
    queryset = models.Organization.objects.all()
    serializer_class = OrgListSerializer

class RoleView(GenericViewSet,MyListModelMixin):
    queryset = models.Role.objects.all()
    serializer_class = RoleSerializer

class PermissionView(GenericViewSet,MyListModelMixin):
    queryset = models.Permission.objects.all()
    serializer_class = PermissionSerializer