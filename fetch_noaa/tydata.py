#!/bin/python
# -*-coding:utf-8-*-
#用來存放每一個要抓取的資料相關資料
class TyData:
    def __init__(self,filename,dirname):
        self.filename=filename
        self.dirname=dirname
        #取出日期字串
        self.dateString = filename[5:15]
        print self.dateString

    def download(self):
        print "downloading..."
    
