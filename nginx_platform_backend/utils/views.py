from django.core.cache import cache
from rest_framework.mixins import ListModelMixin
from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet
from utils.response import APIResponse


class CacheCommonView(GenericViewSet, ListModelMixin):
    cache_key = 'ss'
    def list(self, request, *args, **kwargs):
        cache_data = cache.get(self.cache_key)
        if cache_data:
            print('走了缓存')
            return Response(cache_data)
        res = super(CacheCommonView, self).list(request, *args, **kwargs)
        cache.set(self.cache_key, res.data)
        print('没走缓存')
        return Response(res.data)

class CommonView(GenericViewSet, ListModelMixin):
    def list(self, request, *args, **kwargs):
        res = super(CommonView, self).list(request, *args, **kwargs)
        return APIResponse(result=res.data)