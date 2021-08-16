```
print('开始Rbac权限认证')
```

# Nginx Devops System

<img src="https://gitee.com/gtdong/images/raw/master/blog/nginx.png" style="zoom:50%;" align="left"/>

## 1.前端布局搭建

基于[vue-admin-template](https://github.com/PanJiaChen/vue-admin-template)开发,使用了**Vuex**做全局状态管理(存储用户访问过程中的相关信息),**导航守卫**控制用户的访问路线,**自定义指令控**制页面元素的展示与否

### Build Setup

```
# clone the project
git clone https://gitee.com/gtdong/nginx-consul-frontend.git

# enter the project directory
cd nginx-consul-frontend

# install dependency
npm install

# develop
npm run dev
```

### 配置

```js
// 1.跨域问题解决 vue.config.js
proxy: {
      [process.env.VUE_APP_BASE_API]: {
        target: 'http://127.0.0.1:8000/api',
        changeOrigin: true, // 开启代理服务器,
        pathRewrite: {
          [ '^' + process.env.VUE_APP_BASE_API]: ''
        }
      }
    }
  },
    
// 2.环境变量配置  .env.development
# just a flag
ENV = 'development'

# base api
VUE_APP_BASE_API = '/api' //api接口前缀，访问api接口都是通过 /api/...的形式

# base websocket
VUE_APP_WS_API = 'ws://127.0.0.1:8000' //web_socket接口

// 3.title配置 src/settings
title: 'Nginx后台管理系统',
  
// 4.response状态码配置 src/utils/request.js
  if (res.code !== 20000) {
    Message({
      message: res.message || 'Error',
      type: 'error',
      duration: 5 * 1000
    })
  
// 4.路由配置 src/router.js
// 配置constantRoutes(没有权限的路由) 和 asyncRoutes(有权限要求的页面，用户有meta.permissions中对应的权限之一，才可以访问。)
   
// 5.路由拦截器配置 src/permission.js   
// 根据用户的权限 ，动态生成可访问的路线图accessRoutes router.addRoutes(accessRoutes)动态添加可访问的路线
    
// 6.权限配置： 首先为用户设置角色，为角色分配对应的权限
// 菜单权限配置  控制菜单的展示或者不展示
// src/router.js中配置asyncRoutes的meta.permissions字段
meta: { title: '用户管理', icon: 'user', permissions: ['admin', 'system-users'], noCache: true }
    
// 页面元素权限(可控制元素的展示与否、可点与否)
// 在你需要控制页面元素的中定义 v-permission(自定义指令)  or disabled属性  v-permission控制元素展示不展示，disabled控制可点不可点
<el-button :disabled="!['admin','system-org-delete']" v-permission="['admin','system-org-delete']" type="danger" @click="handleDelete(scope.row.id)" size="mini">删除</el-button>
    
<el-button v-permission="['admin','system-org-delete']" type="danger" @click="handleDelete(scope.row.id)" size="mini">删除</el-button>
    
// 7.自定义指令配置: src/directive/permission.js  定义v-permission的操作
// 
import store from '@/store'
    
function checkPermission(el, binding) {
  const { value } = binding
  // const permissions = store.getters && store.getters.permissions  //第一种方式 ，有bug页面刷新数不会重新渲染
  // permissions = store.getters && store.getters.permissions //第二种方式可以，但不太好
  global.ButtonPermissions = JSON.parse(sessionStorage.getItem('ButtonPermissions'))  // 第三种方式，推荐，在登录后获取用户信息时将用户的按钮权限存到本地缓存中sessionStorage
  console.log('用户的按钮权限是-----------',global.ButtonPermissions)
  if (value && value instanceof Array) {
    if (value.length > 0) {
      const permissionRoles = value

      const hasPermission = global.ButtonPermissions.some(permission => {
        return permissionRoles.includes(permission)
      })

      if (!hasPermission) {
        el.parentNode && el.parentNode.removeChild(el)
      }
    }
  } else {
    throw new Error(`need roles! Like v-permission="['admin','editor']"`)
  }
}

export default {
  inserted(el, binding) {
    checkPermission(el, binding)
  },
  update(el, binding) {
    checkPermission(el, binding)
  }
}
    
```



## 2.RBAC表结构设计

```python
'''

1.用户表: 继承AbstactUser表和自定义基表CbaseModel
		姓名
		手机号码
		邮箱
		头像
		部门：和组织架构关联、一对多
		职位
		上级主管：自关联
		角色：和角色关联、多对多
		
2.权限表
		权限名
		方法
		父权限:自关联
		
3.角色表
		角色
		权限：和权限表关联、多对多
		描述
		

4.组织架构表
		名称
		类型
		副组织:自关联


CbaseModel表
'''

# CbaseModel表
class CbaseModel(models.Model):
    """基础配置"""

    change_user = models.CharField(max_length=64, blank=True, null=True, verbose_name='修改人', default='admin')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        abstract = True # 抽象类，不生成数据库表单

class UserProfile(AbstractUser, CbaseModel):
    """拓展用户表"""
    name = models.CharField(max_length=150, default="", verbose_name="姓名")
    mobile = models.CharField(max_length=11, default="", verbose_name="手机号码", blank=True, null=True)
    email = models.EmailField(max_length=50, verbose_name="邮箱")
    # image = models.ImageField(upload_to="image/%Y/%m", default="image/default.png",
    #                           max_length=100, null=True, blank=True)
    department = models.ForeignKey("Organization", null=True, blank=True, on_delete=models.SET_NULL, verbose_name="部门")
    position = models.CharField(max_length=50, null=True, blank=True, verbose_name="职位")
    superior = models.ForeignKey("self", null=True, blank=True, on_delete=models.SET_NULL, verbose_name="上级主管")
    roles = models.ManyToManyField("Role", verbose_name="角色", blank=True)

    class Meta:
        verbose_name = "用户信息"
        verbose_name_plural = verbose_name
        ordering = ['id']

    def __str__(self):
        return self.username

    def _get_user_permissions(self):
        # 获取用户权限
        permissions = list(filter(None, set(self.roles.values_list('permissions__sign', flat=True))))
        if 'admin' in self.roles.values_list('name', flat=True):
            permissions.append('admin')
        return permissions

    def get_user_info(self):
        # 获取用户信息
        user_info = {
            'id': self.pk,
            'username': self.username,
            'name': self.name,
            # 'avatar': '/media/' + str(self.image),
            'email': self.email,
            'permissions': self._get_user_permissions(),
            # 'department': self.department.name if self.department else '',
            'mobile': '' if self.mobile is None else self.mobile
        }
        return user_info
      
class Permission(CbaseModel):
    """
    权限
    """
    method_choices = (
        (u'POST', u'增'),
        (u'DELETE', u'删'),
        (u'PUT', u'改'),
        (u'PATCH', u'局部改'),
        (u'GET', u'查')
    )
    name = models.CharField(max_length=30, unique=True, verbose_name="权限名")
    sign = models.CharField(max_length=30,verbose_name='权限标识')
    method = models.CharField(max_length=8, blank=True, default='', choices=method_choices, verbose_name='方法')
    menu = models.BooleanField(verbose_name='是否为菜单')  # True为菜单,False为接口
    path = models.CharField(max_length=200, blank=True, default='', verbose_name='请求路径正则')
    pid = models.ForeignKey('self', null=True, blank=True, on_delete=models.CASCADE, verbose_name='父权限')
    desc = models.CharField(max_length=30, null=True,blank=True, default='', verbose_name='权限描述')


    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '权限'
        verbose_name_plural = verbose_name
        ordering = ['id']


class Role(CbaseModel):
    """
    角色
    """
    name = models.CharField(max_length=32, unique=True, verbose_name="角色")
    permissions = models.ManyToManyField("Permission", blank=True, verbose_name="权限")
    # menus = models.ManyToManyField("Menu", blank=True, verbose_name="菜单")
    desc = models.CharField(max_length=50, blank=True, null=True, verbose_name="描述")

    class Meta:
        verbose_name = '角色'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class Organization(CbaseModel):
    """
    组织架构
    """
    organization_type_choices = (
        ("company", "公司"),
        ("department", "部门")
    )
    name = models.CharField(max_length=60, verbose_name="名称")
    type = models.CharField(max_length=20, choices=organization_type_choices, default="company", verbose_name="类型")
    pid = models.ForeignKey("self", null=True, blank=True, on_delete=models.SET_NULL, verbose_name="父类组织")

    class Meta:
        verbose_name = "组织架构"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name
```

## 3 后端接口

```python
# 1.路由
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
    path('user/info/', views.UserInfoView.as_view(), name='user_info'), # 用户信息查询接口
    path('user/login/', views.UserAuthView.as_view(), name='loginview'),# 用户登录接口
    path('user/logout/', views.logout, name='logout'),# 用户退出登录接口
    path('permissions/methods/', views.PermissionsMethodsAPIView.as_view()),# 权限对应请求方式查询 (GET、POST、PUT、PATCH、delete)
    path('permissionlist/',views.PermissionListView.as_view()),#
    path('', include(router.urls)),
]

# 2.视图函数
# 用户 、角色 、权限、组织 **增删改查**接口,继承CommonModelViewSet(返回指定格式数据)实现
```

## 5 认证与权限

### LDAP

```python
登录启用LDAP认证,用户登录会直接去LDAP进行用户名密码认证，然后将用户名密码存到用户表中
如果用户不存在则使用AUTHENTICATION_BACKENDS中的其他认证

Django维护一个”authentication backends”的列表用来测试认证。当调用 django.contrib.auth.authenticate() — Django将尝试所有的认证后端。如果第一个认证方法失败了，Django将会继续尝试第二个，直到所有的都被尝试过。
认证后端的列表在 AUTHENTICATION_BACKENDS 设置。内容应该是包含Python路径的元组。默认情况下， AUTHENTICATION_BACKENDS 设置为
(‘django.contrib.auth.backends.ModelBackend’,)，这是检测Django用户数据库的基本认证方案。
按照 AUTHENTICATION_BACKENDS 的排列顺序，如果同样的用户名和密码在第一次就匹配了，那么Django将停止处理后面的东西。

# LDAP在settings.py中的配置
import ldap
from django_auth_ldap.config import LDAPSearch, GroupOfNamesType

# Baseline configuration.
AUTH_LDAP_SERVER_URI = 'ldap://192.168.11.251:389' #LDAP服务地址

AUTH_LDAP_BIND_DN = 'cn=admin,dc=sholdboy,dc=com'
AUTH_LDAP_BIND_PASSWORD = '123456'

AUTH_LDAP_USER_SEARCH = LDAPSearch(
    'cn=Users,ou=Tech,dc=sholdboy,dc=com',
    ldap.SCOPE_SUBTREE,
    '(uid=%(user)s)',
)

AUTH_LDAP_USER_ATTR_MAP = {
    "first_name": "cn",
    "username": "sn"
}

AUTHENTICATION_BACKENDS = (
    'django_auth_ldap.backend.LDAPBackend',
    'django.contrib.auth.backends.ModelBackend',
)
```

### 认证

```python
使用JWT认证
# settings中的配置
'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
    ),
```

### 权限

```python
# settings.py配置
'DEFAULT_PERMISSION_CLASSES':
  (
    'rest_framework.permissions.IsAuthenticated',  # 登录验证
    'nginx_platform_backend.utils.permissions.RbacPermission',  # 自定义权限认证
  ),

# 自定义权限认证 (判断用户对后端接口的访问权限)
import json
import re
from django.conf import settings
from django_redis import get_redis_connection
from rest_framework import status
from rest_framework.exceptions import APIException
from rest_framework.permissions import BasePermission
from nginx_platform_backend.libs.permissions import redis_storage_permissions

class UserLock(APIException):
    status_code = status.HTTP_400_BAD_REQUEST
    default_detail = '用户已被锁定,请联系管理员'
    default_code = 'not_authenticated'
    
class RbacPermission(BasePermission):
    """
    自定义权限认证
    """

    @staticmethod
    def pro_uri(uri):
        base_api = settings.BASE_API
        # uri = '/' + base_api + '/' + uri + '/'
        return re.sub('/+', '/', uri)

    def has_permission(self, request, view):
        # 验证用户是否被锁定
        if not request.user.is_active:
            raise UserLock()
        request_url = request.path
        # 如果请求url在白名单，放行
        for safe_url in settings.WHITE_LIST:
            if re.match(settings.REGEX_URL.format(url=safe_url), request_url):
                return True
        # admin权限放行
        conn = get_redis_connection('user_info')
        if not conn.exists('user_permissions_manage'): # 如果redis中没有用户权限表，则从数据库中获取所有权限并且存储到redis中
            redis_storage_permissions(conn)
        if conn.exists('user_info_%s' % request.user.id):
            user_permissions = json.loads(conn.hget('user_info_%s' % request.user.id, 'permissions').decode())
            # 根据user_id获取当前用户权限，如果是admin 放行
            if 'admin' in user_permissions:
                return True
        else:
            user_permissions = []
            if '系统管理员' in request.user.roles.values_list('name', flat=True):
                return True
        # RBAC权限验证
        # Step 1 验证redis中是否存储权限数据
        request_method = request.method
        # Step 2 判断请求路径是否在权限控制中
        url_keys = conn.hkeys('user_permissions_manage')
        # print('所有权限key值',url_keys)
        for url_key in url_keys: # 遍历权限列表返回匹配到的权限 key值 形式为"/api/system/org/"
            if re.match(settings.REGEX_URL.format(url=self.pro_uri(url_key.decode())), request_url):
                redis_key = url_key.decode()
                break
        else:
            return True # 匹配不到代表没有做权限限制，放行
        # Step 3 redis权限验证
        permissions = json.loads(conn.hget('user_permissions_manage', redis_key).decode())
        # 返回匹配到的权限key值 对应的values [{},{}...]
        method_hit = True  # 同一接口配置不同权限验证
        for permission in permissions:
            if permission.get('method') == request_method:
                method_hit = True
                if permission.get('sign') in user_permissions: # 如果权限标识 在 获取到的用户权限表中放行
                    return True
        else:
            if method_hit:
                return False
            else:
                return True

```

## 6 系统服务监控

```python
使用websocket和psutil实现实时获取系统的cpu、内存 和 磁盘信息,并实时展示到前端

# 1.新建app monitor
	# urls.py (系统信息路由配置，不走websocket)
  from django.urls import path
	from .views import service

	urlpatterns = [
    path('service/', service.ServiceMonitorAPIView.as_view()),  # 服务监控
	]

  # views.service(略)
  get请求中返回要展示的数据

# 2.websocket路由配置 在url.py同级目录下新建 routing.py
import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nginx_platform_backend.settings.dev')
from channels.routing import ProtocolTypeRouter, URLRouter
from django.urls import re_path

from nginx_platform_backend.utils.websocket import TokenAuthMiddleware
from monitor.consumer import service

django.setup()
# 配置websocket路由
application = ProtocolTypeRouter({
    'websocket': TokenAuthMiddleware(
        URLRouter([
            re_path(r'^monitor/service', service.ResourcesConsumer),
        ])
    )
})

# 3.websocket配置(相当于视图函数配置) monitor.consumer.service.ResourcesConsumer配置(略)

# 4.settings.py中配置
INSTALL_APPS中注册 'channels'

# channels配置(配置ASGI, 用于实现WebSocket)
ASGI_APPLICATION = 'nginx_platform_backend.routing.application'

# django-channels配置
CHANNEL_LAYERS = {
    'default': {
        'BACKEND': "channels_redis.core.RedisChannelLayer",
        'CONFIG': {
            'hosts': [f'redis://127.0.0.1:6379/4'],
            # 'hosts': [f'redis://10.0.0.80:6379/4'],
            'symmetric_encryption_keys': [SECRET_KEY],
            'capacity': 1500,
            'expiry': 10
        },
    },
}

# 3.

```

