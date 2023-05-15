--숫자함수 : 매개변수로 숫자값을 전달받아 가공하여 결과값을 반환하는 함수
 
--ROUND(숫자값,소숫점자릿수) : 숫자값을 전달받아 소숫점자릿수 위치만큼 검색되도록 반올림 처리하여 반환하는 함수
--DUAL 테이블 : 테이블 없이 검색대상을 SELECT 명령으로 작성할 경우 사용되는 가상의 테이블
SELECT ROUND(45.582, 2), ROUND(45.582, 0), ROUND(45.582, -1) FROM DUAL;

--TRUNC(숫자값, 소숫점자릿수) : 숫자값을 전달받아 소숫점자릿수 위치만큼 검색되도록 절삭 처리하여 반환하는 함수
SELECT TRUNC(45.582, 2), TRUNC(45.582, 0), TRUNC(45.582, -1) FROM DUAL;

--CEIL(숫자값) : 숫자값을 전달받아 소숫점 이하 값이 존재할 경우 증가된 숫자값(정수값)을 반환하는 함수
SELECT CEIL(15.3), CEIL(-15.3) FROM DUAL;

--FLOOR(숫자값) : 숫자값을 전달받아 소숫점 이하 값이 존재할 경우 감소된 숫자값(정수값)을 반환하는 함수
SELECT FLOOR(15.3), FLOOR(-15.3) FROM DUAL;

--MOD(숫자값1,숫자값2) : 두개의 숫자값을 전달받아 숫자값1을 숫자값2로 나눈 나머지를 반환하는 함수
SELECT 20/8, MOD(20,8) FROM DUAL;

--POWER(숫자값1,숫자값2) : 두개의 숫자값을 전달받아 숫자값1에 대한 숫자값2의 제곱근을 반환하는 함수
SELECT 3*3*3*3*3, POWER(3, 5) FROM DUAL;

--날짜함수 : 매개변수로 날짜값을 전달받아 가공하여 결과값을 반환하는 함수

--SYSDATE : 시스템의 현재 날짜와 시간을 제공하기 위한 키워드
--SYSDATE 키워드의 검색값은 기본적으로 [RR/MM/DD] 패턴으로 검색되지만 내부적으로는 날짜와 시간 제공
SELECT SYSDATE FROM DUAL;

--ADD_MONTHS(날짜값, 숫자값) : 날짜값을 전달받아 숫자값만큼 개월수를 더한 날짜값을 반환하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 5) FROM DUAL;

--날짜값은 + 연산자 및 - 연산자를 이용하여 연산 가능
--날짜값 + 숫자값 = 날짜값 >> 일 증가
SELECT SYSDATE, SYSDATE+7 FROM DUAL;

--날짜값 + 숫자값/24 = 날짜값 >> 시간 증가
SELECT SYSDATE, SYSDATE+100/24 FROM DUAL;

--날짜값 - 숫자값 = 날짜값 >> 일 감소
SELECT SYSDATE, SYSDATE-7 FROM DUAL;

--날짜값 - 숫자값/24 = 날짜값 >> 시간 감소
SELECT SYSDATE, SYSDATE-100/24 FROM DUAL;

--날짜값 - 날짜값 = 숫자값 >> 일(실수값)
SELECT EMPNO,ENAME,HIREDATE,SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE)||'일' "근속일수" FROM EMP WHERE EMPNO=7499;

--NEXT_DAY(날짜값, 요일) : 날짜값을 전달받아 미래의 특정 요일에 대한 날짜값을 반환하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;

--오라클에 접속된 현재 사용자 환경(세션 : SESSION)에 따라 사용 언어 및 날짜와 시간 패턴이 다르게 적용
--세션의 사용 언어 및 날짜와 시간 패턴 변경 가능
ALTER SESSION SET NLS_LANGUAGE='AMERICAN';--사용 언어 변경 : AMERICAN
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE='KOREAN';--사용 언어 변경 : KOREAN
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;

--TRUNC(날짜값, 표현단위) : 날짜값을 전달받아 원하는 단위만 표현하고 나머지는 절삭하여 초기값으로 반환하는 함수
SELECT SYSDATE, TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;

