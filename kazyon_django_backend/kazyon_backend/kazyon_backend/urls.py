"""
URL configuration for kazyon_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from kazyon_catalog.view import create_catalog, salutView,addPageToCatalog,fetchCatalogs,fetchCatalogPages


urlpatterns = [
    path('admin/', admin.site.urls), # by default
    path('salut/', salutView), # test view
    path('api/create-new-catalog/', create_catalog.as_view()), # create a new catalog
    path('api/add-page-to-catalog/', addPageToCatalog.as_view()), # add a page to a new catalog
    path('api/get-all-catalogs/', fetchCatalogs.as_view()), # get all catalogs
    path('api/get-catalog-pages/', fetchCatalogPages.as_view()), # get the pages of a specific catalog
]
