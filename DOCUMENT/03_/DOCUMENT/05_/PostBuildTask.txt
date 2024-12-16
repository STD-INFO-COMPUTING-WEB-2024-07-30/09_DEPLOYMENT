#!/bin/bash

# 프로세스를 실행한 Java 명령어와 JAR 파일 경로를 지정합니다.
JAVA_COMMAND="java -jar"
JAR_PATH="/var/lib/jenkins/workspace/MY_WEBSERVER_DEPLOY/build/libs/demo-0.0.1-SNAPSHOT.jar"

# 해당 Java 프로세스를 찾아서 PID를 얻어냅니다.
TARGET_PID=$(pgrep -f "$JAVA_COMMAND $JAR_PATH")

# PID를 확인하고 종료합니다.
if [ -z "$TARGET_PID" ]; then
    echo "해당 프로세스가 이미 종료되었습니다."
else
    echo "프로세스 $TARGET_PID 종료 중..."
    kill -9 "$TARGET_PID"

    # 종료 후 확인
    if ps -p "$TARGET_PID" > /dev/null; then
        echo "프로세스 $TARGET_PID 종료 실패"
        # exit 1
    else
        echo "프로세스 $TARGET_PID 성공적으로 종료됨"
    fi
fi

nohup java -jar /var/lib/jenkins/workspace/MY_WEBSERVER_DEPLOY/build/libs/demo-0.0.1-SNAPSHOT.jar &
