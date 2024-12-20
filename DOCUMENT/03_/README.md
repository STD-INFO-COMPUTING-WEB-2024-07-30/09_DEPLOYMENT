DEPLOY
---
> 목차 <br>

|-|
|-|
|[SPRINGBOOT PROJECT_INIT](./DOCUMENT/01_)|
|[AWS_EC2 INIT](./DOCUMENT/02_)|
|[AWS_EC2_SETUP](./DOCUMENT/03_)|
|[JENKINS INIT](./DOCUMENT/04_)|
|[JENKINS SETUP](./DOCUMENT/05_)|
|[DEPLOY TEST](./DOCUMENT/06_)|
|[]()|
|[]()|


> 테스트 시나리오
```
1 Local git 에서 Project Push
2 github WebHook 동작
3 Jenkins 수신 후 자동코드 실행
4 수정 배포된 내용 확인
```
![20240517172602](https://github.com/MY-ALL-LECTURE/DEPLOYMENT/assets/84259104/5315289d-50eb-4f9e-9e0b-8fe4fbdf16e1)


> 오류 - ./gradlew build  실행시 toolChain 관련 오류 
```

[ec2-user@ip-10-0-0-10 DEPLOY_TEST_]$ ./gradlew build

FAILURE: Build failed with an exception.

* What went wrong:
Gradle could not start your build.
> Could not create service of type BuildLifecycleController using ServicesProvider.createBuildLifecycleController().
   > Could not create service of type BuildModelController using VintageBuildControllerProvider.createBuildModelController().
      > Could not create service of type FileHasher using BuildSessionServices.createFileHasher().
         > java.io.FileNotFoundException: /test/DEPLOY_TEST_/.gradle/8.11.1/fileHashes/fileHashes.lock (Permission denied)

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
```
> 해결 gradle.setting 에 추가하기
```
plugins {
    id 'org.gradle.toolchains.foojay-resolver-convention' version '0.8.0'
}
```

