--�޼����� ����� �� �ִ� ������ ȯ�溯�� ������ ����
SET SERVEROUT ON;

--CASE : ������ ����� ���� ���Ͽ� ����� ���� �����ϰų� ���ǽ��� ����Ͽ� ����� ���� �����ϴ� ����
--����)CASE ������ WHEN �񱳰�1 THEN ���;���;... WHEN �񱳰�2 THEN ���;���;... END CASE;

--EMP ���̺��� �����ȣ�� 7788�� ��������� �˻��Ͽ� �����ȣ,����̸�,����,�޿�,������ �Ǳ޿��� �˻��Ͽ� ����ϴ� PL/SQL �ۼ�
--������ �Ǳ޿� - ANALYST:�޿�*1.1, CLERK:�޿�*1.2, MANAGER:�޿�*1.3, PRESIDENT:�޿�*1.4, SALESMAN:�޿�*1.5
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('������ �Ǳ޿� = '||VPAY);
END;
/
    
--����)CASE WHEN ���ǽ�1 THEN ���;���;... WHEN ���ǽ�2 THEN ���;���;... END CASE;

--EMP ���̺��� �����ȣ�� 7788�� ��������� �˻��Ͽ� �����ȣ,����̸�,�޿�,�޿������ ����Ͽ� ����ϴ� PL/SQL �ۼ�
--�޿���� - E : 0~1000, D : 1001~2000, C : 2001~3000, B : 3001~4000, A : 4001~5000
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

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('�޿���� = '||VGRADE);
END;
/

--�ݺ��� : ����� �ݺ� �����ϱ� ���� ����

--BASIC LOOP : ���ѹݺ� - ���ù��� ����Ͽ� ���ǽ��� ���� ��� EXIT ������� �ݺ��� ����
--����)LOOP ���; ���; ... END LOOP;

--1~5 ������ ���ڰ��� ����ϴ� PL/SQL �ۼ�
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

--FOR LOOP : �ݺ��� Ƚ���� ������ �ִ� ��� ����ϴ� �ݺ���
--����)FOR INDEX_COUNTER IN [REVERSE] LOWER_BOUND..HIGH_BOUND LOOP ���; ���; ... END LOOP;

--1~10 ������ �������� ���� �հ踦 ����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    TOT NUMBER(2) := 0;
BEGIN
    /* FOR LOOP �������� �����Ǵ� ����(INDEX_COUNTER)�� FOR LOOP ���������� ��� ���� */
    FOR I IN 1..10 LOOP
        TOT := TOT + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10 ������ �������� �հ� = '||TOT);
END;
/
    
--FOR LOOP ������ ����Ͽ� ���̺��� ���� �˻��࿡ ���� �ݺ� ó�� ���� - ������ Ŀ��(CURSOR)�� ����Ͽ� �ݺ� ó��    
--����)FOR RECORD_VARIABLE IN (SELECT �˻����,�˻����,... FROM ���̺�� [WHERE ���ǽ�]) LOOP ���;... END LOOP;

--EMP ���̺� ����� ��� ��������� �˻��Ͽ� �����ȣ,����̸��� ����ϴ� PL/SQL �ۼ�
BEGIN
    FOR VEMP IN (SELECT * FROM EMP) LOOP
        DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO||', ����̸� = '||VEMP.ENAME);
    END LOOP;
END;
/
    
--Ŀ��(CURSOR) : ���̺��� �˻����� �����Ͽ� ó���ϱ� ���� ����� ����
--1.������ Ŀ�� : �˻������ �������� ��츦 ó���ϱ� ���� Ŀ��
--2.����� Ŀ�� : �˻������ �������� ��츦 ó���ϱ� ���� Ŀ�� 

