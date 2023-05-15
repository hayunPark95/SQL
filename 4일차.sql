--�������� ��ġ�� ���� ����
--1.��Į�� ��������(SCALAR SUBQUERY) : SELECT, WHERE(NESTED SUBQUERY), GROUP BY, HAVING, ORDER BY 
--�ϳ��� SQL ������� ��޵����� ���������δ� �ϳ��� �Լ��� ó�� 
--�Լ��� �ټ��� �Է��� �־ ó�� ����� �ϳ��� ����
--��Į�� ���������� ������ �Լ��̹Ƿ� ��ø ��� �����ϳ� ���������� ������� �ΰ� �̻��̰ų� 
--������� �ڷ����� �ٸ� ��� ���� �߻�
--�뷮�� ����Ÿ ó���� ��Į�� ���������� ������ ������ ���ϴ� ������ �� �����Ƿ� ���̺� ������ ����ϴ� ���� ����
--2.�ζ��κ� ��������(INLINE VIEW SUBQUERY) : FROM
--INLINE VIEW : ���������� �̿��Ͽ� �Ͻ������� ������ ������ ���̺� - ���� ���̺�
--���̺� ���� Ƚ���� ���� �� ���� �������� ��� �ο�

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP;

--FROM�� ���������� ����Ͽ� �˻� - �ζ��κ� ��������
SELECT EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--ROWNUM : �˻��࿡ �������� ���ڰ��� �����ϴ� Ű���� - ���ȣ
SELECT ROWNUM,EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--��� �÷�(*)�� �ٸ� �˻����� ��� �Ұ���
SELECT ROWNUM,* FROM (SELECT EMPNO,ENAME,SAL FROM EMP);--���� �߻�

--�ζ��κ信 ���̺� ��Ī�� �ο��Ͽ� ��� ����
--[���̺��.*] �������� ǥ���Ͽ� ���̺��� ��� �÷� �˻� - �ٸ� �˻����� ���� ��� ����
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP) TEMP;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿��� �޿������� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿��� �޿������� �������� �����Ͽ� �˻�
--�˻��� �࿡ ROWNUM Ű����� ���ȣ�� �����޾� �˻� 
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;--�˻� ����

--�ζ��κ� ���������� ����Ͽ� ���ĵ� ��������� �˻��� �� ���ȣ�� �����޾� �˻�
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP;

--EMP ���̺� ����� ��� �� �޿��� ���� ���� �޴� ��� 5���� �����ȣ,����̸�,�޿� �˻�
--�޿��� �������� �����ϰ� ���ȣ(ROWNUM)�� �����޾� ���ȣ�� [6]���� ���� �� �˻�
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM<6;

--EMP ���̺� ����� ��� �� �޿��� 5��°�� ���� ���� �޴� ����� �����ȣ,����̸�,�޿� �˻�
--�޿��� �������� �����ϰ� ���ȣ(ROWNUM)�� �����޾� ���ȣ�� [5]�� �� �˻� 
--ROWNUM Ű����� ���ȣ�� �����޾� WHERE�� ���ǽĿ��� ���� ��� <(<=) �����ڸ� �̿��� �˻��� 
--���������� = �Ǵ� >(>=) �����ڸ� �̿��� �˻� �Ұ��� - ROWNUM Ű����� ���ȣ�� �˻��࿡ ���������� ����
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM=5;--�˻� ����

