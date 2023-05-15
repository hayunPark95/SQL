--서브쿼리 위치에 따른 종류
--1.스칼라 서브쿼리(SCALAR SUBQUERY) : SELECT, WHERE(NESTED SUBQUERY), GROUP BY, HAVING, ORDER BY 
--하나의 SQL 명령으로 취급되지만 내부적으로는 하나의 함수로 처리 
--함수는 다수의 입력이 있어도 처리 결과는 하나만 제공
--스칼라 서브쿼리도 일종의 함수이므로 중첩 사용 가능하나 서브쿼리의 결과값이 두개 이상이거나 
--결과값의 자료형이 다른 경우 에러 발생
--대량의 데이타 처리시 스칼라 서브쿼리의 남발은 성능의 저하는 유발할 수 있으므로 테이블 결합을 사용하는 것을 권장
--2.인라인뷰 서브쿼리(INLINE VIEW SUBQUERY) : FROM
--INLINE VIEW : 서브쿼리를 이용하여 일시적으로 생성된 가상의 테이블 - 논리적 테이블
--테이블 결합 횟수의 감소 및 절차 지향적인 기능 부여

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP;

--FROM에 서브쿼리를 사용하여 검색 - 인라인뷰 서브쿼리
SELECT EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--ROWNUM : 검색행에 순차적인 숫자값을 제공하는 키워드 - 행번호
SELECT ROWNUM,EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--모든 컬럼(*)은 다른 검색대상과 사용 불가능
SELECT ROWNUM,* FROM (SELECT EMPNO,ENAME,SAL FROM EMP);--에러 발생

--인라인뷰에 테이블 별칭을 부여하여 사용 가능
--[테이블명.*] 형식으로 표현하여 테이블의 모든 컬럼 검색 - 다른 검색대상과 동시 사용 가능
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP) TEMP;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여를 급여순으로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여를 급여순으로 내림차순 정렬하여 검색
--검색된 행에 ROWNUM 키워드로 행번호를 제공받아 검색 
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;--검색 오류

--인라인뷰 서브쿼리를 사용하여 정렬된 사원정보를 검색한 후 행번호를 제공받아 검색
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP;

--EMP 테이블에 저장된 사원 중 급여를 가장 많이 받는 사원 5명의 사원번호,사원이름,급여 검색
--급여로 내림차순 정렬하고 행번호(ROWNUM)를 제공받아 행번호가 [6]보다 작은 행 검색
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM<6;

--EMP 테이블에 저장된 사원 중 급여를 5번째로 가장 많이 받는 사원의 사원번호,사원이름,급여 검색
--급여로 내림차순 정렬하고 행번호(ROWNUM)를 제공받아 행번호가 [5]인 행 검색 
--ROWNUM 키워드로 행번호를 제공받아 WHERE의 조건식에서 비교할 경우 <(<=) 연산자를 이용한 검색은 
--가능하지만 = 또는 >(>=) 연산자를 이용한 검색 불가능 - ROWNUM 키워드는 행번호를 검색행에 순차적으로 제공
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM=5;--검색 오류

--EMP 테이블의 행을 정렬하여 검색한 후 행번호를 제공받아 인라인뷰로 생성하고 행번호 대신 사용할 수 있는
--컬럼 별칭을 부여하여 WHERE의 조건식에서 별칭을 이용한 행 검색
SELECT * FROM (SELECT ROWNUM RANKING,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RANKING=5; 
    
--EMP 테이블에 저장된 모든 사원 중 급여를 6번째부터 10번째까지 많이 받은 사원의 사원번호,사원이름,급여 검색    
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN BETWEEN 6 AND 10;

--집합연산자(SET 연산자) : 두 개의 SELECT 명령에 대한 검색결과를 이용하여 집합 결과값을 제공하는 연산자
--합집합(UNION), 교집합(INTERSECT), 차집합(MINUS)

--SUPER_HERO 테이블 생성 - 속성 : 이름(문자형)
CREATE TABLE SUPER_HERO(NAME VARCHAR2(20) PRIMARY KEY);

--SUPER_HERO 테이블에 행 삽입
INSERT INTO SUPER_HERO VALUES('슈퍼맨');
INSERT INTO SUPER_HERO VALUES('아이언맨');
INSERT INTO SUPER_HERO VALUES('배트맨');
INSERT INTO SUPER_HERO VALUES('앤트맨');
INSERT INTO SUPER_HERO VALUES('스파이더맨');
COMMIT;

--MARVEL_HERO 테이블 생성 - 속성 : 이름(문자형),등급(숫자형)
CREATE TABLE MARVEL_HERO(NAME VARCHAR2(20) PRIMARY KEY,GRADE NUMBER(1));

--MARVEL_HERO 테이블에 행 삽입
INSERT INTO MARVEL_HERO VALUES('아이언맨',3);
INSERT INTO MARVEL_HERO VALUES('헐크',1);
INSERT INTO MARVEL_HERO VALUES('스파이더맨',4);
INSERT INTO MARVEL_HERO VALUES('토르',2);
INSERT INTO MARVEL_HERO VALUES('앤트맨',5);
COMMIT;

--SUPER_HERO 테이블에 저장된 모든 행 검색
SELECT * FROM SUPER_HERO;
--MARVEL_HERO 테이블에 저장된 모든 행 검색
SELECT * FROM MARVEL_HERO;

--UNION : 두 개의 SELECT 명령으로 검색된 행을 합친 행을 제공하는 연산자 - 중복행 제외
--형식)SELECT 검색대상,... FROM 테이블명1 UNOIN SELECT 검색대상,... FROM 테이블명2
--두 개의 SELECT 명령은 검색대상의 자료형과 갯수가 반드시 일치되도록 검색
SELECT NAME FROM SUPER_HERO UNION SELECT NAME FROM MARVEL_HERO;

