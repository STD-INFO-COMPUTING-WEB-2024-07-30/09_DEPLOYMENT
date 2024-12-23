# DOCKER DEPLOY

확인
---
|-|
|-|
|<img src="/DATA/04_SB_DOCKER_EC2(JENKINS,DEPLOY)/시나리오 이미지.png"/>|

> 테스트 시나리오
```
1 LOCALHOST에서 작업 이후 git push
2 github 에서 push 이벤트 감지후 AWS EC2 내의 Jenkins Docker Container로 전달
3 Jenkins Docker Container 에서 빌드처리
4 Jenkins Docker Container 에서 SSH Service 연결을 통한 Shell Command 전달
5 Deploy Server에 Web App 동작 확인

```

INDEX
---

|-|
|-|
|-|
|-|
|-|
|-|
|-|
|-|
