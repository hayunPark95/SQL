--DBMS ������ ���޵� SQL ����� �߸��� ��� �ѹ��� ����Ͽ� ����Ÿ ������ ���� Ʈ������ ��� - ����Ÿ ���Ἲ
--����Ÿ ���Ἲ : ���̺� ���������� ���� �������� �ʾ� �������� �˻���� ����
SELECT * FROM EMP;
DELETE FROM EMP;--���� ���̺� DELETE ����� ����Ǵ� ���� �ƴ϶� Ʈ�����ǿ� DELETE ��� ����
SELECT * FROM EMP;
ROLLBACK;--Ʈ������ �ʱ�ȭ
SELECT * FROM EMP;

--���� ���ǿ��� �۾����� ���̺��� ���� Ŀ�� ó�� ������ �ٸ� ���ǿ��� �˻����� �ʰ� �������� �˻��ǵ��� 
--Ʈ������ ��� - ����Ÿ �ϰ���
--����Ÿ �ϰ��� : DBMS ������ ���ӵ� ��� ����ڿ��� ������ �˻������ ����

--BONUS ���̺��� ����̸��� KIM�� ������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='KIM';
SELECT * FROM BONUS;

--�ٸ� ���ǿ����� BONUS ���̺��� ����̸��� KIM�� ������� �˻�
--���� ���ǿ��� Ŀ�� ó���ϱ� ������ �ٸ� ���ǿ����� �������� �˻���� ���� - ����Ÿ �ϰ���
--Ŀ�� ó���� �̿��� Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �����ϸ� �ٸ� ���ǿ����� ���̺��� ���۵� �� �˻�
COMMIT;

--����Ÿ ��� ���(LOCK)�� �����ϱ� ���� Ʈ������ ���
--DBMS ���α׷��� ���� ����� ȯ������ ���� ���̺��� ���� �ٸ� ���ǿ��� ���� ����
--���� ���ǿ��� �۾����� ���̺��� ���� �ٸ� ���ǿ��� �۾����� ���ϵ��� Ʈ�������� ����Ͽ� ����Ÿ ��� ��� ����

--BONUS ���̺��� ����̸��� ALLEN�� ����� �޿��� 2000���� ����
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN';--���̺� �࿡ ���� ����Ÿ ��� ��� Ȱ��ȭ
SELECT * FROM BONUS;

--�ٸ� ������ ����Ͽ� BONUS ���̺��� ����̸��� ALLEN�� ����� �����޸� �޿��� 50%�� ����
--UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--���� ���ǿ��� �۾����� ���̺��� ���� �ٸ� ���ǿ��� ������ ��� Ʈ�������� ����Ÿ ��� ������� ����
--�ٸ� ������ �Ͻ������� ����
--���� ���ǿ��� �۾����� ���̺��� �࿡ ���� Ʈ�������� ����� Ŀ�� �Ǵ� �ѹ� ó���ؾ߸� ����Ÿ ���
--����� ��Ȱ��ȭ �Ǿ� �ٸ� ������ DML ����� ���� ����
COMMIT;

--SAVEPOINT : Ʈ�����ǿ� ��(��ġ����)�� �ο��ϴ� ���
--Ʈ�����ǿ� ����� DML ��� �� ���� �̿��Ͽ� ���ϴ� ��ġ�� DML ��ɸ� �ѹ� ó���ϱ� ���� SAVEPOINT ���
--����)SAVEPOINT �󺧸�

--BONUS ���̺��� ����̸��� ALLEN�� ������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--BONUS ���̺��� ����̸��� MARTIN�� ������� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--�ѹ� ó��
ROLLBACK;--Ʈ�����ǿ� ����� ��� DML ��� ����
SELECT * FROM BONUS;

--BONUS ���̺��� ����̸��� ALLEN�� ������� ����
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;
SAVEPOINT ALLEN_DELETE_AFTER;--Ʈ�����ǿ� ���� �����Ͽ� ����

