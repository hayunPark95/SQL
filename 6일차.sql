--FOREIGN KEY : �θ� ���̺� ����� ���� �÷����� �����Ͽ� �ڽ� ���̺��� �÷��� ���������� ���� ����Ǵ� ���� �����ϴ� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ �������� ���� ����
--�θ� ���̺��� PRIMARY KEY ���������� ������ �÷��� �����Ͽ� �ڽ� ���̺��� �÷��� FOREIGN KEY �������� ����
--���̺��� ���踦 �����ϱ� ���� ��������

--SUBJECT1 ���̺� ���� - �����ڵ�(������-PRIMARY KEY),�����(������) : �θ� ���̺�
CREATE TABLE SUBJECT1(SNO NUMBER(2) CONSTRAINT SUBJECT1_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT1 ���̺� �� ����
INSERT INTO SUBJECT1 VALUES(10,'JAVA');
INSERT INTO SUBJECT1 VALUES(20,'JSP');
INSERT INTO SUBJECT1 VALUES(30,'SPRING');
SELECT * FROM SUBJECT1;
COMMIT;

--TRAINEE1 ���̺� ���� - ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������)
CREATE TABLE TRAINEE1(TNO NUMBER(4) CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY
    ,TNAME VARCHAR2(20),SCODE NUMBER(2));

--TRAINEE1 ���̺� �� ����
INSERT INTO TRAINEE1 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE1 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE1 VALUES(3000,'����ġ',30);
INSERT INTO TRAINEE1 VALUES(4000,'������',40);
SELECT * FROM TRAINEE1;
COMMIT;

--TRAINEE1 ���̺�� SUBJECT1 ���̺��� ��� �������� ��������ȣ,�������̸�,��������� �˻�
--�������� : TRAINEE1 ���̺��� ���������ڵ�(SCODE)�� SUBJECT1 ���̺��� �����ڵ�(SNO)�� ���� ���� ���� - INNER JOIN
--INNER JOIN�� ���������� ��(TRUE)�� �ุ �����Ͽ� �˻��ϹǷ� ���������� ���� �ʴ� �� �̰˻� 
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;--[������] �̰˻� >> �˻� ����
--OUTER JOIN�� ����ϸ� ���������� ���� �ʴ� ���� NULL�� �����Ͽ� �˻�
SELECT TNO,TNAME,SNAME FROM TRAINEE1 LEFT JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 ���̺� ���� - ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������-FOREIGN KEY) : �ڽ� ���̺�
--�ڽ� ���̺��� �÷��� ������ FOREIGN KEY ���������� �θ� ���̺��� PRIMARY KEY ���������� ������ �÷� ���� 
--TRAINEE2 ���̺��� ���������ڵ�(SCODE)�� FOREIGN KEY ���������� �����Ͽ� SUBJECT1 ���̺��� �����ڵ�(SNO)�� ����
CREATE TABLE TRAINEE2(TNO NUMBER(4) CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20)
    ,SCODE NUMBER(2) CONSTRAINT TRAINEE2_SCODE_FK REFERENCES SUBJECT1(SNO));

--�������� Ȯ��
--R_CONSTRAINT_NAME : �θ� ���̺� �����Ǵ� �÷��� PRIMARY KEY �������� �̸�
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='TRAINEE2';

--TRAINEE2 ���̺� �� ���� - �ڽ� ���̺� �� ���Խ� FOREIGN KEY ���������� ������ �÷����� �θ� ���̺��� �÷��� ����
INSERT INTO TRAINEE2 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE2 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE2 VALUES(3000,'����ġ',30);
INSERT INTO TRAINEE2 VALUES(4000,'������',40);--�θ� ���̺� ����� �÷����� ������ �� �����Ƿ� FOREIGN KEY ���������� �����Ͽ� ���� �߻�
SELECT * FROM TRAINEE2;
COMMIT;

--TRAINEE2 ���̺�� SUBJECT1 ���̺��� ��� �������� ��������ȣ,�������̸�,��������� �˻�
--�������� : TRAINEE2 ���̺��� ���������ڵ�(SCODE)�� SUBJECT1 ���̺��� �����ڵ�(SNO)�� ���� ���� ���� - INNER JOIN
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 ���̺��� ��������ȣ�� 1000�� �������� ���������ڵ带 40���� ����
UPDATE TRAINEE2 SET SCODE=40 WHERE TNO=1000;--FOREIGN KEY ���������� �����Ͽ� ���� �߻�

--SUBJECT ���̺��� �����ڵ尡 10�� �������� ����
--�ڽ� ���̺��� �����Ǵ� �θ� ���̺��� �� ���� �Ұ���
DELETE FROM SUBJECT1 WHERE SNO=10;--FOREIGN KEY ���������� �����Ͽ� ���� �߻�

--SUBJECT2 ���̺� ���� - �����ڵ�(������-PRIMARY KEY),�����(������) : �θ� ���̺�
CREATE TABLE SUBJECT2(SNO NUMBER(2) CONSTRAINT SUBJECT2_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT2 ���̺� �� ����
INSERT INTO SUBJECT2 VALUES(10,'JAVA');
INSERT INTO SUBJECT2 VALUES(20,'JSP');
INSERT INTO SUBJECT2 VALUES(30,'SPRING');
SELECT * FROM SUBJECT2;
COMMIT;

--TRAINEE3 ���̺� ���� - ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������-FOREIGN KEY) : �ڽ� ���̺�
--TRAINEE3 ���̺��� ���������ڵ�(SCODE)�� FOREIGN KEY ���������� �����Ͽ� SUBJECT2 ���̺��� �����ڵ�(SNO)�� ����
--FOREIGN KEY �������� ������ ON DELETE CASCADE �Ǵ� ON DELETE SET NULL ��� �߰�
--ON DELETE CASCADE : �θ� ���̺��� ���� ������ ��� �ڽ� ���̺��� ���� �÷����� ����� �൵ ���� ó���ϴ� ��� ����
--ON DELETE SET NULL : �θ� ���̺��� ���� ������ ��� �ڽ� ���̺��� ���� �÷����� NULL�� �����ϴ� ��� ����
CREATE TABLE TRAINEE3(TNO NUMBER(4) CONSTRAINT TRAINEE3_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE3_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT2(SNO) ON DELETE CASCADE);

--TRAINEE3 ���̺� �� ����  
INSERT INTO TRAINEE3 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE3 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE3 VALUES(3000,'����ġ',30); 
SELECT * FROM TRAINEE3;    
COMMIT;

--SUBJECT2 ���̺��� �����ڵ尡 10�� �������� ����
DELETE FROM SUBJECT2 WHERE SNO=10;
--SUBJECT2 ���̺�(�θ� ���̺�)�� �����ڵ带 �����ϴ� TRAINEE3 ���̺��� ���������� ����
SELECT * FROM SUBJECT2;
SELECT * FROM TRAINEE3;

--���������� ����Ͽ� ���̺� ���� ���� - ���� ���̺��� �̿��Ͽ� ���ο� ���̺� ���� : �� ����
--����)CREATE TABLE Ÿ�����̺��[(�÷���,�÷���,...)] AS SELECT �˻����,�˻����,... FROM �������̺�� [WHERE ���ǽ�]
--���������� �˻������ ����Ͽ� Ÿ�� ���̺��� �����ϰ� �˻��� ���� Ÿ�� ���̺��� ������ ���� ó��
--Ÿ�� ���̺��� �÷����� ���� ���������� �ڷ��� �� ũ��� ���� �Ұ���
--������������ ���� ���� ���̺��� ���������� Ÿ�� ���̺� ������

--EMP ���̺� ����� ��� ����� ��������� �˻��Ͽ� EMP_COPY ���̺� �����ϰ� �˻����� ���� ó��
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;

--EMP ���̺�� EMP_COPY ���̺��� ���� �� - ���� ���̺�� Ÿ�� ���̺��� �Ӽ� ����
DESC EMP;
DESC EMP_COPY;

--EMP ���̺�� EMP_COPY ���̺��� �������� �� - ���� ���̺��� ���������� �����Ǿ� ������ Ÿ�� ���̺��� �������� �̼���
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP_COPY';

--EMP ���̺�� EMP_COPY ���̺��� ������ �� - ���� ���̺�� Ÿ�� ���̺��� ������ ����
SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP_COPY2 ���̺� �����ϰ� �˻����� ���� ó��
CREATE TABLE EMP_COPY2 AS SELECT EMPNO,ENAME,SAL FROM EMP;

--EMP_COPY2 ���̺��� ���� �� �� �˻�
DESC EMP_COPY2;
SELECT * FROM EMP_COPY2;