--UNION ALL : 두 개의 SELECT 명령으로 검색된 행을 합친 행을 제공하는 연산자 - 중복행 포함
--형식)SELECT 검색대상,... FROM 테이블명1 UNOIN ALL SELECT 검색대상,... FROM 테이블명2
SELECT NAME FROM SUPER_HERO UNION ALL SELECT NAME FROM MARVEL_HERO;

--INTERSECT : 두 개의 SELECT 명령으로 검색된 행에서 중복된 행을 제공하는 연산자
--형식)SELECT 검색대상,... FROM 테이블명1 INTERSECT SELECT 검색대상,... FROM 테이블명2
SELECT NAME FROM SUPER_HERO INTERSECT SELECT NAME FROM MARVEL_HERO;

--MINUS : 첫번째 SELECT 명령으로 검색된 행에서 두번째 SELECT 명령으로 검색된 행을 제외한 행을 제공하는 연산자
--형식)SELECT 검색대상,... FROM 테이블명1 MINUS SELECT 검색대상,... FROM 테이블명2
SELECT NAME FROM SUPER_HERO MINUS SELECT NAME FROM MARVEL_HERO;

--집합 연산자 사용시 두개의 SELECT 명령에 대한 검색대상의 자료형 또는 갯수가 다른 경우 에러 발생
SELECT NAME FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;--검색대상의 갯수가 다르므로 에러 발생
SELECT NAME FROM SUPER_HERO UNION SELECT GRADE FROM MARVEL_HERO;--검색대상의 자료형이 다르므로 에러 발생

--집합 연산자 사용시 두개의 SELECT 명령에 대한 검색대상의 갯수가 다른 경우 동일 자료형의 임의값을
--사용하거나 NULL을 사용하여 집합 처리 가능
SELECT NAME,0 FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;
SELECT NAME,NULL FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;

--집합 연산자 사용시 두개의 SELECT 명령에 대한 검색대상의 자료형이 다른 경우 변환함수를 사용하여 집합 처리 가능
SELECT NAME FROM SUPER_HERO UNION SELECT TO_CHAR(GRADE,'0') FROM MARVEL_HERO;

--DML(DATA MANIPULATION LANGUAGE) : 테이타 조작어
--테이블의 행에 대한 삽입,변경,삭제 기능을 제공하는 SQL 명령
--DML 명령 실행 후 COMMIT(DML 명령의 적용) 또는 ROLLBACK 명령(DML 명령의 취소)을 실행하는 것을 권장

--INSERT : 테이블에 행을 삽입하는 SQL 명령
--형식)INSERT INTO 테이블명 VALUES(컬럼값,컬럼값,...)
--테이블에 삽입될 행의 컬럼값은 테이블 속성의 순서대로 자료형에 맞는 컬럼값을 생략 없이 차례대로 나열해서 
--전달해야만 행 삽입 처리

--테이블 속성(컬럼과 자료형) 확인
--형식)DESC 테이블명
DESC DEPT;

--DEPT 테이블에 새로운 행(부서정보) 삽입
INSERT INTO DEPT VALUES(50,'회계부','서울시');
SELECT * FROM DEPT;
COMMIT;

