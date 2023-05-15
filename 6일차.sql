--FOREIGN KEY : 부모 테이블에 저장된 행의 컬럼값을 참조하여 자식 테이블의 컬럼에 비정상적인 값이 저장되는 것을 방지하는 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건 설정 가능
--부모 테이블의 PRIMARY KEY 제약조건이 설정된 컬럼을 참조하여 자식 테이블의 컬럼에 FOREIGN KEY 제약조건 설정
--테이블의 관계를 구현하기 위한 제약조건

--SUBJECT1 테이블 생성 - 과목코드(숫자형-PRIMARY KEY),과목명(문자형) : 부모 테이블
CREATE TABLE SUBJECT1(SNO NUMBER(2) CONSTRAINT SUBJECT1_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT1 테이블에 행 삽입
INSERT INTO SUBJECT1 VALUES(10,'JAVA');
INSERT INTO SUBJECT1 VALUES(20,'JSP');
INSERT INTO SUBJECT1 VALUES(30,'SPRING');
SELECT * FROM SUBJECT1;
COMMIT;

--TRAINEE1 테이블 생성 - 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형)
CREATE TABLE TRAINEE1(TNO NUMBER(4) CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY
    ,TNAME VARCHAR2(20),SCODE NUMBER(2));

--TRAINEE1 테이블에 행 삽입
INSERT INTO TRAINEE1 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE1 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE1 VALUES(3000,'전우치',30);
INSERT INTO TRAINEE1 VALUES(4000,'일지매',40);
SELECT * FROM TRAINEE1;
COMMIT;

--TRAINEE1 테이블과 SUBJECT1 테이블에서 모든 수강생의 수강생번호,수강생이름,수강과목명 검색
--결합조건 : TRAINEE1 테이블의 수강과목코드(SCODE)와 SUBJECT1 테이블의 과목코드(SNO)가 같은 행을 결합 - INNER JOIN
--INNER JOIN은 결합조건이 참(TRUE)인 행만 결합하여 검색하므로 결합조건이 맞지 않는 행 미검색 
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;--[일지매] 미검색 >> 검색 오류
--OUTER JOIN를 사용하면 결합조건이 맞지 않는 행은 NULL과 결합하여 검색
SELECT TNO,TNAME,SNAME FROM TRAINEE1 LEFT JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 테이블 생성 - 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형-FOREIGN KEY) : 자식 테이블
--자식 테이블의 컬럼에 설정된 FOREIGN KEY 제약조건은 부모 테이블의 PRIMARY KEY 제약조건이 설정된 컬럼 참조 
--TRAINEE2 테이블의 수강과목코드(SCODE)에 FOREIGN KEY 제약조건을 설정하여 SUBJECT1 테이블의 과목코드(SNO)를 참조
CREATE TABLE TRAINEE2(TNO NUMBER(4) CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20)
    ,SCODE NUMBER(2) CONSTRAINT TRAINEE2_SCODE_FK REFERENCES SUBJECT1(SNO));

--제약조건 확인
--R_CONSTRAINT_NAME : 부모 테이블에 참조되는 컬럼의 PRIMARY KEY 제약조건 이름
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='TRAINEE2';

--TRAINEE2 테이블에 행 삽입 - 자식 테이블에 행 삽입시 FOREIGN KEY 제약조건이 설정된 컬럼값은 부모 테이블의 컬럼값 참조
INSERT INTO TRAINEE2 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE2 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE2 VALUES(3000,'전우치',30);
INSERT INTO TRAINEE2 VALUES(4000,'일지매',40);--부모 테이블에 저장된 컬럼값을 참조할 수 없으므로 FOREIGN KEY 제약조건을 위반하여 에러 발생
SELECT * FROM TRAINEE2;
COMMIT;

--TRAINEE2 테이블과 SUBJECT1 테이블에서 모든 수강생의 수강생번호,수강생이름,수강과목명 검색
--결합조건 : TRAINEE2 테이블의 수강과목코드(SCODE)와 SUBJECT1 테이블의 과목코드(SNO)가 같은 행을 결합 - INNER JOIN
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 테이블에서 수강생번호가 1000인 수강생의 수강과목코드를 40으로 변경
UPDATE TRAINEE2 SET SCODE=40 WHERE TNO=1000;--FOREIGN KEY 제약조건을 위반하여 에러 발생