--EMP ���̺��� ���� �����Ͽ� �˻��� �� ���ȣ�� �����޾� �ζ��κ�� �����ϰ� ���ȣ ��� ����� �� �ִ�
--�÷� ��Ī�� �ο��Ͽ� WHERE�� ���ǽĿ��� ��Ī�� �̿��� �� �˻�
SELECT * FROM (SELECT ROWNUM RANKING,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RANKING=5; 
    
--EMP ���̺� ����� ��� ��� �� �޿��� 6��°���� 10��°���� ���� ���� ����� �����ȣ,����̸�,�޿� �˻�    
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN BETWEEN 6 AND 10;

--���տ�����(SET ������) : �� ���� SELECT ��ɿ� ���� �˻������ �̿��Ͽ� ���� ������� �����ϴ� ������
--������(UNION), ������(INTERSECT), ������(MINUS)

--SUPER_HERO ���̺� ���� - �Ӽ� : �̸�(������)
CREATE TABLE SUPER_HERO(NAME VARCHAR2(20) PRIMARY KEY);

--SUPER_HERO ���̺� �� ����
INSERT INTO SUPER_HERO VALUES('���۸�');
INSERT INTO SUPER_HERO VALUES('���̾��');
INSERT INTO SUPER_HERO VALUES('��Ʈ��');
INSERT INTO SUPER_HERO VALUES('��Ʈ��');
INSERT INTO SUPER_HERO VALUES('�����̴���');
COMMIT;

--MARVEL_HERO ���̺� ���� - �Ӽ� : �̸�(������),���(������)
CREATE TABLE MARVEL_HERO(NAME VARCHAR2(20) PRIMARY KEY,GRADE NUMBER(1));

--MARVEL_HERO ���̺� �� ����
INSERT INTO MARVEL_HERO VALUES('���̾��',3);
INSERT INTO MARVEL_HERO VALUES('��ũ',1);
INSERT INTO MARVEL_HERO VALUES('�����̴���',4);
INSERT INTO MARVEL_HERO VALUES('�丣',2);
INSERT INTO MARVEL_HERO VALUES('��Ʈ��',5);
COMMIT;

--SUPER_HERO ���̺� ����� ��� �� �˻�
SELECT * FROM SUPER_HERO;
--MARVEL_HERO ���̺� ����� ��� �� �˻�
SELECT * FROM MARVEL_HERO;

--UNION : �� ���� SELECT ������� �˻��� ���� ��ģ ���� �����ϴ� ������ - �ߺ��� ����
--����)SELECT �˻����,... FROM ���̺��1 UNOIN SELECT �˻����,... FROM ���̺��2
--�� ���� SELECT ����� �˻������ �ڷ����� ������ �ݵ�� ��ġ�ǵ��� �˻�
SELECT NAME FROM SUPER_HERO UNION SELECT NAME FROM MARVEL_HERO;

--UNION ALL : �� ���� SELECT ������� �˻��� ���� ��ģ ���� �����ϴ� ������ - �ߺ��� ����
--����)SELECT �˻����,... FROM ���̺��1 UNOIN ALL SELECT �˻����,... FROM ���̺��2
SELECT NAME FROM SUPER_HERO UNION ALL SELECT NAME FROM MARVEL_HERO;

--INTERSECT : �� ���� SELECT ������� �˻��� �࿡�� �ߺ��� ���� �����ϴ� ������
--����)SELECT �˻����,... FROM ���̺��1 INTERSECT SELECT �˻����,... FROM ���̺��2
SELECT NAME FROM SUPER_HERO INTERSECT SELECT NAME FROM MARVEL_HERO;

--MINUS : ù��° SELECT ������� �˻��� �࿡�� �ι�° SELECT ������� �˻��� ���� ������ ���� �����ϴ� ������
--����)SELECT �˻����,... FROM ���̺��1 MINUS SELECT �˻����,... FROM ���̺��2
SELECT NAME FROM SUPER_HERO MINUS SELECT NAME FROM MARVEL_HERO;

--���� ������ ���� �ΰ��� SELECT ��ɿ� ���� �˻������ �ڷ��� �Ǵ� ������ �ٸ� ��� ���� �߻�
SELECT NAME FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;--�˻������ ������ �ٸ��Ƿ� ���� �߻�
SELECT NAME FROM SUPER_HERO UNION SELECT GRADE FROM MARVEL_HERO;--�˻������ �ڷ����� �ٸ��Ƿ� ���� �߻�

