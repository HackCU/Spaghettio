#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# $File: cmdtool.py
# $Date: Sat Apr 06 15:42:43 2013 +0800
# $Author: jiakai@megvii.com
import sys
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

import time
from pprint import pformat
#Usage: print_result(name, api.detection.detect(something))
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

print(len(sys.argv))
#print(argv)
#argv[1] command; argv[2] username; argv[3] picutre; argv[4] optional temp credentials;
COMMANDS = ['new', 'test']
if(sys.argv[1] == 'new'):
	try:
		print(api.person.create(person_name=sys.argv[2]))
		
	except:
		print("User already exists.")
