from rest_framework.mixins import ListModelMixin
from utils.response import APIResponse
from rest_framework.viewsets import ModelViewSet
from rest_framework.generics import ListAPIView


class MyListModelMixin(ListModelMixin):
    """
    List a queryset.
    """

    def list(self, request, *args, **kwargs):
        res = super().list(request, *args, **kwargs)
        return APIResponse(data=res.data, code=20000, message="查询成功")


class CommonModelViewSet(ModelViewSet):
    def create(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).create(request, *args, **kwargs)
        return APIResponse(data=res.data)


    def retrieve(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).retrieve(request, *args, **kwargs)
        return APIResponse(data=res.data)


    def update(self, request, *args, **kwargs):
        try:
            res = super(CommonModelViewSet, self).update(request, *args, **kwargs)
        except Exception as e:
            print(e)
        return APIResponse(data=res.data)


    def destroy(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).destroy(request, *args, **kwargs)
        return APIResponse()


    def list(self, request, *args, **kwargs):
        res = super(CommonModelViewSet, self).list(request, *args, **kwargs)
        return APIResponse(data=res.data)