--삽입행으로 전달될 컬럼값의 갯수가 테이블의 컬럼 갯수와 맞지 않을 경우 에러 발생
INSERT INTO DEPT VALUES(60,'총무부');--전달값이 충분하지 않아 에러 발생
INSERT INTO DEPT VALUES(60,'총무부','수원시','팔달구');--전달값이 너무 많아 에러 발생

--삽입행으로 전달될 컬럼값의 자료형이 테이블 컬럼의 자료형과 맞지 않을 경우 에러 발생
INSERT INTO DEPT VALUES('육십','총무부','수원시');--숫자값이 아닌 컬럼값을 사용하여 에러 발생

--삽입행으로 전달될 컬럼값이 테이블 컬럼의 크기보다 큰 경우 경우 에러 발생
INSERT INTO DEPT VALUES(6000,'총무부','수원시');--부서번호에 2자리의 숫자값보다 큰 값을 사용하여 에러 발생
INSERT INTO DEPT VALUES(60,'총무부','수원시 팔달구');--부서위치에 13자리의 문자값보다 큰 값을 사용하여 에러 발생

--테이블 컬럼에 부여된 제약조건을 위반하는 값을 전달할 경우 에러 발생
--PK(PRIMARY KEY) 제약조건 : 중복된 컬럼값 저장을 방지하기 위한 제약조건
--DEPT 테이블의 DEPTNO 컬럼에는 PK 제약조건 부여
SELECT DEPTNO FROM DEPT;--검색결과 : 10,20,30,40,50
INSERT INTO DEPT VALUES(50,'총무부','수원시');--PK 제약조건이 부여된 컬럼에 중복값을 전달하여 에러 발생

--테이블 속성과 제약조건을 위반하지 않는 컬럼값을 전달하야만 행 삽입 가능
INSERT INTO DEPT VALUES(60,'총무부','수원시');
SELECT * FROM DEPT;
COMMIT;

--테이블에 행을 삽입할 때 컬럼에 값을 저장하고 싶지 않은 경우 NULL 전달 - 명시적 NULL 사용
INSERT INTO DEPT VALUES(70,'영업부',NULL);
SELECT * FROM DEPT;
COMMIT;

DESC DEPT;--DEPT 테이블 구조 확인 : 컬럼의 NULL 허용 유무 확인
--NULL를 허용하지 않는 컬럼(NOT NULL)에는 NULL 저장 불가능
INSERT INTO DEPT VALUES(NULL,'영업부','인천시');--NOT NULL 컬럼에 NULL를 전달하여 에러 발생

--테이블의 특정 컬럼에 값을 전달하여 삽입 가능
--형식)INSERT INTO 테이블명(컬럼명,컬럼명,...) VALUES(컬럼값,컬럼값,...)
--컬럼이 나열된 순서에 따라 컬럼값을 전달하여 행 삽입
INSERT INTO DEPT(DNAME,LOC,DEPTNO) VALUES('자재부','인천시',80);
SELECT * FROM DEPT;
COMMIT;

--테이블 컬럼 생략 가능 - 테이블 컬럼을 생략할 경우 생략된 컬럼에는 컬럼 기본값이 자동으로 전달되어 삽입 처리
--테이블 생성 또는 테이블의 컬럼 변경시 컬럼에 저장될 기본값 변경 가능
--컬럼 기본값을 변경하지 않으면 NULL을 기본값으로 사용되도록 자동 설정
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'인사부');--LOC 컬럼에 NULL이 전달되어 삽입 처리 : 묵시적 NULL 사용
SELECT * FROM DEPT;
COMMIT;

DESC EMP;--EMP 테이블의 속성 확인
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/01',3500,1000,40);
SELECT * FROM EMP;
COMMIT;

--날짜형 컬럼에는 날짜값 대신 SYSDATE 키워드를 사용하여 컬럼값을 전달하여 행 삽입 가능
INSERT INTO EMP VALUES(9001,'LEE','ANALYST',9000,SYSDATE,2000,NULL,40);
SELECT * FROM EMP;
COMMIT;

--INSERT 명령에 서브쿼리(SUBQUERY)를 사용하여 행 삽입 가능
--형식)INSERT INTO 테이블명1 SELECT 검색대상,검색대상,... FROM 테이블명2 [WHERE 조건식]
--서브쿼리의 검색결과를 이용하여 테이블에 행 삽입 - 테이블 행 복사
--행이 삽입될 테이블과 서브쿼리로 생성될 검색대상의 컬럼 갯수와 자료형이 반드시 일치