--SUBJECT 테이블에서 과목코드가 10인 과목정보 삭제
--자식 테이블에서 참조되는 부모 테이블의 행 삭제 불가능
DELETE FROM SUBJECT1 WHERE SNO=10;--FOREIGN KEY 제약조건을 위반하여 에러 발생

--SUBJECT2 테이블 생성 - 과목코드(숫자형-PRIMARY KEY),과목명(문자형) : 부모 테이블
CREATE TABLE SUBJECT2(SNO NUMBER(2) CONSTRAINT SUBJECT2_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT2 테이블에 행 삽입
INSERT INTO SUBJECT2 VALUES(10,'JAVA');
INSERT INTO SUBJECT2 VALUES(20,'JSP');
INSERT INTO SUBJECT2 VALUES(30,'SPRING');
SELECT * FROM SUBJECT2;
COMMIT;

--TRAINEE3 테이블 생성 - 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형-FOREIGN KEY) : 자식 테이블
--TRAINEE3 테이블의 수강과목코드(SCODE)에 FOREIGN KEY 제약조건을 설정하여 SUBJECT2 테이블의 과목코드(SNO)를 참조
--FOREIGN KEY 제약조건 설정시 ON DELETE CASCADE 또는 ON DELETE SET NULL 기능 추가
--ON DELETE CASCADE : 부모 테이블의 행을 삭제할 경우 자식 테이블의 참조 컬럼값이 저장된 행도 삭제 처리하는 기능 제공
--ON DELETE SET NULL : 부모 테이블의 행을 삭제할 경우 자식 테이블의 참조 컬럼값을 NULL로 변경하는 기능 제공
CREATE TABLE TRAINEE3(TNO NUMBER(4) CONSTRAINT TRAINEE3_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE3_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT2(SNO) ON DELETE CASCADE);

--TRAINEE3 테이블에 행 삽입  
INSERT INTO TRAINEE3 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE3 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE3 VALUES(3000,'전우치',30); 
SELECT * FROM TRAINEE3;    
COMMIT;

--SUBJECT2 테이블에서 과목코드가 10인 과목정보 삭제
DELETE FROM SUBJECT2 WHERE SNO=10;
--SUBJECT2 테이블(부모 테이블)의 과목코드를 참조하는 TRAINEE3 테이블의 수강생정보 삭제
SELECT * FROM SUBJECT2;
SELECT * FROM TRAINEE3;

--서브쿼리를 사용하여 테이블 생성 가능 - 기존 테이블을 이용하여 새로운 테이블 생성 : 행 복사
--형식)CREATE TABLE 타겟테이블명[(컬럼명,컬럼명,...)] AS SELECT 검색대상,검색대상,... FROM 원본테이블명 [WHERE 조건식]
--서브쿼리의 검색결과를 사용하여 타겟 테이블을 생성하고 검색된 행은 타겟 테이블의 행으로 삽입 처리
--타겟 테이블의 컬럼명은 변경 가능하지만 자료형 및 크기는 변경 불가능
--서브쿼리에서 사용된 원본 테이블의 제약조건은 타겟 테이블에 미적용

--EMP 테이블에 저장된 모든 사원의 사원정보를 검색하여 EMP_COPY 테이블를 생성하고 검색행을 삽입 처리
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;

--EMP 테이블과 EMP_COPY 테이블의 구조 비교 - 원본 테이블과 타겟 테이블의 속성 동일
DESC EMP;
DESC EMP_COPY;

--EMP 테이블과 EMP_COPY 테이블의 제약조건 비교 - 원본 테이블에는 제약조건이 설정되어 있지만 타겟 테이블에는 제약조건 미설정
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP_COPY';

--EMP 테이블과 EMP_COPY 테이블의 저장행 비교 - 원본 테이블과 타겟 테이블의 저장행 동일
SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여를 검색하여 EMP_COPY2 테이블를 생성하고 검색행을 삽입 처리
CREATE TABLE EMP_COPY2 AS SELECT EMPNO,ENAME,SAL FROM EMP;

--EMP_COPY2 테이블의 구조 및 행 검색
DESC EMP_COPY2;
SELECT * FROM EMP_COPY2;

--EMP 테이블에서 급여가 2000 이상인 사원의 사원번호,사원이름,급여를 검색하여 EMP_COPY3 테이블를 생성하고 검색행을 삽입 처리
CREATE TABLE EMP_COPY3 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP_COPY3 테이블의 구조 및 행 검색
DESC EMP_COPY3;
SELECT * FROM EMP_COPY3;

