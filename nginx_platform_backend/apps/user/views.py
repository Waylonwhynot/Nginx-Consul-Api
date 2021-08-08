from django.shortcuts import render
from rest_framework.viewsets import GenericViewSet,ModelViewSet
from rest_framework.mixins import ListModelMixin
from .serializer import MenuListSerializer,OrgListSerializer,RoleSerializer,PermissionSerializer,UserSerializer,TreeSerializer
from . import models
from libs.views import MyListModelMixin
from .SearchBackend import SearchByName
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from libs.views import CommonModelViewSet
from utils.response import APIResponse
from rest_framework.generics import ListAPIView

# Create your views here.

# 菜单展示

class TreeAPIView(ListAPIView):
    '''
    自定义树结构View
    '''
    serializer_class = TreeSerializer
    # authentication_classes = (JSONWebTokenAuthentication,)
    # permission_classes = (IsAuthenticated,)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        page = self.paginate_queryset(queryset)
        serializer = self.get_serializer(queryset, many=True)
        tree_dict = {}
        tree_data = []
        try:
            for item in serializer.data:
                tree_dict[item['id']] = item
            for i in tree_dict:
                if tree_dict[i]['pid']:
                    pid = tree_dict[i]['pid']
                    parent = tree_dict[pid]
                    parent.setdefault('children', []).append(tree_dict[i])
                else:
                    tree_data.append(tree_dict[i])
            results = tree_data
        except KeyError:
            results = serializer.data
        if page is not None:
            return self.get_paginated_response(results)
        # print(results)
        return APIResponse(results)



class MenuTreeView(TreeAPIView):
    '''
    菜单树
    '''
    queryset = models.Menu.objects.all()

class MenuView(CommonModelViewSet):
    queryset = models.Menu.objects.filter()
    serializer_class = MenuListSerializer

    #搜索功能
    filter_backends = [SearchFilter]
    search_fields = ['name', 'id',]

# 组织架构接口
class OrganizationView(CommonModelViewSet):
    queryset = models.Organization.objects.all()
    serializer_class = OrgListSerializer
    filter_backends = [SearchFilter,OrderingFilter]
    # filter_backends = [SearchFilter,DjangoFilterBackend,OrderingFilter]
    search_fields = ['name', 'type'] # 按search字段模糊搜索 SearchFilter
    # filter_fields = ['id','name', 'type'] # 按字段精确搜索 DjangoFilterBackend

# 角色接口
class RoleView(CommonModelViewSet):
    queryset = models.Role.objects.all()
    serializer_class = RoleSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['name',]
# 权限接口

class PermissionView(GenericViewSet,MyListModelMixin):
    queryset = models.Permission.objects.all()
    serializer_class = PermissionSerializer

# 用户接口
class UserView(CommonModelViewSet):
    queryset = models.UserProfile.objects.all()
    serializer_class = UserSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    # filter_backends = [SearchFilter,DjangoFilterBackend,OrderingFilter]
    search_fields = ['username', 'mobile']  # 按search字段模糊搜索 SearchFilter


