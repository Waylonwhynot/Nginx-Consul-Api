from django.shortcuts import render

# Create your views here.
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter

from utils.views import CommonModelViewSet
from . import models
from .serializer import NginxConfSerializer

class NginxConfigViewSet(CommonModelViewSet):
    queryset = models.NginxConf.objects.all()
    serializer_class = NginxConfSerializer
    filter_backends = [SearchFilter, OrderingFilter, DjangoFilterBackend]
    search_fields = ['name', 'appid']