--���� ������ ���� �ΰ��� SELECT ��ɿ� ���� �˻������ ������ �ٸ� ��� ���� �ڷ����� ���ǰ���
--����ϰų� NULL�� ����Ͽ� ���� ó�� ����
SELECT NAME,0 FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;
SELECT NAME,NULL FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;

--���� ������ ���� �ΰ��� SELECT ��ɿ� ���� �˻������ �ڷ����� �ٸ� ��� ��ȯ�Լ��� ����Ͽ� ���� ó�� ����
SELECT NAME FROM SUPER_HERO UNION SELECT TO_CHAR(GRADE,'0') FROM MARVEL_HERO;

--DML(DATA MANIPULATION LANGUAGE) : ����Ÿ ���۾�
--���̺��� �࿡ ���� ����,����,���� ����� �����ϴ� SQL ���
--DML ��� ���� �� COMMIT(DML ����� ����) �Ǵ� ROLLBACK ���(DML ����� ���)�� �����ϴ� ���� ����

--INSERT : ���̺� ���� �����ϴ� SQL ���
--����)INSERT INTO ���̺�� VALUES(�÷���,�÷���,...)
--���̺� ���Ե� ���� �÷����� ���̺� �Ӽ��� ������� �ڷ����� �´� �÷����� ���� ���� ���ʴ�� �����ؼ� 
--�����ؾ߸� �� ���� ó��

--���̺� �Ӽ�(�÷��� �ڷ���) Ȯ��
--����)DESC ���̺��
DESC DEPT;

--DEPT ���̺� ���ο� ��(�μ�����) ����
INSERT INTO DEPT VALUES(50,'ȸ���','�����');
SELECT * FROM DEPT;
COMMIT;

--���������� ���޵� �÷����� ������ ���̺��� �÷� ������ ���� ���� ��� ���� �߻�
INSERT INTO DEPT VALUES(60,'�ѹ���');--���ް��� ������� �ʾ� ���� �߻�
INSERT INTO DEPT VALUES(60,'�ѹ���','������','�ȴޱ�');--���ް��� �ʹ� ���� ���� �߻�

--���������� ���޵� �÷����� �ڷ����� ���̺� �÷��� �ڷ����� ���� ���� ��� ���� �߻�
INSERT INTO DEPT VALUES('����','�ѹ���','������');--���ڰ��� �ƴ� �÷����� ����Ͽ� ���� �߻�

--���������� ���޵� �÷����� ���̺� �÷��� ũ�⺸�� ū ��� ��� ���� �߻�
INSERT INTO DEPT VALUES(6000,'�ѹ���','������');--�μ���ȣ�� 2�ڸ��� ���ڰ����� ū ���� ����Ͽ� ���� �߻�
INSERT INTO DEPT VALUES(60,'�ѹ���','������ �ȴޱ�');--�μ���ġ�� 13�ڸ��� ���ڰ����� ū ���� ����Ͽ� ���� �߻�

--���̺� �÷��� �ο��� ���������� �����ϴ� ���� ������ ��� ���� �߻�
--PK(PRIMARY KEY) �������� : �ߺ��� �÷��� ������ �����ϱ� ���� ��������
--DEPT ���̺��� DEPTNO �÷����� PK �������� �ο�
SELECT DEPTNO FROM DEPT;--�˻���� : 10,20,30,40,50
INSERT INTO DEPT VALUES(50,'�ѹ���','������');--PK ���������� �ο��� �÷��� �ߺ����� �����Ͽ� ���� �߻�

--���̺� �Ӽ��� ���������� �������� �ʴ� �÷����� �����Ͼ߸� �� ���� ����
INSERT INTO DEPT VALUES(60,'�ѹ���','������');
SELECT * FROM DEPT;
COMMIT;

--���̺� ���� ������ �� �÷��� ���� �����ϰ� ���� ���� ��� NULL ���� - ����� NULL ���
INSERT INTO DEPT VALUES(70,'������',NULL);
SELECT * FROM DEPT;
COMMIT;

