from django.urls import path, include
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
# 用户 、角色 、权限、组织增删改查接口
router.register('permission', views.PermissionView, 'PermissionView'),
router.register('role', views.RoleView ,'RoView')
router.register('org', views.OrganizationView, 'OrgView')
router.register('user', views.UserView, 'UserView')

urlpatterns = [
    path('user/info/', views.UserInfoView.as_view(), name='user_info'),
    path('user/login/', views.UserAuthView.as_view(), name='loginview'),
    path('user/logout/', views.logout, name='logout'),
    path('permissions/methods/', views.PermissionsMethodsAPIView.as_view()),
    path('permissionlist/',views.PermissionListView.as_view()),
    path('', include(router.urls)),
]
