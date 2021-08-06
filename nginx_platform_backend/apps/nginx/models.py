from django.db import models

# Create your models here.
class NginxModel(models.Model):
    status = (
        ('running', '启用'),
        ('closed', '关闭')
    )
    nginx_types = (
        ('consul', 'consul'),
        ('default', 'default')
    )
    name = models.CharField(max_length=128, verbose_name="ng名称")
    desc = models.CharField(max_length=128, default="", blank=True, verbose_name="ng描述")
    managerIp = models.GenericIPAddressField(verbose_name="远程调用IP")
    confPath = models.CharField(max_length=512, verbose_name="ng配置路径")
    rmCmd = models.CharField(max_length=512, blank=True, null=True, verbose_name="删除命令")
    syncCmd = models.CharField(max_length=512, blank=True, null=True, verbose_name="同步命令")
    dumpCmd = models.CharField(max_length=512, blank=True, null=True, verbose_name="dump文件命令")
    reloadCmd = models.CharField(max_length=512, blank=True, null=True, verbose_name="reload命令")
    upstream_status_url = models.CharField(max_length=512, blank=True, null=True, verbose_name="upstream_status_url")
    upstream_show_url = models.CharField(max_length=512, blank=True, null=True, verbose_name="upstream_show_url")
    consulApi = models.CharField(max_length=512, blank=True, null=True, verbose_name="consulApi")
    template = models.TextField(default="", blank=True, verbose_name="站点模板")
    create_time = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    update_time = models.DateTimeField(auto_now=True, verbose_name="修改时间")
    region = models.CharField(max_length=64, verbose_name="所属机房")
    status = models.CharField(choices=status, max_length=16, default='running', verbose_name="使用状态")
    nginx_type = models.CharField(choices=nginx_types, max_length=16, default='default', verbose_name="nginx类型")
    # nginx_2_index = models.ForeignKey("elk.EsIndex", on_delete=models.SET_NULL, null=True, blank=True, verbose_name="关联ES索引")
    group_ops = models.CharField(max_length=64, blank=True, null=True, verbose_name="OPS操作组")

    class Meta:
        verbose_name = "Nginx管理"
        verbose_name_plural = verbose_name
        unique_together = ('name', 'region')

    def __str__(self):
        return "%s-%s" % (self.name, self.status)


class NginxConf(models.Model):
    status = (
        ('running', '启用'),
        ('closed', '关闭')
    )
    action_list = (
        ('running', '运行中'),
        ('success', '成功'),
        ('failed', '执行失败')
    )
    name = models.CharField(max_length=128, verbose_name="站点名称")
    type = models.ForeignKey(NginxModel, on_delete=models.SET_NULL, blank=True, null=True, verbose_name="关联ng模块")
    content = models.TextField(max_length=2000000, blank=True, null=True, verbose_name="ng配置")
    comments = models.CharField(default="", blank=True, max_length=256, verbose_name="备注")
    create_time = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    update_time = models.DateTimeField(auto_now=True, verbose_name="修改时间")
    status = models.CharField(choices=status, max_length=16, default="running", verbose_name="使用状态")
    appid = models.CharField(max_length=32, blank=True, null=True, verbose_name="站点APPID")
    dep_owner = models.CharField(max_length=128, blank=True, null=True, default='unknown', verbose_name="开发负责人")
    ops_owner = models.CharField(max_length=128, blank=True, null=True, default='unknown', verbose_name="运维负责人")
    qa_owner = models.CharField(max_length=128, blank=True, null=True, default='unknown', verbose_name="测试负责人")
    l1_biz = models.CharField(max_length=128, blank=True, null=True, default='unknown', verbose_name="一级业务")
    parent = models.CharField(max_length=128, blank=True, null=True, default='unknown', verbose_name="二级业务")
    conf_add_status = models.BooleanField(default=False, verbose_name="consul类型，首次生产data文件")
    action_ops = models.CharField(choices=action_list, max_length=16, default="success", verbose_name="发布action运行状态")

    class Meta:
        verbose_name = "Nginx配置"
        verbose_name_plural = verbose_name
        unique_together = ('name', 'type')

    def __str__(self):
        return "%s-%s" % (self.name, self.status)


class NginxInstanceOps(models.Model):
    """
    Nginx操作: sync, reload
    """
    status_list = (
        ('running', '运行中'),
        ('success', '执行成功'),
        ('failed', '执行失败')
    )
    action_list = (
        ('sync', 'sync'),
        ('reload', 'reload'),
        ('remove', 'remove'),
    )
    ops_2_conf = models.ForeignKey("NginxConf", on_delete=models.SET_NULL, null=True, blank=True, verbose_name="关联nginx配置")
    action_name = models.CharField(default="sync", choices=action_list, max_length=16, verbose_name="操作名称")
    create_time = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    ops_time = models.DateTimeField(auto_now=True, verbose_name="修改时间")
    operator = models.CharField(max_length=64, default="unknown", null=True, verbose_name="操作人")
    ops_status = models.CharField(choices=status_list, max_length=32, default="running", verbose_name="操作状态")

    class Meta:
        verbose_name_plural = 'Nginx操作表'

    def __str__(self):
        return "%s-%s" % (self.ops_2_conf, self.ops_status)


class NginxAction(models.Model):
    action_list = (
        ('SetConf', '生成配置'),
        ('dump_path', '生成dump文件'),
        ('sync', '同步操作'),
        ('reload', '重载操作'),
        ('dns_check', '域名验证'),
        ('es_check', '访问日志验证'),
        ('rm_conf', '移除配置文件')
    )
    status_list = (
        ('running', '运行中'),
        ('success', '执行成功'),
        ('failed', '执行失败')
    )
    action_2_ops = models.ForeignKey("NginxInstanceOps", on_delete=models.SET_NULL, null=True, blank=True, verbose_name="管理ops表")
    action = models.CharField(choices=action_list, max_length=64, verbose_name="动作")
    msg = models.TextField(max_length=40960, verbose_name="操作信息")
    operator = models.CharField(max_length=64, null=True, blank=True, verbose_name="操作人")
    action_status = models.CharField(choices=status_list, max_length=16, default="running", verbose_name="执行状态")
    ops_date = models.DateTimeField(auto_now=True, verbose_name='操作时间')

    class Meta:
        verbose_name_plural = 'NginxAction详情表'

    def __str__(self):
        return "%s-%s" % (self.action_2_ops, self.action_status)