--BONUS 테이블의 구조 확인 및 행 검색
DESC BONUS;
SELECT * FROM BONUS;

--EMP 테이블에서 성과급이 존재하는 사원의 사원이름,업무,급여,성과급을 검색하여 BONUS 테이블에 행 삽입
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM BONUS;
COMMIT;

--UPDATE : 테이블에 저장된 행의 컬럼값을 변경하는 SQL 명령
--형식)UPDATE 테이블명 SET 컬럼명=변경값,컬럼명=변경값,... [WHERE 조건식]
--테이블에 저장된 행에서 WHERE 조건식의 결과가 참(TRUE)인 행의 컬럼값 변경
--WHERE를 생략할 경우 테이블에 저장된 모든 행의 컬럼값을 동일하게 변경 처리
--WHERE 조건식에서 사용하는 비교 컬럼은 PK 제약조건이 부여된 컬럼을 이용하여 변경하는 것을 권장
--일반적으로 PK 제약조건이 부여된 컬럼값은 변경하는 것을 비권장

--DEPT 테이블에서 부서번호가 50인 부서정보 검색
SELECT * FROM DEPT WHERE DEPTNO=50;--부서이름 : 회계부, 부서위치 : 서울시

--DEPT 테이블에서 부서번호가 50인 부서의 부서이름을 [경리부]로 변경하고 부서위치를 [부천시]로 변경 
UPDATE DEPT SET DNAME='경리부',LOC='부천시' WHERE DEPTNO=50;
SELECT * FROM DEPT WHERE DEPTNO=50;--부서이름 : 경리부, 부서위치 : 부천시
COMMIT; 

--컬럼의 변경값은 컬럼의 자료형,크기,제약조건이 맞는 경우에만 변경 처리
UPDATE DEPT SET LOC='부천시 원미구' WHERE DEPTNO=50;--변경값이 컬럼의 크기보다 크기 때문에 에러 발생

--UPDATE 명령에서 SET의 변경값 또는 WHERE 비교값 대신 서브쿼리 사용 가능
--DPET 테이블에서 부서이름이 영업부인 부서위치(NULL)를 부서이름이 총무부인 부서위치(수원시)로 변경
SELECT * FROM DEPT;
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='총무부') WHERE DNAME='영업부';
SELECT * FROM DEPT WHERE DNAME='영업부';
COMMIT;

--BONUS 테이블에서 사원이름이 KIM인 사원보다 성과급이 적은 사원의 성과급이 100 증가되도록 변경
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=100 WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='KIM');
SELECT * FROM BONUS;
COMMIT;

--DELETE : 테이블에 저장된 행을 삭제하는 SQL 명령
--형식)DELETE FROM 테이블명 [WHERE 조건식]
--테이블에 저장된 행에서 WHERE 조건식의 결과가 참(TRUE)인 행 삭제
--WHERE를 생략한 경우 테이블에 저장된 모든 행 삭제
--WHERE 조건식에서 사용하는 비교 컬럼은 PK 제약조건이 부여된 컬럼을 이용하여 삭제하는 것을 권장

--DEPT 테이블에서 부서번호가 90인 부서정보 삭제
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
SELECT * FROM DEPT;
COMMIT;

--DEPT 테이블에서 부서번호가 10인 부서정보 삭제
--자식 테이블에서 참조되는 부모테이블의 행은 FK(FOREIGN KEY) 제약조건에 의해 삭제 불가능
DELETE FROM DEPT WHERE DEPTNO=10;--FK 제약조건에 에러 발생

--FK(FOREIGN KEY) 제약조건 : 자식 테이블의 컬럼값으로 부모 테이블의 컬럼값을 참조하여 저장하는 기능을 
--제공하는 제약조건 
--EMP 테이블의 DEPTNO 컬럼에 FK 제약조건이 부여되어 DEPT 테이블의 DEPTNO 컬럼값이 참조되도록 설정
SELECT DISTINCT DEPTNO FROM EMP;--검색결과 : 10,20,30,40 - 부모 테이블을 참조하여 저장된 자식 테이블의 컬럼값
DELETE FROM DEPT WHERE DEPTNO=20;--자식 테이블이 참조하는 부모 테이블의 행을 삭제하여 에러 발생
DELETE FROM DEPT WHERE DEPTNO=80;
SELECT * FROM DEPT;
COMMIT;