--EMP 테이블에서 급여가 2000 이상인 사원의 사원번호,사원이름,급여를 검색하여 EMP_COPY4 테이블를 생성하고 검색행을 삽입 처리
--EMP_COPY4 테이블의 컬럼명을 NO(사원번호),NAME(사원이름),PAY(급여)이 되도록 생성
CREATE TABLE EMP_COPY4(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP_COPY4 테이블의 구조 및 행 검색
DESC EMP_COPY4;
SELECT * FROM EMP_COPY4;

--EMP 테이블과 동일한 속성의 EMP_COPY5 테이블 생성 - 원본 테이블의 행을 타겟 테이블에 삽입 처리되지 않도록 설정
CREATE TABLE EMP_COPY5 AS SELECT * FROM EMP WHERE 0=1;--조건식이 무조건 거짓이므로 행 미검색

--EMP_COPY5 테이블의 구조 및 행 검색
DESC EMP_COPY5;
SELECT * FROM EMP_COPY5;

--테이블 삭제 : 테이블에 저장된 모든 행 삭제
--형식)DROP TABLE 테이블명

--테이블 목록 확인 - USER_TABLES 딕셔너리 이용
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';

--USER1 테이블 삭제
DROP TABLE USER1;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';

--USER_TABLES 딕셔너리 대신 TAB 뷰(VIEW)를 이용하여 테이블 목록 검색 가능
--오라클은 테이블을 삭제할 경우 테이블을 휴지통(RECYCLEBIN)으로 이동하여 삭제 처리 - 삭제 테이블 복구 가능
--TNAME 컬럼에 BIN으로 시작되는 테이블은 오라클 휴지통에 존재하는 삭제 테이블
SELECT * FROM TAB;

--오라클 휴지통에 존재하는 객체 목록 확인
SHOW RECYCLEBIN;

--오라클 휴지통에 존재하는 삭제 테이블 복구
--형식)FLASHBACK TABLE 테이블명 TO BEFORE DROP
FLASHBACK TABLE USER1 TO BEFORE DROP;

--삭제 테이블 복구 확인 및 저장행 확인
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SELECT * FROM USER1;

--USER2 테이블 삭제
DROP TABLE USER2;

--오라클 휴지통 확인
--오라클 휴지통에는 테이블뿐만 아니라 테이블과 종속관계에 있는 인덱스(INDEX) 객체도 같이 존재
SHOW RECYCLEBIN;

--USER2 테이블 복구 - 종속관계의 인텍스 객체도 복구
FLASHBACK TABLE USER2 TO BEFORE DROP;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--USER1,USER2,USER3,USER4 테이블 삭제
DROP TABLE USER1;
DROP TABLE USER2;
DROP TABLE USER3;
DROP TABLE USER4;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--오라클 휴지통의 테이블 삭제 - 테이블에 종속된 인덱스 객체가 같이 삭제 처리
--형식)PURGE TABLE 테이블명
PURGE TABLE USER4;
SHOW RECYCLEBIN;

--오라클 휴지통의 모든 테이블 삭제 - 오라클 휴지통 비우기
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

--MRG1 테이블 삭제
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'MGR%';
DROP TABLE MGR1;--테이블의 논리적 삭제 >> 오라클 휴지통으로 이동
SHOW RECYCLEBIN;
PURGE RECYCLEBIN;--테이블의 물리적 삭제
SHOW RECYCLEBIN;

--MRG2 테이블 삭제 - 오라클 휴지통을 사용하지 않고 물리적 삭제
--형식)DROP TABLE 테이블명 PURGE
DROP TABLE MGR2 PURGE;
SHOW RECYCLEBIN;

--테이블 초기화 : 테이블을 생성 직후의 상태로 초기화 처리하는 명령 - 테이블에 저장된 모든 행 삭제 처리
--형식)TRUNCATE TABLE 테이블명

--BONUS 테이블에 저장된 모든 행 삭제
DELETE FROM BONUS;--실제 테이블에 저장된 행을 삭제 처리한 것이 아닌 트렌젝션에 명령 저장
SELECT * FROM BONUS;
ROLLBACK;--롤백 처리 : 트렌젝션 초기화 - 트렌젝션에 저장된 모든 SQL 명령 제거
SELECT * FROM BONUS;

--BONUS 테이블 초기화
TRUNCATE TABLE BONUS;--자동 커밋 처리
SELECT * FROM BONUS;
ROLLBACK;--롤백 불가능
SELECT * FROM BONUS;