--변환함수 : 매개변수로 전달받은 값을 원하는 자료형의 값으로 변환하여 반환하는 함수

--TO_NUMBER(문자값) : 문자값을 전달받아 숫자값으로 변환하여 반환하는 함수
--매개변수로 전달받은 문자값에 숫자가 아닌 형태의 문자가 존재할 경우 에러 발생
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7839;
--비교 컬럼의 자료형이 숫자형인 경우 비교값이 문자값이면 TO_NUMBER 함수를 사용하여 문자값을 숫자값으로 
--변환하여 반환받아 비교 가능 - 강제 형변환
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--비교 컬럼의 자료형이 숫자형인 경우 비교값이 문자값이면 자동으로 숫자값으로 변환되어 비교 - 자동 형변환
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO='7839';

--문자깂을 산술 연산할 경우 문자값이 자동으로 숫자값으로 변환되어 연산 처리 - 자동 형변환
SELECT 100+200 FROM DUAL;
SELECT 100+'200' FROM DUAL;

--EMP 테이블에서 사원번호가 7839인 사원의 사원번호,사원이름,급여,세후급여(급여*0.9) 검색
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;

--TO_DATE(문자값[,패턴문자]) : 문자값을 전달받아 날짜값으로 변환하여 반환하는 함수
--날짜와 시간 관련 패턴문자를 사용하여 원하는 패턴의 문자값을 전달받아 날짜값으로 변환
--패턴에 맞지 않는 문자값을 전달받은 경우 에러 발생 - 기본패턴 : [RR/MM/DD]
--비교 컬럼의 자료형이 날짜형인 경우 비교값이 문자값이면 TO_DATE 함수를 사용하여 문자값을 날짜값으로 
--변환하여 반환받아 비교 가능 - 강제 형변환
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('82/01/23');
--비교 컬럼의 자료형이 날짜형인 경우 비교값이 문자값이면 자동으로 날짜값으로 변환되어 비교 - 자동 형변환
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='82/01/23';

--날짜값은 [RR/MM/DD] 패턴을 기본으로 사용하지만 [YYYY-MM-DD] 패턴도 사용 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='1982-01-23';

--패턴에 맞지 않는 문자값을 사용할 경우 에러 발생
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='01-23-1982';--에러 발생
--TO_DATE 함수에 패턴문자를 사용하여 원하는 패턴의 문자값을 전달받아 날짜값으로 변환 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('01-23-1982','MM-DD-YYYY');

--2000년 1월 1일에 태어난 사람이 오늘까지 살아온 날짜를 검색
SELECT SYSDATE-'2000-01-01' FROM DUAL;--에러 발생 : 날짜값이 아닌 문자값의 연산 처리
SELECT SYSDATE-TO_DATE('2000-01-01') FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('2000-01-01'))||'일' "오늘까지 살아온 날짜`" FROM DUAL;

--TO_CHAR({숫자값|날짜값},패턴문자) : 숫자값 또는 날짜값을 전달받아 원하는 패턴의 문자값으로 변환하여 반환하는 함수

--날짜패턴문자 : RR(년),YYYY(년),MM(월),DD(일),HH24(시간),HH12(시간),MI(분),SS(초)
SELECT SYSDATE,TO_CHAR(SYSDATE,'YYYY-MM-DD'),TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP 테이블에서 1981년에 입사한 사원의 사원번호,사원이름,입사일 검색
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE BETWEEN '81/01/01'  AND '81/12/31';
--현재 접속된 사용자 환경(세션)의 날짜와 시간의 기본패턴이 [RR/MM/DD/]인 경우에만 검색 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';
--TO_CHAR 함수를 사용하여 날짜값을 원하는 패턴의 문자값으로 변환하여 반환받아 비교 처리
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY')='1981'; 

