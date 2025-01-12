@echo off
:: Docker 네트워크 생성 (서브넷 지정)
echo Creating custom network...
docker network create --subnet=192.168.1.0/24 my-custom-network

:: MySQL 8 컨테이너 실행 (주석 처리됨, 필요 시 주석 해제)
:: echo Running MySQL container...
docker run -d --network my-custom-network --ip 192.168.1.30 --name mysql8-container -p 3330:3306 mysql-custom:1.0



:: Flask + OpenCV 애플리케이션 컨테이너 실행
echo Running Flask OpenCV container 1...
docker run -d --network my-custom-network --ip 192.168.1.100 --name flask-opencv-container -p 5000:5000 flask-opencv-app

:: Flask + OpenCV 애플리케이션 컨테이너 실행 2
echo Running Flask OpenCV container 2...
docker run -d --network my-custom-network --ip 192.168.1.200 --name flask-opencv-container2 -p 5002:5002 -p 5003:5003 -p 5004:5004 flask-opencv-app2

:: BN_AUTH
echo Running BN_AUTH...
docker run -d --network  my-custom-network --ip 192.168.1.40 --name bn_auth-container -p 8095:8095 bn_auth

:: BN_REDIS
echo Running BN_REDIS...
docker run -d --network  my-custom-network --ip 192.168.1.50 --name bn_redis-container -p 6379:6379 bn_redis


:: React 애플리케이션 컨테이너 실행
echo Running React container...
docker run -d --network my-custom-network --ip 192.168.1.10 --name react-container -p 3000:80 react-docker-app


::----------------------------
::CMD
::----------------------------
:: echo Running MySQL container...
::docker run -it --network my-custom-network --ip 192.168.1.30 --name mysql8-container -p 3330:3306 mysql-custom:1.0 /bin/bash

:: Flask + OpenCV 애플리케이션 컨테이너 실행
::docker run -d  -it --network my-custom-network --ip 192.168.1.100 --name flask-opencv-container -p 5000:5000 flask-opencv-app /bin/bash

:: Flask + OpenCV 애플리케이션 컨테이너 실행 2
::docker run -it --network my-custom-network --ip 192.168.1.200 --name flask-opencv-container2 -p 5002:5002 -p 5003:5003 -p 5004:5004 flask-opencv-app2 /bin/bash

:: BN_AUTH
::docker run -it --network  my-custom-network --ip 192.168.1.40 --name bn_auth-container -p 8095:8095 bn_auth /bin/bash

:: BN_REDIS
::docker run -it --network  my-custom-network --ip 192.168.1.50 --name bn_redis-container -p 6379:6379 bn_redis /bin/bash

:: React 애플리케이션 컨테이너 실행
::docker run -it --network my-custom-network --ip 192.168.1.10 --name react-container -p 3000:80 react-docker-app /bin/bash
