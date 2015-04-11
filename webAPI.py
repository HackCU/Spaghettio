import json
import bottle
from bottle import route, run, request, abort, response, template, post
from pymongo import MongoClient
from bson.json_util import dumps
 
connection = MongoClient('localhost', 27017)
db = connection.mydatabase

@route('/forum')
def display_forum():
    forum_id = request.query.kadesballs
    page = request.query.page or '1'
    return template('Forum ID: {{id}} (page {{page}})', id=forum_id, page=page)

@route('/<userid>/credentials', method='GET')
def getCredentials(userid):
    name_id = request.query.name
    if not name_id:
        entity = db[userid].find()
    else:
        entity = db[userid].distinct(name_id)
    entity = dumps(entity)
    print(entity)
    return entity

@route('/<userid>/credentials', method='POST')
def getCredentials(userid):
    data = request.body.read()
    if not data:
        abort(400, 'No data received')
    entity = json.loads(data.decode("utf-8", "strict"))
    try:
        db[userid].save(entity)
    except ValidationError as ve:
        abort(400, str(ve))

run(host='ec2-54-69-170-52.us-west-2.compute.amazonaws.com', port=8080)