--숫자패턴문자 : 9(숫자 또는 공백), 0(숫자), L(화폐단위), $(달러)
SELECT 1000000000,TO_CHAR(1000000000,'9,999,999,990') FROM DUAL;
--매개변수로 전달받은 숫자값의 길이가 패턴문자의 길이보다 큰 경우 모든 패턴문자가 [#]으로 변환되어 반환
SELECT 1000000000000,TO_CHAR(1000000000000,'9,999,999,990') FROM DUAL;

--EMP 테이블에서 사원번호가 7844인 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'L99,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'$99,990.00') SAL FROM EMP WHERE EMPNO=7844;

--일반함수 : 매개변수로 전달받은 값이 특정 조건에 참(TRUE)인 경우 변경값으로 변환하여 반환하는 함수

--NVL(전달값,변경값) : 전달값이 NULL인 경우 변경값으로 변환하여 반환하는 함수
--변경값은 전달값과 동일한 자료형의 값으로만 변경 가능 - 다른 자료형의 값으로 변경할 경우 에러 발생

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,연봉(급여*12) 검색
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,연봉((급여+성과급)*12) 검색
--성과급이 NULL인 경우 연산이 불가능하므로 NULL 결과값 검색
SELECT EMPNO,ENAME,(SAL+COMM)*12 ANNUAL FROM EMP;--검색 오류
--NVL 함수를 사용하여 성과급이 NULL인경우 0으로 변환하여 연산 처리
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(전달값,변경값1,변경값2) : 전달값이 NULL이 아닌 경우 변경값1로 변환하여 반환하고 NULL인 경우 
--변경값2으로 변환하여 반환하는 함수
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO,ENAME,NVL2(COMM,(SAL+COMM)*12,SAL*12) ANNUAL FROM EMP;

--DECODE(전달값,비교값1,변경값1,비교값2,변경값,...[,기본값]) : 전달값을 비교값과 차례대로 비교하여
--같은 경우 변경값으로 변환하여 반환하는 함수
--비교값이 모두 다른 경우 기본값으로 변환하여 반환 - 기본값이 생략된 경우 NULL 반환

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,업무,급여,업무별 실급여 검색
--업무별 실급여 : 사원의 업무를 구분하여 실제로 지불된 급여
SELECT DISTINCT JOB FROM EMP;
--ANALYST:급여*1.1, CLERK:급여*1.2, MANAGER:급여*1.3, PRESIDENT:급여*1.4, SALESMAN:급여*1.5
SELECT EMPNO,ENAME,JOB,SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2
    ,'MANAGER',SAL*1.3,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "업무별 실급여" FROM EMP;
    
--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,업무별 급여 검색 - 해당 업무가 아닌 경우에는 NULL 검색
SELECT EMPNO,ENAME,DECODE(JOB,'ANALIST',SAL) "ANALIST",DECODE(JOB,'CLERK',SAL) "CLERK"
    ,DECODE(JOB,'MANAGER',SAL) "MANAGER",DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT"
    ,DECODE(JOB,'SALESMAN',SAL) "SALESMAN" FROM EMP;

--문제1. 사원테이블에서 입사일이 12월인 사원의 사번, 사원명, 입사일 검색하시오.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '%/12/%';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '__/12/__';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';

--문제2.다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "급여" FROM EMP;

--문제3.다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "입사일" FROM EMP;

--그룹함수 : 매개변수로 다수의 값을 전달받아 가공하여 결과값을 반환하는 함수

--COUNT(컬럼명) : 매개변수로 전달받은 컬럼값의 갯수를 반환하는 함수 - 검색행의 갯수 반환
SELECT COUNT(EMPNO) FROM EMP;

--그룹함수를 다른 검색대상과 같이 사용할 경우 그룹함수와 검색대상에 검색행의 갯수가 서로 다르므로 에러 발생
SELECT EMPNO,COUNT(EMPNO) FROM EMP;--에러 발생

--그룹함수는 NULL을 값으로 처리하지 않는 결과값 반환
SELECT COUNT(EMPNO),COUNT(COMM) FROM EMP;

--COUNT 함수는 컬럼명 대신 [*] 기호를 사용하여 모든 컬럼을 표현하여 테이블에 저장된 행의 갯수 반환
SELECT COUNT(*) FROM EMP;

--MAX(컬럼명) : 매개변수로 전달받은 컬럼값 중 최대값을 반환하는 함수
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP;
SELECT MAX(HIREDATE) FROM EMP;

--MIN(컬럼명) : 매개변수로 전달받은 컬럼값 중 최소값을 반환하는 함수
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP;

--SUM(컬럼명) : 매개변수로 전달받은 컬럼값(숫자값)의 합계를 계산하여 반환하는 함수
SELECT SUM(SAL) FROM EMP;

--AVG(컬럼명) : 매개변수로 전달받은 컬럼값(숫자값)의 평균을 계산하여 반환하는 함수
SELECT AVG(SAL) FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP 테이블에 저장된 모든 사원의 평균 성과급을 계산하여 검색
SELECT AVG(COMM) FROM EMP;--검색 오류 : 성과급이 NULL이 아닌 사원의 평균 성과급 계산
--NVL 함수를 사용하여 성과급이 NULL인 경우 0으로 반환받아 평균 성과급 계산
SELECT AVG(NVL(COMM,0)) FROM EMP;--모든 사원의 평균 성과급 계산
SELECT CEIL(AVG(NVL(COMM,0))) "평균 성과급" FROM EMP;--모든 사원의 평균 성과급 계산

--EMP 테이블에 저장된 모든 사원에 대한 인원수 검색
SELECT COUNT(*) FROM EMP;
--EMP 테이블에 저장된 모든 사원을 부서로 구분하여 인원수 검색
SELECT DISTINCT DEPTNO FROM EMP;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;

--GROUP BY : 그룹함수 사용시 컬럼값으로 그룹을 여러개 구분하여 검색하는 기능
--컬럼값이 같은 경우 같은 그룹으로 처리하여 그룹함수의 결과값 반환
--형식)SELECT 그룹함수(컬럼명)[,검색대상,...] FROM 테이블명 [WHERE 조건식]
--    GROUP BY {컬럼명|연산식|함수},{컬럼명|연산식|함수},...
--    [ORDER BY {컬럼명|연산식|별칭|COLUMN_INDEX} {ASC|DESC},...]

