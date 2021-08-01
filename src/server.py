from falcon import App
from wsgiref import simple_server
from logging import Logger
from .common.middlewares.authentication import AuthenticationMiddleware


class Server:
    __instance = None
    __middlewares = [
        AuthenticationMiddleware()
    ]

    def __init__(self) -> None:
        self.__app = App(middleware=self.__middlewares)

    @classmethod
    def get_instance(cls):
        if cls.__instance is not None:
            return cls.__instance
        cls.__instance = cls()
        return cls.__instance

    @property
    def app(self):
        return self.__app

    def run(self, host: str, port: int):
        print(f"Starting: {host}:{port}")
        httpd = simple_server.make_server(host, port, self.__app)
        httpd.serve_forever()
