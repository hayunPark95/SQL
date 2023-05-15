--DBMS 서버에 전달된 SQL 명령이 잘못된 경우 롤백을 사용하여 데이타 복구를 위해 트렌젝션 사용 - 데이타 무결성
--데이타 무결성 : 테이블에 비정상적인 값을 저장하지 않아 정상적인 검색결과 제공
SELECT * FROM EMP;
DELETE FROM EMP;--실제 테이블에 DELETE 명령이 적용되는 것이 아니라 트렌젝션에 DELETE 명령 저장
SELECT * FROM EMP;
ROLLBACK;--트렌젝션 초기화
SELECT * FROM EMP;

--현재 세션에서 작업중인 테이블의 행을 커밋 처리 전까지 다른 세션에서 검색되지 않고 기존행이 검색되도록 
--트렌젝션 사용 - 데이타 일관성
--데이타 일관성 : DBMS 서버에 접속된 모든 사용자엑게 동일한 검색결과를 제공

--BONUS 테이블에서 사원이름이 KIM인 사원정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='KIM';
SELECT * FROM BONUS;

--다른 세션에서는 BONUS 테이블에서 사원이름이 KIM인 사원정보 검색
--현재 세션에서 커밋 처리하기 전까지 다른 세션에서는 기존행의 검색결과 제공 - 데이타 일관성
--커밋 처리를 이용해 트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하면 다른 세션에서도 테이블의 조작된 행 검색
COMMIT;

--데이타 잠금 기능(LOCK)을 제공하기 위해 트렌젹션 사용
--DBMS 프로그램은 다중 사용자 환경으로 같은 테이블의 행을 다른 세션에서 조작 가능
--현재 세션에서 작업중인 테이블의 행을 다른 세션에서 작업하지 못하도록 트렌젝션을 사용하여 데이타 잠금 기능 제공

--BONUS 테이블에서 사원이름이 ALLEN인 사원의 급여를 2000으로 변경
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN';--테이블 행에 대한 데이타 잠금 기능 활성화
SELECT * FROM BONUS;

--다른 세션을 사용하여 BONUS 테이블에서 사원이름이 ALLEN인 사원의 성과급를 급여의 50%로 변경
--UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--현재 세션에서 작업중인 테이블의 행을 다른 세션에서 조작할 경우 트렌젝션의 데이타 잠금 기능으로 인해
--다른 세션이 일시적으로 중지
--현재 세션에서 작업중인 테이블의 행에 대한 트렌젝션의 명령을 커밋 또는 롤백 처리해야만 데이타 잠금
--기능이 비활성화 되어 다른 세션의 DML 명령이 실행 가능
COMMIT;

--SAVEPOINT : 트렌젝션에 라벨(위치정보)을 부여하는 명령
--트렌젝션에 저장된 DML 명령 중 라벨을 이용하여 원하는 위치의 DML 명령만 롤백 처리하기 위해 SAVEPOINT 사용
--형식)SAVEPOINT 라벨명

--BONUS 테이블에서 사원이름이 ALLEN인 사원정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--BONUS 테이블에서 사원이름이 MARTIN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--롤백 처리
ROLLBACK;--트렌젝션에 저장된 모든 DML 명령 제거
SELECT * FROM BONUS;

--BONUS 테이블에서 사원이름이 ALLEN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;
SAVEPOINT ALLEN_DELETE_AFTER;--트렌젝션에 라벨을 생성하여 부착

--BONUS 테이블에서 사원이름이 MARTIN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT 명령으로 설정된 라벨을 이용하여 롤백 처리
--형식)ROLLBACK TO 라벨명
ROLLBACK TO ALLEN_DELETE_AFTER;--트렌젝션에서 라벨 뒤에 작성된 DML 명령만 제거
SELECT * FROM BONUS;

