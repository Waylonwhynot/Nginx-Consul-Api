from django.db import models

import datetime


class BaseModel(models.Model):
    is_delete = models.BooleanField(default=False, verbose_name='是否删除')
    is_show = models.BooleanField(default=False, verbose_name='是否展示')
    created_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间', null=True)
    updated_time = models.DateTimeField(auto_now=True, verbose_name='更新时间', null=True)
    orders = models.IntegerField(verbose_name='顺序', null=True)

    class Meta:  # 不在数据库生成
        abstract = True
