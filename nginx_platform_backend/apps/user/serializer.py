from rest_framework import serializers
from .models import Menu,UserProfile,Permission,Role,Organization
import json
from rest_framework import serializers
from rest_framework import exceptions
from django.conf import settings
import re
from rest_framework_jwt.serializers import jwt_payload_handler, jwt_encode_handler
from django.core.cache import cache

#子菜单序列化类
# class MenuChildSerializer(serializers.ModelSerializer):
#     create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
#     update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
#     class Meta:
#         model = Menu
#         fields = '__all__'


class TreeSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    label = serializers.CharField(max_length=20, source='name')
    pid = serializers.PrimaryKeyRelatedField(read_only=True)

class MenuListSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    # children = serializers.SerializerMethodField(source='get_children')

    class Meta:
        model = Menu
        fields = '__all__'
        # fields = ["id","change_user","create_time","update_time","name","icon","path","is_frame","is_show","sort","component","pid","children"]

    # 获取子菜单
    # def get_children(self,obj):
    #     children_queryset = Menu.objects.filter(pid=obj.id)
    #     children_list = MenuChildSerializer(children_queryset,many=True).data
    #     return children_list



# 组织
class OrgListSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Organization
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    department_name = serializers.ReadOnlyField(source="department.name")
    class Meta:
        model = UserProfile
        fields = '__all__'

class RoleSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Role
        fields = '__all__'

class PermissionChildSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Permission
        fields = '__all__'

class PermissionSerializer(serializers.ModelSerializer):
    # children = serializers.SerializerMethodField(source='get_children')
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Permission
        fields = '__all__'
        # fields = ["id", "name","method", "change_user","create_time","update_time","pid", "children"]

    # # 获取子菜单
    # def get_children(self, obj):
    #     children_queryset = Permission.objects.filter(pid=obj.id)
    #     children_list = PermissionChildSerializer(children_queryset, many=True).data
    #     return children_list

# 登录认证序列化类
class LoginSerializer(serializers.ModelSerializer):
    username = serializers.CharField(max_length=32) # 数据库唯一字段
    class Meta:
        model = UserProfile
        fields = ['id','username','password']
        extra_kwargs = {
            'username':{'write_only':True},
            'password':{'write_only':True}
        }


    def _get_user(self,attrs):
        username = attrs.get('username')
        # if re.match(r'^1[3-9][0-9]{9}$', username):
        #     user = UserProfile.objects.filter(mobile=username).first()
        # elif re.match(r'^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-z]{2,}$', username):
        #     user = UserProfile.objects.filter(email=username).first()
        # else:
        user = UserProfile.objects.filter(username=username).first()
        if not user:
            raise exceptions.ValidationError({'username': 'username error'})

        password = attrs.get('password')
        if not user.check_password(password):
            raise exceptions.ValidationError({'password': 'password error'})

        return user

    def _get_token(self, user):
        payload = jwt_payload_handler(user)
        token = jwt_encode_handler(payload)
        return token

    def validate(self, attrs):
        user = self._get_user(attrs)
        token = self._get_token(user)
        self.context['token'] = token
        self.context['user'] = user
        # request = self.context['request']
        # icon = 'http://%s%s%s' % (request.META['HTTP_HOST'], settings.MEDIA_URL, user.icon)
        # self.context['icon'] = icon
        return attrs

class MenuSerializer(serializers.ModelSerializer):
    '''
    菜单序列化
    '''

    class Meta:
        model = Menu
        fields = ('id', 'name', 'icon', 'path', 'is_show','is_frame', 'sort', 'component', 'pid')
        extra_kwargs = {'name': {'required': True, 'error_messages': {'required': '必须填写菜单名'}}}