ROLLBACK;
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : 데이타 정의어
--데이타베이스의 객체(테이블,뷰,시퀸스,인덱스,동의어,사용자 등)를 관리하기 위한 SQL 명령

--테이블(TABLE) : 데이타베이스에서 데이타(행)을 저장하기 위한 가장 기본적인 객체

--테이블 생성 : 테이블 속성(ATTRIBUTE)의 집합
--형식)CREATE TABLE 테이블명(컬럼명 자료형[(크기)] [DEFAULT 기본값] [컬럼제약조건]
--     ,컬럼명 자료형[(크기)] [DEFAULT 기본값] [컬럼제약조건],...[,테이블제약조건])

--식별자 작성 규칙 : 테이블명, 컬럼명, 별칭, 라벨명 등
--1.영문자로 시작되며 1~30 범위의 문자들로만 구성
--2.A~Z,0~9,_,$,# 문자들을 조합하여 작성 - 대소문자 미구분 : 스네이크 표기법을 사용하는 것을 권장
--3.영문자외에 다른 문자(한글 등) 사용 가능 - 비권장
--4.키워드로 식별자를 선언할 경우 에러 발생 - " " 안에 표현하면 가능하지만 비권장

--자료형(DATATYPE) : 컬럼에 저장 가능한 값의 형태를 표현하기 위한 키워드
--1.숫자형 : NUMBER[(전체자릿수,소숫점자릿수)]
--2.문자형 : CHAR(크기) - 크기 : 1~2000(BYTE) >> 고정길이
--          VARCHAR2(크기) - 크기 : 1~4000(BYTE) >> 가변길이
--          LONG - 최대 2GBYTE 저장 >> 가변길이 - 테이블 하나의 컬럼에만 설정 가능하며 정렬 불가능  
--          CLOB - 최대 4GBYTE 저장 >> 가변길이 - 텍스트 파일을 저장하기 위한 자료형
--          BLOB - 최대 4GBYTE 저장 >> 가변길이 - 이진 파일을 저장하기 위한 자료형
--3.날짜형 : DATE - 날짜와 시간
--          TIMESTAMP - 초(MS) 단위 시간

--SALESMAN 테이블 생성 - 사원번호(숫자형),사원이름(문자형),입사일(날짜형)
CREATE TABLE SALESMAN(NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE);

--딕셔너리(DICTIONARY) : 시스템 정보를 제공하기 위한 가상의 테이블(뷰)
--USER_DICTIONARY(일반 사용자), DBA_DICTIONARY(관리자), ALL_DICTIONARY(모든 사용자)

--USER_OBJECTS : 현재 접속 사용자의 스키마로 접근 가능한 객체의 정보를 제공하는 딕셔너리
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES : 현재 접속 사용자의 스키마로 접근 가능한 테이블의 정보를 제공하는 딕셔너리
SELECT TABLE_NAME FROM USER_TABLES;
--USER_TABLES 딕셔너리 대신 동의어(SYNONYM)로 TABS 제공
SELECT TABLE_NAME FROM TABS;

--SALESMAN 테이블 구조 확인
DESC SALESMAN;

--SALESMAN 테이블에 행 삽입
INSERT INTO SALESMAN VALUES(1000,'홍길동','00/04/18');
SELECT * FROM SALESMAN;
COMMIT;

--컬럼을 생략하여 삽입 처리한 경우 생략된 컬럼에는 컬럼 기본값이 전달되어 삽입 처리
--테이블 생성시 컬럼 기본값을 설정하지 않은 경우 자동으로 NULL이 기본값으로 자동 설정
INSERT INTO SALESMAN(NO,NAME) VALUES(2000,'임꺽정');
SELECT * FROM SALESMAN;
COMMIT;

--테이블 생성시 제약조건을 설정하지 않은 경우 컬럼에 어떤한 값을 전달해도 삽입 처리 - 데이타 무결성 위반 가능
INSERT INTO SALESMAN VALUES(1000,'전우치','10/10/10');
SELECT * FROM SALESMAN;
COMMIT;

