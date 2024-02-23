#!/system/bin/sh

# Module's own path (local path)
MODDIR=${0%/*}

# 设置文件路径
LOG_FILE="$MODDIR/status.log"

# 连续成功计次
success_count=0

sleep 4

echo "auto open adb" > $LOG_FILE
echo "run dir is $MODDIR" >> $LOG_FILE


while true; do
    # 执行命令并获取返回值
    result=$(settings get global adb_enabled)
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        # 将结果写入日志文件
        if [ $result -eq 0 ]; then
            settings put global adb_enabled 1
            settings put global development_settings_enabled 1
            echo "open adb" >> $LOG_FILE
            result=$(settings get global development_settings_enabled)
            echo "development_settings_enabled :$result" >> $LOG_FILE
            result=$(settings get global adb_enabled)
            echo "adb_enabled: $result" >> $LOG_FILE
            # 清零连续成功计次
            success_count=0
        else
            echo "adb status:$result" >> $LOG_FILE

            # 判断连续成功计次
            if [ $success_count -ge 3 ]; then
                echo "Exiting script due to continuous success." >> $LOG_FILE
                exit 0
            fi

            # 增加连续成功计次
            success_count=$((success_count + 1))
        fi
    fi

    # 等待一段时间后继续尝试
    sleep 4
done
