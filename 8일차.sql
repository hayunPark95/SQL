--메세지를 출력할 수 있는 세션의 환경변수 설정값 변경
SET SERVEROUT ON;

--CASE : 변수에 저장된 값을 비교하여 명령을 선택 실행하거나 조건식을 사용하여 명령을 선택 실행하는 구문
--형식)CASE 변수명 WHEN 비교값1 THEN 명령;명령;... WHEN 비교값2 THEN 명령;명령;... END CASE;

--EMP 테이블에서 사원번호가 7788인 사원정보를 검색하여 사원번호,사원이름,업무,급여,업무별 실급여를 검색하여 출력하는 PL/SQL 작성
--업무별 실급여 - ANALYST:급여*1.1, CLERK:급여*1.2, MANAGER:급여*1.3, PRESIDENT:급여*1.4, SALESMAN:급여*1.5
DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    CASE VEMP.JOB
        WHEN 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
        WHEN 'CLERK' THEN VPAY := VEMP.SAL * 1.2;
        WHEN 'MANAGER' THEN VPAY := VEMP.SAL * 1.3;
        WHEN 'PRESIDENT' THEN VPAY := VEMP.SAL * 1.4;
        WHEN 'SALESMAN' THEN VPAY := VEMP.SAL * 1.5;
    END CASE;    
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('업무별 실급여 = '||VPAY);
END;
/
    
--형식)CASE WHEN 조건식1 THEN 명령;명령;... WHEN 조건식2 THEN 명령;명령;... END CASE;

--EMP 테이블에서 사원번호가 7788인 사원정보를 검색하여 사원번호,사원이름,급여,급여등급을 계산하여 출력하는 PL/SQL 작성
--급여등급 - E : 0~1000, D : 1001~2000, C : 2001~3000, B : 3001~4000, A : 4001~5000
DECLARE
    VEMP EMP%ROWTYPE;
    VGRADE VARCHAR2(1);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    CASE 
        WHEN VEMP.SAL BETWEEN 0 AND 1000 THEN VGRADE := 'E';
        WHEN VEMP.SAL BETWEEN 1001 AND 2000 THEN VGRADE := 'D';
        WHEN VEMP.SAL BETWEEN 2001 AND 3000 THEN VGRADE := 'C';
        WHEN VEMP.SAL BETWEEN 3001 AND 4000 THEN VGRADE := 'B';
        WHEN VEMP.SAL BETWEEN 4001 AND 5000 THEN VGRADE := 'A';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('급여등급 = '||VGRADE);
END;
/

--반복문 : 명령을 반복 실행하기 위한 구문

--BASIC LOOP : 무한반복 - 선택문을 사용하여 조건식이 참인 경우 EXIT 명령으로 반복문 종료
--형식)LOOP 명령; 명령; ... END LOOP;

--1~5 범위의 숫자값을 출력하는 PL/SQL 작성
DECLARE
    I NUMBER(1) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        IF I > 5 THEN 
            EXIT;
        END IF;
    END LOOP;
END;
/

--FOR LOOP : 반복의 횟수가 정해져 있는 경우 사용하는 반복문
--형식)FOR INDEX_COUNTER IN [REVERSE] LOWER_BOUND..HIGH_BOUND LOOP 명령; 명령; ... END LOOP;

--1~10 범위의 정수값에 대한 합계를 계산하여 출력하는 PL/SQL 작성
DECLARE
    TOT NUMBER(2) := 0;
BEGIN
    /* FOR LOOP 구문에서 생성되는 변수(INDEX_COUNTER)는 FOR LOOP 구문에서만 사용 가능 */
    FOR I IN 1..10 LOOP
        TOT := TOT + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 범위의 정수들의 합계 = '||TOT);
END;
/
    
--FOR LOOP 구문을 사용하여 테이블의 다중 검색행에 대한 반복 처리 가능 - 내부적 커서(CURSOR)를 사용하여 반복 처리    
--형식)FOR RECORD_VARIABLE IN (SELECT 검색대상,검색대상,... FROM 테이블명 [WHERE 조건식]) LOOP 명령;... END LOOP;

