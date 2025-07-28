
from rest_framework.exceptions import AuthenticationFailed, APIException
import jwt
from environ import Env
from django.utils.html import escape

from kazyon_catalog.models import Token, Admins_token
# Get JWT secret key
env = Env()
env.read_env()
SECRET_KEY = env("JWT_SECRET_KEY")
SECRET_KEY_ADMIN = env("JWT_SECRET_KEY_ADMIN")

class MyCustomExceptionCode401(APIException):
    status_code = 401
    default_detail = 'Erreur d\'authentification.'
    default_code = 'authentication_failed'

class Authenticate():
    def authenticate(self, request):
        if "user_id" not in request.data:
            raise AuthenticationFailed('Pas d\'id renseigné !')

        user_id = escape(request.data['user_id'])
        jwt_token = request.headers.get('authorization', None)

        if not jwt_token:
            raise AuthenticationFailed('Non authentifié !')

                # soustraire le "Bearer " devant le jwt
        token = jwt_token[7:]

        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
            user_id_jwt = payload['id']
            if int(user_id) != int(user_id_jwt):
                raise AuthenticationFailed('Ids différents !')
            isTokenInDB = False
            tokensInDB = Token.objects.filter(user_id=user_id)
            for tokenInDB in tokensInDB:
                if tokenInDB.token == token:
                    isTokenInDB = True
            if not isTokenInDB:
                raise AuthenticationFailed('Token absent de la BDD !')
        except jwt.ExpiredSignatureError:
            # raise AuthenticationFailed('Jeton expiré !')
            raise MyCustomExceptionCode401('Jeton expiré !')
        except (jwt.DecodeError, jwt.InvalidTokenError):
            raise AuthenticationFailed('JWT non valide !')

    def authenticate_admin(self, request):
        if "admin_id" not in request.data:
            raise AuthenticationFailed('Pas d\'id renseigné !')

        admin_id = escape(request.data['admin_id'])
        jwt_token = request.headers.get('authorization', None)

        if not jwt_token:
            raise AuthenticationFailed('Non authentifié !')

        token = jwt_token[7:]

        try:
            payload = jwt.decode(token, SECRET_KEY_ADMIN, algorithms=['HS256'])
            admin_id_jwt = payload['id']
            if int(admin_id) != int(admin_id_jwt):
                raise AuthenticationFailed('Ids différents !')
            isTokenInDB = False
            tokensInDB = Admins_token.objects.filter(admin_id=admin_id)
            for tokenInDB in tokensInDB:
                if tokenInDB.token == token:
                    isTokenInDB = True
            if not isTokenInDB:
                raise AuthenticationFailed('Token absent de la BDD !')
        except jwt.ExpiredSignatureError:
            raise AuthenticationFailed('Jeton expiré !')
        except (jwt.DecodeError, jwt.InvalidTokenError):
            raise AuthenticationFailed('JWT non valide !')
