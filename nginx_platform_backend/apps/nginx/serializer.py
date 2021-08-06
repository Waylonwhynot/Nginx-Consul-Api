from rest_framework import serializers
from .models import NginxConf

class NginxConfSerializer(serializers.ModelSerializer):
    class Meta:
        model = NginxConf
        fields = '__all__'

