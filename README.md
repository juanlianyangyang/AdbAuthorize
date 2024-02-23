###################################################<br>
重新编译adbd服务模块<br>
修改为无需弹出授权 其它未修改<br>
-    if (ALLOW_ADBD_NO_AUTH && !android::base::GetBoolProperty("ro.adb.secure", false)) {
-        auth_required = false;
-    }
+    auth_required = false;
<br>
