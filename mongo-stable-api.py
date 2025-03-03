# 导入pymongo模块
import pymongo

from pymongo import MongoClient
from pymongo.server_api import ServerApi

# 连接MongoDB数据库并启用稳定API功能
# 注意，我们使用 ServerApi 类启用了稳定API功能，并将 strict 参数设置为 False，以确保您的应用程序可以在稳定API功能未完全支持某些操作的情况下继续运行.
# 也就是说某功能没有被api化也能正常用 - by zb
# client = pymongo.MongoClient("mongodb://localhost:27017/", server_api=ServerApi("1", strict=False))
client = pymongo.MongoClient("mongodb+srv://test:1Qaz2wsx@demo.baqo4.mongodb.net/test?readPreference=secondary&readPreferenceTags=nodeType:READ_ONLY")
# 获取要操作的数据库和集合
db = client["mydatabase"]
collection = db["mycollection"]

# 插入一条文档
# mydoc = { "name": "John", "address": "Highway 37" }
# collection.insert_one(mydoc)

# 查询一条文档
for i in range(100000):
    x = collection.find_one()
    print(x)
