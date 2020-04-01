#!/bin/csh
#################################################################
# Csh Script to retrieve 9 online Data files of 'ds084.1',
# total 2.99G. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an environment variable RDAPSWD
# if your Operating System supports it.
#
# Contact rpconroy@ucar.edu (Riley Conroy) for further assistance.
#################################################################


set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=matthew.dunlop@ucdconnect.ie&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 https://rda.ucar.edu/data/ds084.1/"
set filelist = ( \
  2020/20200318/gfs.0p25.2020031800.f000.grib2 \
  2020/20200318/gfs.0p25.2020031800.f003.grib2 \
  2020/20200318/gfs.0p25.2020031800.f006.grib2 \
  2020/20200318/gfs.0p25.2020031800.f009.grib2 \
  2020/20200318/gfs.0p25.2020031800.f012.grib2 \
  2020/20200318/gfs.0p25.2020031800.f015.grib2 \
  2020/20200318/gfs.0p25.2020031800.f018.grib2 \
  2020/20200318/gfs.0p25.2020031800.f021.grib2 \
  2020/20200318/gfs.0p25.2020031800.f024.grib2 \
)
while($#filelist > 0)
 set syscmd = "$opt2$filelist[1]"
 echo "$syscmd ..."
 $syscmd
 shift filelist
end

