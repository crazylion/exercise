#!/bin/python
from ftplib import FTP

host="satepsanone.nesdis.noaa.gov"
ftp = FTP(host)
ftp.login()
ftp.cwd("MTCSWA")
ftp.cwd("ATCF_FIX")
ftp.retrlines('LIST')
ftp.quit()

