"""nginx_platform_backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, re_path, include
from django.views.static import serve
from django.conf import settings
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()

# 用户 、角色 、权限、组织增删改查接口
router.register('permission', views.PermissionView, 'PermissionView'),
router.register('role', views.RoleView ,'RoView')
router.register('org', views.OrganizationView, 'OrgView')

# 用户 、角色 、权限、菜单、组织查询所有接口
router.register('userlist', views.UserAllView, 'UserListView')
router.register('rolelist',views.RoleView,'RoleListView')
router.register('permissionlist', views.PermissionAllView, 'PermissionListView'),
router.register('orglist',views.OrganizationView,'OrgListView')

# 搜索接口
router.register('permissionsearch', views.PermissionView, 'PermissionSearchView'),
router.register('usersearch', views.UserAllView, 'UserSearchView')
router.register('rolesearch',views.RoleView,'RoleSearchView')
router.register('orgsearch',views.OrganizationView,'OrgSearchView')
urlpatterns = [
    path('user/info/', views.UserInfoView.as_view(), name='user_info'),
    path('user/login/', views.UserAuthView.as_view(), name='loginview'),
    path('user/logout/', views.logout, name='logout'),
    path('permissions/methods/', views.PermissionsMethodsAPIView.as_view()),
    path('', include(router.urls)),
]
