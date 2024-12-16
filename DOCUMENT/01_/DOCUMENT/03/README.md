# 리눅스 기본명령어 2


> alias : 별칭, (명령어)단축키
```
[옵션]x

------------------------------
[실습]-1
------------------------------
alias a1='mkdir /aliastest'

a1

ls -al /aliastest



------------------------------
[실습]-1 명령어 지정
------------------------------

alias a2='touch /aliastest/a /aliastest/b'
a2

ls -al /aliastest


------------------------------
[실습]-2 명령어 지정
------------------------------

alias a3='touch /aliastest/test1
	>mkdir /aliastest/test2'

a3

ls -al /aliastest

------------------------------
[실습]-3 alias 조합 사용
------------------------------

alias a4='a1
	> a2'

ls -al /aliasteset



------------------------------
[실습]-4 ailas 삭제 
------------------------------

unalias a1 a2 a3

```

---
#
---

> 문제
```
/aliastest 디렉토리를 삭제후에 진행하세요 (rm -rf /aliastest )

1./aliastest 디렉토리를 만드는 alias a1 을 생성하세요
2. /aliastest 안에 빈파일 test1 test2 test3 을만드는 alias a2 를 생성하세요
3. /aliastest 안의 빈파일 test1 test2 test3 의 시간을 11:30으로  으로 변경하는 alias a3 을 생성하세요
4. find 명령어를 이용해서 login.defs, passwd, inittab 을 /aliastest 디렉토리로 복사시키는 alias a4를 생성하세요
5. a1,a2,a3,a4 를 한번에 사용할 수 있는 alias a5 를 만드세요
6. /aliastest 를 삭제하는 alias a6를 생성하세요
```
---
#
---


> [date] 시스템 시간 확인	<br>
```
Date -s “2016-09-09 22:24:30”		- 날짜 시간 모두 설정
Date +%D -s “2016-09-09”		- 날짜만 설정
Date +%T -s “22:42:30”		- 시간만 설정
Date ‘+%Y-%m-%d %H:%M:%S’		- 내가 원하는 방식으로 출력
```

> [cal] 달력 보기 <br>

```
cal [월][연]
cal 2015
cal 09 2016
```

> [hwclock] 하드웨어 시간 <br>

```
Hwclock 		- 현재 하드웨어 시간확인
Hwclock -w 		- 하드웨어 시간변경(시스템시간으로)
Hwclock -s 		- 시스템 시간변경(하드웨어 시간으로)
```

> [rdate] 하드웨어-시스템 시간 동기화<br>
```
rdate time.bora.net
rdate -s time.bora.net
```

---
#
---
> cat : 문서 전체 출력 <br>
```
[옵션]
-n  : 행번호 출력

[실습]

cat /etc/passwd
cat -n /etc/passwd

```

> head&tail : 위&아래에서 시작해서(기본10줄) 출력<br>

```
[옵션]
-숫자 : 지정된 숫자 줄수만큼 출력

[실습]

head /etc/passwd
head -5 /etc/passwd 	
head -2 /etc/passwd 
tail /etc/passwd
tail -5 /etc/passwd
```

> more : 화면크기만큼 출력<br>
```
more /etc/passwd
```

---
#
---
> 문제 <br>

```
1. /output 디렉토리 만든 후 /etc/passwd, /etc/inittab, /etc/login.defs 를 복사
2./output/login.defs 의 내용을 위에서부터 5줄만 확인하세요
3./output/inittab 의 내용을 아래서부터 5줄만 확인하세요
4./output/passwd의 내용을 화면 크기만큼 끊어서 확인하세요
5. /output/passwd의 내용을 행번호를 붙여서 확인해보세요
6. find 명령어를 이용해서 /output 디렉토리 안의 login.defs , inittab, passwd의 
내용을 위로 5행만 출력하는 alias a1 을 만들고 실행해서 확인해 보세요
```
