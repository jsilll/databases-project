from app import app
from wsgiref.handlers import CGIHandler

CGIHandler().run(app)
