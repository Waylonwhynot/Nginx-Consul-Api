from .models import UserProfile,Permission,Role,Organization
from rest_framework import serializers
class CommonModelSerializer(serializers.ModelSerializer):
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)

# 组织
class OrgListSerializer(CommonModelSerializer):
    class Meta:
        model = Organization
        fields = '__all__'

class UserSerializer(CommonModelSerializer):
    department_name = serializers.ReadOnlyField(source="department.name")
    class Meta:
        model = UserProfile
        fields = '__all__'

class RoleSerializer(CommonModelSerializer):
    class Meta:
        model = Role
        fields = '__all__'

class PermissionChildSerializer(CommonModelSerializer):
    class Meta:
        model = Permission
        fields = '__all__'

class PermissionSerializer(CommonModelSerializer):
    class Meta:
        model = Permission
        fields = '__all__'