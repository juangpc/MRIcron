#!/bin/sh
#This script builds a distribution on Chris Rorden's personal computer.
#  to build your own version you typically run
#    lazbuild -B filename.lpr

cd /Users/rorden/Documents/pas/mricron

chmod 777 ./_xclean.bat
./_xclean.bat
cp ./common/notgui.inc ./common/isgui.inc
#lazbuild ./dcm2nii/dcm2nii.lpr --cpu=x86_64 --compiler="/usr/local/bin/ppcx64"
#Current FPC 3.0.0 can not compile on OSX 10.11 El Capitan, so use 3.1.1
lazbuild ./dcm2nii/dcm2nii.lpr --cpu=x86_64 --compiler="/usr/local/lib/fpc/3.1.1/ppcx64"

cp ./dcm2nii/dcm2nii /Users/rorden/Documents/mricron/MRIcron/dcm2nii64

# lazbuild -B ./dcm2nii/dcm2nii.lpr
lazbuild -B ./dcm2nii/dcm2nii.lpr --ws=cocoa --cpu=x86_64 --os=darwin --compiler=/usr/local/bin/ppcx64
cp ./dcm2nii/dcm2nii /Users/rorden/Documents/mricron/MRIcron/dcm2nii

./_xclean.bat
cp ./common/gui.inc ./common/isgui.inc

#compile 32-bit
# lazbuild -B ./npm/npm.lpr --ws=carbon
# lazbuild -B ./dcm2nii/dcm2niigui.lpr --ws=carbon
# lazbuild -B ./mricron.lpr --ws=carbon

#compile 64-bit
#lazbuild ./mricron.lpr --cpu=x86_64 --ws=cocoa --compiler="/usr/local/bin/ppcx64"
#Current FPC 3.0.0 can not compile on OSX 10.11 El Capitan, so use 3.1.1
/Users/rorden/lazarus/lazbuild ./mricron.lpr --cpu=x86_64 --ws=cocoa --compiler="/usr/local/lib/fpc/3.1.1/ppcx64"
/Users/rorden/lazarus/lazbuild ./npm/npm.lpr --cpu=x86_64 --ws=cocoa --compiler="/usr/local/lib/fpc/3.1.1/ppcx64"
/Users/rorden/lazarus/lazbuild ./dcm2nii/dcm2niigui.lpr --cpu=x86_64 --ws=cocoa --compiler="/usr/local/lib/fpc/3.1.1/ppcx64"


strip ./mricron
strip ./npm/npm
strip ./dcm2nii/dcm2niigui

cp ./mricron /Users/rorden/Documents/mricron/MRIcron/mricron.app/Contents/MacOS/mricron
cp ./npm/npm /Users/rorden/Documents/mricron/MRIcron/npm.app/Contents/MacOS/npm
cp ./dcm2nii/dcm2niigui /Users/rorden/Documents/mricron/MRIcron/dcm2niigui.app/Contents/MacOS/dcm2niigui

./_xclean.bat

cd /Users/rorden/Documents/pas/
zip -r /Users/rorden/Documents/mricron_source.zip mricron

cd /Users/rorden/Documents/
zip -r /Users/rorden/Documents/mricron_osx.zip mricron

