#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# $File: cmdtool.py
# $Date: Sat Apr 06 15:42:43 2013 +0800
# $Author: jiakai@megvii.com
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING (copied as below) for more details.
#
#                DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#                        Version 2, December 2004 
#
#     Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 
#
#     Everyone is permitted to copy and distribute verbatim or modified 
#     copies of this license document, and changing it is allowed as long 
#     as the name is changed. 
#
#                DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#       TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
#
#      0. You just DO WHAT THE FUCK YOU WANT TO. 

def init():
    import sys
    import os
    import os.path
    if sys.version_info.major != 2:
        sys.exit('Python 2 is required to run this program')

    fdir = None
    if hasattr(sys, "frozen") and \
            sys.frozen in ("windows_exe", "console_exe"):
        fdir = os.path.dirname(os.path.abspath(sys.executable))
        sys.path.append(fdir)
        fdir = os.path.join(fdir, '..')
    else:
        fdir = os.path.dirname(__file__)

    with open(os.path.join(fdir, 'apikey.cfg')) as f:
        exec(f.read())

    srv = locals().get('SERVER')
    from facepp import API
    return API(API_KEY, API_SECRET, srv = srv)

api = init()

from facepp import API, File

del init
'''
def _run():
    global _run
    _run = lambda: None
    try:
        from IPython import embed
#        embed(banner2 = msg)
#	print(api.detection.detect(img = File(r'1.jpg')))
    except ImportError:
        import code
#        code.interact(msg, local = globals())
#	print(api.detection.detect(img = File(r'1.jpg')))
#api.detection.detect(img = File(r'1.jpg'))
if __name__ == '__main__':
    _run()
'''
#print(api.detection.detect(img = File(r'1.jpg')))



import time
from pprint import pformat
def print_result(hint, result):
    def encode(obj):
        if type(obj) is unicode:
            return obj.encode('utf-8')
        if type(obj) is dict:
            return {encode(k): encode(v) for (k, v) in obj.iteritems()}
        if type(obj) is list:
            return [encode(i) for i in obj]
        return obj
    print hint
    result = encode(result)
    print '\n'.join(['  ' + i for i in pformat(result, width = 75).split('\n')])

IMAGE_DIR = 'http://cn.faceplusplus.com/static/resources/python_demo/'
'''
ERSONS = [
    ('Jim Parsons', IMAGE_DIR+'1.jpg'),
    ('Leonardo DiCaprio', IMAGE_DIR+'2.jpg'),
    ('Andy Liu', IMAGE_DIR+'3.jpg')
]
TARGET_IMAGE = IMAGE_DIR + '4.jpg'
FACES = {name: api.detection.detect(url = url)
        for name, url in PERSONS}
'''
PERSONS = [
    ('Jim Parsons', '1.jpg'),
    ('Leonardo DiCaprio', '2.jpg'),
    ('Andy Liu', '3.jpg')
]
TARGET_IMAGE = IMAGE_DIR + '4.jpg'
FACES = {name: api.detection.detect(img = File(img))
        for name, img in PERSONS}
#for name, age in FACES.iteritems():
#	print_result(name, age)
#print(name)
'''
for name, face in FACES.iteritems():
#    try:
        api.person.create(person_name = name)
        api.group.add_person(group_name = 'test', person_name = name)
        print_result(name, face)
'''
'''
try:
	rst = api.group.create(group_name = 'test')
	print_result('create group', rst)
	rst = api.group.add_person(group_name = 'test', person_name = FACES.iterkeys())
	print_result('add these persons to group', rst)
'''
rst = api.train.identify(group_name = 'test')
print_result('train', rst)

rst = api.wait_async(rst['session_id'])
print_result('wait async', rst)

rst = api.recognition.identify(group_name = 'test', url = TARGET_IMAGE)
print_result('recognition result', rst)
print '=' * 60
print 'The person with highest confidence:', \
        rst['face'][0]['candidate'][0]['person_name']

#api.group.delete(group_name = 'test')
api.person.delete(person_name = FACES.iterkeys())