--EMP 테이블에 저장된 모든 사원정보를 검색하여 사원번호,사원이름을 출력하는 PL/SQL 작성
BEGIN
    FOR VEMP IN (SELECT * FROM EMP) LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO||', 사원이름 = '||VEMP.ENAME);
    END LOOP;
END;
/
    
--커서(CURSOR) : 테이블의 검색행을 저장하여 처리하기 위한 기능을 제공
--1.묵시적 커서 : 검색결과가 단일행인 경우를 처리하기 위한 커서
--2.명시적 커서 : 검색결과가 다중행인 경우를 처리하기 위한 커서 

--명시적 커서의 선언 방법 및 사용 - 커서를 선언부에서 생성하여 실행부에서 OPEN,FATCH,CLOSE 명령으로 커서 사용
--형식)DECLARE
--        /* 커서를 생성하여 커서에 검색결과(다중행) 저장 */    
--        CURSOR 커서명 IS SELECT 검색대상,검색대상,... FROM 테이블명 [WHERE 조건식];
--    BEGIN
--        OPEN 커서명;/* 커서 열기 - 첫번째 검색행을 제공받기 위해 커서의 위치 이동 */
--        FETCH 커서명 INTO 변수명,변수명,...;/* 커서 위치의 검색행을 제공받아 변수에 저장 - 커서는 다음행으로 이동 */
--        CLOSE 커서명;/* 커서 닫기 - 커서를 더이상 사용하지 않도록 제거 */
--    END;

--EMP 테이블에 저장된 모든 사원정보를 검색하여 사원번호,사원이름을 출력하는 PL/SQL 작성 - 커서 이용
DECLARE
    CURSOR C IS SELECT * FROM EMP;
    VEMP EMP%ROWTYPE;
BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VEMP;/* 커서 위치의 검색행을 레코드 변수에 저장 */
        EXIT WHEN C%NOTFOUND;/* 커서 위치에 검색행이 없는 경우 반복문 종료 */
        DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO||', 사원이름 = '||VEMP.ENAME);
    END LOOP;
    
    CLOSE C;
END;
/
        
--WHILE LOOP : 반복의 횟수가 부정확한 경우 사용하는 반복문
--형식)WHILE 조건식 LOOP 명령; 명령; ... END LOOP;

--1~10 범위의 정수값에 대한 합계를 계산하여 출력하는 PL/SQL 작성
DECLARE
    I NUMBER(2) := 1;
    TOT NUMBER(2) := 0;
BEGIN
    WHILE I <= 10 LOOP
        TOT := TOT + I;
        I := I + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~10 범위의 정수들의 합계 = '||TOT);
END;
/
    
--저장 프로시저(STORED PROCEDURE) : PL/SQL 프로시저에 이름을 부여하여 저장하고 필요한 경우 호출하여 사용    
        
--저장 프로시저 생성
--형식)CREATE [OR REPLACE] PROCEDURE 프로시저명[(매개변수 [MODE] 자료형,매개변수 [MODE] 자료형,...)] 
--     IS [변수선언부] BEGIN 명령; 명령; ... END;

--EMP_COPY 테이블에 저장된 모든 사원정보를 삭제하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE DELETE_ALL_EMP_COPY IS
BEGIN
    DELETE FROM EMP_COPY;
    COMMIT;
END;
/

--저장 프로시저 확인 - USER_SOURCE : 저장 프로시저와 저장 함수 정보를 제공하는 딕셔너리
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--저장 프로시저 호출 - 저장 프로시저에 작성된 PL/SQL 실행
--형식)EXECUTE 프로시저명[({변수|값},{변수|값},...)]

--DELETE_ALL_EMP_COPY 저장 프로시저 호출
SELECT * FROM EMP_COPY;
EXECUTE DELETE_ALL_EMP_COPY;
SELECT * FROM EMP_COPY;

--저장 프로시저 생성시 발생된 컴파일 에러는 컴파일 로그를 이용하여 확인 가능
SHOW ERROR;

--저장 프로시저 삭제
--형식)DROP PROCEDURE 프로시저명

