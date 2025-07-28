
# from datetime import date, datetime, time
# from datetime import timedelta
# import statistics
# from unittest import result
# from django.utils import timezone
from datetime import datetime
from django.http import JsonResponse
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
from django.db import connection
from django.utils import timezone
# from django.db.models import Q
# from django.db.models import Count, Avg
# from django.db.models.functions import Concat
# from collections import defaultdict
# from django.conf import settings
# from datetime import datetime
# from rest_framework.permissions import IsAuthenticated
# from rest_framework.authentication import SessionAuthentication, BasicAuthentication
# from django.core import serializers
# from rest_framework import viewsets
# from django.utils.html import escape
# from rest_framework.exceptions import AuthenticationFailed
# import jwt
# import html
# import json
# # from dateutil import tz
# import pytz
# import html
# import re
# # import pytz
# # import html
# from environ import Env
# import requests
# import talentlms
# import bcrypt
# from mailjet_rest import Client
# from django.db.models import Max

# from django.views.decorators.csrf import csrf_protect
import concurrent.futures
from django.views.decorators.csrf import csrf_exempt

from django.core.files.base import ContentFile, File
import os
from kazyon_catalog.models import Catalog_pages, Catalogs



def salutView(request):
    return HttpResponse('Salut les gens')

class testView(APIView):
    def post(self, request):
        print('TEST PASS')
        # return JsonResponse({ 'msg': 'TEST PASS' })

class create_catalog(APIView):
    # requires user_id , start_date , end_date, image_link, number of pages;
    def post(self, request):
        try:
            user_id = request.data['user_id']
            start_date = request.data['start_date']
            end_date = request.data['end_date']
            image_link = request.data['image_link']
            pages = request.data['pages']

            # Create the Catalog instance
            creation_request = Catalogs(
                user_id=user_id, 
                start_date=start_date, 
                end_date=end_date,
                pages=pages,
                image_link=image_link,
                active=0,
                created_at=timezone.now()
            )
            creation_request.save()  # Save the catalog instance to the database
            # Verify the data has been saved by querying the database
            last_added_catalog= Catalogs.objects.filter(user_id=user_id, start_date=start_date, end_date=end_date, pages=pages, image_link=image_link)
            if last_added_catalog.first() is not None:
                res = {
                "Success": True,
                "msg": "Catalog successfully saved"
            }
                return JsonResponse(res, status=status.HTTP_200_OK)
            else:
                res = {
                "Success": False,
                "msg": "Catalog not saved"
            }
                return JsonResponse(res, status=status.HTTP_406_NOT_ACCEPTABLE)
            # Log the information

        except Exception as e:
            # Error response
            res = {
                "Success": False,
                "msg": "Error while creating catalog",
                "Error details": str(e)  # Convert exception to string
            }
            return JsonResponse(res, status=status.HTTP_400_BAD_REQUEST)
        
class addPageToCatalog(APIView):
    #requires image link, catalog id, page number
    def post(self, request):
        try :
            image_link = request.data['image_link']
            catalog_id = request.data['catalog_id']
            page_number = request.data['page_number']
            Catalog_pages(link=image_link, catalog_id=catalog_id, page_number=page_number).save()
            last_added_page=Catalog_pages.objects.filter(link=image_link, catalog_id=catalog_id, page_number=page_number)
            if last_added_page.exists() :
                res={
                    "status": True,
                    "msg":"page added successfully"
                }
                return JsonResponse(res, status=status.HTTP_200_OK)
            
            else:
                res = {
                "Success": False,
                "msg": "page not saved"
            }
                return JsonResponse(res, status=status.HTTP_406_NOT_ACCEPTABLE)
        except Exception as e:
            # Error response
            res = {
                "Success": False,
                "msg": "Error while adding page",
                "Error details": str(e)  # Convert exception to string
            }
            return JsonResponse(res, status=status.HTTP_400_BAD_REQUEST)
        
class fetchCatalogs(APIView):
    def post(self, request):
        # no payload required
        catalog_list=[]
        try:
            catalogs = Catalogs.objects.filter(active=True, end_date__lte=timezone.now()).all()
            if len(catalogs)>0:
            
                for catalog in catalogs:
                    catalog_list.append({
                        "id": catalog.id,
                        "start_date": catalog.start_date,
                        "end_date": catalog.end_date,
                        "pages" : catalog.pages,
                        "cover": catalog.image_link
                    })
                res={
                    "status": True,
                    "msg": "Catalogs fetched successfully",
                    "catalogs": catalog_list
                }
                return JsonResponse(res, status=status.HTTP_200_OK)
            else:
                res={
                    "status": False,
                    "msg": "No acive catalogs found",
                    "catalogs": catalog_list
                }
                return JsonResponse(res, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            # Error response
            res = {
                "Success": False,
                "msg": "Error while fetching catalogs",
                "Error details": str(e)  # Convert exception to string
            }
            return JsonResponse(res, status=status.HTTP_400_BAD_REQUEST)
        
class fetchCatalogPages(APIView):
    # requires catalog_id
    def post(self, request):
        catalog_id = request.data['catalog_id']
        try:
            catalog_pages_list=[]
            pages=Catalog_pages.objects.filter(catalog_id=catalog_id).all()
            if len(pages)>0:
                for page in pages:
                    catalog_pages_list.append(
                        {
                            "id": page.id,
                            "image": page.link,
                            "page_number": page.number
                        }
                    )
                res={
                    "status": True,
                    "msg": "Catalog pages fetched successfully",
                    "catalogs": catalog_pages_list
                }
                return JsonResponse(res, status=status.HTTP_200_OK)
            else:
                res={
                    "status": False,
                    "msg": "No pages found in this catalog",
                    "catalogs": catalog_pages_list
                }
                return JsonResponse(res, status=status.HTTP_404_NOT_FOUND)

        except Exception as e:
            # Error response
            res = {
                "Success": False,
                "msg": "Error while fetching catalog pages",
                "Error details": str(e)  # Convert exception to string
            }
            return JsonResponse(res, status=status.HTTP_400_BAD_REQUEST)

        



    


