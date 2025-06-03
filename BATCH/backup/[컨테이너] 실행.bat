@echo off
:: Docker 네트워크 생성 (서브넷 지정)
docker network create --subnet=192.168.1.0/24 my-custom-network

:: MySQL 8 컨테이너 실행 (주석 처리됨, 필요 시 주석 해제)
docker run -d --network my-custom-network --ip 192.168.1.30 --name mysql8-container -p 3330:3306 mysql-custom:1.0
 
:: BN_REDIS
docker run -d --network  my-custom-network --ip 192.168.1.50 --name bn_redis-container -p 6379:6379 bn_redis

:: BN
docker run -d --network  my-custom-network --ip 192.168.1.40 --name bn-container -p 8095:8095 bn


:: React 애플리케이션 컨테이너 실행
docker run -d --network my-custom-network --ip 192.168.1.10 --name react-container -p 3000:80 react-docker-app

:: TEST(CMD)
:: 
::docker run -it --network  my-custom-network --ip 192.168.1.40 --name flask-opencv-container2 -p 8095:8095 flask-opencv-app2 /bin/bash


::docker run -it --network my-custom-network --ip 192.168.1.10 --name react-container -p 3000:80 react-docker-app /bin/bash



:: 실행과 동시에 로그확인
docker run -d --network  my-custom-network --ip 192.168.1.40 --name bn-container -p 8095:8095 bn && docker logs -f bn-container 
docker run -d --network my-custom-network --ip 192.168.1.10 --name react-container -p 3000:80 react-docker-app && docker logs -f react-container


:: TEST flask-opencv-app2
docker run -d --network my-custom-network --ip 192.168.1.40 --name flask-opencv-app2-container -p 8095:8095 flask-opencv-app2; docker logs -f flask-opencv-app2-container

