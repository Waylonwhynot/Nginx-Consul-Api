from django.shortcuts import render
from rest_framework.viewsets import GenericViewSet,ModelViewSet
from rest_framework.mixins import ListModelMixin
from .serializer import MenuListSerializer,OrgListSerializer,RoleSerializer,PermissionSerializer,UserSerializer,TreeSerializer,LoginSerializer
from . import models
from .pagination import BasicPagination
from libs.views import MyListModelMixin
from .SearchBackend import SearchByName
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from libs.views import CommonModelViewSet
from utils.response import APIResponse
from rest_framework.generics import ListAPIView
from rest_framework.viewsets import ViewSet
from rest_framework.decorators import action
from django.http.response import JsonResponse
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework_jwt.serializers import jwt_payload_handler, jwt_encode_handler
from .models import Menu
from .serializer import MenuSerializer
from operator import itemgetter
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from utils.permissions import RbacPermission
import json


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
    queryset = models.Menu.objects.all()
    serializer_class = MenuListSerializer

    #搜索功能
    filter_backends = [SearchFilter]
    search_fields = ['name', 'id',]

class MenuAllView(CommonModelViewSet):
    queryset = models.Menu.objects.all()
    serializer_class = MenuListSerializer

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

class PermissionView(CommonModelViewSet):
    queryset = models.Permission.objects.all()
    serializer_class = PermissionSerializer
    pagination_class = BasicPagination
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['name', 'method']

class PermissionAllView(CommonModelViewSet):
    queryset = models.Permission.objects.all()
    serializer_class = PermissionSerializer

# 用户信息查询接口
class UserAllView(CommonModelViewSet):
    queryset = models.UserProfile.objects.all()
    serializer_class = UserSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    # # filter_backends = [SearchFilter,DjangoFilterBackend,OrderingFilter]
    search_fields = ['username', 'mobile']  # 按search字段模糊搜索 SearchFilter


# 用户登录接口
# class LoginView(ViewSet):
#
#     @action(methods=['post'],detail=False)
#     def loging(self,request,*args,**kwargs):
#         ser = LoginSerializer(data=request.data,context={'request':request})
#         if ser.is_valid():
#             token = ser.context['token']
#             user = ser.context['user']
#             # icon = ser.context['icon']
#             return APIResponse(id=user.id,username=user.username,data={'token':token})
#         else:
#             return APIResponse(code=1,message='用户名或者密码错误')

from django_redis import get_redis_connection
class UserAuthView(APIView):
    '''
    用户认证获取token
    '''
    authentication_classes = []
    permission_classes = []
    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(username=username, password=password)

        if user:
            conn = get_redis_connection('user_info')
            conn.incr('visits')

            payload = jwt_payload_handler(user)
            jwt_token = jwt_encode_handler(payload)
            return JsonResponse({
                'code': 20000,
                'message': '登录成功',
                'data': {
                    'token': jwt_token
                    # 'token': 'admin'
                }
            })
        else:
            return JsonResponse({
                'code': 20001,
                'message': '用户名或密码错误'
            })


class UserInfoView(APIView):
    '''
    获取当前用户信息和权限
    '''
    # authentication_classes = (JSONWebTokenAuthentication,)
    @classmethod
    def get_permission_from_role(self, request):
        try:
            if request.user:
                perms_list = []
                for item in request.user.roles.values('permissions__method').distinct():
                    perms_list.append(item['permissions__method'])
                return perms_list
        except AttributeError:
            return None

    def get(self, request):
        if request.user.id is not None:

            user_info = request.user.get_user_info()
            # 将用户信息缓存到redis
            conn = get_redis_connection('user_info')
            if request.user.is_superuser and 'admin' not in user_info['permissions']:
                user_info['permissions'].append('admin')
            user_info['permissions'] = json.dumps(user_info['permissions'])
            print('用户的信息是',user_info)
            # user_info['avatar'] = request._current_scheme_host + user_info.get('avatar')
            conn.hmset('user_info_%s' % request.user.id, user_info)
            conn.expire('user_info_%s' % request.user.id, 60 * 60 * 24)  # 设置过期时间为1天
            # user_info['permissions'] = json.loads(user_info['permissions'])


            perms = self.get_permission_from_role(request)
            data = {
                'id': request.user.id,
                'username': request.user.username,
                # 'avatar': request._request._current_scheme_host + '/media/image/default.png',
                # 'email': request.user.email,
                'is_active': request.user.is_active,
                'createTime': request.user.date_joined,
                'roles': perms
            }
            print('用户权限获取成功')
            return JsonResponse({'code': 20000, 'data': data})
        else:
            print('未获取到用户信息')
            return JsonResponse({'code': 50008, 'message': '请先登录'})

