from .celery import app

@app.task
def update_banner():
    from django.core.cache import cache
    from django.conf import settings
    from home import models
    from home import ser

    # 修改缓存
    # 拿到轮播图
    banners=models.Banner.objects.filter(is_delete=False, is_show=True).order_by('-orders')[:settings.BANNER_SIZE]
    banner_ser = ser.BannerModelSerializer(instance=banners, many=True)
    banner_data = banner_ser.data

    # 拿不到request对象，所以头像的连接base_url要自己组装
    for banner in banner_data:
        banner['img'] = 'http://127.0.0.1:8000%s' % banner['img']
    # 往缓存中设置
    cache.set('banner_data', banner_data)

    return True