from django.shortcuts import render
from rest_framework.viewsets import GenericViewSet,ModelViewSet
from rest_framework.mixins import ListModelMixin
from .serializer import MenuListSerializer,OrgListSerializer,RoleSerializer,PermissionSerializer,UserSerializer
from . import models
from libs.views import MyListModelMixin
from .SearchBackend import SearchByName
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from libs.views import CommonModelViewSet

# Create your views here.

class MenuListView(GenericViewSet,MyListModelMixin):
    queryset = models.Menu.objects.filter(pid=None)
    serializer_class = MenuListSerializer

    #搜索功能
    filter_backends = [SearchFilter]
    search_fields = ['name', 'id',]

class UserListView(GenericViewSet,MyListModelMixin):
    queryset = models.UserProfile.objects.all()
    serializer_class = UserSerializer

class OrganizationView(CommonModelViewSet):
    queryset = models.Organization.objects.all()
    serializer_class = OrgListSerializer
    filter_backends = [SearchFilter,OrderingFilter]
    # filter_backends = [SearchFilter,DjangoFilterBackend,OrderingFilter]
    search_fields = ['name', 'type'] # 按search字段模糊搜索 SearchFilter
    # filter_fields = ['id','name', 'type'] # 按字段精确搜索 DjangoFilterBackend

class RoleView(GenericViewSet,MyListModelMixin):
    queryset = models.Role.objects.all()
    serializer_class = RoleSerializer

class PermissionView(GenericViewSet,MyListModelMixin):
    queryset = models.Permission.objects.all()
    serializer_class = PermissionSerializer

class UserView(ModelViewSet):
    ...
