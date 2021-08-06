from rest_framework.mixins import ListModelMixin
from utils.response import APIResponse
class MyListModelMixin(ListModelMixin):
    """
    List a queryset.
    """
    def list(self, request, *args, **kwargs):
        res=super().list(request, *args, **kwargs)
        return APIResponse(data=res.data,code=20000,message="查询成功")