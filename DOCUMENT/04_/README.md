# DOCKER 

|-|
|-|
|[DOCKER 란](https://khj93.tistory.com/entry/Docker-Docker-%EA%B0%9C%EB%85%90)|
|[DOCKER 란](https://adjh54.tistory.com/352)|


---
DOCKER IMAGE 생성
---

> DB
```

```

> REDIS
```

```

> BN
```

```

> FN
```

```
















---
TMP
---
---
EC2 DOCKER 사용해보기(- 수정중 - )
---

> DOCKER 설치
```
[root@ip-10-0-0-8 libs]# yum install docker -y
[root@ip-10-0-0-8 libs]# docker -v
[root@ip-10-0-0-8 libs]# systemctl restart docker
[root@ip-10-0-0-8 libs]# systemctl status docker

```

DOCKER IMAGE CONTAINER 받기
---

> IMAGE PULL <br>

```
[root@ip-10-0-0-8 libs]# docker search centos:8
[root@ip-10-0-0-8 libs]# docker pull centos:8
7: Pulling from library/centos
2d473b07cdd5: Pull complete
Digest: sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4
Status: Downloaded newer image for centos:7
docker.io/library/centos:7

[root@ip-10-0-0-8 libs]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
centos       8         eeb6ee3f44bd   2 years ago   204MB

```

> DOCKER CONTAINER 생성 <br>

```
[root@ip-10-0-0-8 libs]# docker run --privileged --name centos-test --hostname centos-test --network host  -p 80:80 -it -d centos:8 /sbin/init
WARNING: Published ports are discarded when using host network mode
135e94f67eddee71b1a2db522c31ce3655ae222b9cb3ec69ee3b1b52f70a711f

[root@ip-10-0-0-8 libs]# docker ps
CONTAINER ID   IMAGE      COMMAND        CREATED         STATUS         PORTS     NAMES
135e94f67edd   centos:8   "/sbin/init"   2 minutes ago   Up 2 minutes             centos-test


```

> 방화벽 설정 <br>

|-|
|-|
|![20240518194035](https://github.com/MY-ALL-LECTURE/DEPLOYMENT/assets/84259104/146fa9a8-fea6-483a-845c-479e130e6a2b)|


> DOCKER CONTAINER 실행<br>

```
[root@ip-10-0-0-8 libs]# docker exec -it centos-test /bin/bash
[root@centos-test /]#

```

> 패키지 설치<br>

```
[root@centos-test /]# yum install -y httpd
```

> index page만들기 <br>

```
[root@centos-test /]# cd /var/www/html
[root@centos-test html]# cat > index.html
DOCKER_TEST_PAGE
^C

```
> 서비스실행<br>

```
systemctl restart httpd
systemctl enable httpd

```

