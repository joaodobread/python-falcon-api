from src.common.decorators.unprotected import Unprotected
from src.common.decorators.roles import Roles
from .server import Server

app_instance = Server.get_instance().app


@Roles('admin')
class A:
    def on_get(self, req, resp):
        print(req.user)
        resp.media = {
            "name": "joao"
        }


app_instance.add_route('/', A())
