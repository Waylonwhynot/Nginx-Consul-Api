from rest_framework import serializers
from .models import Menu,UserProfile,Permission,Role,Organization
import json

#子菜单序列化类
class MenuChildSerializer(serializers.ModelSerializer):
    class Meta:
        model = Menu
        fields = '__all__'

class MenuListSerializer(serializers.ModelSerializer):
    children = serializers.SerializerMethodField(source='get_children')
    class Meta:
        model = Menu
        fields = ["id","change_user","create_time","update_time","name","icon","path","is_frame","is_show","sort","component","pid","children"]

    # 获取子菜单
    def get_children(self,obj):
        children_queryset = Menu.objects.filter(pid=obj.id)
        children_list = MenuChildSerializer(children_queryset,many=True).data
        return children_list



# 组织
class OrgListSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Organization
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class RoleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Role
        fields = '__all__'

class PermissionChildSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = '__all__'

class PermissionSerializer(serializers.ModelSerializer):
    children = serializers.SerializerMethodField(source='get_children')
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    class Meta:
        model = Permission
        fields = ["id", "name","method", "change_user","create_time","update_time","pid", "children"]

    # 获取子菜单
    def get_children(self, obj):
        children_queryset = Permission.objects.filter(pid=obj.id)
        children_list = PermissionChildSerializer(children_queryset, many=True).data
        return children_list




