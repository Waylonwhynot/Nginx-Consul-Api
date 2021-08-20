

[TOC]

# Nginx DevOps System

前端项目地址: https://gitee.com/gtdong/nginx-consul-frontend

后端项目地址: https://github.com/Waylonwhynot/Nginx-Consul-Api

## 1 背景

```python
在大型的公司，站点数 、用户量、网站的并发量，包括接口的用户量一般都是非常大的，在这种情况下，1-2台的nginx可能满足不了我们的请求。......
```

## 2 功能介绍

![image-20210817084326625](https://gitee.com/waylon1006/blog_pic/raw/master/pic/image-20210817084326625.png)

```python
登录认证：
	LDAP + JWT
  
1.RBAC权限管理
	根据用户权限控制以下权限：
  	* 对菜单的展示
    * 接口的权限
    * 按钮的权限
    
2.Nginx器群管理
		* 配置管理
  	* 站点管理
    * Nginx动态上下线
    * 动作记录
  
3.服务器的基础监控
		* 信息搜集：prometheus
  	* 监控数据展示：grafana
    
4.todo list
		* CMDB资产管理
  	* webssh终端
    * 任务执行
    * ...

```

## 3 主要应用技术

- Django
- Django Rest Framework
- channels
- redis
- Myql
- celery
- Vue-admin-template
- Vuex
- nginx
- LDAP
- Signals
- consul
- prometheus
- grafana