DESC DEPT;--DEPT ���̺� ���� Ȯ�� : �÷��� NULL ��� ���� Ȯ��
--NULL�� ������� �ʴ� �÷�(NOT NULL)���� NULL ���� �Ұ���
INSERT INTO DEPT VALUES(NULL,'������','��õ��');--NOT NULL �÷��� NULL�� �����Ͽ� ���� �߻�

--���̺��� Ư�� �÷��� ���� �����Ͽ� ���� ����
--����)INSERT INTO ���̺��(�÷���,�÷���,...) VALUES(�÷���,�÷���,...)
--�÷��� ������ ������ ���� �÷����� �����Ͽ� �� ����
INSERT INTO DEPT(DNAME,LOC,DEPTNO) VALUES('�����','��õ��',80);
SELECT * FROM DEPT;
COMMIT;

--���̺� �÷� ���� ���� - ���̺� �÷��� ������ ��� ������ �÷����� �÷� �⺻���� �ڵ����� ���޵Ǿ� ���� ó��
--���̺� ���� �Ǵ� ���̺��� �÷� ����� �÷��� ����� �⺻�� ���� ����
--�÷� �⺻���� �������� ������ NULL�� �⺻������ ���ǵ��� �ڵ� ����
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'�λ��');--LOC �÷��� NULL�� ���޵Ǿ� ���� ó�� : ������ NULL ���
SELECT * FROM DEPT;
COMMIT;

DESC EMP;--EMP ���̺��� �Ӽ� Ȯ��
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/01',3500,1000,40);
SELECT * FROM EMP;
COMMIT;

--��¥�� �÷����� ��¥�� ��� SYSDATE Ű���带 ����Ͽ� �÷����� �����Ͽ� �� ���� ����
INSERT INTO EMP VALUES(9001,'LEE','ANALYST',9000,SYSDATE,2000,NULL,40);
SELECT * FROM EMP;
COMMIT;

--INSERT ��ɿ� ��������(SUBQUERY)�� ����Ͽ� �� ���� ����
--����)INSERT INTO ���̺��1 SELECT �˻����,�˻����,... FROM ���̺��2 [WHERE ���ǽ�]
--���������� �˻������ �̿��Ͽ� ���̺� �� ���� - ���̺� �� ����
--���� ���Ե� ���̺�� ���������� ������ �˻������ �÷� ������ �ڷ����� �ݵ�� ��ġ

--BONUS ���̺��� ���� Ȯ�� �� �� �˻�
DESC BONUS;
SELECT * FROM BONUS;

--EMP ���̺��� �������� �����ϴ� ����� ����̸�,����,�޿�,�������� �˻��Ͽ� BONUS ���̺� �� ����
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM BONUS;
COMMIT;

--UPDATE : ���̺� ����� ���� �÷����� �����ϴ� SQL ���
--����)UPDATE ���̺�� SET �÷���=���氪,�÷���=���氪,... [WHERE ���ǽ�]
--���̺� ����� �࿡�� WHERE ���ǽ��� ����� ��(TRUE)�� ���� �÷��� ����
--WHERE�� ������ ��� ���̺� ����� ��� ���� �÷����� �����ϰ� ���� ó��
--WHERE ���ǽĿ��� ����ϴ� �� �÷��� PK ���������� �ο��� �÷��� �̿��Ͽ� �����ϴ� ���� ����
--�Ϲ������� PK ���������� �ο��� �÷����� �����ϴ� ���� �����

--DEPT ���̺��� �μ���ȣ�� 50�� �μ����� �˻�
SELECT * FROM DEPT WHERE DEPTNO=50;--�μ��̸� : ȸ���, �μ���ġ : �����

--DEPT ���̺��� �μ���ȣ�� 50�� �μ��� �μ��̸��� [�渮��]�� �����ϰ� �μ���ġ�� [��õ��]�� ���� 
UPDATE DEPT SET DNAME='�渮��',LOC='��õ��' WHERE DEPTNO=50;
SELECT * FROM DEPT WHERE DEPTNO=50;--�μ��̸� : �渮��, �μ���ġ : ��õ��
COMMIT; 