--EMP ���̺��� �޿��� 2000 �̻��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP_COPY3 ���̺� �����ϰ� �˻����� ���� ó��
CREATE TABLE EMP_COPY3 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP_COPY3 ���̺��� ���� �� �� �˻�
DESC EMP_COPY3;
SELECT * FROM EMP_COPY3;

--EMP ���̺��� �޿��� 2000 �̻��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP_COPY4 ���̺� �����ϰ� �˻����� ���� ó��
--EMP_COPY4 ���̺��� �÷����� NO(�����ȣ),NAME(����̸�),PAY(�޿�)�� �ǵ��� ����
CREATE TABLE EMP_COPY4(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP_COPY4 ���̺��� ���� �� �� �˻�
DESC EMP_COPY4;
SELECT * FROM EMP_COPY4;

--EMP ���̺�� ������ �Ӽ��� EMP_COPY5 ���̺� ���� - ���� ���̺��� ���� Ÿ�� ���̺� ���� ó������ �ʵ��� ����
CREATE TABLE EMP_COPY5 AS SELECT * FROM EMP WHERE 0=1;--���ǽ��� ������ �����̹Ƿ� �� �̰˻�

--EMP_COPY5 ���̺��� ���� �� �� �˻�
DESC EMP_COPY5;
SELECT * FROM EMP_COPY5;

--���̺� ���� : ���̺� ����� ��� �� ����
--����)DROP TABLE ���̺��

--���̺� ��� Ȯ�� - USER_TABLES ��ųʸ� �̿�
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';

--USER1 ���̺� ����
DROP TABLE USER1;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';

--USER_TABLES ��ųʸ� ��� TAB ��(VIEW)�� �̿��Ͽ� ���̺� ��� �˻� ����
--����Ŭ�� ���̺��� ������ ��� ���̺��� ������(RECYCLEBIN)���� �̵��Ͽ� ���� ó�� - ���� ���̺� ���� ����
--TNAME �÷��� BIN���� ���۵Ǵ� ���̺��� ����Ŭ �����뿡 �����ϴ� ���� ���̺�
SELECT * FROM TAB;

--����Ŭ �����뿡 �����ϴ� ��ü ��� Ȯ��
SHOW RECYCLEBIN;

--����Ŭ �����뿡 �����ϴ� ���� ���̺� ����
--����)FLASHBACK TABLE ���̺�� TO BEFORE DROP
FLASHBACK TABLE USER1 TO BEFORE DROP;

--���� ���̺� ���� Ȯ�� �� ������ Ȯ��
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SELECT * FROM USER1;

--USER2 ���̺� ����
DROP TABLE USER2;

--����Ŭ ������ Ȯ��
--����Ŭ �����뿡�� ���̺�Ӹ� �ƴ϶� ���̺�� ���Ӱ��迡 �ִ� �ε���(INDEX) ��ü�� ���� ����
SHOW RECYCLEBIN;

--USER2 ���̺� ���� - ���Ӱ����� ���ؽ� ��ü�� ����
FLASHBACK TABLE USER2 TO BEFORE DROP;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--USER1,USER2,USER3,USER4 ���̺� ����
DROP TABLE USER1;
DROP TABLE USER2;
DROP TABLE USER3;
DROP TABLE USER4;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--����Ŭ �������� ���̺� ���� - ���̺� ���ӵ� �ε��� ��ü�� ���� ���� ó��
--����)PURGE TABLE ���̺��
PURGE TABLE USER4;
SHOW RECYCLEBIN;

--����Ŭ �������� ��� ���̺� ���� - ����Ŭ ������ ����
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

--MRG1 ���̺� ����
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME LIKE 'MGR%';
DROP TABLE MGR1;--���̺��� ���� ���� >> ����Ŭ ���������� �̵�
SHOW RECYCLEBIN;
PURGE RECYCLEBIN;--���̺��� ������ ����
SHOW RECYCLEBIN;

--MRG2 ���̺� ���� - ����Ŭ �������� ������� �ʰ� ������ ����
--����)DROP TABLE ���̺�� PURGE
DROP TABLE MGR2 PURGE;
SHOW RECYCLEBIN;

--���̺� �ʱ�ȭ : ���̺��� ���� ������ ���·� �ʱ�ȭ ó���ϴ� ��� - ���̺� ����� ��� �� ���� ó��
--����)TRUNCATE TABLE ���̺��

--BONUS ���̺� ����� ��� �� ����
DELETE FROM BONUS;--���� ���̺� ����� ���� ���� ó���� ���� �ƴ� Ʈ�����ǿ� ��� ����
SELECT * FROM BONUS;
ROLLBACK;--�ѹ� ó�� : Ʈ������ �ʱ�ȭ - Ʈ�����ǿ� ����� ��� SQL ��� ����
SELECT * FROM BONUS;