--EMP 테이블에 저장된 모든 사원을 부서로 구분하여 인원수 검색
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;

--GROUP BY에서 사용한 표현식(컬럼명|연산식|함수)은 그룹함수와 같이 검색대상으로 검색 가능
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY의 표현식으로 컬럼의 별칭 사용 불가능
SELECT DEPTNO DNO,COUNT(*) FROM EMP GROUP BY DNO;--에러 발생

--EMP 테이블에 저장된 모든 사원의 업무별 평균 급여를 계산하여 검색
SELECT JOB,AVG(SAL) FROM EMP GROUP BY JOB;
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB;

--EMP 테이블에서 업무가 PRESIDENT인 사원을 제외한 모든 사원의 업무별 평균 급여를 평균 급여로 내림차순 정렬하여 검색 
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' 
    GROUP BY JOB ORDER BY AVG_SAL DESC;
    
--HAVING : GROUP BY에 의해 그룹화된 검색결과에서 그룹조건이 참(TRUE)인 행인 그룹만 검색하는 기능 제공    
--형식)SELECT 그룹함수(컬럼명)[,검색대상,...] FROM 테이블명 [WHERE 조건식]
--    GROUP BY {컬럼명|연산식|함수},{컬럼명|연산식|함수},... HAVING 그룹조건식
--    [ORDER BY {컬럼명|연산식|별칭|COLUMN_INDEX} {ASC|DESC},...]

--EMP 테이블에서 업무가 PRESIDENT인 사원을 제외한 모든 사원의 업무별 평균 급여를 평균 급여로 내림차순 정렬하여 검색 
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP
    GROUP BY JOB HAVING JOB<>'PRESIDENT' ORDER BY AVG_SAL DESC;

--EMP 테이블에 저장된 모든 사원의 부서별 급여 합계 중 급여 합계가 9000 이상인 부서번호와 급여 합계 검색
SELECT DEPTNO,SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--문제1.사원테이블에서 부서별 인원수가 6명 이상인 부서코드 검색
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6;