--����� Ŀ���� ���� ��� �� ��� - Ŀ���� ����ο��� �����Ͽ� ����ο��� OPEN,FATCH,CLOSE ������� Ŀ�� ���
--����)DECLARE
--        /* Ŀ���� �����Ͽ� Ŀ���� �˻����(������) ���� */    
--        CURSOR Ŀ���� IS SELECT �˻����,�˻����,... FROM ���̺�� [WHERE ���ǽ�];
--    BEGIN
--        OPEN Ŀ����;/* Ŀ�� ���� - ù��° �˻����� �����ޱ� ���� Ŀ���� ��ġ �̵� */
--        FETCH Ŀ���� INTO ������,������,...;/* Ŀ�� ��ġ�� �˻����� �����޾� ������ ���� - Ŀ���� ���������� �̵� */
--        CLOSE Ŀ����;/* Ŀ�� �ݱ� - Ŀ���� ���̻� ������� �ʵ��� ���� */
--    END;

--EMP ���̺� ����� ��� ��������� �˻��Ͽ� �����ȣ,����̸��� ����ϴ� PL/SQL �ۼ� - Ŀ�� �̿�
DECLARE
    CURSOR C IS SELECT * FROM EMP;
    VEMP EMP%ROWTYPE;
BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VEMP;/* Ŀ�� ��ġ�� �˻����� ���ڵ� ������ ���� */
        EXIT WHEN C%NOTFOUND;/* Ŀ�� ��ġ�� �˻����� ���� ��� �ݺ��� ���� */
        DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO||', ����̸� = '||VEMP.ENAME);
    END LOOP;
    
    CLOSE C;
END;
/
        
--WHILE LOOP : �ݺ��� Ƚ���� ����Ȯ�� ��� ����ϴ� �ݺ���
--����)WHILE ���ǽ� LOOP ���; ���; ... END LOOP;

--1~10 ������ �������� ���� �հ踦 ����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    I NUMBER(2) := 1;
    TOT NUMBER(2) := 0;
BEGIN
    WHILE I <= 10 LOOP
        TOT := TOT + I;
        I := I + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~10 ������ �������� �հ� = '||TOT);
END;
/
    
--���� ���ν���(STORED PROCEDURE) : PL/SQL ���ν����� �̸��� �ο��Ͽ� �����ϰ� �ʿ��� ��� ȣ���Ͽ� ���    
        
--���� ���ν��� ����
--����)CREATE [OR REPLACE] PROCEDURE ���ν�����[(�Ű����� [MODE] �ڷ���,�Ű����� [MODE] �ڷ���,...)] 
--     IS [���������] BEGIN ���; ���; ... END;

--EMP_COPY ���̺� ����� ��� ��������� �����ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE DELETE_ALL_EMP_COPY IS
BEGIN
    DELETE FROM EMP_COPY;
    COMMIT;
END;
/

--���� ���ν��� Ȯ�� - USER_SOURCE : ���� ���ν����� ���� �Լ� ������ �����ϴ� ��ųʸ�
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--���� ���ν��� ȣ�� - ���� ���ν����� �ۼ��� PL/SQL ����
--����)EXECUTE ���ν�����[({����|��},{����|��},...)]

--DELETE_ALL_EMP_COPY ���� ���ν��� ȣ��
SELECT * FROM EMP_COPY;
EXECUTE DELETE_ALL_EMP_COPY;
SELECT * FROM EMP_COPY;

--���� ���ν��� ������ �߻��� ������ ������ ������ �α׸� �̿��Ͽ� Ȯ�� ����
SHOW ERROR;

--���� ���ν��� ����
--����)DROP PROCEDURE ���ν�����

--DELETE_ALL_EMP_COPY ���� ���ν��� ����
DROP PROCEDURE DELETE_ALL_EMP_COPY;
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='DELETE_ALL_EMP_COPY';

--���� ���ν����� �Ű����� ���(MODE)
--1.IN : ���� ���ν��� ȣ��� �ܺηκ��� ���� ���޹޾� ���� ���ν����� PL/SQL ��ɿ��� ����� ������ �Ű������� ������ �� ��� 
--2.OUT : ���� ���ν��� ȣ��� ���ε� ������ ���޹޾� ���� ���ν����� PL/SQL ���� ����� �����Ͽ� �ܺο� ������� ������
--������ �Ű������� ������ �� ���
--3.INOUT : ���� ���ν��� ȣ��� ���ε� ������ ���޹޾� ���� ���ν����� PL/SQL ��ɿ��� ����ϰų� ���� ����� �����Ͽ�
--�ܺο� ������� ������ ������ �Ű������� ������ �� ���

