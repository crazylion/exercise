#!/bin/python
# -*-coding:utf-8-*-
from ftplib import FTP
#用來存放每一個要抓取的資料相關資料
class TyData:
    def __init__(self,filename,dirname,host,data_dir):
        self.filename=filename
        self.dirname=dirname
        self.host=host
        self.data_dir=data_dir
        #取出日期字串
        self.dateString = filename[5:15]
        print self.dateString

    def setlogger(logger):
        self.logger=logger
         

    def download(self):
        path= self.host+"/"+self.data_dir+"/"+self.dirname
        print "downloading..."+path
        ftp = FTP(self.host)
        ftp.login()
        ftp.cwd(self.data_dir)
        ftp.cwd(self.dirname)
        files = ftp.nlst()
        is_found=False
        for f in files:
            if  f.find(self.dateString+".bin")!=-1 or f.find(self.dateString+".ctl")!=-1:
                print f
                ftp.retrbinary('RETR '+f,open(f,"wb").write)
                is_found=True

        if is_found ==False :
            print "[Error] Can't find files"
        ftp.close

    