--테이블의 이름 변경
--형식)RENAME 기존테이블명 TO 변경테이블명

--BONUS 테이블의 이름을 COMM으로 변경
RENAME BONUS TO COMM;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME IN('BONUS','COMM');

--테이블의 속성 및 제약조건 변경
--형식)ALTER TABLE 테이블명 변경옵션
--변경옵션에 의해 테이블 속성에 대한 추가,삭제,변경 및 제약조건에 대한 추가,삭제 가능

--USER1 테이블 생성 - 회원번호(숫자형),회원이름(문자형),전화번호(문자형)
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--USER1 테이블 행 삽입
INSERT INTO USER1 VALUES(1000,'홍길동','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--테이블의 속성 추가 - 컬럼 기본값 및 컬럼 수준의 제약조건 설정 가능
--형식)ALTER TABLE 테이블명 ADD(컬럼명 자료형[(크기)] [DEFAULT 기본값] [제약조건])

--USER1 테이블에 주소(문자형) 속성 추가
--테이블에 행이 저장된 상태에서 테이블 속성 추가 가능 - 저장행의 추가 속성에는 컬럼 기본값이 자동 저장
ALTER TABLE USER1 ADD(ADDRESS VARCHAR2(100));
DESC USER1;
SELECT * FROM USER1;
UPDATE USER1 SET ADDRESS='서울시 강남구' WHERE NO=1000;--추가된 속성의 컬럼값 변경
SELECT * FROM USER1;
COMMIT;

--테이블 속성의 컬럼 자료형 또는 크기 변경 - 컬럼 기본값 및 컬럼 수준의 제약조건 설정 가능
--형식)ALTER TABLE 테이블명 MODIFY(컬럼명 자료형[(크기)] [DEFAULT 기본값] [제약조건])

--USER1 테이블 초기화
TRUNCATE TABLE USER1;
SELECT * FROM USER1;

--USER1 테이블의 NO 컬럼의 자료형을 숫자형에서 문자형으로 변경
ALTER TABLE USER1 MODIFY(NO VARCHAR2(4));
DESC USER1;

--USER1 테이블에 행 삽입
INSERT INTO USER1 VALUES('1000','홍길동','010-1234-5678','서울시 강남구');
SELECT * FROM USER1;
COMMIT;

--USER1 테이블의 NO 컬럼의 자료형을 문자형에서 숫자형으로 변경
--컬럼 자료형을 변경할 속성에 컬럼값이 저장되어 있는 경우 컬럼의 자료형 변경 불가능
ALTER TABLE USER1 MODIFY(NO NUMBER(4));--에러 발생

--USER1 테이블의 NAME 컬럼의 크기를 20BYTE에서 10BYTE로  변경
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10));
DESC USER1;

--USER1 테이블의 NAME 컬럼의 크기를 10BYTE에서 5BYTE로  변경
--컬럼의 크기를 변경할 속성에 컬럼값이 저장되어 있는 경우 컬럼값의 크기보다 작은 컬럼의 크기로 변경 불가능
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(5));--에러 발생

--테이블 속성의 컬럼명 변경
--형식)ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 변경컬럼명

--USER1 테이블의 ADDRESS 컬럼의 이름을 ADDR로 변경
DESC USER1;
ALTER TABLE USER1 RENAME COLUMN ADDRESS TO ADDR;
DESC USER1;

--테이블의 속성 삭제 - 테이블 속성에 저장된 컬럼값 삭제
--형식)ALTER TABLE 테이블명 DROP COLUMN 컬럼명

--USER1 테이블에서 PHONE 컬럼 삭제
ALTER TABLE USER1 DROP COLUMN PHONE;
DESC USER1;
SELECT * FROM USER1;

--제약조건 추가 - 테이블의 속성 추가 및 테이블 속성 변경시 컬럼 수준의 제약조건 추가 가능
--USER1 테이블의 NAME 컬럼에 NOT NULL 제약조건 추가
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10) CONSTRAINT USER1_NAME_NN NOT NULL); 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--테이블 수준의 제약조건은 ADD 옵션을 사용하여 추가 가능
--형식)ALTER TABLE 테이블명 ADD [CONSTAINT 제약조건명] 제약조건
--USER1 테이블의 NO 컬럼에 PRIMARY KEY 제약조건 추가
ALTER TABLE USER1 ADD CONSTRAINT USER1_NO_PK PRIMARY KEY(NO);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--DROP 옵션을 사용하여 제약조건 삭제
--형식)ALTER TABLE 테이블명 DROP {PRIMARY KEY|CONSRAINT 제약조건명}

