from rest_framework.filters import BaseFilterBackend
from . import models
from django_filters import filters
from django_filters.filterset import FilterSet

# 自定义搜索类，自定义搜索字段
class SearchByName(BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        name = request.GET.get('name')
        queryset = queryset.filter(name__startswith=name)
        return queryset

