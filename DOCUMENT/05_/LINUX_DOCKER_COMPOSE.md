#리눅스도커 / 도커컴포즈 설치


>DOCKER INSTALL
```
yum install -y docker
systemctl restart docker
systemctl enable docker
```

>DOCKER-COMPOSE
```
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

```