--�����ȣ�� �Ű������� ���޹޾� EMP ���̺��� ���޹��� �����ȣ�� ��������� �˻��Ͽ� ����̸�,����,�޿��� �Ű�������
--�����Ͽ� �ܺη� �����ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE, VENAME OUT EMP.ENAME%TYPE
    ,VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS
BEGIN   
    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO=VEMPNO;
END;
/

--OUT ����� �Ű������� ���� �����޴� ���� �����ϱ� ���� ���ε� ���� ����
--����)VARIABLE ���ε������� �ڷ���
--���ε� ���� : ���� ���� ������� ���ǿ����� ����� �� �ִ� �ý��� ����
--�ټ��� ���� ���ν������� �ʿ��� ���� �����ϰų� ���޹ޱ� ���� ���
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

--SELECT_EMPNO ���� ���ν��� ȣ�� - IN ����� �Ű������� ���� �����ϰ� OUT ����� �Ű������� ���ε� ������ �����Ͽ� ȣ��
--OUT ����� �Ű������� ���ε� ������ �����Ͽ� ���� �����ϱ� ���ؼ��� �ݵ�� ���ε� ���� �տ� :�� �ٿ��� ���
EXECUTE SELECT_EMPNO(7788,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

--���ε� ������ ����� �� ���
--����)PRINT ���ε�������
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;

--���� �Լ�(STORED FUNCTION) : ���� ���ν����� ������ ����� ���������� �ݵ�� �ϳ��� ����� ��ȯ
    
--���� �Լ� ����
--����)CREATE [OR REPLACE] FUNCTION �����Լ���[(�Ű����� [MODE] �ڷ���,�Ű����� [MODE] �ڷ���,...)] 
--     RETURN �ڷ��� IS [���������] BEGIN ���; ���; ... RETURN ��ȯ��; END;

--�����ȣ�� �Ű������� ���޹޾� EMP ���̺��� ���޹޾� �����ȣ�� ��������� �˻��Ͽ� �޿��� 2�迡 �ش��ϴ�
--������� ��ȯ�ϴ� ���� �Լ� ����
CREATE OR REPLACE FUNCTION CAL_SAL(VEMPNO IN EMP.EMPNO%TYPE) RETURN NUMBER IS
    VSAL NUMBER(7,2);
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO=VEMPNO;
    RETURN ( VSAL * 2 );
END;
/

--���� �Լ� Ȯ�� - USER_SOURCE  ��ųʸ�
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='CAL_SAL';

--���� �Լ��� ��ȯ���� �����ϱ� ���� ���ε� ���� ����
VARIABLE VAR_SAL NUMBER;

--���� �Լ� ȣ�� - ���� �Լ��� ��ȯ���� ���ε� ������ ����
EXECUTE :VAR_SAL := CAL_SAL(7788);

--���ε� ������ ���
PRINT VAR_SAL;

--���� �Լ��� ����Ŭ �Լ�ó�� SQL ��ɿ� ���ԵǾ� ��� ����
SELECT EMPNO,ENAME,SAL,CAL_SAL(EMPNO) "Ư������" FROM EMP;

--���� �Լ� ����
--����)DROP FUNCTION �����Լ���

--CAL_SAL  ���� �Լ� ����
DROP FUNCTION CAL_SAL;
SELECT NAME,TEXT FROM USER_SOURCE WHERE NAME='CAL_SAL';

--Ʈ����(TRIGGER) : Ư�� ���̺��� SQL ���(DML)�� ����� ��� PL/SQL ���ν����� ����� �����ϴ� ���

--Ʈ���� ����
--����)CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� {AFTER|BEFORE} {INSERT|UPDATE|DELETE} ON ���̺��
--     [FOR EACH ROW] [WITH ���ǽ�] BEGIN ���; ���; ... END;
--FOR EACH ROW : ������ ��� ���� ���� Ʈ���Ÿ� �����ϰ� ������ ��� �� ���� Ʈ���ŷ� ����
--���� ���� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���ſ� �ۼ��� PL/SQL ���ν����� ����� �ѹ��� ����
--�� ���� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���ſ� �ۼ��� PL/SQL ���ν����� ����� ���� ������ŭ ����
--Ʈ���ſ� ��ϵ� PL/SQL ���ν����� ������� TCL ���(COMMIT �Ǵ� ROLLBACK) ��� �Ұ���

