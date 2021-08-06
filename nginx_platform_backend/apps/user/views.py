from django.shortcuts import render
from rest_framework.viewsets import GenericViewSet
from rest_framework.mixins import ListModelMixin
from .serializer import MenuListSerializer
from . import models

# Create your views here.

class MenuListView(GenericViewSet,ListModelMixin):
    queryset = models.Menu.objects.filter(pid=None)
    serializer_class = MenuListSerializer
