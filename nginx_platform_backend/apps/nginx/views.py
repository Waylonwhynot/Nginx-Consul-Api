from django.shortcuts import render

# Create your views here.
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter

from utils.views import CommonModelViewSet
from . import models
from .serializer import NginxConfSerializer, NginxModelSerializer, NginxOpsSerializer


class NginxConfigViewSet(CommonModelViewSet):
    queryset = models.NginxConf.objects.filter(status='running').order_by('-id')
    serializer_class = NginxConfSerializer
    filter_backends = [SearchFilter, OrderingFilter, DjangoFilterBackend]
    search_fields = ['name', 'appid']


class NginxModelViewSet(CommonModelViewSet):
    queryset = models.NginxModel.objects.filter(status='running').order_by('-id')
    serializer_class = NginxModelSerializer
    filter_backends = [SearchFilter, OrderingFilter, DjangoFilterBackend]
    search_fields = ['name', 'managerIp']


class NginxOpsViewSet(CommonModelViewSet):
    queryset = models.NginxInstanceOps.objects.order_by('-id')
    serializer_class = NginxOpsSerializer
    filter_backends = [SearchFilter, OrderingFilter, DjangoFilterBackend]
    search_fields = ['operator', 'ops_2_conf__name']