--EMP_COPY2 ���̺� ��������� ���Ե� ��� �޼����� ����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER EMP_COPY2_INSERT_TRIGGER AFTER INSERT ON EMP_COPY2
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ο� ����� �Ի� �Ͽ����ϴ�.');
END;
/

--Ʈ���� Ȯ�� - USER_TRIGGERS : Ʈ���� ������ �����ϴ� ��ųʸ�
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_COPY2 ���̺� �� ����
SELECT * FROM EMP_COPY2;
INSERT INTO EMP_COPY2 VALUES(1111,'ȫ�浿',4000);
SELECT * FROM EMP_COPY2;
COMMIT;

--Ʈ���� ����
--����)DROP TRIGGER Ʈ���Ÿ�

--EMP_COPY2_INSERT_TRIGGER Ʈ���� ����
DROP TRIGGER EMP_COPY2_INSERT_TRIGGER;
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_TRI ���̺��� �����Ͽ� �˻��� ����
CREATE TABLE EMP_TRI AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;
SELECT * FROM EMP_TRI;

--EMP_HIS ���̺� ���� - �����ȣ(������),����̸�(������),�������(������)
CREATE TABLE EMP_HIS(NO NUMBER(4),NAME VARCHAR2(20),STATUS VARCHAR2(50));

--EMP_TRI ���̺��� ���� �����ϰų� ���� �Ǵ� ������ ��� DML ��� ���� �� ����,����,������ ���� ������
--EMP_HIS ���̺� ������ �����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER EMP_HIS_TRIGGER AFTER INSERT OR UPDATE OR DELETE ON EMP_TRI FOR EACH ROW
BEGIN
    /* :NEW.�÷��� : �̺�Ʈ�� �߻��� ���̺��� ���� �Ǵ� ���� ��ɿ��� ���� ���ο� ���� �÷��� ǥ��  */
    /* :OLD.�÷��� : �̺�Ʈ�� �߻��� ���̺��� ���� �Ǵ� ���� ��ɿ��� ���� ���� ���� �÷��� ǥ��  */
    IF INSERTING THEN /* INSERT ����� ����� ��� */
        INSERT INTO EMP_HIS VALUES(:NEW.EMPNO, :NEW.ENAME, '�Ի�');
    ELSIF UPDATING THEN  /* UPDATE ����� ����� ��� */
        IF :NEW.DEPTNO <> :OLD.DEPTNO THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '�μ��̵�');
        ELSIF :NEW.SAL <> :OLD.SAL THEN
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '�޿�����');
        ELSE    
            INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '���λ���');
        END IF;            
    ELSIF DELETING THEN   /* DELETE ����� ����� ��� */
        INSERT INTO EMP_HIS VALUES(:OLD.EMPNO, :OLD.ENAME, '���');
    END IF;
END;
/

--Ʈ���� Ȯ��
SELECT TRIGGER_NAME,TRIGGER_TYPE,TRIGGERING_EVENT,TABLE_NAME FROM USER_TRIGGERS;

--EMP_TRI ���̺� �� ���� - EMP_HIS_TRIGGER Ʈ���ſ� ���� EMP_HIS ���̺��� �� ����
SELECT * FROM EMP_TRI;
INSERT INTO EMP_TRI VALUES(5000,'PARK',2000,10);
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI ���̺� ����� ���� �÷��� ���� - EMP_HIS_TRIGGER Ʈ���ſ� ���� EMP_HIS ���̺��� �� ����
UPDATE EMP_TRI SET DEPTNO=20 WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET SAL=3000 WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
UPDATE EMP_TRI SET ENAME='ȫ�浿' WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;

--EMP_TRI ���̺� ����� �� ���� - EMP_HIS_TRIGGER Ʈ���ſ� ���� EMP_HIS ���̺��� �� ����
DELETE FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_TRI WHERE EMPNO=5000;
SELECT * FROM EMP_HIS;
COMMIT;