--�÷��� ���氪�� �÷��� �ڷ���,ũ��,���������� �´� ��쿡�� ���� ó��
UPDATE DEPT SET LOC='��õ�� ���̱�' WHERE DEPTNO=50;--���氪�� �÷��� ũ�⺸�� ũ�� ������ ���� �߻�

--UPDATE ��ɿ��� SET�� ���氪 �Ǵ� WHERE �񱳰� ��� �������� ��� ����
--DPET ���̺��� �μ��̸��� �������� �μ���ġ(NULL)�� �μ��̸��� �ѹ����� �μ���ġ(������)�� ����
SELECT * FROM DEPT;
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='�ѹ���') WHERE DNAME='������';
SELECT * FROM DEPT WHERE DNAME='������';
COMMIT;

--BONUS ���̺��� ����̸��� KIM�� ������� �������� ���� ����� �������� 100 �����ǵ��� ����
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=100 WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='KIM');
SELECT * FROM BONUS;
COMMIT;

--DELETE : ���̺� ����� ���� �����ϴ� SQL ���
--����)DELETE FROM ���̺�� [WHERE ���ǽ�]
--���̺� ����� �࿡�� WHERE ���ǽ��� ����� ��(TRUE)�� �� ����
--WHERE�� ������ ��� ���̺� ����� ��� �� ����
--WHERE ���ǽĿ��� ����ϴ� �� �÷��� PK ���������� �ο��� �÷��� �̿��Ͽ� �����ϴ� ���� ����

--DEPT ���̺��� �μ���ȣ�� 90�� �μ����� ����
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
SELECT * FROM DEPT;
COMMIT;

--DEPT ���̺��� �μ���ȣ�� 10�� �μ����� ����
--�ڽ� ���̺��� �����Ǵ� �θ����̺��� ���� FK(FOREIGN KEY) �������ǿ� ���� ���� �Ұ���
DELETE FROM DEPT WHERE DEPTNO=10;--FK �������ǿ� ���� �߻�

--FK(FOREIGN KEY) �������� : �ڽ� ���̺��� �÷������� �θ� ���̺��� �÷����� �����Ͽ� �����ϴ� ����� 
--�����ϴ� �������� 
--EMP ���̺��� DEPTNO �÷��� FK ���������� �ο��Ǿ� DEPT ���̺��� DEPTNO �÷����� �����ǵ��� ����
SELECT DISTINCT DEPTNO FROM EMP;--�˻���� : 10,20,30,40 - �θ� ���̺��� �����Ͽ� ����� �ڽ� ���̺��� �÷���
DELETE FROM DEPT WHERE DEPTNO=20;--�ڽ� ���̺��� �����ϴ� �θ� ���̺��� ���� �����Ͽ� ���� �߻�
DELETE FROM DEPT WHERE DEPTNO=80;
SELECT * FROM DEPT;
COMMIT;

--DELETE ��ɿ��� WHERE�� �񱳰� ��� �������� ��� ����
--DEPT ���̺��� �μ��̸��� �������� �μ��� ���� �μ���ġ�� �μ����� ���� - ������ ����
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='������');
SELECT * FROM DEPT;
COMMIT;

--MERGE : ���� ���̺��� ���� �˻��Ͽ� Ÿ�� ���̺� ������ �����ϰų� Ÿ�� ���̺� ����� ���� �÷�����
--�����ϴ� SQL ��� - ���̺��� �� ����
--����)MERGE INTO Ÿ�����̺�� USING �������̺�� ON (���ǽ�)
--     WHEN MATCHED THEN UPDATE SET Ÿ���÷���=�����÷���,Ÿ���÷���=�����÷���,...
--     WHEN NOT MATCHED THEN INSERT(Ÿ���÷���,Ÿ���÷���,...) VALUES(�����÷���,�����÷���,...)