--BONUS ���̺� �ʱ�ȭ
TRUNCATE TABLE BONUS;--�ڵ� Ŀ�� ó��
SELECT * FROM BONUS;
ROLLBACK;--�ѹ� �Ұ���
SELECT * FROM BONUS;

--���̺��� �̸� ����
--����)RENAME �������̺�� TO �������̺��

--BONUS ���̺��� �̸��� COMM���� ����
RENAME BONUS TO COMM;
SELECT TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME IN('BONUS','COMM');

--���̺��� �Ӽ� �� �������� ����
--����)ALTER TABLE ���̺�� ����ɼ�
--����ɼǿ� ���� ���̺� �Ӽ��� ���� �߰�,����,���� �� �������ǿ� ���� �߰�,���� ����

--USER1 ���̺� ���� - ȸ����ȣ(������),ȸ���̸�(������),��ȭ��ȣ(������)
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES(1000,'ȫ�浿','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--���̺��� �Ӽ� �߰� - �÷� �⺻�� �� �÷� ������ �������� ���� ����
--����)ALTER TABLE ���̺�� ADD(�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [��������])

--USER1 ���̺� �ּ�(������) �Ӽ� �߰�
--���̺� ���� ����� ���¿��� ���̺� �Ӽ� �߰� ���� - �������� �߰� �Ӽ����� �÷� �⺻���� �ڵ� ����
ALTER TABLE USER1 ADD(ADDRESS VARCHAR2(100));
DESC USER1;
SELECT * FROM USER1;
UPDATE USER1 SET ADDRESS='����� ������' WHERE NO=1000;--�߰��� �Ӽ��� �÷��� ����
SELECT * FROM USER1;
COMMIT;

--���̺� �Ӽ��� �÷� �ڷ��� �Ǵ� ũ�� ���� - �÷� �⺻�� �� �÷� ������ �������� ���� ����
--����)ALTER TABLE ���̺�� MODIFY(�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [��������])

--USER1 ���̺� �ʱ�ȭ
TRUNCATE TABLE USER1;
SELECT * FROM USER1;

--USER1 ���̺��� NO �÷��� �ڷ����� ���������� ���������� ����
ALTER TABLE USER1 MODIFY(NO VARCHAR2(4));
DESC USER1;

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES('1000','ȫ�浿','010-1234-5678','����� ������');
SELECT * FROM USER1;
COMMIT;

--USER1 ���̺��� NO �÷��� �ڷ����� ���������� ���������� ����
--�÷� �ڷ����� ������ �Ӽ��� �÷����� ����Ǿ� �ִ� ��� �÷��� �ڷ��� ���� �Ұ���
ALTER TABLE USER1 MODIFY(NO NUMBER(4));--���� �߻�

--USER1 ���̺��� NAME �÷��� ũ�⸦ 20BYTE���� 10BYTE��  ����
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10));
DESC USER1;

--USER1 ���̺��� NAME �÷��� ũ�⸦ 10BYTE���� 5BYTE��  ����
--�÷��� ũ�⸦ ������ �Ӽ��� �÷����� ����Ǿ� �ִ� ��� �÷����� ũ�⺸�� ���� �÷��� ũ��� ���� �Ұ���
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(5));--���� �߻�

--���̺� �Ӽ��� �÷��� ����
--����)ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �����÷���

--USER1 ���̺��� ADDRESS �÷��� �̸��� ADDR�� ����
DESC USER1;
ALTER TABLE USER1 RENAME COLUMN ADDRESS TO ADDR;
DESC USER1;

--���̺��� �Ӽ� ���� - ���̺� �Ӽ��� ����� �÷��� ����
--����)ALTER TABLE ���̺�� DROP COLUMN �÷���

--USER1 ���̺��� PHONE �÷� ����
ALTER TABLE USER1 DROP COLUMN PHONE;
DESC USER1;
SELECT * FROM USER1;

