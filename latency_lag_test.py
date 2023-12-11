# -*- coding: utf-8 -*-
from bson.json_util import dumps, loads
from calendar import timegm
from time import gmtime
from pymongo import MongoClient, errors
from sys import exit
import time

mongo_db = ["admin", ]
startOptimeDate = None


def connect():
    try:
        conn = MongoClient(
            "mongodb+srv://user:password@zoom-test.baqo4.mongodb.net/?retryWrites=true&w=majority")
    except errors.PyMongoError as py_mongo_error:
        print('Error in MongoDB connection: %s' %
              str(py_mongo_error))
    return conn


def replag(conn):
    replStatus = conn[mongo_db[0]].command('replSetGetStatus')
    # me = conn[mongo_db[0]].command('isMaster')['me']
    mem = replStatus['members']
    secondaryOp = None
    for i in range(0, len(mem)):
        if mem[i]['state'] == 1:
            # find out primary node name
            primary = mem[i]
            me = mem[i]['name']
            # print("Primary" + str(primary))
    if primary is not None:
        startOptimeDate = primary['optimeDate']

        for i in range(0, len(mem)):
            if mem[i]['state'] == 1 or mem[i]['state'] == 7:
                # ignore primary node and hidden nodes
                a = 1
            else:
                # print("secondary members:" + str(mem[i]['name']))
                # if mem[i]['name'] == me:
                secondaryOp = time.mktime(mem[i]['optimeDate'].timetuple())
                primaryOp = time.mktime(startOptimeDate.timetuple())
                ago = (primaryOp-secondaryOp)
                print(" Lag_time: " + str((ago)))


if __name__ == "__main__":
    try:
        conn = connect()
        print("Connected to atlas")
        while True:
            replag(conn)

    except Exception as e:
        print(e)