class UserBuildMenuView(APIView):
    '''
    绑定当前用户菜单信息
    '''
    def get_menu_from_role(self, request):
        if request.user:
            menu_dict = {}
            menus = request.user.roles.values(
                'menus__id',
                'menus__name',
                'menus__path',
                'menus__is_frame',
                'menus__is_show',
                'menus__component',
                'menus__icon',
                'menus__sort',
                'menus__pid'
            ).distinct()
            for item in menus:
                if item['menus__pid'] is None:
                    if item['menus__is_frame']:
                        # 判断是否外部链接
                        top_menu = {
                            'id': item['menus__id'],
                            'path': item['menus__path'],
                            'component': 'Layout',
                            'children': [{
                                'path': item['menus__path'],
                                'meta': {
                                    'title': item['menus__name'],
                                    'icon': item['menus__icon']
                                }
                            }],
                            'pid': item['menus__pid'],
                            'sort': item['menus__sort']
                        }
                    else:
                        top_menu = {
                            'id': item['menus__id'],
                            'name': item['menus__path'],
                            'path': '/' + item['menus__path'],
                            'redirect': 'noredirect',
                            'component': 'Layout',
                            'alwaysShow': True,
                            'meta': {
                                'title': item['menus__name'],
                                'icon': item['menus__icon']
                            },
                            'pid': item['menus__pid'],
                            'sort': item['menus__sort'],
                            'children': []
                        }
                    menu_dict[item['menus__id']] = top_menu
                else:
                    if item['menus__is_frame']:
                        children_menu = {
                            'id': item['menus__id'],
                            'name': item['menus__path'],
                            'path': item['menus__path'],
                            'component': 'Layout',
                            'meta': {
                                'title': item['menus__name'],
                                'icon': item['menus__icon'],
                            },
                            'pid': item['menus__pid'],
                            'sort': item['menus__sort']
                        }
                    elif item['menus__is_show']:
                        children_menu = {
                            'id': item['menus__id'],
                            'name': item['menus__path'],
                            'path': item['menus__path'],
                            'component': item['menus__component'],
                            'meta': {
                                'title': item['menus__name'],
                                'icon': item['menus__icon'],
                            },
                            'pid': item['menus__pid'],
                            'sort': item['menus__sort']
                        }
                    else:
                        children_menu = {
                            'id': item['menus__id'],
                            'name': item['menus__path'],
                            'path': item['menus__path'],
                            'component': item['menus__component'],
                            'meta': {
                                'title': item['menus__name'],
                                'noCache': True,
                            },
                            'hidden': True,
                            'pid': item['menus__pid'],
                            'sort': item['menus__sort']
                        }
                    menu_dict[item['menus__id']] = children_menu
            return menu_dict

    def get_all_menu_dict(self):
        '''
        获取所有菜单数据，重组结构
        '''
        menus = Menu.objects.all()
        serializer = MenuSerializer(menus, many=True)
        tree_dict = {}
        for item in serializer.data:
            if item['pid'] is None:
                if item['is_frame']:
                    # 判断是否外部链接
                    top_menu = {
                        'id': item['id'],
                        'path': item['path'],
                        'component': 'Layout',
                        'children': [{
                            'path': item['path'],
                            'meta': {
                                'title': item['name'],
                                'icon': item['icon']
                            }
                        }],
                        'pid': item['pid'],
                        'sort': item['sort']
                    }
                else:
                    top_menu = {
                        'id': item['id'],
                        'name': item['path'],
                        'path': '/' + item['path'],
                        'redirect': 'noredirect',
                        'component': 'Layout',
                        'alwaysShow': True,
                        'meta': {
                            'title': item['name'],
                            'icon': item['icon']
                        },
                        'pid': item['pid'],
                        'sort': item['sort'],
                        'children': []
                    }
                tree_dict[item['id']] = top_menu
            else:
                if item['is_frame']:
                    children_menu = {
                        'id': item['id'],
                        'name': item['path'],
                        'path': item['path'],
                        'component': 'Layout',
                        'meta': {
                            'title': item['name'],
                            'icon': item['icon'],
                        },
                        'pid': item['pid'],
                        'sort': item['sort']
                    }
                elif item['is_show']:
                    children_menu = {
                        'id': item['id'],
                        'name': item['path'],
                        'path': item['path'],
                        'component': item['component'],
                        'meta': {
                            'title': item['name'],
                            'icon': item['icon'],
                        },
                        'pid': item['pid'],
                        'sort': item['sort']
                    }
                else:
                    children_menu = {
                        'id': item['id'],
                        'name': item['path'],
                        'path': item['path'],
                        'component': item['component'],
                        'meta': {
                            'title': item['name'],
                            'noCache': True,
                        },
                        'hidden': True,
                        'pid': item['pid'],
                        'sort': item['sort']
                    }
                tree_dict[item['id']] = children_menu
        return tree_dict

    def get_all_menus(self, request):
        perms = UserInfoView.get_permission_from_role(request)
        tree_data = []
        if 'admin' in perms or request.user.is_superuser:
            tree_dict = self.get_all_menu_dict()
        else:
            tree_dict = self.get_menu_from_role(request)
        for i in tree_dict:
            if tree_dict[i]['pid']:
                pid = tree_dict[i]['pid']
                parent = tree_dict[pid]
                parent.setdefault('redirect', 'noredirect')
                parent.setdefault('alwaysShow', True)
                parent.setdefault('children', []).append(tree_dict[i])
                parent['children'] = sorted(parent['children'], key=itemgetter('sort'))
            else:
                tree_data.append(tree_dict[i])
        return tree_data

    def get(self, request):
        if request.user.id is not None:
            menu_data = self.get_all_menus(request)
            return JsonResponse({'code':20000, 'data': menu_data, 'message': '成功'})
        else:
            return JsonResponse({'message': '请登录后访问!', 'code': 20000})

def logout(request):
    response = JsonResponse({'code': 20000, 'status': 'success'})

    response.delete_cookie('Admin-Token')
    return response