--�������� �߰� - ���̺��� �Ӽ� �߰� �� ���̺� �Ӽ� ����� �÷� ������ �������� �߰� ����
--USER1 ���̺��� NAME �÷��� NOT NULL �������� �߰�
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10) CONSTRAINT USER1_NAME_NN NOT NULL); 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--���̺� ������ ���������� ADD �ɼ��� ����Ͽ� �߰� ����
--����)ALTER TABLE ���̺�� ADD [CONSTAINT �������Ǹ�] ��������
--USER1 ���̺��� NO �÷��� PRIMARY KEY �������� �߰�
ALTER TABLE USER1 ADD CONSTRAINT USER1_NO_PK PRIMARY KEY(NO);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--DROP �ɼ��� ����Ͽ� �������� ����
--����)ALTER TABLE ���̺�� DROP {PRIMARY KEY|CONSRAINT �������Ǹ�}

--USER1 ���̺��� NAME �÷��� ������ NOT NULL �������� ����
ALTER TABLE USER1 DROP CONSTRAINT USER1_NAME_NN;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--USER1 ���̺��� NO �÷��� ������ PRIMARY KEY �������� ����
ALTER TABLE USER1 DROP PRIMARY KEY;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--��(VIEW) : ���̺��� ������� ��������� ������ ���̺� - �ܼ���� ���պ�� ����
--��� ���̺��� ��˻� �Ǵ� ���̺��� ���� ������ �����ϰ� �����ϱ� ���� ����
--�ܼ��� : �ϳ��� ���̺��� ������� �����Ǵ� �� - �並 �̿��� ���̺��� �˻��Ӹ� �ƴ϶� ���̺��� �� ����,����,���� ����
--�ܼ��� ������ �׷��Լ� �Ǵ� DISTINCT Ű���带 ����� ��� �˻��� ����
--���պ� : �������� ���̺��� ������� ������ �� - ���̺��� ���� �����Ͽ� ������ �� - �˻��� ����

--�� ���� - �������� �̿�
--����)CREATE [OR REPLACE] VIEW [{FORCE|NOFORCE}] VIEW ���̸�[(�÷���,�÷���,...)]
--     AS SELECT �˻����,�˻����,... FROM ���̺�� [WHERE ���ǽ�] [WITH CHECK OPTION] [WITH READ ONLY]
--���������� �˻������ �̿��Ͽ� �� ����
--CREATE OR REPLACE : ������ �̸��� �䰡 �ִ� ��� �����並 �����ϰ� ���ο� �� ����
--FORCE : ���������� �˻������ ��� ������ �並 �����ϱ� ���� ��� ����
--WITH CHECK OPTION : �並 ������ ���������� ���ǽĿ��� ���� �÷����� �������� ���ϵ��� �����ϴ� ��� ����
--WITH READ ONLY : �˻��� �����ϵ��� �����ϴ� ��� ����(�ܼ���)

--EMP_COPY ���̺��� �μ���ȣ�� 30�� ����� �����ȣ,����̸�,�μ���ȣ�� �˻��ؿ� EMP_VIEW30 �� ����
SELECT * FROM EMP_COPY;
--CREATE VIEW �ý��� ������ ���� ����ڿ��� �����Ƿ� CREATE VIEW ��� ����� ���� �߻�
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;--���� ��������� ���� �߻�

--�ý��� ������(SYSDBA - SYS ����)�� �����Ͽ� ���� ���� �����(SCOTT)���� CREATE VIEW �ý��� ������ �ο�
--GRANT CREATE VIEW TO SCOTT;

--�ý��� �����ڿ��� CREATE VIEW �ý��� ������ �ο����� �� CREATE VIEW ��� ����
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;--�ܼ���

--�� ��� Ȯ�� - USER_VIEWS : �� ������ �����ϴ� ��ųʸ�
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--�� �˻� - ���̺��� ������ �˻�
SELECT * FROM EMP_VIEW30;

--�ܼ���� �࿡ ���� ����,����,���� ����
--EMP_VIEW30 �信 �� ���� - EMP_COPY ���̺� �� ���� : ������ �÷����� �÷� �⺻�� ����
INSERT INTO EMP_VIEW30 VALUES(1111,'ȫ�浿',30);
SELECT * FROM EMP_VIEW30;
SELECT * FROM EMP_COPY;

--EMP ���̺�� DEPT ���̺��� �μ���ȣ�� 10�� ����� �����ȣ,����̸�,�μ��̸��� �˻��Ͽ� EMP_VIEW10 �� ����
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;--���պ�
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
SELECT * FROM EMP_VIEW10;

