import json
import bottle
from bottle import route, run, request, abort, response, template, post
from pymongo import MongoClient
from bson.json_util import dumps
import os
 
connection = MongoClient('localhost', 27017)
db = connection.mydatabase

# @route('/forum')
# def display_forum():
#     forum_id = request.query.kadesballs
#     page = request.query.page or '1'
#     return template('Forum ID: {{id}} (page {{page}})', id=forum_id, page=page)

@route('/<userid>/dickpic', method='POST')
def getPic(userid):
    data = request.files.data
    if data and data.file:
        if not os.path.exists(userid):
            os.makedirs(userid)
        raw = data.file.read() # This is dangerous for big files
        filename = data.filename
        newFile = open("{0}/{1}".format(userid,filename), "wb")
        newFile.write(raw)
        newFile.close()
        return "You uploaded %s (%d bytes)." % (filename, len(raw))
    return "You missed a field."

@route('/<userid>/credentials', method='GET')
def getCredentials(userid):
    name_id = request.query.name
    if not name_id:
        entity = db[userid].find()
        name_id = "all"
    else:
        entity = db[userid].distinct(name_id)
    entity = dumps(entity)
    thing = json.loads(entity)
    stuff ={}
    stuff[name_id]=thing
    return str(stuff)

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

run(host='localhost', port=8080)