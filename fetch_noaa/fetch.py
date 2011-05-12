#!/bin/python
# -*-coding:utf-8-*-
from ftplib import FTP
from tydata import TyData

def checkfile(data):
    print "line here"
    print data

#從文字行中組出對應的目錄

def combindDirName(data):
    line_data=data.split(',')
    year = line_data[2][0:5]
    dirname = line_data[0].strip()+line_data[1].strip()+year.strip()
    return dirname


def fetchData(ftp,f,host,data_dir):
    print "fetchData"
    def saveFile(data):
        dirname = combindDirName(data)
        tydata = TyData(f,dirname,host,data_dir)
        tydata.download()

    ftp.retrlines('RETR '+f,saveFile)

host="satepsanone.nesdis.noaa.gov"
data_dir="MTCSWA"
ftp = FTP(host)
ftp.login()
ftp.cwd(data_dir)
ftp.cwd("ATCF_FIX")

files = ftp.nlst()
for f in files:
#     print f
    fetchData(ftp,f,host,data_dir)

ftp.quit()

