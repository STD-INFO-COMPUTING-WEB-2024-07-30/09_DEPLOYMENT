# DOCKER COMPOSE 

---
COMPOSE란
---
|-|
|-|
|[DOCKER COMPOSE 란](https://hstory0208.tistory.com/entry/Docker-%EB%8F%84%EC%BB%A4-%EC%BB%B4%ED%8F%AC%EC%A6%88Docker-Compose%EB%9E%80-%EC%99%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EB%8A%94%EA%B0%80)|


---
dockercompose.yml 생성
---
```
version: "3.9"

networks:
  my-custom-network:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.1.0/24

services:
  DB:
    build:
      context: ./DB
    image: db:1.0
    container_name: db-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.100
    ports:
      - "3330:3306"
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    build:
      context: ./REDIS
    image: redis:latest
    container_name: redis-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.200
    ports:
      - "6376:6376"

  BN:
    build:
      context: ./BN
    image: bn:latest
    container_name: bn-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.20
    ports:
      - "8095:8095"
    depends_on:
      DB:
        condition: service_healthy
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8095 || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 5

  FN:
    build:
      context: ./FN
    image: fn:latest
    container_name: fn-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.10
    ports:
      - "3000:80"
    depends_on:
      BN:
        condition: service_healthy

```

> 코드 해석(버전)
```
version: "3.9"

설명:
Docker Compose 파일의 버전을 정의합니다.
3.9는 Docker Compose 버전 3의 최신 사양으로, 다양한 최신 기능을 지원합니다.
```

> 코드 해석(사설 network 설정)
```
networks:
  my-custom-network:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.1.0/24

driver: bridge: 브리지 네트워크 드라이버를 사용합니다. 컨테이너 간 통신을 지원합니다.
ipam: 네트워크 IP 할당을 관리하는 섹션입니다.
subnet: 네트워크의 서브넷 범위를 지정합니다. 여기서는 192.168.1.0/24 서브넷을 사용합니다

```

> 코드 해석(서비스)
```
  DB:
    build:
      context: ./DB

설명: DB 서비스를 정의합니다.
build: Docker 이미지를 빌드할 때 사용할 디렉터리를 지정합니다.
context: ./DB: 현재 docker-compose.yml 파일 위치를 기준으로 ./DB 디렉터리에서 Dockerfile을 찾습니다.
```

> 코드 해석(이미지)
```
    image: db:1.0

설명: 빌드한 이미지를 db:1.0 이름으로 태그합니다.
``

> 코드 해석(컨테이너)
```
    container_name: db-container
설명: 컨테이너 이름을 db-container로 설정합니다.
``


> 코드 해석(네트워크)
```
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.100
설명: my-custom-network 네트워크에 컨테이너를 연결하고, 192.168.1.100 고정 IP 주소를 할당합니다
``

> 코드 해석(포트)
```
    ports:
      - "3330:3306"

설명: 호스트의 포트 3330을 컨테이너 내부의 3306 포트(MySQL 기본 포트)와 연결합니다.
``
> 코드 해석(헬스체크)
```
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

설명: 컨테이너 상태를 주기적으로 확인합니다.
test: mysqladmin ping 명령어를 실행하여 데이터베이스가 준비되었는지 확인합니다.
interval: 상태 확인 간격(10초).
timeout: 상태 확인 응답 대기 시간(5초).
retries: 재시도 횟수(5번).
``


> 코드 해석(Depends_on)
```
  BN:
    build:
      context: ./BN
    image: bn:latest
    container_name: bn-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.20
    ports:
      - "8095:8095"
    depends_on:
      DB:
        condition: service_healthy

        
설명: BN 서비스를 설정합니다.
context: ./BN: BN의 Dockerfile이 있는 디렉터리를 지정합니다.
고정 IP는 192.168.1.20이며, 8095 포트를 사용합니다.
depends_on: DB 서비스가 완전히 준비된 상태(healthy)일 때까지 BN 서비스를 대기시킵니다.        
```


---
Docker-compose up
---


> docker-compose 명령어 정리
```
docker-compose up	컨테이너를 시작 (필요 시 빌드)
docker-compose down	컨테이너, 네트워크, 볼륨 정리
docker-compose build	이미지를 빌드
docker-compose start	중지된 컨테이너 시작
docker-compose stop	실행 중인 컨테이너 중지
docker-compose restart	컨테이너 재시작
docker-compose ps	컨테이너 상태 확인
docker-compose logs	컨테이너 로그 확인
docker-compose exec	실행 중인 컨테이너에서 명령어 실행
docker-compose run	새 컨테이너를 생성하여 명령어 실행
docker-compose config	Compose 파일 구성을 확인
docker-compose version	Docker Compose 버전 확인
```