--DEPT ���̺��� �����Ͽ� MERGE_DEPT ���̺� ���� - �Ӽ� : �μ���ȣ(������),�μ��̸�(������),�μ���ġ(������)
DESC DEPT;
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(14),LOC VARCHAR(13));
DESC MERGE_DEPT;

--MERGE_DEPT ���̺� �� ����
INSERT INTO MERGE_DEPT VALUES(30,'�ѹ���','�����');
INSERT INTO MERGE_DEPT VALUES(60,'�����','������');
SELECT * FROM MERGE_DEPT;
COMMIT;

--DEPT ���̺�(���� ���̺�)�� ����� ��� �μ������� �˻��Ͽ� MERGE_DEPT ���̺�(Ÿ�� ���̺�)�� ����
--�����ϰų� MERGE_DEPT ���̺� ����� ���� �÷����� ����
SELECT * FROM DEPT;--�˻����(�μ���ȣ) : 10,20,30,40,50
SELECT * FROM MERGE_DEPT;--�˻����(�μ���ȣ) : 30,60
MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT(M.DEPTNO,M.DNAME,M.LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);
SELECT * FROM MERGE_DEPT;
COMMIT;

--TCL(TRANSACTION CONTROL LANGUAGE) : Ʈ������ �����
--Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �����ϰų� ���̺� �������� �ʰ� ����ϴ� ���

--Ʈ������(TRANSACTION) : ����� ���� ȯ��(����)���� ���޵� SQL ����� DBMS ������ �����ϴ� ������ �۾�����
--SQL ����� ���޹��� DBMS ������ ���� ���̺� SQL ����� �������� �ʰ� Ʈ�����ǿ� �����Ͽ� �˻��� ���

--Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �����ϱ� ���ؼ��� Ŀ��(COMMIT) ó�� - Ŀ�� ó�� �� Ʈ������ �ʱ�ȭ
--1.���� ���ǿ��� ���������� ���� ������ ������ ��� �ڵ� Ŀ�� ó��
--2.DDL ��� �Ǵ� DCL ����� �ۼ��Ͽ� ������ ������ ��� �ڵ� Ŀ�� ó��
--3.������ �����Ͽ� Ʈ�����ǿ� ����� DML ����� COMMIT ����� ����Ͽ� Ŀ�� ó��

--Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �������� �ʰ� �ʱ�ȭ�ϱ� ���� �ѹ�(ROLLBACK) ó��
--1.���� ���ǿ��� ������������ ���� ������ ����� ��� �ڵ� �ѹ� ó��
--2.������ �����Ͽ� Ʈ�����ǿ� ����� DML ����� ROLLBACK ����� ����Ͽ� �ѹ� ó��

--DEPT ���̺��� �μ���ȣ�� 50�� �μ����� ����
SELECT * FROM DEPT;
--DELETE ����� �����ϸ� DEPT ���̺��� ���� �������� �ʰ� Ʈ�����ǿ� DELETE ��� ����
DELETE FROM DEPT WHERE DEPTNO=50;
--DEPT ���̺��� �˻��࿡�� Ʈ�����ǿ� ����� DELETE ����� ������ �˻���� ����
SELECT * FROM DEPT;

--ROLLBACK ����� �̿��� �ѹ� ó�� - Ʈ������ �ʱ�ȭ
ROLLBACK;
SELECT * FROM DEPT;

--DEPT ���̺��� �μ���ȣ�� 50�� �μ����� ����
DELETE FROM DEPT WHERE DEPTNO=50;--Ʈ�����ǿ� DELETE ��� ����

--COMMIT ����� �̿��� Ŀ�� ó�� - Ŀ�� ó�� �� Ʈ������ �ʱ�ȭ
COMMIT;--Ʈ�����ǿ� ����� DELETE ����� ���� ���̺� �����Ͽ� ����
SELECT * FROM DEPT;