--BONUS ���̺��� ����̸��� MARTIN�� ������� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT ������� ������ ���� �̿��Ͽ� �ѹ� ó��
--����)ROLLBACK TO �󺧸�
ROLLBACK TO ALLEN_DELETE_AFTER;--Ʈ�����ǿ��� �� �ڿ� �ۼ��� DML ��ɸ� ����
SELECT * FROM BONUS;

ROLLBACK;
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : ����Ÿ ���Ǿ�
--����Ÿ���̽��� ��ü(���̺�,��,������,�ε���,���Ǿ�,����� ��)�� �����ϱ� ���� SQL ���

--���̺�(TABLE) : ����Ÿ���̽����� ����Ÿ(��)�� �����ϱ� ���� ���� �⺻���� ��ü

--���̺� ���� : ���̺� �Ӽ�(ATTRIBUTE)�� ����
--����)CREATE TABLE ���̺��(�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [�÷���������]
--     ,�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [�÷���������],...[,���̺���������])

--�ĺ��� �ۼ� ��Ģ : ���̺��, �÷���, ��Ī, �󺧸� ��
--1.�����ڷ� ���۵Ǹ� 1~30 ������ ���ڵ�θ� ����
--2.A~Z,0~9,_,$,# ���ڵ��� �����Ͽ� �ۼ� - ��ҹ��� �̱��� : ������ũ ǥ����� ����ϴ� ���� ����
--3.�����ڿܿ� �ٸ� ����(�ѱ� ��) ��� ���� - �����
--4.Ű����� �ĺ��ڸ� ������ ��� ���� �߻� - " " �ȿ� ǥ���ϸ� ���������� �����

--�ڷ���(DATATYPE) : �÷��� ���� ������ ���� ���¸� ǥ���ϱ� ���� Ű����
--1.������ : NUMBER[(��ü�ڸ���,�Ҽ����ڸ���)]
--2.������ : CHAR(ũ��) - ũ�� : 1~2000(BYTE) >> ��������
--          VARCHAR2(ũ��) - ũ�� : 1~4000(BYTE) >> ��������
--          LONG - �ִ� 2GBYTE ���� >> �������� - ���̺� �ϳ��� �÷����� ���� �����ϸ� ���� �Ұ���  
--          CLOB - �ִ� 4GBYTE ���� >> �������� - �ؽ�Ʈ ������ �����ϱ� ���� �ڷ���
--          BLOB - �ִ� 4GBYTE ���� >> �������� - ���� ������ �����ϱ� ���� �ڷ���
--3.��¥�� : DATE - ��¥�� �ð�
--          TIMESTAMP - ��(MS) ���� �ð�

--SALESMAN ���̺� ���� - �����ȣ(������),����̸�(������),�Ի���(��¥��)
CREATE TABLE SALESMAN(NO NUMBER(4), NAME VARCHAR2(20),STARTDATE DATE);

--��ųʸ�(DICTIONARY) : �ý��� ������ �����ϱ� ���� ������ ���̺�(��)
--USER_DICTIONARY(�Ϲ� �����), DBA_DICTIONARY(������), ALL_DICTIONARY(��� �����)

--USER_OBJECTS : ���� ���� ������� ��Ű���� ���� ������ ��ü�� ������ �����ϴ� ��ųʸ�
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES : ���� ���� ������� ��Ű���� ���� ������ ���̺��� ������ �����ϴ� ��ųʸ�
SELECT TABLE_NAME FROM USER_TABLES;
--USER_TABLES ��ųʸ� ��� ���Ǿ�(SYNONYM)�� TABS ����
SELECT TABLE_NAME FROM TABS;

--SALESMAN ���̺� ���� Ȯ��
DESC SALESMAN;

--SALESMAN ���̺� �� ����
INSERT INTO SALESMAN VALUES(1000,'ȫ�浿','00/04/18');
SELECT * FROM SALESMAN;
COMMIT;

--�÷��� �����Ͽ� ���� ó���� ��� ������ �÷����� �÷� �⺻���� ���޵Ǿ� ���� ó��
--���̺� ������ �÷� �⺻���� �������� ���� ��� �ڵ����� NULL�� �⺻������ �ڵ� ����
INSERT INTO SALESMAN(NO,NAME) VALUES(2000,'�Ӳ���');
SELECT * FROM SALESMAN;
COMMIT;