--MANAGER 테이블 생성 - 사원번호(숫자형),사원이름(문자형),입사일(날짜형-기본값:현재),급여(숫자형-기본값:1000)
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20)
    ,STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);

--테이블 목록 및 구조 확인
SELECT TABLE_NAME FROM USER_TABLES;
DESC MANAGER;

--USER_TAB_COLUMNS : 테이블의 컬럼 정보를 제공하는 딕셔너리
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER 테이블에 행 삽입
INSERT INTO MANAGER VALUES(1000,'홍길동','00/05/09',3000);
SELECT * FROM MANAGER;
--생략된 컬럼값에는 자동으로 컬럼 기본값이 전달되어 삽입 처리
INSERT INTO MANAGER(NO,NAME) VALUES(2000,'임꺽정');
SELECT * FROM MANAGER;
--DEFUALT 키워드를 사용하여 컬럼 기본값을 제공받아 삽입 처리
INSERT INTO MANAGER VALUES(3000,'전우치',DEFAULT,DEFAULT);
SELECT * FROM MANAGER;
COMMIT;

--제약조건(CONSTRAINT) : 컬럼에 비정상적인 값이 저장되는 것을 방지하기 위한 기능 - 데이타 무결성 유지
--컬럼 수준의 제약조건 : 테이블의 속성 선언시 컬럼에 제약조건을 설정
--테이블 수준의 제약조건 : 테이블 선언시 테이블의 특정 컬럼에 제약조건을 설정

--CHECK : 컬럼값으로 저장 가능한 조건을 제공하여 조건이 참(TRUE)인 경우에만 컬럼값으로 저장되도록 설정하는 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준 제약조건으로 설정 가능

--SAWON1 테이블 생성 : 사원번호(숫자형),사원이름(문자형),급여(숫자형)
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

--SAWON1 테이블 행 삽입 - 급여(PAY) 컬럼에는 모든 숫자값을 전달받아 저장 가능
INSERT INTO SAWON1 VALUES(1000,'홍길동',8000000);
INSERT INTO SAWON1 VALUES(2000,'임꺽정',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 테이블 생성 : 사원번호(숫자형),사원이름(문자형),급여(숫자형-최소급여:5000000)
--CHEKC 제약조건을 컬럼수준의 제약조건 설정 - 해당 컬럼을 이용한 조건식 설정 가능(다른 컬럼을 이용한 조건식을 사용하면 에러 발생)
CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER CHECK(PAY>=5000000));

--SAWON2 테이블 행 삽입
INSERT INTO SAWON2 VALUES(1000,'홍길동',8000000);
INSERT INTO SAWON2 VALUES(2000,'임꺽정',800000);--CHECK 제약조건을 위반하여 에러 발생
SELECT * FROM SAWON2;
COMMIT;

--USER_CONSTRAINTS : 테이블에 설정된 제약조건을 제공하는 딕셔너리
--CONSTRAINT_NAME : 제약조건을 구분하기 위한 이름(고유값) - 제약조건의 이름을 지정하지 않으면 자동으로 SYS_XXXXXXX 형식으로 설정
--CONSTRAINT_TYPE : 제약조건의 종류 - C(CHECK), U(UNIQUE), P(PRIMARY KEY), R(REFERENCE - FOREIGN KEY)
--SEARCH_CONDITION : CHECK 제약조건으로 설정된 조건식
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--제약조건을 설정할 경우 제약조건을 효율적으로 관리하기 위해 제약조건의 이름을 지정하는 것을 권장
--형식)컬럼명 자료형[(크기)] CONSTRAINT 제약조건명 제약조건

--SAWON3 테이블 생성 : 사원번호(숫자형),사원이름(문자형),급여(숫자형-최소급여:5000000)
CREATE TABLE SAWON3(NO NUMBER(4),NAME VARCHAR2(20)
    ,PAY NUMBER CONSTRAINT SAWON3_PAY_CHECK CHECK(PAY>=5000000));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON3';

--SAWON4 테이블 생성 : 사원번호(숫자형),사원이름(문자형),급여(숫자형-최소급여:5000000)
--CHEKC 제약조건을 테이블 수준의 제약조건으로 설정 - 모든 컬럼을 이용한 조건식 설정 가능
CREATE TABLE SAWON4(NO NUMBER(4),NAME VARCHAR2(20)
    ,PAY NUMBER,CONSTRAINT SAWON4_PAY_CHECK CHECK(PAY>=5000000));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON4';

--NOT NULL : NULL를 허용하지 않는 제약조건 - 컬럼에 반드시 값을 저장되도록 설정하는 제약조건
--컬럼 수준의 제약조건으로만 설정 가능 - CHECK 제약조건으로 표현

--DEPT1 테이블 생성 : 부서번호(숫자형),부서이름(문자형),부서위치(문자형)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;

--DEPT1 테이블에 행 삽입
INSERT INTO DEPT1 VALUES(10,'총무부','서울시');
INSERT INTO DEPT1 VALUES(20,NULL,NULL);--명시적 NULL 사용
INSERT INTO DEPT1(DEPTNO) VALUES(30);--묵시적 NULL 사용
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 테이블 생성 : 부서번호(숫자형-NOT NULL),부서이름(문자형-NOT NULL),부서위치(문자형-NOT NULL)
CREATE TABLE DEPT2(DEPTNO NUMBER(4) CONSTRAINT DEPT2_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(12) CONSTRAINT DEPT2_DNAME_NN NOT NULL
    ,LOC VARCHAR2(11) CONSTRAINT DEPT2_LOC_NN NOT NULL);
DESC DEPT2;    

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';    

--DEPT2 테이블에 행 삽입
INSERT INTO DEPT2 VALUES(10,'총무부','서울시');
INSERT INTO DEPT2 VALUES(20,NULL,NULL);--명시적 NULL 사용 : NOT NULL 제약조건을 위반하여 에러 발생
INSERT INTO DEPT2(DEPTNO) VALUES(30);--묵시적 NULL 사용 : NOT NULL 제약조건을 위반하여 에러 발생
SELECT * FROM DEPT2;
COMMIT;

--UNIQUE : 중복 컬럼값 저장을 방지하기 위한 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건 가능
--UNIQUE 제약조건은 테이블에 여러개 설정이 가능하며 NULL 허용

--USER1 테이블 생성 - 아이디(문자형),이름(문자형),전화번호(문자형)
CREATE TABLE USER1(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15));

--USER1 테이블에 행 삽입
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--USER2 테이블 생성 - 아이디(문자형-UNIQUE),이름(문자형),전화번호(문자형-UNIQUE) : 컬럼 수준의 제약조건
CREATE TABLE USER2(ID VARCHAR2(20) CONSTRAINT USER2_ID_UK UNIQUE
    ,NAME VARCHAR2(30),PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
    
--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

--USER2 테이블에 행 삽입
INSERT INTO USER2 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER2 VALUES('ABC','홍길동','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디와 전화번호 중복
INSERT INTO USER2 VALUES('ABC','임꺽정','010-7890-1234');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디 중복
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 전화번호 중복
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-7890-1234');--아이디와 전화번호가 중복되지 않아 삽입 처리
SELECT * FROM USER2;
COMMIT;

--UNIQUE 제약조건이 설정된 컬럼에 NULL을 전달하여 삽입 가능
INSERT INTO USER2 VALUES('OPQ','전우치',NULL);
--NULL은 값이 아니므로 UNIQUE 제약조건을 위반하지 않는 것으로 처리
INSERT INTO USER2 VALUES('IJK','일지매',NULL);
SELECT * FROM USER2;
COMMIT;

--USER3 테이블 생성 - 아이디(문자형-UNIQUE),이름(문자형),전화번호(문자형-UNIQUE) : 테이블 수준의 제약조건
CREATE TABLE USER3(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 테이블에 행 삽입
INSERT INTO USER3 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER3 VALUES('ABC','홍길동','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디와 전화번호 중복
INSERT INTO USER3 VALUES('ABC','임꺽정','010-7890-1234');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디 중복
INSERT INTO USER3 VALUES('XYZ','임꺽정','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 전화번호 중복
SELECT * FROM USER3;
COMMIT;

--USER4 테이블 생성 - 아이디(문자형),이름(문자형),전화번호(문자형) 
--아이디와 전화번호를 묶어서 UNIQUE 제약조건 설정 - 테이블 수준의 제약조건으로만 설정 가능
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 테이블에 행 삽입
INSERT INTO USER4 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER4 VALUES('ABC','홍길동','010-1234-5678');--UNIQUE 제약조건을 위반하여 에러 발생 : 아이디와 전화번호 중복
INSERT INTO USER4 VALUES('ABC','임꺽정','010-7890-1234');
INSERT INTO USER4 VALUES('XYZ','임꺽정','010-1234-5678');
SELECT * FROM USER4;
COMMIT;

--PRIMARY KEY(PK) : 중복 컬럼값 저장을 방지하기 위한 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건 설정 가능
--PRIMARY KEY 제약조건의 테이블에 한번만 설정 가능하며 NULL 미허용
--PRIMARY KEY 제약조건은 테이블에 한번만 설정 가능하므로 제약조건의 이름 지정 생략 가능
--PRIMARY KEY 제약조건은 테이블의 관계를 구체화하기 위해 반드시 설정

--MGR1 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),입사일(숫자형) - 컬럼 수준의 제약조건
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';

--MGR1 테이블 행 삽입
INSERT INTO MGR1 VALUES(1000,'홍길동',SYSDATE);
INSERT INTO MGR1 VALUES(1000,'임꺽정',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - 사원번호 중복 
INSERT INTO MGR1 VALUES(NULL,'임꺽정',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - NULL 전달
INSERT INTO MGR1 VALUES(2000,'임꺽정',SYSDATE);
SELECT * FROM MGR1;
COMMIT;

--MGR2 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),입사일(숫자형) - 테이블 수준의 제약조건
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE, CONSTRAINT MGR2_NO_PK PRIMARY KEY(NO));
DESC MGR2;

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';

--MGR2 테이블 행 삽입
INSERT INTO MGR2 VALUES(1000,'홍길동',SYSDATE);
INSERT INTO MGR2 VALUES(1000,'임꺽정',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - 사원번호 중복 
INSERT INTO MGR2 VALUES(NULL,'임꺽정',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - NULL 전달
INSERT INTO MGR2 VALUES(2000,'임꺽정',SYSDATE);
SELECT * FROM MGR2;
COMMIT;

--MGR3 테이블 생성 - 사원번호(숫자형),사원이름(문자형),입사일(숫자형)
--사원번호와 사원이름을 묶어서 PRIMARY KEY 제약조건 설정
--테이블 수준의 제약조건은 컬럼을 묶어서 PRIMARY KEY 제약조건 설정 가능
CREATE TABLE MGR3(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE
    ,CONSTRAINT MGR3_NO_NAME_PK PRIMARY KEY(NO,NAME));
DESC MGR3;

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR3';

--MGR3 테이블 행 삽입
INSERT INTO MGR3 VALUES(1000,'홍길동',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'임꺽정',SYSDATE);
INSERT INTO MGR3 VALUES(2000,'임꺽정',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'홍길동',SYSDATE);--PRIMARY KEY 제약조건을 위반하여 에러 발생 - 사원번호와 이름 중복 
SELECT * FROM MGR3;
COMMIT;