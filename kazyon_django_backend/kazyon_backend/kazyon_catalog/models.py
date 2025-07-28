from unicodedata import category
from django.db import models
import os



from django.utils import timezone
# from django.db.backends.mysql.base import DatabaseWrapper

# DatabaseWrapper.data_types = DatabaseWrapper._data_types

from django.contrib.auth.models import AbstractUser, AbstractBaseUser


class Admins(models.Model):
    first_name = models.CharField(max_length=60)
    last_name = models.CharField(max_length=60)
    type = models.IntegerField()
    password = models.TextField()  # Use Django's user handling for security
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15, blank=True, null=True)
    avatar = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField()
    status = models.IntegerField(default=1)  # Assuming 1 is active
    gender = models.CharField(max_length=2, choices=[('M', 'M'), ('F', 'F')])

    class Meta:
        db_table = 'admins'


class Admin_types(models.Model):
    type_name= models.TextField()
    type_number= models.TextField()

    

    class Meta:
        db_table='admin_types'

class Catalogs(models.Model):
    start_date= models.fields.DateField(default=None, blank=True, null=True)
    end_date= models.fields.DateField(default=None, blank=True, null=True)
    image_link= models.TextField()
    pages= models.IntegerField()
    active= models.BooleanField()
    created_at= models.DateTimeField()
    user_id= models.IntegerField()
   
    class Meta:
        db_table='catalogs'
        
class Catalog_pages(models.Model):
    link= models.TextField()
    added_at= models.DateTimeField()
    catalog_id= models.IntegerField()
    number= models.IntegerField()
   
    class Meta:
        db_table='catalog_pages'

class Token(models.Model):
    token = models.fields.TextField()
    user_id = models.fields.IntegerField()
    created_at = models.fields.DateTimeField(default=timezone.now, blank=True, null=True, max_length=0)
    class Meta:
        db_table = "token"

class Admins_token(models.Model):
    token = models.fields.TextField()
    admin = models.ForeignKey(Admins, on_delete=models.CASCADE)
    created_at = models.fields.DateTimeField(default=timezone.now, blank=True, null=True, max_length=0)
    class Meta:
        db_table = "admins_token"