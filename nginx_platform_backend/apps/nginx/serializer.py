from rest_framework import serializers
from .models import NginxConf




class NginxConfSerializer(serializers.ModelSerializer):
    # 日期
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    type_name = serializers.ReadOnlyField(source="type.name")
    class Meta:
        model = NginxConf
        fields = '__all__'
        # extra_kwargs = {
        #     'type_name': {'read_only': True},
        # }

