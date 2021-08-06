from rest_framework import serializers
from .models import Menu
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