--���̺� ������ ���������� �������� ���� ��� �÷��� ��� ���� �����ص� ���� ó�� - ����Ÿ ���Ἲ ���� ����
INSERT INTO SALESMAN VALUES(1000,'����ġ','10/10/10');
SELECT * FROM SALESMAN;
COMMIT;

--MANAGER ���̺� ���� - �����ȣ(������),����̸�(������),�Ի���(��¥��-�⺻��:����),�޿�(������-�⺻��:1000)
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20)
    ,STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);

--���̺� ��� �� ���� Ȯ��
SELECT TABLE_NAME FROM USER_TABLES;
DESC MANAGER;

--USER_TAB_COLUMNS : ���̺��� �÷� ������ �����ϴ� ��ųʸ�
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER ���̺� �� ����
INSERT INTO MANAGER VALUES(1000,'ȫ�浿','00/05/09',3000);
SELECT * FROM MANAGER;
--������ �÷������� �ڵ����� �÷� �⺻���� ���޵Ǿ� ���� ó��
INSERT INTO MANAGER(NO,NAME) VALUES(2000,'�Ӳ���');
SELECT * FROM MANAGER;
--DEFUALT Ű���带 ����Ͽ� �÷� �⺻���� �����޾� ���� ó��
INSERT INTO MANAGER VALUES(3000,'����ġ',DEFAULT,DEFAULT);
SELECT * FROM MANAGER;
COMMIT;

--��������(CONSTRAINT) : �÷��� ���������� ���� ����Ǵ� ���� �����ϱ� ���� ��� - ����Ÿ ���Ἲ ����
--�÷� ������ �������� : ���̺��� �Ӽ� ����� �÷��� ���������� ����
--���̺� ������ �������� : ���̺� ����� ���̺��� Ư�� �÷��� ���������� ����

--CHECK : �÷������� ���� ������ ������ �����Ͽ� ������ ��(TRUE)�� ��쿡�� �÷������� ����ǵ��� �����ϴ� ��������
--�÷� ������ �������� �Ǵ� ���̺� ���� ������������ ���� ����

--SAWON1 ���̺� ���� : �����ȣ(������),����̸�(������),�޿�(������)
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

--SAWON1 ���̺� �� ���� - �޿�(PAY) �÷����� ��� ���ڰ��� ���޹޾� ���� ����
INSERT INTO SAWON1 VALUES(1000,'ȫ�浿',8000000);
INSERT INTO SAWON1 VALUES(2000,'�Ӳ���',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 ���̺� ���� : �����ȣ(������),����̸�(������),�޿�(������-�ּұ޿�:5000000)
--CHEKC ���������� �÷������� �������� ���� - �ش� �÷��� �̿��� ���ǽ� ���� ����(�ٸ� �÷��� �̿��� ���ǽ��� ����ϸ� ���� �߻�)
CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER CHECK(PAY>=5000000));

--SAWON2 ���̺� �� ����
INSERT INTO SAWON2 VALUES(1000,'ȫ�浿',8000000);
INSERT INTO SAWON2 VALUES(2000,'�Ӳ���',800000);--CHECK ���������� �����Ͽ� ���� �߻�
SELECT * FROM SAWON2;
COMMIT;

--USER_CONSTRAINTS : ���̺� ������ ���������� �����ϴ� ��ųʸ�
--CONSTRAINT_NAME : ���������� �����ϱ� ���� �̸�(������) - ���������� �̸��� �������� ������ �ڵ����� SYS_XXXXXXX �������� ����
--CONSTRAINT_TYPE : ���������� ���� - C(CHECK), U(UNIQUE), P(PRIMARY KEY), R(REFERENCE - FOREIGN KEY)
--SEARCH_CONDITION : CHECK ������������ ������ ���ǽ�
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--���������� ������ ��� ���������� ȿ�������� �����ϱ� ���� ���������� �̸��� �����ϴ� ���� ����
--����)�÷��� �ڷ���[(ũ��)] CONSTRAINT �������Ǹ� ��������

--SAWON3 ���̺� ���� : �����ȣ(������),����̸�(������),�޿�(������-�ּұ޿�:5000000)
CREATE TABLE SAWON3(NO NUMBER(4),NAME VARCHAR2(20)
    ,PAY NUMBER CONSTRAINT SAWON3_PAY_CHECK CHECK(PAY>=5000000));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON3';

--SAWON4 ���̺� ���� : �����ȣ(������),����̸�(������),�޿�(������-�ּұ޿�:5000000)
--CHEKC ���������� ���̺� ������ ������������ ���� - ��� �÷��� �̿��� ���ǽ� ���� ����
CREATE TABLE SAWON4(NO NUMBER(4),NAME VARCHAR2(20)
    ,PAY NUMBER,CONSTRAINT SAWON4_PAY_CHECK CHECK(PAY>=5000000));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON4';

--NOT NULL : NULL�� ������� �ʴ� �������� - �÷��� �ݵ�� ���� ����ǵ��� �����ϴ� ��������
--�÷� ������ �����������θ� ���� ���� - CHECK ������������ ǥ��

--DEPT1 ���̺� ���� : �μ���ȣ(������),�μ��̸�(������),�μ���ġ(������)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;

--DEPT1 ���̺� �� ����
INSERT INTO DEPT1 VALUES(10,'�ѹ���','�����');
INSERT INTO DEPT1 VALUES(20,NULL,NULL);--����� NULL ���
INSERT INTO DEPT1(DEPTNO) VALUES(30);--������ NULL ���
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 ���̺� ���� : �μ���ȣ(������-NOT NULL),�μ��̸�(������-NOT NULL),�μ���ġ(������-NOT NULL)
CREATE TABLE DEPT2(DEPTNO NUMBER(4) CONSTRAINT DEPT2_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(12) CONSTRAINT DEPT2_DNAME_NN NOT NULL
    ,LOC VARCHAR2(11) CONSTRAINT DEPT2_LOC_NN NOT NULL);
DESC DEPT2;    

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';    

--DEPT2 ���̺� �� ����
INSERT INTO DEPT2 VALUES(10,'�ѹ���','�����');
INSERT INTO DEPT2 VALUES(20,NULL,NULL);--����� NULL ��� : NOT NULL ���������� �����Ͽ� ���� �߻�
INSERT INTO DEPT2(DEPTNO) VALUES(30);--������ NULL ��� : NOT NULL ���������� �����Ͽ� ���� �߻�
SELECT * FROM DEPT2;
COMMIT;

--UNIQUE : �ߺ� �÷��� ������ �����ϱ� ���� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ �������� ����
--UNIQUE ���������� ���̺� ������ ������ �����ϸ� NULL ���

--USER1 ���̺� ���� - ���̵�(������),�̸�(������),��ȭ��ȣ(������)
CREATE TABLE USER1(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15));

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--USER2 ���̺� ���� - ���̵�(������-UNIQUE),�̸�(������),��ȭ��ȣ(������-UNIQUE) : �÷� ������ ��������
CREATE TABLE USER2(ID VARCHAR2(20) CONSTRAINT USER2_ID_UK UNIQUE
    ,NAME VARCHAR2(30),PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
    
--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

--USER2 ���̺� �� ����
INSERT INTO USER2 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER2 VALUES('ABC','ȫ�浿','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵�� ��ȭ��ȣ �ߺ�
INSERT INTO USER2 VALUES('ABC','�Ӳ���','010-7890-1234');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵� �ߺ�
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ��ȭ��ȣ �ߺ�
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-7890-1234');--���̵�� ��ȭ��ȣ�� �ߺ����� �ʾ� ���� ó��
SELECT * FROM USER2;
COMMIT;

--UNIQUE ���������� ������ �÷��� NULL�� �����Ͽ� ���� ����
INSERT INTO USER2 VALUES('OPQ','����ġ',NULL);
--NULL�� ���� �ƴϹǷ� UNIQUE ���������� �������� �ʴ� ������ ó��
INSERT INTO USER2 VALUES('IJK','������',NULL);
SELECT * FROM USER2;
COMMIT;

--USER3 ���̺� ���� - ���̵�(������-UNIQUE),�̸�(������),��ȭ��ȣ(������-UNIQUE) : ���̺� ������ ��������
CREATE TABLE USER3(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 ���̺� �� ����
INSERT INTO USER3 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER3 VALUES('ABC','ȫ�浿','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵�� ��ȭ��ȣ �ߺ�
INSERT INTO USER3 VALUES('ABC','�Ӳ���','010-7890-1234');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵� �ߺ�
INSERT INTO USER3 VALUES('XYZ','�Ӳ���','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ��ȭ��ȣ �ߺ�
SELECT * FROM USER3;
COMMIT;

--USER4 ���̺� ���� - ���̵�(������),�̸�(������),��ȭ��ȣ(������) 
--���̵�� ��ȭ��ȣ�� ��� UNIQUE �������� ���� - ���̺� ������ �����������θ� ���� ����
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 ���̺� �� ����
INSERT INTO USER4 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER4 VALUES('ABC','ȫ�浿','010-1234-5678');--UNIQUE ���������� �����Ͽ� ���� �߻� : ���̵�� ��ȭ��ȣ �ߺ�
INSERT INTO USER4 VALUES('ABC','�Ӳ���','010-7890-1234');
INSERT INTO USER4 VALUES('XYZ','�Ӳ���','010-1234-5678');
SELECT * FROM USER4;
COMMIT;

--PRIMARY KEY(PK) : �ߺ� �÷��� ������ �����ϱ� ���� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ �������� ���� ����
--PRIMARY KEY ���������� ���̺� �ѹ��� ���� �����ϸ� NULL �����
--PRIMARY KEY ���������� ���̺� �ѹ��� ���� �����ϹǷ� ���������� �̸� ���� ���� ����
--PRIMARY KEY ���������� ���̺��� ���踦 ��üȭ�ϱ� ���� �ݵ�� ����

--MGR1 ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�Ի���(������) - �÷� ������ ��������
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';

--MGR1 ���̺� �� ����
INSERT INTO MGR1 VALUES(1000,'ȫ�浿',SYSDATE);
INSERT INTO MGR1 VALUES(1000,'�Ӳ���',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - �����ȣ �ߺ� 
INSERT INTO MGR1 VALUES(NULL,'�Ӳ���',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - NULL ����
INSERT INTO MGR1 VALUES(2000,'�Ӳ���',SYSDATE);
SELECT * FROM MGR1;
COMMIT;

--MGR2 ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�Ի���(������) - ���̺� ������ ��������
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE, CONSTRAINT MGR2_NO_PK PRIMARY KEY(NO));
DESC MGR2;

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';

--MGR2 ���̺� �� ����
INSERT INTO MGR2 VALUES(1000,'ȫ�浿',SYSDATE);
INSERT INTO MGR2 VALUES(1000,'�Ӳ���',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - �����ȣ �ߺ� 
INSERT INTO MGR2 VALUES(NULL,'�Ӳ���',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - NULL ����
INSERT INTO MGR2 VALUES(2000,'�Ӳ���',SYSDATE);
SELECT * FROM MGR2;
COMMIT;

--MGR3 ���̺� ���� - �����ȣ(������),����̸�(������),�Ի���(������)
--�����ȣ�� ����̸��� ��� PRIMARY KEY �������� ����
--���̺� ������ ���������� �÷��� ��� PRIMARY KEY �������� ���� ����
CREATE TABLE MGR3(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE
    ,CONSTRAINT MGR3_NO_NAME_PK PRIMARY KEY(NO,NAME));
DESC MGR3;

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR3';

--MGR3 ���̺� �� ����
INSERT INTO MGR3 VALUES(1000,'ȫ�浿',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'�Ӳ���',SYSDATE);
INSERT INTO MGR3 VALUES(2000,'�Ӳ���',SYSDATE);
INSERT INTO MGR3 VALUES(1000,'ȫ�浿',SYSDATE);--PRIMARY KEY ���������� �����Ͽ� ���� �߻� - �����ȣ�� �̸� �ߺ� 
SELECT * FROM MGR3;
COMMIT;