--DELETE_ALL_EMP_COPY 저장 프로시저 삭제
DROP PROCEDURE DELETE_ALL_EMP_COPY;
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--저장 프로시저의 매개변수 모드(MODE)
--1.IN : 저장 프로시저 호출시 외부로부터 값을 전달받아 저장 프로시저의 PL/SQL 명령에서 사용할 목적의 매개변수를 선언할 때 사용 
--2.OUT : 저장 프로시저 호출시 바인딩 변수를 전달받아 저장 프로시저의 PL/SQL 실행 결과를 저장하여 외부에 결과값을 제공할
--목적의 매개변수를 선언할 때 사용
--3.INOUT : 저장 프로시저 호출시 바인딩 변수를 전달받아 저장 프로시저의 PL/SQL 명령에서 사용하거나 실행 결과를 저장하여
--외부에 결과값을 제공할 목적의 매개변수를 선언할 때 사용

--사원번호를 매개변수로 전달받아 EMP 테이블에서 전달받은 사원번호의 사원정보를 검색하여 사원이름,업무,급여를 매개변수로
--전달하여 외부로 제공하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE, VENAME OUT EMP.ENAME%TYPE
    ,VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS
BEGIN   
    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO=VEMPNO;
END;
/

--OUT 모드의 매개변수에 의해 제공받는 값을 저장하기 위한 바인딩 변수 선언
--형식)VARIABLE 바인딩변수명 자료형
--바인딩 변수 : 현재 접속 사용자의 세션에서만 사용할 수 있는 시스템 변수
--다수의 저장 프로시저에서 필요한 값을 전달하거나 전달받기 위해 사용
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

--SELECT_EMPNO 저장 프로시저 호출 - IN 모드의 매개변수에 값을 전달하고 OUT 모드의 매개변수는 바인딩 변수를 전달하여 호출
--OUT 모드의 매개변수에 바인딩 변수를 전달하여 값을 저장하기 위해서는 반드시 바인딩 변수 앞에 :를 붙여서 사용
EXECUTE SELECT_EMPNO(7788,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

--바인딩 변수에 저장된 값 출력
--형식)PRINT 바인딩변수명
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;

--저장 함수(STORED FUNCTION) : 저장 프로시저와 유사한 기능을 제공하지만 반드시 하나의 결과값 반환
    
--저장 함수 생성
--형식)CREATE [OR REPLACE] FUNCTION 저장함수명[(매개변수 [MODE] 자료형,매개변수 [MODE] 자료형,...)] 
--     RETURN 자료형 IS [변수선언부] BEGIN 명령; 명령; ... RETURN 반환값; END;

--사원번호를 매개변수로 전달받아 EMP 테이블에서 전달받아 사원번호의 사원정보를 검색하여 급여의 2배에 해당하는
--결과값을 반환하는 저장 함수 생성
CREATE OR REPLACE FUNCTION CAL_SAL(VEMPNO IN EMP.EMPNO%TYPE) RETURN NUMBER IS
    VSAL NUMBER(7,2);
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO=VEMPNO;
    RETURN ( VSAL * 2 );
END;
/

--저장 함수 확인 - USER_SOURCE  딕셔너리
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='CAL_SAL';

--저장 함수의 반환값을 저장하기 위한 바인딩 변수 선언
VARIABLE VAR_SAL NUMBER;

--저장 함수 호출 - 저장 함수의 반환값을 바인딩 변수에 저장
EXECUTE :VAR_SAL := CAL_SAL(7788);

--바인딩 변수값 출력
PRINT VAR_SAL;

--저장 함수는 오라클 함수처럼 SQL 명령에 포함되어 사용 가능
SELECT EMPNO,ENAME,SAL,CAL_SAL(EMPNO) "특별수당" FROM EMP;

--저장 함수 삭제
--형식)DROP FUNCTION 저장함수명

--CAL_SAL  저장 함수 삭제
DROP FUNCTION CAL_SAL;
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='CAL_SAL';

--트리거(TRIGGER) : 특정 테이블에서 SQL 명령(DML)이 실행될 경우 PL/SQL 프로시저의 명령을 실행하는 기능

