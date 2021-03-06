from .serializer import OrgListSerializer,RoleSerializer,PermissionSerializer,UserSerializer
from . import models
from .pagination import BasicPagination
from rest_framework.filters import SearchFilter, OrderingFilter
from libs.views import CommonModelViewSet,MyListAPIView
from django.http.response import JsonResponse
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework_jwt.serializers import jwt_payload_handler, jwt_encode_handler
import json
from utils.response import APIResponse
from django_redis import get_redis_connection

# 用户信息查询接口
class UserView(CommonModelViewSet):
    queryset = models.UserProfile.objects.all()
    serializer_class = UserSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['username', 'mobile']  # 按search字段模糊搜索 SearchFilter

# 角色接口
class RoleView(CommonModelViewSet):
    queryset = models.Role.objects.all()
    serializer_class = RoleSerializer
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['name',]

# 组织架构接口
class OrganizationView(CommonModelViewSet):
    queryset = models.Organization.objects.all()
    serializer_class = OrgListSerializer
    filter_backends = [SearchFilter,OrderingFilter]
    # filter_backends = [SearchFilter,DjangoFilterBackend,OrderingFilter]
    search_fields = ['name', 'type'] # 按search字段模糊搜索 SearchFilter
    # filter_fields = ['id','name', 'type'] # 按字段精确搜索 DjangoFilterBackend

# 权限接口
class PermissionView(CommonModelViewSet):
    queryset = models.Permission.objects.all().order_by('-id')
    serializer_class = PermissionSerializer
    pagination_class = BasicPagination
    filter_backends = [SearchFilter, OrderingFilter]
    search_fields = ['name', 'method']

# # 查询所有权限（不加分页）
class PermissionListView(MyListAPIView):
    queryset = models.Permission.objects.all().order_by('-id')
    serializer_class = PermissionSerializer

class PermissionsMethodsAPIView(APIView):

    """
    model choice字段API, 需指定choice属性或覆盖get_choice方法
    """
    choice = models.Permission.method_choices
    def get(self, request):
        methods = [{'value': value[0], 'label': value[1]} for value in self.get_choice()]
        return APIResponse(data={'results': methods})

    def get_choice(self):
        assert self.choice is not None, (
                "'%s' 应该包含一个`choice`属性,或覆盖`get_choice()`方法."
                % self.__class__.__name__
        )
        assert isinstance(self.choice, tuple) and len(self.choice) > 0, 'choice数据错误, 应为二维元组'
        for values in self.choice:
            assert isinstance(values, tuple) and len(values) == 2, 'choice数据错误, 应为二维元组'
        return self.choice

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
                for item in request.user.roles.values('permissions__sign').distinct():
                    perms_list.append(item['permissions__sign'])
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
                'email': request.user.email,
                'is_active': request.user.is_active,
                'createTime': request.user.date_joined,
                'mobile': request.user.mobile,
                'permissions': perms
            }
            print(data)
            return JsonResponse({'code': 20000, 'data': data})
        else:
            print('未获取到用户信息')
            return JsonResponse({'code': 50008, 'message': '请先登录'})

def logout(request):
    response = JsonResponse({'code': 20000, 'status': 'success'})
    response.delete_cookie('Admin-Token')
    return response