from django.contrib import admin

# Register your models here.
from . import models
admin.site.register(models.UserProfile)
admin.site.register(models.Menu)
admin.site.register(models.Permission)
admin.site.register(models.Role)
admin.site.register(models.Organization)