--EMP ���̺�� DEPT ���̺��� �μ���ȣ�� 10�� ����� �����ȣ,����̸�,�޿�,�μ��̸��� �˻��Ͽ� EMP_VIEW10 �� ����
--������ ��ü�� ���� �̸��� �並 ������ ��� ���� �߻�
CREATE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;--���� �߻�
--���غ並 ���ο� ���ο� ��� ��ü - �� ����
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--�並 �������� �ʰ� SELECT ����� ���������� ����Ͽ� �ζ��� �並 �����Ͽ� ��� - CREATE VIRE �ý��� ������ ��� ��� ����
SELECT * FROM (SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO);

--�� ����
--����)DROP VIEW ���̸�

--EMP_VIEW30 �� ����
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
DROP VIEW EMP_VIEW30;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--������(SEQUENCE) : ���ڰ�(������)�� �����Ͽ� �ڵ� �����Ǵ� ���� �����ϴ� ��ü - ���̺� �÷��� �������� ����

--������ ����
--����)CREATE SEQUENCE �������� [START WITH �ʱⰪ] [INCREMENT BY ������] [MAXVALUE �ִ밪] 
--    [MINVALUE �ּҰ�] [CYCLE] [CACHE ����]
--START WITH �ʱⰪ : �������� ����� �ʱⰪ ���� - ���� : NULL
--INCREMENT BY ������ : �ڵ� �����Ǵ� ���ڰ� ���� - ���� : 1
--MAXVALUE �ִ밪 : �������� ���� ������ �ִ밪 ���� - ���� : ����Ŭ���� ���ڰ����� ǥ�� ������ �ִ밪
--MINVALUE �ּҰ� : �������� ���� ������ �ּҰ� ���� - ���� : 1
--CYCLE : �������� ����� ���� �ִ밪�� �ʰ��� ��� �ּҰ����� �ٽ� �����ǵ��� �ݺ��ϴ� ����� ����
--CACHE ���� : ������ ��������� �ڵ� �������� �̸� �����Ͽ� ������ �� �ִ� ���� ���� - ���� : 20

--USER2 ���̺� ���� - ȸ����ȣ(������-PRIMARY KEY),ȸ���̸�(������),�������(��¥��)
CREATE TABLE USER2(NO NUMBER(2) CONSTRAINT USER2_NO_PK PRIMARY KEY,NAME VARCHAR2(20),BIRTHDAY DATE);
DESC USER2;

--USER2 ���̺��� NO �÷������� ����Ǳ� ���� �ڵ� �������� �����ϴ� USER2_SEQ ������ ����
CREATE SEQUENCE USER2_SEQ;

--������ Ȯ�� - USER_SEQUENCES : ������ ������ �����ϴ� ��ųʸ�
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--�������� ����� ���ڰ� Ȯ��
--����)��������.CURRVAL
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�������� NULL�� ����Ǿ� �����Ƿ� ���� �߻�

--�������� ����� ���ڰ��� �̿��Ͽ� ������ ���� �����ϴ� ��� - ������ �� ������ �������� ������ ������ �ڵ� ����
--�������� NULL�� ����Ǿ� �ִ� ��� �������� �ּҰ��� ������ �� �������� ���尪 ���� ó��
--����)��������.NEXTVAL
SELECT * FROM USER2;
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--�˻���� : 1 - �������� ���尪�� 1�� ����
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�˻���� : 1
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--�˻���� : 2 - �������� ���尪�� 2�� ����
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�˻���� : 2

--USER2 ���̺� �� ���� - NO �÷����� �������κ��� �ڵ� �������� �����޾� ���� ó��
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'ȫ�浿','00/01/01');
SELECT * FROM USER2;
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'�Ӳ���','00/12/31');
SELECT * FROM USER2;
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'����ġ',SYSDATE);
SELECT * FROM USER2;
COMMIT;

--������ ����
--����)ALTER SEQUENCE �������� {MAXVALUE|MINVALUE|INCREMENT BY} ���氪

--USER2_SEQ �������� �ִ밪�� 99�� �����ϰ� �������� 5�� ����
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
ALTER SEQUENCE USER2_SEQ MAXVALUE 99 INCREMENT BY 5;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--USER2 ���̺� �� ���� - NO �÷����� �������κ��� �ڵ� �������� �����޾� ���� ó��
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�˻���� : 5
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'������','03/09/09');
SELECT * FROM USER2;
SELECT USER2_SEQ.CURRVAL FROM DUAL;--�˻���� : 10
COMMIT;

--������ ����
--����)DROP SEQUENCE ��������

--USER2_SEQ ������ ����
DROP SEQUENCE USER2_SEQ;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;