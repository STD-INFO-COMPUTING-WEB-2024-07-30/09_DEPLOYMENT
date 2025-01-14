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

```
C:\Users\jwg13\Downloads\TEST___\09_DEPLOYMENT\DOCUMENT\05_>docker-compose up
time="2025-01-14T12:44:26+09:00" level=warning msg="C:\\Users\\jwg13\\Downloads\\TEST___\\09_DEPLOYMENT\\DOCUMENT\\05_\\docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
[+] Running 4/4
 ! BN Warning   pull access denied for bn, repository does not exist or may require 'docker login'                 1.8s
 ! FN Warning   pull access denied for fn, repository does not exist or may require 'docker login'                 2.6s
 ! DB Warning   pull access denied for db, repository does not exist or may require 'docker login'                 1.8s
 ✔ redis Pulled                                                                                                    2.0s
[+] Building 6.7s (42/42) FINISHED                                                                 docker:desktop-linux
 => [DB internal] load build definition from Dockerfile                                                            0.0s
 => => transferring dockerfile: 329B                                                                               0.0s
 => [DB internal] load metadata for docker.io/library/mysql:8.0                                                    1.6s
 => [DB auth] library/mysql:pull token for registry-1.docker.io                                                    0.0s
 => [DB internal] load .dockerignore                                                                               0.0s
 => => transferring context: 2B                                                                                    0.0s
 => CACHED [DB 1/1] FROM docker.io/library/mysql:8.0@sha256:d58ac93387f644e4e040c636b8f50494e78e5afc27ca0a87348b2  0.0s
 => => resolve docker.io/library/mysql:8.0@sha256:d58ac93387f644e4e040c636b8f50494e78e5afc27ca0a87348b2f577da2b7f  0.0s
 => [DB] exporting to image                                                                                        0.1s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:3fe9d10f944264abd71a302de210ec55efd681520b68ad6a2ed7857c6dd8436d                  0.0s
 => => exporting config sha256:2e8a1cc82f30336a701d1b7f5bdeaaab60e14fead96020e4ff91005f60621ad9                    0.0s
 => => exporting attestation manifest sha256:58cec442de6de05f4e141ec80fa396ca7a5483f0840b23b6117561e236916bfa      0.0s
 => => exporting manifest list sha256:5bb782ed69880683a87da7f09751aa85b47bacf1115b495a83884c011e4eb95e             0.0s
 => => naming to docker.io/library/db:1.0                                                                          0.0s
 => => unpacking to docker.io/library/db:1.0                                                                       0.0s
 => [DB] resolving provenance for metadata file                                                                    0.0s
 => [BN internal] load build definition from Dockerfile                                                            0.0s
 => => transferring dockerfile: 630B                                                                               0.0s
 => [BN internal] load metadata for docker.io/library/eclipse-temurin:21-jdk                                       1.6s
 => [BN internal] load metadata for docker.io/library/gradle:8.11.1-jdk21                                          1.6s
 => [BN auth] library/gradle:pull token for registry-1.docker.io                                                   0.0s
 => [BN auth] library/eclipse-temurin:pull token for registry-1.docker.io                                          0.0s
 => [BN internal] load .dockerignore                                                                               0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [BN build 1/4] FROM docker.io/library/gradle:8.11.1-jdk21@sha256:7990a44ed0ad609ee740426d3becc69ae7d10a5ed14d  0.0s
 => => resolve docker.io/library/gradle:8.11.1-jdk21@sha256:7990a44ed0ad609ee740426d3becc69ae7d10a5ed14da7e354ad8  0.0s
 => [BN stage-1 1/4] FROM docker.io/library/eclipse-temurin:21-jdk@sha256:843686b2422d68890bb3ee90c5d08d9b325b9a2  0.0s
 => => resolve docker.io/library/eclipse-temurin:21-jdk@sha256:843686b2422d68890bb3ee90c5d08d9b325b9a2acf06ffca42  0.0s
 => [BN internal] load build context                                                                               0.0s
 => => transferring context: 6.69kB                                                                                0.0s
 => CACHED [BN stage-1 2/4] WORKDIR /app                                                                           0.0s
 => CACHED [BN build 2/4] WORKDIR /app                                                                             0.0s
 => CACHED [BN build 3/4] COPY . .                                                                                 0.0s
 => CACHED [BN build 4/4] RUN gradle build --no-daemon -x test                                                     0.0s
 => CACHED [BN stage-1 3/4] COPY --from=build /app/build/libs/*.jar app.jar                                        0.0s
 => CACHED [BN stage-1 4/4] RUN apt-get update && apt-get install -y     mysql-client     iputils-ping     net-to  0.0s
 => [BN] exporting to image                                                                                        0.9s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:a80b0130db1fae9e625263430d2ba383059d34ef7a5e65376239458d9136cbef                  0.0s
 => => exporting config sha256:dcd0d936cfeff37a55492acabff005302d6f03bad0b33451b566eea4162dab72                    0.0s
 => => exporting attestation manifest sha256:d6ca0de291d2bf43b1114955d0c271b20b4db55e2e83fa7fb1b8def3066aa4a7      0.0s
 => => exporting manifest list sha256:2a11938f60de69cae7542fde3e7f3577caa50793c4271bb676f6a74a4eaa1896             0.0s
 => => naming to docker.io/library/bn:latest                                                                       0.0s
 => => unpacking to docker.io/library/bn:latest                                                                    0.9s
 => [BN] resolving provenance for metadata file                                                                    0.0s
 => [FN internal] load build definition from Dockerfile                                                            0.0s
 => => transferring dockerfile: 528B                                                                               0.0s
 => [FN internal] load metadata for docker.io/library/nginx:stable                                                 1.5s
 => [FN internal] load metadata for docker.io/library/node:22                                                      1.5s
 => [FN auth] library/nginx:pull token for registry-1.docker.io                                                    0.0s
 => [FN auth] library/node:pull token for registry-1.docker.io                                                     0.0s
 => [FN internal] load .dockerignore                                                                               0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [FN build 1/6] FROM docker.io/library/node:22@sha256:99981c3d1aac0d98cd9f03f74b92dddf30f30ffb0b34e6df8bd96283  0.0s
 => => resolve docker.io/library/node:22@sha256:99981c3d1aac0d98cd9f03f74b92dddf30f30ffb0b34e6df8bd96283f62f12c6   0.0s
 => [FN stage-1 1/3] FROM docker.io/library/nginx:stable@sha256:df6f3c8e3fb6161cc5e85c8db042c8e62cfb7948fc4d6fddf  0.0s
 => => resolve docker.io/library/nginx:stable@sha256:df6f3c8e3fb6161cc5e85c8db042c8e62cfb7948fc4d6fddfad32741c3e2  0.0s
 => [FN internal] load build context                                                                               0.0s
 => => transferring context: 1.69kB                                                                                0.0s
 => CACHED [FN build 2/6] WORKDIR /FN                                                                              0.0s
 => CACHED [FN build 3/6] COPY package*.json ./                                                                    0.0s
 => CACHED [FN build 4/6] RUN npm install                                                                          0.0s
 => CACHED [FN build 5/6] COPY . .                                                                                 0.0s
 => CACHED [FN build 6/6] RUN npm run build                                                                        0.0s
 => CACHED [FN stage-1 2/3] COPY --from=build /FN/build /usr/share/nginx/html                                      0.0s
 => CACHED [FN stage-1 3/3] COPY nginx.conf /etc/nginx/conf.d/default.conf                                         0.0s
 => [FN] exporting to image                                                                                        0.1s
 => => exporting layers                                                                                            0.0s
 => => exporting manifest sha256:14a01f99f06eaf2cb9b7a104511922f928d67ed3c2b552e1859f6350a700991d                  0.0s
 => => exporting config sha256:919943c06e5c6a8e1e97c37503ec5359dedd2d159ac828cf2bf22f319435c636                    0.0s
 => => exporting attestation manifest sha256:866a7c76e713908102abf81e54ff633f961617acf2d1a44db02e45cda1f875c9      0.0s
 => => exporting manifest list sha256:bd6ad288d0371ebb80ad1d6dcf4df5083d23a3cc8b87a7931b4359fc92689def             0.0s
 => => naming to docker.io/library/fn:latest                                                                       0.0s
 => => unpacking to docker.io/library/fn:latest                                                                    0.0s
 => [FN] resolving provenance for metadata file                                                                    0.0s
[+] Running 4/3
 ✔ Container redis-container  Created                                                                              0.2s
 ✔ Container db-container     Created                                                                              0.2s
 ✔ Container bn-container     Created                                                                              0.1s
 ✔ Container fn-container     Created                                                                              0.1s
Attaching to bn-container, db-container, fn-container, redis-container
db-container     | 2025-01-14 03:44:37+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.40-1.el9 started.
redis-container  | 1:C 14 Jan 2025 03:44:37.998 * oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
redis-container  | 1:C 14 Jan 2025 03:44:37.998 * Redis version=7.4.2, bits=64, commit=00000000, modified=0, pid=1, just started
redis-container  | 1:C 14 Jan 2025 03:44:37.998 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
redis-container  | 1:M 14 Jan 2025 03:44:37.999 * monotonic clock: POSIX clock_gettime
redis-container  | 1:M 14 Jan 2025 03:44:38.000 * Running mode=standalone, port=6379.
redis-container  | 1:M 14 Jan 2025 03:44:38.001 * Server initialized
redis-container  | 1:M 14 Jan 2025 03:44:38.001 * Ready to accept connections tcp
db-container     | 2025-01-14 03:44:38+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
db-container     | 2025-01-14 03:44:38+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.40-1.el9 started.
db-container     | 2025-01-14 03:44:38+00:00 [Note] [Entrypoint]: Initializing database files
db-container     | 2025-01-14T03:44:38.312434Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
db-container     | 2025-01-14T03:44:38.312971Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.40) initializing of server in progress as process 80
db-container     | 2025-01-14T03:44:38.320735Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
db-container     | 2025-01-14T03:44:38.497787Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
db-container     | 2025-01-14T03:44:39.137279Z 6 [Warning] [MY-010453] [Server] root@localhost is created with an empty password ! Please consider switching off the --initialize-insecure option.
db-container     | 2025-01-14 03:44:41+00:00 [Note] [Entrypoint]: Database files initialized
db-container     | 2025-01-14 03:44:41+00:00 [Note] [Entrypoint]: Starting temporary server
db-container     | 2025-01-14T03:44:41.620811Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
db-container     | 2025-01-14T03:44:41.621776Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.40) starting as process 124
db-container     | 2025-01-14T03:44:41.630716Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
db-container     | 2025-01-14T03:44:41.736594Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
db-container     | 2025-01-14T03:44:41.881408Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
db-container     | 2025-01-14T03:44:41.881460Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
db-container     | 2025-01-14T03:44:41.883201Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
db-container     | 2025-01-14T03:44:41.895496Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: /var/run/mysqld/mysqlx.sock
db-container     | 2025-01-14T03:44:41.895573Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.40'  socket: '/var/run/mysqld/mysqld.sock'  port: 0  MySQL Community Server - GPL.
db-container     | 2025-01-14 03:44:41+00:00 [Note] [Entrypoint]: Temporary server started.
db-container     | '/var/lib/mysql/mysql.sock' -> '/var/run/mysqld/mysqld.sock'
db-container     | Warning: Unable to load '/usr/share/zoneinfo/iso3166.tab' as time zone. Skipping it.
db-container     | Warning: Unable to load '/usr/share/zoneinfo/leap-seconds.list' as time zone. Skipping it.
db-container     | Warning: Unable to load '/usr/share/zoneinfo/leapseconds' as time zone. Skipping it.
db-container     | Warning: Unable to load '/usr/share/zoneinfo/tzdata.zi' as time zone. Skipping it.
db-container     | Warning: Unable to load '/usr/share/zoneinfo/zone.tab' as time zone. Skipping it.
db-container     | Warning: Unable to load '/usr/share/zoneinfo/zone1970.tab' as time zone. Skipping it.
db-container     | 2025-01-14 03:44:43+00:00 [Note] [Entrypoint]: Creating database bookdb
db-container     | 2025-01-14 03:44:43+00:00 [Note] [Entrypoint]: Creating user dbonn
db-container     | 2025-01-14 03:44:43+00:00 [Note] [Entrypoint]: Giving user dbonn access to schema bookdb
db-container     |
db-container     | 2025-01-14 03:44:43+00:00 [Note] [Entrypoint]: Stopping temporary server
db-container     | 2025-01-14T03:44:43.442692Z 13 [System] [MY-013172] [Server] Received SHUTDOWN from user root. Shutting down mysqld (Version: 8.0.40).
db-container     | 2025-01-14T03:44:44.439602Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.40)  MySQL Community Server - GPL.
db-container     | 2025-01-14 03:44:44+00:00 [Note] [Entrypoint]: Temporary server stopped
db-container     |
db-container     | 2025-01-14 03:44:44+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.
db-container     |
db-container     | 2025-01-14T03:44:44.613412Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
db-container     | 2025-01-14T03:44:44.614376Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.40) starting as process 1
db-container     | 2025-01-14T03:44:44.618220Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
db-container     | 2025-01-14T03:44:44.695425Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
db-container     | 2025-01-14T03:44:44.837419Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
db-container     | 2025-01-14T03:44:44.837467Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
db-container     | 2025-01-14T03:44:44.839518Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
db-container     | 2025-01-14T03:44:44.850957Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
db-container     | 2025-01-14T03:44:44.851028Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.40'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
bn-container     |
bn-container     |   .   ____          _            __ _ _
bn-container     |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
bn-container     | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
bn-container     |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
bn-container     |   '  |____| .__|_| |_|_| |_\__, | / / / /
bn-container     |  =========|_|==============|___/=/_/_/_/
bn-container     |
bn-container     |  :: Spring Boot ::                (v3.4.0)
bn-container     |
bn-container     | 2025-01-14T12:44:49.807+09:00  INFO 1 --- [demo] [           main] com.example.demo.DemoApplication         : Starting DemoApplication v0.0.1-SNAPSHOT using Java 21.0.5 with PID 1 (/app/app.jar started by root in /app)
bn-container     | 2025-01-14T12:44:49.810+09:00  INFO 1 --- [demo] [           main] com.example.demo.DemoApplication         : No active profile set, falling back to 1 default profile: "default"
bn-container     | 2025-01-14T12:44:50.445+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Multiple Spring Data modules found, entering strict repository configuration mode
bn-container     | 2025-01-14T12:44:50.446+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFAULT mode.
bn-container     | 2025-01-14T12:44:50.562+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 110 ms. Found 3 JPA repository interfaces.
bn-container     | 2025-01-14T12:44:50.569+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Multiple Spring Data modules found, entering strict repository configuration mode
bn-container     | 2025-01-14T12:44:50.569+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data Redis repositories in DEFAULT mode.
bn-container     | 2025-01-14T12:44:50.579+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 1 ms. Found 0 Redis repository interfaces.
bn-container     | 2025-01-14T12:44:50.800+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Multiple Spring Data modules found, entering strict repository configuration mode
bn-container     | 2025-01-14T12:44:50.800+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data Redis repositories in DEFAULT mode.
bn-container     | 2025-01-14T12:44:50.822+09:00  INFO 1 --- [demo] [           main] .RepositoryConfigurationExtensionSupport : Spring Data Redis - Could not safely identify store assignment for repository candidate interface com.example.demo.domain.repository.JWTTokenRepository; If you want this repository to be a Redis repository, consider annotating your entities with one of these annotations: org.springframework.data.redis.core.RedisHash (preferred), or consider extending one of the following types with your repository: org.springframework.data.keyvalue.repository.KeyValueRepository
bn-container     | 2025-01-14T12:44:50.823+09:00  INFO 1 --- [demo] [           main] .RepositoryConfigurationExtensionSupport : Spring Data Redis - Could not safely identify store assignment for repository candidate interface com.example.demo.domain.repository.SignatureRepository; If you want this repository to be a Redis repository, consider annotating your entities with one of these annotations: org.springframework.data.redis.core.RedisHash (preferred), or consider extending one of the following types with your repository: org.springframework.data.keyvalue.repository.KeyValueRepository
bn-container     | 2025-01-14T12:44:50.823+09:00  INFO 1 --- [demo] [           main] .RepositoryConfigurationExtensionSupport : Spring Data Redis - Could not safely identify store assignment for repository candidate interface com.example.demo.domain.repository.UserRepository; If you want this repository to be a Redis repository, consider annotating your entities with one of these annotations: org.springframework.data.redis.core.RedisHash (preferred), or consider extending one of the following types with your repository: org.springframework.data.keyvalue.repository.KeyValueRepository
bn-container     | 2025-01-14T12:44:50.823+09:00  INFO 1 --- [demo] [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 21 ms. Found 0 Redis repository interfaces.
bn-container     | 2025-01-14T12:44:51.526+09:00  INFO 1 --- [demo] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8095 (http)
bn-container     | 2025-01-14T12:44:51.545+09:00  INFO 1 --- [demo] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
bn-container     | 2025-01-14T12:44:51.545+09:00  INFO 1 --- [demo] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.33]
bn-container     | 2025-01-14T12:44:51.577+09:00  INFO 1 --- [demo] [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
bn-container     | 2025-01-14T12:44:51.579+09:00  INFO 1 --- [demo] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1722 ms
bn-container     | 2025-01-14T12:44:51.677+09:00  INFO 1 --- [demo] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
bn-container     | 2025-01-14T12:44:52.143+09:00  INFO 1 --- [demo] [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection com.mysql.cj.jdbc.ConnectionImpl@554566a8
bn-container     | 2025-01-14T12:44:52.145+09:00  INFO 1 --- [demo] [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
bn-container     | 2025-01-14T12:44:52.223+09:00  INFO 1 --- [demo] [           main] o.hibernate.jpa.internal.util.LogHelper  : HHH000204: Processing PersistenceUnitInfo [name: default]
bn-container     | 2025-01-14T12:44:52.287+09:00  INFO 1 --- [demo] [           main] org.hibernate.Version                    : HHH000412: Hibernate ORM core version 6.6.2.Final
bn-container     | 2025-01-14T12:44:52.333+09:00  INFO 1 --- [demo] [           main] o.h.c.internal.RegionFactoryInitiator    : HHH000026: Second-level cache disabled
bn-container     | 2025-01-14T12:44:52.774+09:00  INFO 1 --- [demo] [           main] o.s.o.j.p.SpringPersistenceUnitInfo      : No LoadTimeWeaver setup: ignoring JPA class transformer
bn-container     | 2025-01-14T12:44:52.838+09:00  WARN 1 --- [demo] [           main] org.hibernate.orm.deprecation            : HHH90000025: MySQLDialect does not need to be specified explicitly using 'hibernate.dialect' (remove the property setting and it will be selected by default)
bn-container     | 2025-01-14T12:44:52.851+09:00  INFO 1 --- [demo] [           main] org.hibernate.orm.connections.pooling    : HHH10001005: Database info:
bn-container     |      Database JDBC URL [Connecting through datasource 'HikariDataSource (HikariPool-1)']
bn-container     |      Database driver: undefined/unknown
bn-container     |      Database version: 8.0.40
bn-container     |      Autocommit mode: undefined/unknown
bn-container     |      Isolation level: undefined/unknown
bn-container     |      Minimum pool size: undefined/unknown
bn-container     |      Maximum pool size: undefined/unknown
bn-container     | 2025-01-14T12:44:53.500+09:00  INFO 1 --- [demo] [           main] o.h.e.t.j.p.i.JtaPlatformInitiator       : HHH000489: No JTA platform available (set 'hibernate.transaction.jta.platform' to enable JTA platform integration)
bn-container     | 2025-01-14T12:44:53.563+09:00  INFO 1 --- [demo] [           main] j.LocalContainerEntityManagerFactoryBean : Initialized JPA EntityManagerFactory for persistence unit 'default'
bn-container     | KeyGenerator getKeygen Key: [B@589a82af
bn-container     | JwtTokenProvider Constructor  최초 Key init: javax.crypto.spec.SecretKeySpec@58833fc
bn-container     | 2025-01-14T12:44:54.484+09:00  INFO 1 --- [demo] [           main] r$InitializeUserDetailsManagerConfigurer : Global AuthenticationManager configured with UserDetailsService bean with name principalDetailsServiceImpl
bn-container     | 2025-01-14T12:44:54.641+09:00  WARN 1 --- [demo] [           main] JpaBaseConfiguration$JpaWebConfiguration : spring.jpa.open-in-view is enabled by default. Therefore, database queries may be performed during view rendering. Explicitly configure spring.jpa.open-in-view to disable this warning
bn-container     | 2025-01-14T12:44:54.758+09:00  INFO 1 --- [demo] [           main] o.s.b.a.w.s.WelcomePageHandlerMapping    : Adding welcome page template: index
bn-container     | 2025-01-14T12:44:55.530+09:00  INFO 1 --- [demo] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8095 (http) with context path '/'
bn-container     | 2025-01-14T12:44:55.555+09:00  INFO 1 --- [demo] [           main] com.example.demo.DemoApplication         : Started DemoApplication in 6.145 seconds (process running for 6.778)
bn-container     | 2025-01-14T12:44:58.827+09:00  INFO 1 --- [demo] [nio-8095-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
bn-container     | 2025-01-14T12:44:58.827+09:00  INFO 1 --- [demo] [nio-8095-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
bn-container     | 2025-01-14T12:44:58.828+09:00  INFO 1 --- [demo] [nio-8095-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 0 ms
bn-container     | [JWTAUTHORIZATIONFILTER] doFilterInternal...
bn-container     | [JWTAUTHORIZATIONFILTER] access-token: null
bn-container     | [JWTAUTHORIZATIONFILTER] refresh-toekn : null
bn-container     | [JWTAUTHORIZATIONFILTER] 에러 발생: non null key required
bn-container     | 2025-01-14T12:44:59.135+09:00  INFO 1 --- [demo] [nio-8095-exec-1] c.e.demo.controller.HomeController       : GET /home...
fn-container     | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
fn-container     | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
fn-container     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
fn-container     | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
fn-container     | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
fn-container     | /docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
fn-container     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
fn-container     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
fn-container     | /docker-entrypoint.sh: Configuration complete; ready for start up
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: using the "epoll" event method
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: nginx/1.26.2
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: OS: Linux 5.15.167.4-microsoft-standard-WSL2
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker processes
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 28
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 29
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 30
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 31
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 32
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 33
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 34
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 35
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 36
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 37
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 38
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 39
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 40
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 41
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 42
fn-container     | 2025/01/14 03:45:00 [notice] 1#1: start worker process 43
```

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
