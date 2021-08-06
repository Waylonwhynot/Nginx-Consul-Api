from django.db import models
class CbaseModel(models.Model):
    """基础配置"""

    change_user = models.CharField(max_length=64, blank=True, null=True, verbose_name='修改人', default='admin')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        abstract = True # 抽象类，不生成数据库表单
        #default_permissions = ('get', 'add', 'change', 'delete')
        #默认值为 ('add', 'change', 'delete', 'view') 。你可以自定义这个列表，例如，如果你的应用不需要任何默认的权限，可以将其设置为空列表。它必须在模型创建之前通过 migrate 在模型上指定，以防止任何遗漏的权限被创建。
