from django.core.cache import cache
from rest_framework.mixins import ListModelMixin
from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet, ModelViewSet
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


class CommonModelViewSet(ModelViewSet):
    def create(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).create(request, *args, **kwargs)
        return APIResponse(data=res.data)

    def retrieve(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).create(request, *args, **kwargs)
        return APIResponse(data=res.data)

    def update(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).update(request, *args, **kwargs)
        return APIResponse(data=res.data)

    def destroy(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).destroy(request, *args, **kwargs)
        return APIResponse()

    def list(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).list(request, *args, **kwargs)
        return APIResponse(data=res.data)