--USER1 테이블의 NAME 컬럼에 설정된 NOT NULL 제약조건 삭제
ALTER TABLE USER1 DROP CONSTRAINT USER1_NAME_NN;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--USER1 테이블의 NO 컬럼에 설정된 PRIMARY KEY 제약조건 삭제
ALTER TABLE USER1 DROP PRIMARY KEY;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--뷰(VIEW) : 테이블을 기반으로 만들어지는 가상의 테이블 - 단순뷰와 복합뷰로 구분
--뷰는 테이블의 행검색 또는 테이블의 권한 설정을 간편하게 제공하기 위해 생성
--단순뷰 : 하나의 테이블을 기반으로 생성되는 뷰 - 뷰를 이용한 테이블의 검색뿐만 아니라 테이블의 행 삽입,삭제,변경 가능
--단순뷰 생성시 그룹함수 또는 DISTINCT 키워드를 사용한 경우 검색만 가능
--복합뷰 : 여러개의 테이블을 기반으로 생성된 뷰 - 테이블의 행을 결합하여 생성된 뷰 - 검색만 가능

--뷰 생성 - 서브쿼리 이용
--형식)CREATE [OR REPLACE] VIEW [{FORCE|NOFORCE}] VIEW 뷰이름[(컬럼명,컬럼명,...)]
--     AS SELECT 검색대상,검색대상,... FROM 테이블명 [WHERE 조건식] [WITH CHECK OPTION] [WITH READ ONLY]
--서브쿼리의 검색결과를 이용하여 뷰 생성
--CREATE OR REPLACE : 동일한 이름의 뷰가 있는 경우 기존뷰를 삭제하고 새로운 뷰 생성
--FORCE : 서브쿼리의 검색결과가 없어도 강제로 뷰를 생성하기 위한 기능 제공
--WITH CHECK OPTION : 뷰를 생성한 서브쿼리의 조건식에서 사용된 컬럼값을 변경하지 못하도록 설정하는 기능 제공
--WITH READ ONLY : 검색만 가능하도록 설정하는 기능 제공(단순뷰)

--EMP_COPY 테이블에서 부서번호가 30인 사원의 사원번호,사원이름,부서번호를 검색해여 EMP_VIEW30 뷰 생성
SELECT * FROM EMP_COPY;
--CREATE VIEW 시스템 권한이 현재 사용자에게 없으므로 CREATE VIEW 명령 실행시 에러 발생
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;--권한 불충분으로 에러 발생

--시스템 관리자(SYSDBA - SYS 계정)로 접속하여 현재 접속 사용자(SCOTT)에게 CREATE VIEW 시스템 권한을 부여
--GRANT CREATE VIEW TO SCOTT;

--시스템 관리자에게 CREATE VIEW 시스템 권한을 부여받은 후 CREATE VIEW 명령 실행
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;--단순뷰

--뷰 목록 확인 - USER_VIEWS : 뷰 정보를 제공하는 딕셔너리
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--뷰 검색 - 테이블의 저장행 검색
SELECT * FROM EMP_VIEW30;

--단순뷰는 행에 대한 삽입,삭제,변경 가능
--EMP_VIEW30 뷰에 행 삽입 - EMP_COPY 테이블에 행 삽입 : 생략된 컬럼에는 컬럼 기본값 저장
INSERT INTO EMP_VIEW30 VALUES(1111,'홍길동',30);
SELECT * FROM EMP_VIEW30;
SELECT * FROM EMP_COPY;

--EMP 테이블과 DEPT 테이블에서 부서번호가 10인 사원의 사원번호,사원이름,부서이름을 검색하여 EMP_VIEW10 뷰 생성
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;--복합뷰
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
SELECT * FROM EMP_VIEW10;

--EMP 테이블과 DEPT 테이블에서 부서번호가 10인 사원의 사원번호,사원이름,급여,부서이름을 검색하여 EMP_VIEW10 뷰 생성
--기존의 객체와 같은 이름의 뷰를 생성할 경우 에러 발생
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;--에러 발생
--기준뷰를 새로운 새로운 뷰로 대체 - 뷰 변경
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--뷰를 생성하지 않고 SELECT 명령의 서브쿼리를 사용하여 인라인 뷰를 생성하여 사용 - CREATE VIRE 시스템 권한이 없어도 사용 가능
SELECT * FROM (SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO);

