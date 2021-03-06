#!/bin/sh
set -e
. "${MCDDIR}"/functions.sh
#antiX Linux plugin for multicd.sh
#version 20150722
#Copyright (c) 2015 Isaac Schemm
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
if [ $1 = links ];then
	echo "antiX-*.iso antix.iso none"
	echo "MX-*.iso antix.iso antiX_MX-*"
elif [ $1 = scan ];then
	if [ -f antix.iso ];then
		echo "AntiX"
	fi
elif [ $1 = copy ];then
	if [ -f antix.iso ];then
		echo "Copying AntiX..."
		mcdmount antix
		mcdcp -r "${MNT}"/antix/antiX "${WORK}"/ #Everything in antiX but the kernel and initrd
		mcdcp "${MNT}"/antix/boot/isolinux/isolinux.cfg "${WORK}"/antiX
		umcdmount antix
	fi
elif [ $1 = writecfg ];then
if [ -f antix.iso ];then
echo "label anitX
menu label ^antiX
com32 menu.c32
append /antiX/isolinux.cfg" >> "${WORK}"/boot/isolinux/isolinux.cfg
fi
else
	echo "Usage: $0 {links|scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi
