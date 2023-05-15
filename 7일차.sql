--인덱스(INDEX) : 테이블에 저장된 행을 보다 빠르게 검색하기 위한 기능을 제공하는 객체
--컬럼에 인덱스를 설정하면 인덱스 영역을 생성하여 검색 관련 정보를 저장해 컬럼에 대한 행 검색 속도 증가
--조건식에서 많이 사용하는 컬럼에 인덱스를 설정하며 행이 많을 때 인덱스를 설정하는 것이 효율적

--유니크 인덱스(UNIQUE INDEX) : PRIMARY KEY 제약조건이나 UNIQUE 제약조건에 의해 자동 생성되는 인덱스
--비유니크 인덱스(NON-UNIQUE INDEX) : 사용자가 컬럼에 수동으로 인덱스 생성하여 설정하는 인덱스

--USER3 테이블 생성 - 회원번호(숫자형-PRIMARY KEY),회원이름(문자형),이메일(문자형-UNIQUE)
CREATE TABLE USER3(NO NUMBER(4) CONSTRAINT USER3_NO_PK PRIMARY KEY
    ,NAME VARCHAR2(20),EMAIL VARCHAR2(50) CONSTRAINT USER3_EMAIL_UK UNIQUE);
    
--USER3 테이블의 제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 테이블의 인덱스 확인 - USER_INDEXES : 인덱스 정보를 제공하는 딕셔너리, USER_IND_COLUMNS : 컬럼에 설정된 인덱스 정보를 젝공하는 딕셔너리
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';
    
--인덱스 생성 - 비유니크 인덱스(NON-UNIQUE INDEX)
--형식)CREATE INDEX 인덱스명 ON 테이블명(컬럼명)

-- 인덱스를 생성하여 USER3 테이블의 NAME 컬럼에 설정
CREATE INDEX USER3_NAME_INDEX ON USER3(NAME);

--USER3 테이블의 인덱스 확인
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--인덱스 삭제 - 비유니크 인덱스(NON-UNIQUE INDEX)
--형식)DROP INDEX 인덱스명

--USER3 테이블의 NAME 컬럼에 설정된 인덱스 삭제
DROP INDEX USER3_NAME_INDEX;
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--USER3 테이블의 EMAIL 컬럼에 설정된 인덱스 삭제
DROP INDEX USER3_EMAIL_UK;--유니크 인덱스를 삭제할 경우 에러 발생
--유니크 인덱스는 PRIMARY KEY 제약조건이나 UNIQUE 제약조건을 삭제하면 같이 삭제 처리
ALTER TABLE USER3 DROP CONSTRAINT USER3_EMAIL_UK;--제약조건 삭제
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--동의어(SYNONYM) : 오라클 객체에 다른 이름을 부여하여 사용하기 위한 객체
--전용 동의어 : 특정 사용자만 사용할 수 있는 동의어 - 일반 사용자에 의해 관리
--공용 동의어 : 모든 사용자가 사용할 수 있는 동의어 - 관리자에 의해 관리

--동의어 생성
--형식)CREATE [PUBLIC] SYNONYM 동의어 FOR 객체명
--PUBLIC : 공용 동의어를 생성하기 위한 키워드

--테이블 목록 - USER_TABLES 딕셔너리 이용하여 검색
--USER_TABLES 딕셔너리 : SYS 계정에 의해 생성된 뷰
--다른 사용자에 의해 생성된 테이블 또는 뷰에 접근하는 방법 - 사용자 스키마를 이용하여 접근
--형식)사용자명.테이블명 또는 사용자명.뷰명
SELECT TABLE_NAME FROM SYS.USER_TABLES;
--SYS.USER_TABLES 객체의 공용 동의어로 USER_TABLES를 제공
SELECT TABLE_NAME FROM USER_TABLES;
--SYS.USER_TABLES 객체의 공용 동의어로 TABS를 제공
SELECT TABLE_NAME FROM TABS;

--COMM 테이블에 대한 전용 동의어로 BONUS 생성
SELECT * FROM COMM;
SELECT * FROM BONUS;--테이블 또는 뷰가 없으므로 에러 발생
--CREATE SYNONYM 시스템 권한이 없으므로 CREATE SYNONYM 명령을 실행하면 에러 발생
CREATE SYNONYM BONUS FOR COMM;--권한이 불충분하여 에러 발생

--시스템 관리자(SYSDBA - SYS 계정)로 접속하여 현재 접속 사용자(SCOTT 계정)에서 CREATE SYNONYM 시스템 권한을 부여
--GRANT CREATE SYNONYM TO SCOTT;

--시스템 관리자에게 CREATE SYNONYM 시스템 권한을 부여 받은 후 CREATE SYNONYM 명령 실행
CREATE SYNONYM BONUS FOR COMM;
SELECT * FROM BONUS;

--COMM 테이블 관련 동의어 확인 - USER_SYNONYMS : 동의어 정보를 제공하는 딕셔너리
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--동의어 삭제
--형식)DROP [PUBLIC] SYNONYM 동의어

--COMM 테이블의 전용 동의어 BONUS 삭제
DROP SYNONYM BONUS;
SELECT * FROM COMM;
SELECT * FROM BONUS;--테이블 또는 뷰가 없으므로 에러 발생
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--사용자(USER) : 시스템(DBMS)를 사용할 수 있는 객체 - 계정(ACCOUNT) : 권한을 가진 사용자
--계정 관리는 시스템 관리자(SYSDBA - SYS 계정)만 가능

--계정 생성
--형식)CREATE USER 계정명 IDENTIFIED BY 비밀번호

--KIM 계정 생성
--오라클 12C 버전 이상에서는 계정을 관리하기 전에 세션에 대한 환경설정 변경
--ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
--CREATE USER KIM IDENTIFIED BY 1234;

--계정 확인 - DBA_USERS : 사용자 정보를 제공하는 딕셔너리
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--계정의 비밀번호 변경 - 계정의 비밀번호는 기본적으로 180일의 유효기간으로 설정
--형식)ALTER USER 계정명 IDENTIFIED BY 비밀번호

--KIM 계정의 비밀번호 변경
--ALTER USER KIM IDENTIFIED BY 5678;

--계정 상태 변경 - OPEN(계정 활성화 - DBSM 서버 접속 가능), LOCK(계정 비활성화 - DBSM 서버 접속 불가능)
--오라클 서버 접속시 계정의 비밀번호를 5번 틀리면 계정의 상태가 자동으로 LOCK 상태로 변경
--형식)ALTER USER 계정명 ACCOUNT {LOCK|UNLOCK}

--KIM 계정의 상태를 LOCK 상태로 변경
--ALTER USER KIM ACCOUNT LOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--KIM 계정의 상태를 OPEN 상태로 변경
--ALTER USER KIM ACCOUNT UNLOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--계정의 테이블스페이스 변경
--테이블스페이스(TABLESPACE) : 데이타베이스 객체(테이블,뷰,시퀸스,인덱스 등)가 저장되는 장소
--오라클 XE에서는 기본적으로 SYSTEM 테이블스페이스와 USERS 테이블스페이스 제공
--형식)ALTER USER 계정명 DEFAULT TABLESPACE 테이블스페이스명

--KIM 계정의 테이블스페이스를 USERS로 변경
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--테이블스페이스에 대한 계정의 사용 가능한 물리적 저장크기 변경 - 용량 제한
--형식)ALTER USER 계정명 QUOTA 제한크기 ON 테이블스페이스

--KIM 계정의 물리적 저장크기를 무제한으로 변경
--ALTER USER KIM QUOTA UNLIMITED ON USERS;
--계정의 물리적 저장크기 확인 - DBA_TS_QUOTAS : 테이블스페이스의 물리적 저장크기 제한 관련 정보를 제공하는 딕셔너리
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS;

--KIM 계정의 물리적 저장크기를 20MBYTE로 변경
--ALTER USER KIM QUOTA 20M ON USERS;
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS;

--계정 삭제
--형식)DROP USER 사용자명

--KIM 계정 삭제
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--DROP USER KIM;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--DCL(DATA CONTROL LANGUAGE) - 데이타 제어어
--계정에게 권한을 부여하거나 회수하는 SQL 명령
--오라클 권한(ORACLE PRIVILEGE) : 시스템 권한(관리자)과 객체 권한(일반 사용자)으로 구분

--시스템 권한 : 시스템을 구성하는 객체를 관리하기 위한 명령(DDL)에 대한 사용 권한
--시스템 권한을 계정에게 부여
--형식)GRANT {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... TO {계정명|PUBLIC} [WITH ADMIN OPTION] [IDENTIFIED BY 비밀번호]
--롤(ROLL) : 시스템 권한을 그룹화하여 사용하는 이름
--계정명 대신 PUBLIC 키워드를 사용하면 모든 계정에게 일괄적으로 시스템 권한 부여
--WITH ADMIN OPTION : 부여 받은 시스템 권한을 다른 계정에게 부여하거나 회수하는 권한을 제공하는 기능
--시스템 권한을 부여받은 계정이 없는 경우 자동으로 계정 생성
--GRANT 명령에 의해 계정이 생성된 경우 반드시 IDENTIFIED BY 키워드를 사용하여 비밀번호 설정

--KIM 계정 생성
--CREATE USER KIM IDENTIFIED BY 1234;

--KIM 계정으로 오라클 서버에 접속 - SQLPLUS 사용
--C:\USERS\USER>SQLPLUS KIM  >>  KIM 계정으로 오라클 서버 접속 - 비밀번호 입력
--CREATE SESSION 권한이 없으므로 서버 접속 실패

--시스템 관리자(SYSDBA - SYS 계정)가 KIM 계정에게 CREATE SESSION 시스템 권한 부여
--GRANT CREATE SESSION TO KIM;

--KIM 계정으로 오라클 서버에 접속 - SQLPLUS 사용
--SQL>CONN KIM  >>  KIM 계정으로 오라클 서버 접속 - 비밀번호 입력 : 접속 성공

--KIM 계정으로 SAWON 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),급여(숫자형) : SQLPLUS 사용
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);--권한이 불충분하여 에러 발생

--시스템 관리자(SYSDBA - SYS 계정)가 KIM 계정에게 CREATE TABLE 시스템 권한 부여
--GRANT CREATE TABLE TO KIM;

--KIM 계정으로 SAWON 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),급여(숫자형) : SQLPLUS 사용
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);--테이블 생성 성공

--객체 권한 : 사용자 스키마에 존재하는 객체 관련 명령(DQL 또는 DML) 사용에 대한 권한
--형식)GRANT {ALL|PRIVILEGE,PRIVILEGE,...} ON 객체명 TO 계정명 [WITH GRANT OPTION]
--객체 권한은 INSERT,UPDATE,DELETE,SELECT 등의 키워드로 표현
--ALL : 객체에 관련된 모든 명령 사용 권한 표현
--WITH GRANT OPTION : 부여받은 객체 권한을 다른 계정에게 부여하거나 회수하는 권한을 제공하는 기능

--SCOTT 사용자 스키마에 존재하는 DEPT 테이블에 저장된 모든 행 검색
SELECT * FROM SCOTT.DEPT;
--현재 접속 사용자의 스키마인 경우 사용자 스키마 생략 가능
SELECT * FROM DEPT;

--KIM 계정으로 SCOTT 사용자 스키마에 존재하는 DEPT 테이블에 저장된 모든 행 검색 - SQLPLUS 이용
--C:\Users\user>SQLPLUS KIM
--SQL>SELECT * FROM SCOTT.DEPT;--권한이 충분하지 않아 에러 발생
--ORA-00942: 테이블 또는 뷰가 존재하지 않습니다

--SCOTT 계정이 KIM 계정에게 DEPT 테이블에 저장된 행을 검색할 수 있는 권한 부여
GRANT SELECT ON DEPT TO KIM;

--KIM 계정으로 SCOTT 사용자 스키마에 존재하는 DEPT 테이블에 저장된 모든 행 검색 - SQLPLUS 이용
--SQL>SELECT * FROM SCOTT.DEPT;--검색 가능

--다른 계정에게 부여한 객체 권한 확인 - USER_TAB_PRIVS_MADE : 부여한 객체 권한 관련 정보를 제공하는 딕셔너리
SELECT * FROM USER_TAB_PRIVS_MADE;

--다른 계정에게 부여받은 객체 권한 확인 - USER_TAB_PRIVS_RECD : 부여받은 객체 권한 관련 정보를 제공하는 딕셔너리
SELECT * FROM USER_TAB_PRIVS_RECD;

--객체 권한 회수
--형식)REVOKE {ALL|PRIVILEGE,PRIVILEGE,...} ON 객체명 FROM 계정명 [WITH GRANT OPTION]

--SCOTT 계정이 KIM 계정에게 부여한 DEPT 테이블에 저장된 행을 검색할 수 있는 권한 회수
REVOKE SELECT ON DEPT FROM KIM;
SELECT * FROM USER_TAB_PRIVS_MADE;

--KIM 계정으로 SCOTT 사용자 스키마에 존재하는 DEPT 테이블에 저장된 모든 행 검색 - SQLPLUS 이용
--SQL>SELECT * FROM SCOTT.DEPT;--권한이 충분하지 않아 에러 발생
--ORA-00942: 테이블 또는 뷰가 존재하지 않습니다

--시스템 권한 회수 - 계정의 모든 시스템 권한을 회수해도 계정 미삭제
--형식)REVOKE {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... FROM {계정명|PUBLIC} [WITH ADMIN OPTION]

--관리자가 KIM 계정에게 부여한 CREATE SESSION 시스템 권한 회수
--REVOKE CREATE SESSION FROM KIM;

--KIM 계정으로 오라클 서버에 접속 - SQLPLUS 사용
--C:\USERS\USER>SQLPLUS KIM  >>  KIM 계정으로 오라클 서버 접속 - 비밀번호 입력
--CREATE SESSION 권한이 없으므로 서버 접속 실패

--롤(ROLE) : 관리자가 계정의 시스템 권한을 효율적으로 관리하기 위해 사용하는 시스템 권한 그룹
--오라클에서 기본적으로 제공되는 롤 - CONNECT, RESOURCE, DBA 등
--CONNECT : 기본적인 시스템 권한 그룹 - CREATE SESSION, CREATE TABLE, ALTER SESSION, CREATE SYNONYM 등
--RESOURCE : 객체 관련 시스템 권한 그룹 - CREATE TABLE, CREATE SEQUENCE,CREATE TRIGGER 등

--관리자가 LEE 계정에게 CONNECT 롤과 RESOURCE 롤 부여
--시스템 권한을 부여받은 계정이 없는 경우 계정을 자동 생성 - 비밀번호를 반드시 설정
--GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--오라클 서버에 LEE 계정으로 접속하여 SAWON 테이블 생성 - SQLPLUS 이용 : 서버 접속 및 테이블 생성 가능
--C:\Users\user>SQLPLUS LEE  
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);

--관리자가 LEE 계정에게 부여한 CONNECT 롤과 RESOURCE 롤 회수
--REMOKE CONNECT,RESOURCE FROM LEE;

--PL/SQL(PROCEDURAL LANGUAGE EXTENSION SQL) : SQL에 없는 변수 선언,선택 처리,반복 처리를 제공하는 절차적인 언어

--세부분의 영역으로 구분하여 PL/SQL 작성
--1.DECLARE 영역(선언부) : DECLARE - 변수를 선언하는 영역(선택)
--2.EXECUTEABLE 영역(실행부) : BEGIN - SQL 명령을 포함한 다수의 명령을 작성하는 영역(필수)
--3.EXCEPTION 영역(예외처리부) : EXCEPTION - 예외를 처리하기 위한 명령을 작성하는 영역(선택)

--영역에서 하나의 명령을 구분하기 위해 ; 사용
--마지막 영역은 END 키워드로 마무리 후 ; 사용
--PL/SQL 실행을 위해 마지막에 / 기호 사용

--메세지를 출력할 수 있는 세션의 환경변수 설정값 변경
SET SERVEROUT ON;

--메세지를 출력하는 함수 - PL/SQL 실행부에서 호출하여 사용
--형식)DBMS_OUTPUT.PUT_LINE(출력메세지)

--환영메세지를 출력하는 PL/SQL 작성
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE!!!');
END;
/

--변수 선언과 초기값 입력 - 선언부
--형식)변수명 [CONSTANT] 자료형 [NOT NULL] [{:=|DEFAULT} 표현식]
--CONSTANT : 변수에 저장된 초기값을 변경하지 못하도록 설정하는 키워드 - 상수
--NOT NULL : 변수에 NULL 사용 불가능
--:= : 대입연산자 - 변수에 값을 저장하기 위한 연산자
--표현식 : 변수에 저장될 값에 대한 표현 방법 - 값,변수(저장값),연산식(결과값),함수(반환값)

--선언된 변수의 저장값 변경 - 실행부
--형식)변수명 := 표현식

--스칼라 변수 : 오라클 자료형을 이용하여 선언된 변수

--스칼라 변수를 선언하여 값을 저장하고 화면에 변수값을 출력하는 PL/SQL 작성
DECLARE
    VEMPNO NUMBER(4) := 7788;
    VENAME VARCHAR2(20) := 'SCOTT';
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('-----------------');
    VEMPNO := 7893;
    VENAME := 'KING';
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('-----------------');
END;
/

--레퍼런스 변수 : 다른 변수의 자료형 또는 테이블의 컬럼 자료형을 참조하여 선언된 변수 - 선언부
--형식)변수명 {변수명%TYPE|테이블명.컬럼명%TYPR}

--테이블에 저장된 행을 검색하여 컬럼값을 변경에 저장하는 명령 - 실행부
--형식)SELECT 검색대상,검색대상,... INTO 변수명,변수명,... FROM 테이블명 [WHERE 조건식]
--검색대상과 변수의 갯수 및 자료형 반드시 일치

--EMP 테이블의 EMPNO 컬럼과 ENAME 컬럼의 자료형을 참조하여 레퍼런스 변수를 선언하고 EMP 테이블에서
--사원이름이 SCOTT인 사원의 사원번호와 사원이름을 검색하여 레퍼런스 변수에 저장하여 출력하는 PL/SQL 작성
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    /* PL/SQL의 주석 처리 - 프로그램에 설명을 제공 */
    /* 단일행을 검색하여 검색행의 컬럼값을 레퍼런스 변수에 저장 - 다중행이 검색될 경우 에러 발생 */
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME='SCOTT';
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--테이블 변수 : 테이블의 저장된 행을 여러 개 검색하여 얻은 다수의 컬럼값을 저장을 위해 선언하는 변수 - 배열
--형식)테이블변수명 테이블타입명
--테이블 변수를 생성하기 위해 테이블 변수의 자료형(테이블 타입)을 먼저 선언
--형식)TYPE 테이블타입명 IS TABLE OF {자료형|변수명%TYPE|테이블명.컬러명%TYPE} [NOT NULL] [INDEX BY BINARY_INTEGER]

--테이블 변수는 테이블 변수의 요소를 첨자로 구분하여 사용 - 첨자는 1부터 1씩 증가되는 숫자값
--형식)테이블변수명(첨자)

--EMP 테이블의 EMPNO 컬럼과 ENAME 컬럼을 참조하여 테이블 변수를 선언하고 EMP 테이블에 저장된 모든
--사원의 사원번호와 사원이름을 검색하여 테이블 변수에 저장하여 출력하는 PL/SQL 작성
DECLARE
    /* 테이블 타입 선언 */
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;
    
    /* 테이블 변수 선언 */
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    /* 테이블 변수의 요소를 반복 처리하기 위한 첨자 역활의 변수 선언 */
    I BINARY_INTEGER := 0;
BEGIN 
    /* EMP 테이블에 저장된 모든 사원의 사원번호,사원이름을 검색하여 테이블 변수의 요소에 저장하기 위한 반복문 */
    FOR K IN (SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;    

    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    /* 테이블 변수에 저장된 요소값을 출력하기 위한 반복문 */
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(VEMPNO_TABLE(J)||' / '||VENAME_TABLE(J));
    END LOOP;
END;
/

--레코드 변수 : 테이블에 저장된 하나의 행의 모든 컬럼값을 저장하기 위해 선언하는 변수
--형식)레코드변수명 레코드타입명
--레코드 변수를 생성하기 위해 레코드 변수의 자료형(레코드 타입)을 먼저 선언
--형식)TYPE 레코드타입명 IS RECORD(필드명 {자료형|변수명%TYPE|테이블명.컬러명%TYPE} [NOT NULL] 
--    [{:=|DEFAULT} 표현식],...)

--레코드 변수의 필드에 접근하는 방법
--형식)레코드변수명.필드명

--EMP 테이블의 EMPNO,ENAME,JOB,SAL,DEPTNO 컬럼을 참조하여 레코드 변수를 선언하고 EMP 테이블에서
--사원번호가 7844인 사원의 사원번호,사원이름,업무,급여,부서번호를 검색하여 레코드 변수에 저장후 출력하는 PL/SQL 작성
DECLARE
    /* 레코드 타입 선언 */
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE,VJOB EMP.JOB%TYPE
        ,VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);
    /* 레코드 변수 선언 */     
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    /* 단일 검색행의 컬럼값을 레코드 변수의 필드에 저장 - 검색행이 다중행인 경우 에러 발생 */
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO EMP_RECORD.VEMPNO,EMP_RECORD.VENAME,EMP_RECORD.VJOB
        ,EMP_RECORD.VSAL,EMP_RECORD.VDEPTNO FROM EMP WHERE EMPNO=7844;
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||EMP_RECORD.VEMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||EMP_RECORD.VENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||EMP_RECORD.VJOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||EMP_RECORD.VSAL);
    DBMS_OUTPUT.PUT_LINE('부서번호 = '||EMP_RECORD.VDEPTNO);
END;
/

--레코드 타입 없이 테이블 행을 참조하여 레코드 변수 선언 가능 - 행의 컬럼이 자동으로 필드로 선언
--형식)레코드변수명 테이블명%ROWTYPE;

--EMP 테이블의 EMPNO,ENAME,JOB,SAL,DEPTNO 컬럼을 참조하여 레코드 변수를 선언하고 EMP 테이블에서
--사원번호가 7844인 사원의 사원번호,사원이름,업무,급여,부서번호를 검색하여 레코드 변수에 저장후 출력하는 PL/SQL 작성
DECLARE
    /* 레코드 변수 선언 */     
    EMP_RECORD EMP%ROWTYPE;
BEGIN
    /* 단일 검색행의 모든 컬럼값을 레코드 변수의 필드에 저장 - 검색행이 다중행인 경우 에러 발생 */
    SELECT * INTO EMP_RECORD FROM EMP WHERE EMPNO=7844;
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||EMP_RECORD.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||EMP_RECORD.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||EMP_RECORD.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||EMP_RECORD.SAL);
    DBMS_OUTPUT.PUT_LINE('부서번호 = '||EMP_RECORD.DEPTNO);
END;
/

--선택문 : 명령을 선택하여 실행하기 구문
--IF : 조건식에 의해 명령을 선택 실행
--형식)IF(조건식) THEN 명령; 명령; ... END IF;
--조건식의 ( ) 기호 생략 가능

--EMP 테이블에서 사원번호가 7788인 사원정보를 검색하여 사원번호,사원이름,부서번호에 대한 부서이름을 출력하는 PL/SQL 작성
--10 : ACCOUNTING, 20 : RESEARCH, 30 : SALES, 40 : OPERATION
DECLARE
    VEMP EMP%ROWTYPE;/* 레코드 변수 선언 */
    VDNAME VARCHAR2(20) := NULL;/* 부서이름을 저장하기 위한 스칼라 변수 선언 */
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF(VEMP.DEPTNO = 10) THEN VDNAME := 'ACCOUNTING'; END IF;
    IF(VEMP.DEPTNO = 20) THEN VDNAME := 'RESEARCH'; END IF;
    IF(VEMP.DEPTNO = 30) THEN VDNAME := 'SALES'; END IF;
    IF(VEMP.DEPTNO = 40) THEN VDNAME := 'OPERATION'; END IF;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = '||VDNAME);
END;
/

--형식)IF(조건식) THEN 명령; 명령; ... ELSE 명령; 명령;... END IF;

--EMP 테이블에서 사원번호가 7788인 사원정보를 검색하여 사원번호,사원이름,사원연봉을 계산하여 출력하는 PL/SQL 작성
--사원연봉 : (급여+성과급)*12
DECLARE
    VEMP EMP%ROWTYPE;
    ANNUAL NUMBER(7,2) := 0;
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF VEMP.COMM IS NULL THEN
        ANNUAL := VEMP.SAL * 12;
    ELSE 
        ANNUAL := ( VEMP.SAL + VEMP.COMM ) * 12;
    END IF;    
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('사원연봉 = '||ANNUAL);
END;
/
    
--형식)IF(조건식) THEN 명령; 명령; ... ELSIF(조건식) 명령; 명령;... ELSE 명령; 명령;... END IF;

--EMP 테이블에서 사원번호가 7788인 사원정보를 검색하여 사원번호,사원이름,부서번호에 대한 부서이름을 출력하는 PL/SQL 작성
--10 : ACCOUNTING, 20 : RESEARCH, 30 : SALES, 40 : OPERATION
DECLARE
    VEMP EMP%ROWTYPE;
    VDNAME VARCHAR2(20) := NULL;
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF(VEMP.DEPTNO = 10) THEN VDNAME := 'ACCOUNTING';
    ELSIF(VEMP.DEPTNO = 20) THEN VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO = 30) THEN VDNAME := 'SALES';
    ELSIF(VEMP.DEPTNO = 40) THEN VDNAME := 'OPERATION'; 
    END IF;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = '||VDNAME);
END;
/
