import os
from jwt import encode, decode


class JwtService:
    __instance = None

    def __init__(self):
        self.__secret = str(os.getenv('SECRET_KEY'))

    def sign(self, payload):
        """Encode a payload to a jwt

        Args:
            payload (JSON): any payload to be transformed to jwt token

        Returns:
            str: jwt token
        """
        return encode(payload, self.__secret, algorithm="HS256")

    def decode(self, jwt):
        """Decode a JWT token

        Args:
            jwt (str): encoded jwt

        Returns:
            JSON: decoded jwt token
        """
        return decode(jwt, self.__secret, algorithms=["HS256"])

    @classmethod
    def get_instance(cls):
        """
        Returns:
            JwtService: return a instance of JwtService
        """
        if cls.__instance is not None:
            return cls.__instance
        cls.__instance = cls()
        return cls.__instance
