# DOCKER HUB

|-|
|-|
|[DOCKER HUB 란](https://hanmailco34.tistory.com/278)|
|[DOCKER HUB 가입하기](https://tttsss77.tistory.com/232)|


---
DOCKER IMAGE PUSH 
---
>DOCKERHUB REPO 생성
|-|
|-|
|<img src="" />|

> DOCKER IMAGE TAG 변경
```
docker tag bn:latest junwoogyun/react_springboot:bn
docker tag fn:latest junwoogyun/react_springboot:fn
docker tag db:latest junwoogyun/react_springboot:db
docker tag redis:latest junwoogyun/react_springboot:redis
```
|-|
|-|
|<img src="" />|

> DOCKER CMD LOGIN
|-|
|-|
|<img src="" />|


> DOCKER IMAGE PUSH 
```
docker push junwoogyun/react_springboot:bn
docker push junwoogyun/react_springboot:fn
docker push junwoogyun/react_springboot:db
docker push junwoogyun/react_springboot:redis
```
|-|
|-|
|<img src="" />|



---
DOCKERCOMPOSE YML 파일 수정하기
---

> docker-compose.yml 수정
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
    image: junwoogyun/react_springboot:db
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
    image: junwoogyun/react_springboot:redis
    container_name: redis-container
    networks:
      my-custom-network:
        ipv4_address: 192.168.1.200
    ports:
      - "6376:6376"

  BN:
    image: junwoogyun/react_springboot:bn
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
    image: junwoogyun/react_springboot:fn
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


---
DOCKERCOMPOSE UP TEST
---

> 기존 모든 컨테이너 & 도커 이미지 삭제
```
# 실행 중인 모든 컨테이너 중지
docker stop $(docker ps -aq)

# 모든 컨테이너 삭제
docker rm $(docker ps -aq)

```


> docker-compose up 실행
```

```


> 확인

|-|
|-|
|-|
|-|
|-|
 