--뷰 삭제
--형식)DROP VIEW 뷰이름

--EMP_VIEW30 뷰 삭제
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
DROP VIEW EMP_VIEW30;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--시퀸스(SEQUENCE) : 숫자값(정수값)을 저장하여 자동 증가되는 값을 제공하는 객체 - 테이블 컬럼에 고유값을 제공

--시퀸스 생성
--형식)CREATE SEQUENCE 시퀸스명 [START WITH 초기값] [INCREMENT BY 증가값] [MAXVALUE 최대값] 
--    [MINVALUE 최소값] [CYCLE] [CACHE 갯수]
--START WITH 초기값 : 시퀸스에 저장된 초기값 설정 - 생략 : NULL
--INCREMENT BY 증가값 : 자동 증가되는 숫자값 설정 - 생략 : 1
--MAXVALUE 최대값 : 시퀸스에 저장 가능한 최대값 설정 - 생략 : 오라클에서 숫자값으로 표현 가능한 최대값
--MINVALUE 최소값 : 시퀸스에 저장 가능한 최소값 설정 - 생략 : 1
--CYCLE : 시퀸스에 저장된 값이 최대값을 초과할 경우 최소값부터 다시 제공되도록 반복하는 기능을 제공
--CACHE 갯수 : 임의의 저장공감에 자동 증가값을 미리 생성하여 제공할 수 있는 갯수 설정 - 생략 : 20

--USER2 테이블 생성 - 회원번호(숫자형-PRIMARY KEY),회원이름(문자형),생년월일(날짜형)
CREATE TABLE USER2(NO NUMBER(2) CONSTRAINT USER2_NO_PK PRIMARY KEY,NAME VARCHAR2(20),BIRTHDAY DATE);
DESC USER2;

--USER2 테이블의 NO 컬럼값으로 저장되기 위한 자동 증가값을 제공하는 USER2_SEQ 시퀸스 생성
CREATE SEQUENCE USER2_SEQ;

--시퀸스 확인 - USER_SEQUENCES : 시퀸스 정보를 제공하는 딕셔너리
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--시퀸스에 저장된 숫자값 확인
--형식)시퀸스명.CURRVAL
SELECT USER2_SEQ.CURRVAL FROM DUAL;--시퀸스에 NULL이 저장되어 있으므로 에러 발생

--시퀸스에 저장된 숫자값를 이용하여 증가된 값을 제공하는 방법 - 증가된 값 제공후 시퀸스는 증가된 값으로 자동 변경
--시퀸스에 NULL이 저장되어 있는 경우 시퀸스의 최소값을 제공한 후 시퀸스의 저장값 변경 처리
--형식)시퀸스명.NEXTVAL
SELECT * FROM USER2;
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--검색결과 : 1 - 시퀸스에 저장값은 1로 변경
SELECT USER2_SEQ.CURRVAL FROM DUAL;--검색결과 : 1
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--검색결과 : 2 - 시퀸스에 저장값은 2로 변경
SELECT USER2_SEQ.CURRVAL FROM DUAL;--검색결과 : 2

--USER2 테이블에 행 삽입 - NO 컬럼에는 시퀸스로부터 자동 증가값을 제공받아 삽입 처리
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'홍길동','00/01/01');
SELECT * FROM USER2;
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'임꺽정','00/12/31');
SELECT * FROM USER2;
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'전우치',SYSDATE);
SELECT * FROM USER2;
COMMIT;

--시퀸스 변경
--형식)ALTER SEQUENCE 시퀸스명 {MAXVALUE|MINVALUE|INCREMENT BY} 변경값

--USER2_SEQ 시퀸스의 최대값을 99로 변경하고 증가값을 5로 변경
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
ALTER SEQUENCE USER2_SEQ MAXVALUE 99 INCREMENT BY 5;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--USER2 테이블에 행 삽입 - NO 컬럼에는 시퀸스로부터 자동 증가값을 제공받아 삽입 처리
SELECT USER2_SEQ.CURRVAL FROM DUAL;--검색결과 : 5
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'일지매','03/09/09');
SELECT * FROM USER2;
SELECT USER2_SEQ.CURRVAL FROM DUAL;--검색결과 : 10
COMMIT;

--시퀸스 삭제
--형식)DROP SEQUENCE 시퀸스명

--USER2_SEQ 시퀸스 삭제
DROP SEQUENCE USER2_SEQ;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;