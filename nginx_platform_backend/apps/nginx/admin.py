from django.contrib import admin

# Register your models here.
from . import models
admin.site.register(models.NginxConf)
admin.site.register(models.NginxModel)
admin.site.register(models.NginxAction)
admin.site.register(models.NginxInstanceOps)
