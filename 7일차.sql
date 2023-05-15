--�ε���(INDEX) : ���̺� ����� ���� ���� ������ �˻��ϱ� ���� ����� �����ϴ� ��ü
--�÷��� �ε����� �����ϸ� �ε��� ������ �����Ͽ� �˻� ���� ������ ������ �÷��� ���� �� �˻� �ӵ� ����
--���ǽĿ��� ���� ����ϴ� �÷��� �ε����� �����ϸ� ���� ���� �� �ε����� �����ϴ� ���� ȿ����

--����ũ �ε���(UNIQUE INDEX) : PRIMARY KEY ���������̳� UNIQUE �������ǿ� ���� �ڵ� �����Ǵ� �ε���
--������ũ �ε���(NON-UNIQUE INDEX) : ����ڰ� �÷��� �������� �ε��� �����Ͽ� �����ϴ� �ε���

--USER3 ���̺� ���� - ȸ����ȣ(������-PRIMARY KEY),ȸ���̸�(������),�̸���(������-UNIQUE)
CREATE TABLE USER3(NO NUMBER(4) CONSTRAINT USER3_NO_PK PRIMARY KEY
    ,NAME VARCHAR2(20),EMAIL VARCHAR2(50) CONSTRAINT USER3_EMAIL_UK UNIQUE);
    
--USER3 ���̺��� �������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 ���̺��� �ε��� Ȯ�� - USER_INDEXES : �ε��� ������ �����ϴ� ��ųʸ�, USER_IND_COLUMNS : �÷��� ������ �ε��� ������ �����ϴ� ��ųʸ�
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';
    
--�ε��� ���� - ������ũ �ε���(NON-UNIQUE INDEX)
--����)CREATE INDEX �ε����� ON ���̺��(�÷���)

-- �ε����� �����Ͽ� USER3 ���̺��� NAME �÷��� ����
CREATE INDEX USER3_NAME_INDEX ON USER3(NAME);

--USER3 ���̺��� �ε��� Ȯ��
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--�ε��� ���� - ������ũ �ε���(NON-UNIQUE INDEX)
--����)DROP INDEX �ε�����

--USER3 ���̺��� NAME �÷��� ������ �ε��� ����
DROP INDEX USER3_NAME_INDEX;
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--USER3 ���̺��� EMAIL �÷��� ������ �ε��� ����
DROP INDEX USER3_EMAIL_UK;--����ũ �ε����� ������ ��� ���� �߻�
--����ũ �ε����� PRIMARY KEY ���������̳� UNIQUE ���������� �����ϸ� ���� ���� ó��
ALTER TABLE USER3 DROP CONSTRAINT USER3_EMAIL_UK;--�������� ����
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS FROM USER_INDEXES I JOIN USER_IND_COLUMNS C
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3';

--���Ǿ�(SYNONYM) : ����Ŭ ��ü�� �ٸ� �̸��� �ο��Ͽ� ����ϱ� ���� ��ü
--���� ���Ǿ� : Ư�� ����ڸ� ����� �� �ִ� ���Ǿ� - �Ϲ� ����ڿ� ���� ����
--���� ���Ǿ� : ��� ����ڰ� ����� �� �ִ� ���Ǿ� - �����ڿ� ���� ����

--���Ǿ� ����
--����)CREATE [PUBLIC] SYNONYM ���Ǿ� FOR ��ü��
--PUBLIC : ���� ���Ǿ �����ϱ� ���� Ű����

--���̺� ��� - USER_TABLES ��ųʸ� �̿��Ͽ� �˻�
--USER_TABLES ��ųʸ� : SYS ������ ���� ������ ��
--�ٸ� ����ڿ� ���� ������ ���̺� �Ǵ� �信 �����ϴ� ��� - ����� ��Ű���� �̿��Ͽ� ����
--����)����ڸ�.���̺�� �Ǵ� ����ڸ�.���
SELECT TABLE_NAME FROM SYS.USER_TABLES;
--SYS.USER_TABLES ��ü�� ���� ���Ǿ�� USER_TABLES�� ����
SELECT TABLE_NAME FROM USER_TABLES;
--SYS.USER_TABLES ��ü�� ���� ���Ǿ�� TABS�� ����
SELECT TABLE_NAME FROM TABS;

--COMM ���̺� ���� ���� ���Ǿ�� BONUS ����
SELECT * FROM COMM;
SELECT * FROM BONUS;--���̺� �Ǵ� �䰡 �����Ƿ� ���� �߻�
--CREATE SYNONYM �ý��� ������ �����Ƿ� CREATE SYNONYM ����� �����ϸ� ���� �߻�
CREATE SYNONYM BONUS FOR COMM;--������ ������Ͽ� ���� �߻�

--�ý��� ������(SYSDBA - SYS ����)�� �����Ͽ� ���� ���� �����(SCOTT ����)���� CREATE SYNONYM �ý��� ������ �ο�
--GRANT CREATE SYNONYM TO SCOTT;

--�ý��� �����ڿ��� CREATE SYNONYM �ý��� ������ �ο� ���� �� CREATE SYNONYM ��� ����
CREATE SYNONYM BONUS FOR COMM;
SELECT * FROM BONUS;

--COMM ���̺� ���� ���Ǿ� Ȯ�� - USER_SYNONYMS : ���Ǿ� ������ �����ϴ� ��ųʸ�
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--���Ǿ� ����
--����)DROP [PUBLIC] SYNONYM ���Ǿ�

--COMM ���̺��� ���� ���Ǿ� BONUS ����
DROP SYNONYM BONUS;
SELECT * FROM COMM;
SELECT * FROM BONUS;--���̺� �Ǵ� �䰡 �����Ƿ� ���� �߻�
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--�����(USER) : �ý���(DBMS)�� ����� �� �ִ� ��ü - ����(ACCOUNT) : ������ ���� �����
--���� ������ �ý��� ������(SYSDBA - SYS ����)�� ����

--���� ����
--����)CREATE USER ������ IDENTIFIED BY ��й�ȣ

--KIM ���� ����
--����Ŭ 12C ���� �̻󿡼��� ������ �����ϱ� ���� ���ǿ� ���� ȯ�漳�� ����
--ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
--CREATE USER KIM IDENTIFIED BY 1234;

--���� Ȯ�� - DBA_USERS : ����� ������ �����ϴ� ��ųʸ�
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--������ ��й�ȣ ���� - ������ ��й�ȣ�� �⺻������ 180���� ��ȿ�Ⱓ���� ����
--����)ALTER USER ������ IDENTIFIED BY ��й�ȣ

--KIM ������ ��й�ȣ ����
--ALTER USER KIM IDENTIFIED BY 5678;

--���� ���� ���� - OPEN(���� Ȱ��ȭ - DBSM ���� ���� ����), LOCK(���� ��Ȱ��ȭ - DBSM ���� ���� �Ұ���)
--����Ŭ ���� ���ӽ� ������ ��й�ȣ�� 5�� Ʋ���� ������ ���°� �ڵ����� LOCK ���·� ����
--����)ALTER USER ������ ACCOUNT {LOCK|UNLOCK}

--KIM ������ ���¸� LOCK ���·� ����
--ALTER USER KIM ACCOUNT LOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--KIM ������ ���¸� OPEN ���·� ����
--ALTER USER KIM ACCOUNT UNLOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--������ ���̺����̽� ����
--���̺����̽�(TABLESPACE) : ����Ÿ���̽� ��ü(���̺�,��,������,�ε��� ��)�� ����Ǵ� ���
--����Ŭ XE������ �⺻������ SYSTEM ���̺����̽��� USERS ���̺����̽� ����
--����)ALTER USER ������ DEFAULT TABLESPACE ���̺����̽���

--KIM ������ ���̺����̽��� USERS�� ����
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--���̺����̽��� ���� ������ ��� ������ ������ ����ũ�� ���� - �뷮 ����
--����)ALTER USER ������ QUOTA ����ũ�� ON ���̺����̽�

--KIM ������ ������ ����ũ�⸦ ���������� ����
--ALTER USER KIM QUOTA UNLIMITED ON USERS;
--������ ������ ����ũ�� Ȯ�� - DBA_TS_QUOTAS : ���̺����̽��� ������ ����ũ�� ���� ���� ������ �����ϴ� ��ųʸ�
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS;

--KIM ������ ������ ����ũ�⸦ 20MBYTE�� ����
--ALTER USER KIM QUOTA 20M ON USERS;
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS;

--���� ����
--����)DROP USER ����ڸ�

--KIM ���� ����
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--DROP USER KIM;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--DCL(DATA CONTROL LANGUAGE) - ����Ÿ �����
--�������� ������ �ο��ϰų� ȸ���ϴ� SQL ���
--����Ŭ ����(ORACLE PRIVILEGE) : �ý��� ����(������)�� ��ü ����(�Ϲ� �����)���� ����

--�ý��� ���� : �ý����� �����ϴ� ��ü�� �����ϱ� ���� ���(DDL)�� ���� ��� ����
--�ý��� ������ �������� �ο�
--����)GRANT {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... TO {������|PUBLIC} [WITH ADMIN OPTION] [IDENTIFIED BY ��й�ȣ]
--��(ROLL) : �ý��� ������ �׷�ȭ�Ͽ� ����ϴ� �̸�
--������ ��� PUBLIC Ű���带 ����ϸ� ��� �������� �ϰ������� �ý��� ���� �ο�
--WITH ADMIN OPTION : �ο� ���� �ý��� ������ �ٸ� �������� �ο��ϰų� ȸ���ϴ� ������ �����ϴ� ���
--�ý��� ������ �ο����� ������ ���� ��� �ڵ����� ���� ����
--GRANT ��ɿ� ���� ������ ������ ��� �ݵ�� IDENTIFIED BY Ű���带 ����Ͽ� ��й�ȣ ����

--KIM ���� ����
--CREATE USER KIM IDENTIFIED BY 1234;

--KIM �������� ����Ŭ ������ ���� - SQLPLUS ���
--C:\USERS\USER>SQLPLUS KIM  >>  KIM �������� ����Ŭ ���� ���� - ��й�ȣ �Է�
--CREATE SESSION ������ �����Ƿ� ���� ���� ����

--�ý��� ������(SYSDBA - SYS ����)�� KIM �������� CREATE SESSION �ý��� ���� �ο�
--GRANT CREATE SESSION TO KIM;

--KIM �������� ����Ŭ ������ ���� - SQLPLUS ���
--SQL>CONN KIM  >>  KIM �������� ����Ŭ ���� ���� - ��й�ȣ �Է� : ���� ����

--KIM �������� SAWON ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�޿�(������) : SQLPLUS ���
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);--������ ������Ͽ� ���� �߻�

--�ý��� ������(SYSDBA - SYS ����)�� KIM �������� CREATE TABLE �ý��� ���� �ο�
--GRANT CREATE TABLE TO KIM;

--KIM �������� SAWON ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�޿�(������) : SQLPLUS ���
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);--���̺� ���� ����

--��ü ���� : ����� ��Ű���� �����ϴ� ��ü ���� ���(DQL �Ǵ� DML) ��뿡 ���� ����
--����)GRANT {ALL|PRIVILEGE,PRIVILEGE,...} ON ��ü�� TO ������ [WITH GRANT OPTION]
--��ü ������ INSERT,UPDATE,DELETE,SELECT ���� Ű����� ǥ��
--ALL : ��ü�� ���õ� ��� ��� ��� ���� ǥ��
--WITH GRANT OPTION : �ο����� ��ü ������ �ٸ� �������� �ο��ϰų� ȸ���ϴ� ������ �����ϴ� ���

--SCOTT ����� ��Ű���� �����ϴ� DEPT ���̺� ����� ��� �� �˻�
SELECT * FROM SCOTT.DEPT;
--���� ���� ������� ��Ű���� ��� ����� ��Ű�� ���� ����
SELECT * FROM DEPT;

--KIM �������� SCOTT ����� ��Ű���� �����ϴ� DEPT ���̺� ����� ��� �� �˻� - SQLPLUS �̿�
--C:\Users\user>SQLPLUS KIM
--SQL>SELECT * FROM SCOTT.DEPT;--������ ������� �ʾ� ���� �߻�
--ORA-00942: ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�

--SCOTT ������ KIM �������� DEPT ���̺� ����� ���� �˻��� �� �ִ� ���� �ο�
GRANT SELECT ON DEPT TO KIM;

--KIM �������� SCOTT ����� ��Ű���� �����ϴ� DEPT ���̺� ����� ��� �� �˻� - SQLPLUS �̿�
--SQL>SELECT * FROM SCOTT.DEPT;--�˻� ����

--�ٸ� �������� �ο��� ��ü ���� Ȯ�� - USER_TAB_PRIVS_MADE : �ο��� ��ü ���� ���� ������ �����ϴ� ��ųʸ�
SELECT * FROM USER_TAB_PRIVS_MADE;

--�ٸ� �������� �ο����� ��ü ���� Ȯ�� - USER_TAB_PRIVS_RECD : �ο����� ��ü ���� ���� ������ �����ϴ� ��ųʸ�
SELECT * FROM USER_TAB_PRIVS_RECD;

--��ü ���� ȸ��
--����)REVOKE {ALL|PRIVILEGE,PRIVILEGE,...} ON ��ü�� FROM ������ [WITH GRANT OPTION]

--SCOTT ������ KIM �������� �ο��� DEPT ���̺� ����� ���� �˻��� �� �ִ� ���� ȸ��
REVOKE SELECT ON DEPT FROM KIM;
SELECT * FROM USER_TAB_PRIVS_MADE;

--KIM �������� SCOTT ����� ��Ű���� �����ϴ� DEPT ���̺� ����� ��� �� �˻� - SQLPLUS �̿�
--SQL>SELECT * FROM SCOTT.DEPT;--������ ������� �ʾ� ���� �߻�
--ORA-00942: ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�

--�ý��� ���� ȸ�� - ������ ��� �ý��� ������ ȸ���ص� ���� �̻���
--����)REVOKE {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... FROM {������|PUBLIC} [WITH ADMIN OPTION]

--�����ڰ� KIM �������� �ο��� CREATE SESSION �ý��� ���� ȸ��
--REVOKE CREATE SESSION FROM KIM;

--KIM �������� ����Ŭ ������ ���� - SQLPLUS ���
--C:\USERS\USER>SQLPLUS KIM  >>  KIM �������� ����Ŭ ���� ���� - ��й�ȣ �Է�
--CREATE SESSION ������ �����Ƿ� ���� ���� ����

--��(ROLE) : �����ڰ� ������ �ý��� ������ ȿ�������� �����ϱ� ���� ����ϴ� �ý��� ���� �׷�
--����Ŭ���� �⺻������ �����Ǵ� �� - CONNECT, RESOURCE, DBA ��
--CONNECT : �⺻���� �ý��� ���� �׷� - CREATE SESSION, CREATE TABLE, ALTER SESSION, CREATE SYNONYM ��
--RESOURCE : ��ü ���� �ý��� ���� �׷� - CREATE TABLE, CREATE SEQUENCE,CREATE TRIGGER ��

--�����ڰ� LEE �������� CONNECT �Ѱ� RESOURCE �� �ο�
--�ý��� ������ �ο����� ������ ���� ��� ������ �ڵ� ���� - ��й�ȣ�� �ݵ�� ����
--GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--����Ŭ ������ LEE �������� �����Ͽ� SAWON ���̺� ���� - SQLPLUS �̿� : ���� ���� �� ���̺� ���� ����
--C:\Users\user>SQLPLUS LEE  
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(20),PAY NUMBER);

--�����ڰ� LEE �������� �ο��� CONNECT �Ѱ� RESOURCE �� ȸ��
--REMOKE CONNECT,RESOURCE FROM LEE;

--PL/SQL(PROCEDURAL LANGUAGE EXTENSION SQL) : SQL�� ���� ���� ����,���� ó��,�ݺ� ó���� �����ϴ� �������� ���

--���κ��� �������� �����Ͽ� PL/SQL �ۼ�
--1.DECLARE ����(�����) : DECLARE - ������ �����ϴ� ����(����)
--2.EXECUTEABLE ����(�����) : BEGIN - SQL ����� ������ �ټ��� ����� �ۼ��ϴ� ����(�ʼ�)
--3.EXCEPTION ����(����ó����) : EXCEPTION - ���ܸ� ó���ϱ� ���� ����� �ۼ��ϴ� ����(����)

--�������� �ϳ��� ����� �����ϱ� ���� ; ���
--������ ������ END Ű����� ������ �� ; ���
--PL/SQL ������ ���� �������� / ��ȣ ���

--�޼����� ����� �� �ִ� ������ ȯ�溯�� ������ ����
SET SERVEROUT ON;

--�޼����� ����ϴ� �Լ� - PL/SQL ����ο��� ȣ���Ͽ� ���
--����)DBMS_OUTPUT.PUT_LINE(��¸޼���)

--ȯ���޼����� ����ϴ� PL/SQL �ۼ�
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE!!!');
END;
/

--���� ����� �ʱⰪ �Է� - �����
--����)������ [CONSTANT] �ڷ��� [NOT NULL] [{:=|DEFAULT} ǥ����]
--CONSTANT : ������ ����� �ʱⰪ�� �������� ���ϵ��� �����ϴ� Ű���� - ���
--NOT NULL : ������ NULL ��� �Ұ���
--:= : ���Կ����� - ������ ���� �����ϱ� ���� ������
--ǥ���� : ������ ����� ���� ���� ǥ�� ��� - ��,����(���尪),�����(�����),�Լ�(��ȯ��)

--����� ������ ���尪 ���� - �����
--����)������ := ǥ����

--��Į�� ���� : ����Ŭ �ڷ����� �̿��Ͽ� ����� ����

--��Į�� ������ �����Ͽ� ���� �����ϰ� ȭ�鿡 �������� ����ϴ� PL/SQL �ۼ�
DECLARE
    VEMPNO NUMBER(4) := 7788;
    VENAME VARCHAR2(20) := 'SCOTT';
BEGIN
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����̸�');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('-----------------');
    VEMPNO := 7893;
    VENAME := 'KING';
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('-----------------');
END;
/

--���۷��� ���� : �ٸ� ������ �ڷ��� �Ǵ� ���̺��� �÷� �ڷ����� �����Ͽ� ����� ���� - �����
--����)������ {������%TYPE|���̺��.�÷���%TYPR}

--���̺� ����� ���� �˻��Ͽ� �÷����� ���濡 �����ϴ� ��� - �����
--����)SELECT �˻����,�˻����,... INTO ������,������,... FROM ���̺�� [WHERE ���ǽ�]
--�˻����� ������ ���� �� �ڷ��� �ݵ�� ��ġ

--EMP ���̺��� EMPNO �÷��� ENAME �÷��� �ڷ����� �����Ͽ� ���۷��� ������ �����ϰ� EMP ���̺���
--����̸��� SCOTT�� ����� �����ȣ�� ����̸��� �˻��Ͽ� ���۷��� ������ �����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    /* PL/SQL�� �ּ� ó�� - ���α׷��� ������ ���� */
    /* �������� �˻��Ͽ� �˻����� �÷����� ���۷��� ������ ���� - �������� �˻��� ��� ���� �߻� */
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME='SCOTT';
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����̸�');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--���̺� ���� : ���̺��� ����� ���� ���� �� �˻��Ͽ� ���� �ټ��� �÷����� ������ ���� �����ϴ� ���� - �迭
--����)���̺����� ���̺�Ÿ�Ը�
--���̺� ������ �����ϱ� ���� ���̺� ������ �ڷ���(���̺� Ÿ��)�� ���� ����
--����)TYPE ���̺�Ÿ�Ը� IS TABLE OF {�ڷ���|������%TYPE|���̺��.�÷���%TYPE} [NOT NULL] [INDEX BY BINARY_INTEGER]

--���̺� ������ ���̺� ������ ��Ҹ� ÷�ڷ� �����Ͽ� ��� - ÷�ڴ� 1���� 1�� �����Ǵ� ���ڰ�
--����)���̺�����(÷��)

--EMP ���̺��� EMPNO �÷��� ENAME �÷��� �����Ͽ� ���̺� ������ �����ϰ� EMP ���̺� ����� ���
--����� �����ȣ�� ����̸��� �˻��Ͽ� ���̺� ������ �����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    /* ���̺� Ÿ�� ���� */
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;
    
    /* ���̺� ���� ���� */
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    /* ���̺� ������ ��Ҹ� �ݺ� ó���ϱ� ���� ÷�� ��Ȱ�� ���� ���� */
    I BINARY_INTEGER := 0;
BEGIN 
    /* EMP ���̺� ����� ��� ����� �����ȣ,����̸��� �˻��Ͽ� ���̺� ������ ��ҿ� �����ϱ� ���� �ݺ��� */
    FOR K IN (SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;    

    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����̸�');
    DBMS_OUTPUT.PUT_LINE('-----------------');
    /* ���̺� ������ ����� ��Ұ��� ����ϱ� ���� �ݺ��� */
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(VEMPNO_TABLE(J)||' / '||VENAME_TABLE(J));
    END LOOP;
END;
/

--���ڵ� ���� : ���̺� ����� �ϳ��� ���� ��� �÷����� �����ϱ� ���� �����ϴ� ����
--����)���ڵ庯���� ���ڵ�Ÿ�Ը�
--���ڵ� ������ �����ϱ� ���� ���ڵ� ������ �ڷ���(���ڵ� Ÿ��)�� ���� ����
--����)TYPE ���ڵ�Ÿ�Ը� IS RECORD(�ʵ�� {�ڷ���|������%TYPE|���̺��.�÷���%TYPE} [NOT NULL] 
--    [{:=|DEFAULT} ǥ����],...)

--���ڵ� ������ �ʵ忡 �����ϴ� ���
--����)���ڵ庯����.�ʵ��

--EMP ���̺��� EMPNO,ENAME,JOB,SAL,DEPTNO �÷��� �����Ͽ� ���ڵ� ������ �����ϰ� EMP ���̺���
--�����ȣ�� 7844�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �˻��Ͽ� ���ڵ� ������ ������ ����ϴ� PL/SQL �ۼ�
DECLARE
    /* ���ڵ� Ÿ�� ���� */
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE,VJOB EMP.JOB%TYPE
        ,VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);
    /* ���ڵ� ���� ���� */     
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    /* ���� �˻����� �÷����� ���ڵ� ������ �ʵ忡 ���� - �˻����� �������� ��� ���� �߻� */
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO EMP_RECORD.VEMPNO,EMP_RECORD.VENAME,EMP_RECORD.VJOB
        ,EMP_RECORD.VSAL,EMP_RECORD.VDEPTNO FROM EMP WHERE EMPNO=7844;
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||EMP_RECORD.VEMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||EMP_RECORD.VENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||EMP_RECORD.VJOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||EMP_RECORD.VSAL);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ = '||EMP_RECORD.VDEPTNO);
END;
/

--���ڵ� Ÿ�� ���� ���̺� ���� �����Ͽ� ���ڵ� ���� ���� ���� - ���� �÷��� �ڵ����� �ʵ�� ����
--����)���ڵ庯���� ���̺��%ROWTYPE;

--EMP ���̺��� EMPNO,ENAME,JOB,SAL,DEPTNO �÷��� �����Ͽ� ���ڵ� ������ �����ϰ� EMP ���̺���
--�����ȣ�� 7844�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �˻��Ͽ� ���ڵ� ������ ������ ����ϴ� PL/SQL �ۼ�
DECLARE
    /* ���ڵ� ���� ���� */     
    EMP_RECORD EMP%ROWTYPE;
BEGIN
    /* ���� �˻����� ��� �÷����� ���ڵ� ������ �ʵ忡 ���� - �˻����� �������� ��� ���� �߻� */
    SELECT * INTO EMP_RECORD FROM EMP WHERE EMPNO=7844;
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||EMP_RECORD.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||EMP_RECORD.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||EMP_RECORD.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||EMP_RECORD.SAL);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ = '||EMP_RECORD.DEPTNO);
END;
/

--���ù� : ����� �����Ͽ� �����ϱ� ����
--IF : ���ǽĿ� ���� ����� ���� ����
--����)IF(���ǽ�) THEN ���; ���; ... END IF;
--���ǽ��� ( ) ��ȣ ���� ����

--EMP ���̺��� �����ȣ�� 7788�� ��������� �˻��Ͽ� �����ȣ,����̸�,�μ���ȣ�� ���� �μ��̸��� ����ϴ� PL/SQL �ۼ�
--10 : ACCOUNTING, 20 : RESEARCH, 30 : SALES, 40 : OPERATION
DECLARE
    VEMP EMP%ROWTYPE;/* ���ڵ� ���� ���� */
    VDNAME VARCHAR2(20) := NULL;/* �μ��̸��� �����ϱ� ���� ��Į�� ���� ���� */
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF(VEMP.DEPTNO = 10) THEN VDNAME := 'ACCOUNTING'; END IF;
    IF(VEMP.DEPTNO = 20) THEN VDNAME := 'RESEARCH'; END IF;
    IF(VEMP.DEPTNO = 30) THEN VDNAME := 'SALES'; END IF;
    IF(VEMP.DEPTNO = 40) THEN VDNAME := 'OPERATION'; END IF;

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = '||VDNAME);
END;
/

--����)IF(���ǽ�) THEN ���; ���; ... ELSE ���; ���;... END IF;

--EMP ���̺��� �����ȣ�� 7788�� ��������� �˻��Ͽ� �����ȣ,����̸�,��������� ����Ͽ� ����ϴ� PL/SQL �ۼ�
--������� : (�޿�+������)*12
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('������� = '||ANNUAL);
END;
/
    
--����)IF(���ǽ�) THEN ���; ���; ... ELSIF(���ǽ�) ���; ���;... ELSE ���; ���;... END IF;

--EMP ���̺��� �����ȣ�� 7788�� ��������� �˻��Ͽ� �����ȣ,����̸�,�μ���ȣ�� ���� �μ��̸��� ����ϴ� PL/SQL �ۼ�
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

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = '||VDNAME);
END;
/
