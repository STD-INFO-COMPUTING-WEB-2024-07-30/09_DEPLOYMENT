# 리눅스 기본명령어 2


mv : 파일 디렉토리 이동(옵션x)
```
-환경-

mkdir /mvfile /mvtest
cd /mvfile
touch 1 2 3 4 
mkdir a b c 
cd /mvtest


-실습-

1. mv /mvfile/1 	/mvtest/1		
2. mv /mvfile/2 	/mvtest			
3. mv /mvfile/a 	./			
4. mv /mvfile/3	/mvfile/b	/mvfile/c 	/mvtest	
5. mv /mvfile/4	/mvtest/sa		

```

rm(remove) : 파일&디렉토리 삭제
```
[옵션] 
-f : 강제 삭제
-r : 디렉토리 삭제
-i : 질의(y/n)

[환경]
mkdir /rmtest 
cd /rmtest
touch 1 2 3 4
mkdir a b c 

[실습] 

rm 1
rm a
rm -r a
rm -f 2
rm -i 3 	
rm -fi 3		법칙 6 모순되는 옵션 사용시 마지막 옵션 적용
rm -if 3 	
rm -rf b c
```

find  파일&디렉토리 검색
```
--------------------------
[옵션]
--------------------------
name  	: 파일/디렉토리명 검색
perm 	: 지정된 퍼미션 검색 
size 	: 파일 크기가 일치하는 파일 찾기 
type	: 파일 형식 지정함
exec 	: 검색 결과를 해당 명령어로 실행 하는 옵션

o	: 복수 옵션 적용
type 	: 파일 유형검색 (파일 or 디렉토리)

atime n	: n일 전에 엑세스한 파일 찾기, +n 또는 -n 형식으로도 사용가능
mtime n	: n일 전에 마지막으로 수정된 파일 찾기, +n 또는 -n 형식으로도 사용가능
newer	: 지정된 파일 이후 생성된 파일 찾기 
used n	: 변경된지 n일이 지난 모든 파일 찾기
uid	: 지정된 UID를 가진 파일 검색
gid	: 지정된 GID를 가진 파일 검색
group	: 지정된 그룹을 가진 파일 검색
user	: 지정된 소유자가 소유한 모든 파일 검색

--------------------------
[환경]
--------------------------
mkdir /test /exec /exec2 
cd /test
mkdir  aa ab ca dd eae
touch 11 21 31 44 524 


--------------------------
[실습 1]  문자검색
--------------------------
find /test -name 11
find /test -name aa
find /test -name 21


--------------------------
[실습 2]  포함 문자 검색
--------------------------
find  /test -name "a*"
find  /test -name "*a"
find  /test -name "*a*"

--------------------------
[실습 3]  파일 종류 검색
--------------------------
find /test -type f
find /test -type d
find /etc -type l
find /etc -type d


--------------------------
[실습 4] - 다른 옵션 복수 적용
--------------------------
find / -name user1
find / -name user1  -type f
find / -name user1  -type d


--------------------------
[실습 5] - 같은 옵션 복수 적용
--------------------------
find /test -type d
find /test -type f
find /test -type d -type f	(x)
find /test -type d -o -type f	o
find /test -name 1 -o -name 2 	



--------------------------
[실습 6] -같은 옵션 복수 적용 예외(용량 검색)
--------------------------
find / -size +30000k 
find / -size -30000k
find / -size +30000K -size -50000K 
 

--------------------------
[실습 7] - 외부 명령어 실행(추가중)
--------------------------
find /test -exec ls -l {} \;
find /test -exec cp -r {} /exec \;
find /test -type d -exec ls -l {} \;
find / -name user1 -type d -exec cp -r {} /exec2 \;
```

---
#
---
문제
```
1. 
/findtest 디렉토리를 만들고 그안에 a,b,c,d 디렉토리, 1,2,3,4파일을 만든후 
find 명령어를 이용해서 login.defs을 찾아 /findtest에 복사하세요(/etc/에 있는 파일복사)

2.
find 명령어를 이용해서 passwd,inittab 한줄명령어로 찾고
/findtest 에 복사하세요(/etc/에 있는 파일복사)

3. find 명령어를 통해 /findtest 안의 내용중 파일만 검색하세요
	
4.find 명령어를 통해 /findtest 의 모든 디렉토리의 목록을 볼 수있도록 한줄명령어로 해결하세요
```