--문제2.사원테이블로부터 부서번호,업무별 급여합계를 계산하고자 한다. 다음과 같은 결과를 출력할 수 있는 SQL문장 작성
SELECT DEPTNO,SUM(DECODE(JOB,'CLERK',SAL)) "CLERK",SUM(DECODE(JOB,'MANAGER',SAL)) "MANAGER"
    ,SUM(DECODE(JOB,'PRESIDENT',SAL)) "PRESIDENT",SUM(DECODE(JOB,'ANALYST',SAL)) "ANALYST"
    ,SUM(DECODE(JOB,'SALESMAN',SAL)) "SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
    
--문제3.사원테이블로부터 년도별, 월별 급여합계를 출력할 수 있는 SQL문장 작성
SELECT TO_CHAR(HIREDATE,'YYYY') 년, TO_CHAR(HIREDATE,'MM') 월, SUM(SAL) FROM EMP
    GROUP BY TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY 년,월;

--문제4.사원테이블에서 부서별 comm(커미션)을 포함하지 않은 연봉의 합과 포함한 연봉의 합을 구하는 SQL을 작성하시오.    
SELECT DEPTNO,SUM(SAL*12) "연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT DEPTNO,SUM((SAL+NVL(COMM,0))*12) "연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--문제5.사원테이블에서 SALESMAN을 제외한 JOB별 급여 합계 검색
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB<>'SALESMAN' GROUP BY JOB;
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--JOIN : 두개이상의 테이블에서 행을 결합하여 원하는 컬럼값을 검색하기 위한 기능

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--DEPT 테이블에 저장된 모든 부서의 부서번호,부서이름,부서위치 검색
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
--두개이상의 테이블에서 컬럼값을 검색하기 위해서는 반드시 검색행을 결합하기 위한 조건을 제공하여 검색
--카다시안 프로덕트(CATSIAN PRODUCT) : 두개이상의 테이블을 결합조건 없이 검색한 경우 발생되는 검색 결과
--결합조건 없이 검색한 경우 두개이상의 테이블에 저장된 모든 행을 교차 결합하여 검색 결과 제공
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT;

--동등조인(EQUI JOIN) : 두개이상의 테이블에서 결합조건에 = 연산자를 사용하여 참(TRUE)인 행만 결합하여 검색
--결합조건 : EMP 테이블의 부서번호(DEPTNO)와 DEPT 테이블의 부서번호(DEPTNO)가 같은 행만 결합
--결합조건은 WHERE의 조건식을 사용하여 결합
--두개이상의 테이블에 같은 이름의 컬럼이 존재하는 경우 반드시 [테이블명.컬럼명] 형식으로 구분하여 표현
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서번호,부서이름,부서위치 검색
--결합조건 : EMP 테이블의 부서번호(DEPTNO)와 DEPT 테이블의 부서번호(DEPTNO)가 같은 행만 결합
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--결합 테이블에 같은 이름의 컬럼을 동시에 검색할 경우 첫번째로 검색되는 컬럼을 제외한 나머지 컬럼의 이름은
--자동으로 변경되어 검색
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--결합 테이블에 같은 이름의 컬럼을 동시에 검색할 경우 컬럼 별칭을 사용하여 검색하는 것을 권장
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO EMP_DEPTNO,DEPT.DEPTNO DEPT_DEPTNO,DNAME,LOC 
    FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
    
--TABLE ALIAS : 테이블에 일시적으로 새로운 이름을 부여하여 사용하는 기능 - 테이블 별칭
--형식)SELECT 검색대상,... FROM 테이블명 별칭, 테이블명 별칭,...
--테이블 결합시 테이블의 이름을 간단하게 표현하기 위해 사용하거나 하나의 테이블을 다수의 테이블로 표현하기 위해 사용
SELECT EMPNO,ENAME,SAL,E.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--테이블 별칭 설정 후 기존 테이블명을 사용하면 에러 발생
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--에러 발생