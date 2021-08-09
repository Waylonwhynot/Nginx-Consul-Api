from rest_framework import serializers
from . import models


class NginxConfSerializer(serializers.ModelSerializer):
    # 日期
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    type_name = serializers.ReadOnlyField(source="type.name")

    class Meta:
        model = models.NginxConf
        fields = '__all__'
        # extra_kwargs = {
        #     'type_name': {'read_only': True},
        # }


class NginxModelSerializer(serializers.ModelSerializer):
    # 日期
    update_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    conf_count = serializers.SerializerMethodField(label="配置文件数量")
    name = serializers.CharField(label='名称', max_length=32, min_length=3, required=True, help_text='集群名称',
                                 error_messages={
                                     "max_length": "最大128个字符",
                                     "min_length": "最少4个字符",
                                     "required": "集群名称不能为空"
                                 })
    managerIp = serializers.IPAddressField(label='管理IP', required=True, help_text='管理IP',
                                           error_messages={
                                               "required": "管理IP不能为空"
                                           })
    confPath = serializers.CharField(label='远程配置目录', max_length=512, required=True, help_text='远程配置目录',
                                     error_messages={
                                         "max_length": "最大512个字符",
                                         "required": "远程配置目录不能为空"
                                     })
    region = serializers.CharField(label='机房', max_length=64, required=True, help_text='机房',
                                   error_messages={
                                       "max_length": "最大64个字符",
                                       "required": "机房信息不能为空"
                                   })

    class Meta:
        model = models.NginxModel
        fields = '__all__'

    def get_conf_count(self, instace):
        count = instace.nginxconf_set.count()
        return count


class NginxOpsSerializer(serializers.ModelSerializer):
    # 日期
    ops_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    create_time = serializers.DateTimeField(format='%Y-%m-%d %H:%M', required=False, read_only=True)
    nginx_conf = serializers.ReadOnlyField(source="ops_2_conf.name")
    nginx_type_name = serializers.ReadOnlyField(source="type.nginx_type")
    class Meta:
        model = models.NginxInstanceOps
        fields = '__all__'


class NginxActionSerializer(serializers.ModelSerializer):
    """
    nginx 操作详情
    """
    ops_date = serializers.DateTimeField(format="%Y-%m-%d %H:%M:%S")
    action_2_ops_display = serializers.ReadOnlyField(source='action_2_ops.action_name')

    class Meta:
        model = models.NginxAction
        fields = '__all__'