--트리거 생성
--형식)CREATE [OR REPLACE] TRIGGER 트리거명 {AFTER|BEFORE} {INSERT|UPDATE|DELETE} ON 테이블명
--     [FOR EACH ROW] [WITH 조건식] BEGIN 명령; 명령; ... END;
--FOR EACH ROW : 생략된 경우 문장 레벨 트리거를 생성하고 선언한 경우 행 레벨 트리거로 생성
--문장 레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거에 작성된 PL/SQL 프로시저의 명령을 한번만 실행
--행 레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거에 작성된 PL/SQL 프로시저의 명령을 행의 갯수만큼 실행
--트리거에 등록된 PL/SQL 프로시저의 명령으로 TCL 명령(COMMIT 또는 ROLLBACK) 사용 불가능

--EMP_COPY2 테이블에 사원정보가 삽입될 경우 메세지를 출력하는 트리거 생성
CREATE OR REPLACE TRIGGER EMP_COPY2_INSERT_TRIGGER AFTER INSERT ON EMP_COPY2
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로운 사원이 입사 하였습니다.');
END;
/

--트리거 확인 - USER_TRIGGERS : 트리거 정보를 제공하는 딕셔너리
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_COPY2 테이블에 행 삽입
SELECT * FROM EMP_COPY2;
INSERT INTO EMP_COPY2 VALUES(1111,'홍길동',4000);
SELECT * FROM EMP_COPY2;
COMMIT;

--트리거 삭제
--형식)DROP TRIGGER 트리거명

--EMP_COPY2_INSERT_TRIGGER 트리거 삭제
DROP TRIGGER EMP_COPY2_INSERT_TRIGGER;
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_TRI 테이블을 생성하여 검색행 삽입
CREATE TABLE EMP_TRI AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;
SELECT * FROM EMP_TRI;

--EMP_HIS 테이블 생성 - 사원번호(숫자형),사원이름(문자형),사원상태(문자형)
CREATE TABLE EMP_HIS(NO NUMBER(4),NAME VARCHAR2(20),STATUS VARCHAR2(50));

--EMP_TRI 테이블에서 행을 삽입하거나 변경 또는 삭제한 경우 DML 명령 실행 후 삽입,변경,삭제에 대한 이유를
--EMP_HIS 테이블에 행으로 삽입하는 트리거 생성
CREATE OR REPLACE TRIGGER EMP_HIS_TRIGGER AFTER INSERT OR UPDATE OR DELETE ON EMP_TRI FOR EACH ROW
BEGIN
    /* :NEW.컬럼명 : 이벤트가 발생된 테이블의 삽입 또는 변경 명령에서 사용된 새로운 행의 컬럼값 표현  */
    /* :OLD.컬럼명 : 이벤트가 발생된 테이블의 변경 또는 삭제 명령에서 사용된 기존 행의 컬럼값 표현  */
    IF INSERTING THEN /* INSERT 명령이 실행된 경우 */
        INSERT INTO EMP_HIS VALUES(:NEW.EMPNO, :NEW.ENAME, '입사');
    ELSIF UPDATING THEN  /* UPDATE 명령이 실행된 경우 */
        IF :NEW.DEPTNO <> :OLD.DEPTNO THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '부서이동');
        ELSIF :NEW.SAL <> :OLD.SAL THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '급여변경');
        ELSE    
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '개인사유');
        END IF;            
    ELSIF DELETING THEN   /* DELETE 명령이 실행된 경우 */
        INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '퇴사');
    END IF;
END;
/

--트리거 확인
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_TRI 테이블에 행 삽입 - EMP_HIS_TRIGGER 트리거에 의해 EMP_HIS 테이블에서 행 삽입
SELECT * FROM EMP_TRI;
INSERT INTO EMP_TRI VALUES(5000,'PARK',2000,10);
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI 테이블에 저장된 행의 컬럼값 변경 - EMP_HIS_TRIGGER 트리거에 의해 EMP_HIS 테이블에서 행 삽입
UPDATE EMP_TRI SET DEPTNO=20 WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET SAL=3000 WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET ENAME='홍길동' WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI 테이블에 저장된 행 삭제 - EMP_HIS_TRIGGER 트리거에 의해 EMP_HIS 테이블에서 행 삽입
DELETE FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
COMMIT;