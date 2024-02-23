#! /system/bin/sh

ui_print "Install ADB Authorize By Juanlianyangyang"

sdk=`getprop ro.build.version.sdk`

ui_print "Device SDK:$sdk"

if [ $sdk -ge 30 ]; then
	ui_print "Device Android11+"
	rm -rf $MODPATH/system/bin
	chmod +x $MODPATH/system/apex/com.android.adbd/bin/adbd
	chmod +x $MODPATH/post-fs-data.sh
	chcon --reference=/system/apex/com.android.adbd/bin/adbd $MODPATH/system/apex/com.android.adbd/bin/adbd
else
	ui_print "Device Android10-"
	rm -rf $MODPATH/system/apex
	rm -rf $MODPATH/post-fs-data.sh
	chmod +x $MODPATH/system/bin/adbd
	chcon --reference=/system/bin/adbd $MODPATH/system/bin/adbd
fi

chmod +x $MODPATH/service.sh

ui_print "Installed..."
