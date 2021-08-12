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
router.register('menu', views.MenuView, 'MenuView')
# router.register('user', views.UserView, 'UserView')
router.register('permission', views.PermissionView, 'PermissionView'),
router.register('permissionlist', views.PermissionAllView, 'PermissionView'),
router.register('role', views.RoleView ,'RoView')
router.register('org', views.OrganizationView, 'OrgView')
router.register('userlist', views.UserAllView, 'UserAllView')
router.register('rolelist',views.RoleAllView,'RoleAllView')
router.register('orglist',views.OrgAllView,'OrgAllView')
router.register('menulist',views.MenuAllView,'MenuAllView')

router.register('permissionsearch', views.PermissionView, 'PermissionView'),
router.register('usersearch', views.UserAllView, 'UserAllView')
router.register('rolesearch',views.RoleAllView,'RoleAllView')
router.register('orgsearch',views.OrgAllView,'OrgAllView')
router.register('menusearch',views.MenuView,'MenuAllView')
urlpatterns = [
    # path('menu/tree/', views.MenuTreeView.as_view(), name='menus_tree'),
    path('user/info/', views.UserInfoView.as_view(), name='user_info'),
    path('user/login/', views.UserAuthView.as_view(), name='loginview'),
    path('user/logout/', views.logout, name='logout'),
    path('', include(router.urls)),
]