--DELETE 명령에서 WHERE의 비교값 대신 서브쿼리 사용 가능
--DEPT 테이블에서 부서이름이 영업부인 부서와 같은 부서위치의 부서정보 삭제 - 영업부 포함
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='영업부');
SELECT * FROM DEPT;
COMMIT;

--MERGE : 원본 테이블의 행을 검색하여 타겟 테이블에 행으로 삽입하거나 타겟 테이블에 저장된 행의 컬럼값을
--변경하는 SQL 명령 - 테이블의 행 병합
--형식)MERGE INTO 타겟테이블명 USING 원본테이블명 ON (조건식)
--     WHEN MATCHED THEN UPDATE SET 타겟컬럼명=원본컬럼명,타겟컬럼명=원본컬럼명,...
--     WHEN NOT MATCHED THEN INSERT(타겟컬럼명,타겟컬럼명,...) VALUES(원본컬럼명,원본컬럼명,...)

--DEPT 테이블을 참고하여 MERGE_DEPT 테이블 생성 - 속성 : 부서번호(숫자형),부서이름(문자형),부서위치(문자형)
DESC DEPT;
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(14),LOC VARCHAR(13));
DESC MERGE_DEPT;

--MERGE_DEPT 테이블에 행 삽입
INSERT INTO MERGE_DEPT VALUES(30,'총무부','서울시');
INSERT INTO MERGE_DEPT VALUES(60,'자재부','수원시');
SELECT * FROM MERGE_DEPT;
COMMIT;

--DEPT 테이블(원본 테이블)에 저장된 모든 부서정보를 검색하여 MERGE_DEPT 테이블(타겟 테이블)에 행을
--삽입하거나 MERGE_DEPT 테이블에 저장된 행의 컬럼값을 변경
SELECT * FROM DEPT;--검색결과(부서번호) : 10,20,30,40,50
SELECT * FROM MERGE_DEPT;--검색결과(부서번호) : 30,60
MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT(M.DEPTNO,M.DNAME,M.LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);
SELECT * FROM MERGE_DEPT;
COMMIT;

--TCL(TRANSACTION CONTROL LANGUAGE) : 트렌젝션 제어어
--트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하거나 테이블에 적용하지 않고 취소하는 명령

--트렌젝션(TRANSACTION) : 사용자 접속 환경(세션)에서 전달된 SQL 명령을 DBMS 서버에 저장하는 논리적인 작업단위
--SQL 명령을 전달받은 DBMS 서버는 실제 테이블에 SQL 명령을 적용하지 않고 트렌젝션에 저장하여 검색시 사용

--트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하기 위해서는 커밋(COMMIT) 처리 - 커밋 처리 후 트렌젝션 초기화
--1.현재 세션에서 정상적으로 서버 접속을 종료한 경우 자동 커밋 처리
--2.DDL 명령 또는 DCL 명령을 작성하여 서버에 전달할 경우 자동 커밋 처리
--3.서버에 전달하여 트렌젝션에 저장된 DML 명령은 COMMIT 명령을 사용하여 커밋 처리

--트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하지 않고 초기화하기 위해 롤백(ROLLBACK) 처리
--1.현재 세션에서 비정상적으로 서버 접속이 종료된 경우 자동 롤백 처리
--2.서버에 전달하여 트렌젝션에 저장된 DML 명령은 ROLLBACK 명령을 사용하여 롤백 처리

--DEPT 테이블에서 부서번호가 50인 부서정보 삭제
SELECT * FROM DEPT;
--DELETE 명령을 전달하면 DEPT 테이블의 행을 삭제하지 않고 트렌젝션에 DELETE 명령 저장
DELETE FROM DEPT WHERE DEPTNO=50;
--DEPT 테이블의 검색행에서 트렌젝션에 저장된 DELETE 명령을 실행한 검색결과 제공
SELECT * FROM DEPT;

--ROLLBACK 명령을 이용한 롤백 처리 - 트렌젝션 초기화
ROLLBACK;
SELECT * FROM DEPT;

--DEPT 테이블에서 부서번호가 50인 부서정보 삭제
DELETE FROM DEPT WHERE DEPTNO=50;--트렌젝션에 DELETE 명령 저장

--COMMIT 명령을 이용한 커밋 처리 - 커밋 처리 후 트렌젝션 초기화
COMMIT;--트렌젝션에 저장된 DELETE 명령을 실제 테이블에 적용하여 실행
SELECT * FROM DEPT;
