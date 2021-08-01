from falcon import Request
import falcon
from src.security.jwt_service import JwtService


class AuthenticationMiddleware:
    def __init__(self) -> None:
        self.jwt = JwtService.get_instance()

    def process_resource(self, req: Request, resp, resource, params):
        req.user = None
        required_roles = hasattr(resource, 'falcon_security__roles')
        has_unprotected = hasattr(resource, 'falcon_security__unprotected')

        if not has_unprotected:
            return

        if resource.falcon_security__unprotected or not required_roles:
            return

        if not req.auth:
            raise falcon.HTTPUnauthorized()

        try:
            [prefix, token] = req.auth.split(' ')
            if (str(prefix).lower()) != 'bearer' or prefix == '' or token == '':
                raise falcon.HTTPUnauthorized()
            user = self.jwt.decode(token)
            req.user = user

            required_roles = resource.falcon_security__roles
            roles = user['roles']

            if not len(set(required_roles) & set(roles)):
                raise falcon.HTTPUnauthorized(
                    description='user has no permission to perform this action')

        except KeyError:
            raise falcon.HTTPUnauthorized(
                description='user has no permission to perform this action')

        except Exception:
            raise falcon.HTTPUnauthorized()
