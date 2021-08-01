import os
from dotenv import find_dotenv, load_dotenv
from src.server import Server
import src.routes

load_dotenv(find_dotenv())

if __name__ == '__main__':
    app = Server.get_instance()
    app.run(os.getenv('HOST'), int(os.getenv('PORT')))
