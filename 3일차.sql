--�񵿵����(NON-EQUI JOIN) : �ΰ��̻��� ���̺��� �������ǿ� = �����ڰ� �ƴ� �ٸ� �����ڸ� ����Ͽ�
--��(TRUE)�� ���� �����Ͽ� �˻�

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP;

--SALGRADE ���̺� ����� ��� �޿������ ��޹�ȣ,�ּұ޿�,�ִ�޿� �˻�
SELECT GRADE,LOSAL,HISAL FROM SALGRADE;

--EMP ���̺�� SALGRADE ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,��޹�ȣ �˻�
--�������� : EMP ���̺��� �޿�(SAL)�� SALGRADE ���̺��� �ּұ޿�(LOSAL)���� �ִ�޿�(HISAL) ������
--���ԵǴ� ���� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

--�ܺΰ���(OUTER JOIN) : ���������� ���� �ุ �����Ͽ� �˻��ϴ� ���� �ƴ϶� ���������� ���� �ʴ� �൵
--NULL�� �����Ͽ� �˻�
--���� ���ǽ��� ���̺� (+)�� ����ϸ� ���������� ���� �ʴ� ���� NULL�� �����Ͽ� �˻�

--EMP ���̺� ����� ��� ����� �μ���ȣ�� �ߺ����� �ʴ� ������ �÷��� �˻�
SELECT DISTINCT DEPTNO FROM EMP;--�˻���� : 10,20,30

--DEPT ���̺� ����� ��� �μ��� �μ���ȣ,�μ��̸�,�μ���ġ �˻�
SELECT DEPTNO,DNAME,LOC FROM DEPT;--�˻���� : 10,20,30,40

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ ����
--40�� �μ��� �ٹ��ϴ� ����� �����Ƿ� 40�� �μ��� ���� �μ��̸�,�μ���ġ �̰˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--����� ���� �μ������� �˻��ϱ� ���� ���� ���ǽĿ��� EMP ���̺� (+)�� �ٿ� �˻��ϸ� EMP ���̺���
--���յǴ� ���� ���� ��� NULL�� ���յǾ� ����� ���� �μ������� �˻� - �ܺΰ���
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

--�ڱ����(SELF JOIN) : �ϳ��� ���̺��� ���� �ٸ� ��Ī�� �ο��Ͽ� 2�� �̻��� ���̺�� �����Ͽ� ���� �����Ͽ� �˻�
--�˻������ ����� �� ���̺��� ��Ȯ�ϰ� �����ϱ� ���� ���̺� ��Ī�� ����Ͽ� �÷��� �˻� 

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�����ڹ�ȣ(�����ȣ) �˻�
SELECT EMPNO,ENAME,MGR FROM EMP;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�����ڹ�ȣ(�����ȣ),�������̸�(����̸�) �˻�
--�������� : EMP ���̺�(WORKER)�� �����ڹ�ȣ(MGR)�� EMP ���̺�(MANAGER)�� �����ȣ(EMPNO)�� ���� �� ����
--EMP ���̺�(WORKER)�� �����ڹ�ȣ(MGR)�� NULL�� ��� �̰˻�
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO;

--EMP ���̺�(WORKER)�� �����ڹ�ȣ(MGR)�� NULL�� ��� �˻� - �ܺΰ��� ���
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO(+);

--EMP ���̺�� DEPT ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO AND DNAME='SALES';

--�������ǰ� �������� WHERE���� ���� ����ϹǷ� ���������� ������ ����
--1999�� ä�õ� ǥ�� SQL(SQL3)������ ���̺��� �������ǰ� ���� ������ �����Ͽ� ���� �� �ֵ���
--�پ��� ���̺� ���� ���� ��� ���� 

--CROSS JOIN : ���� ���̺��� ��� ���� ���� �����Ͽ� �˻� - �������� ����
--����)SELECT �˻����,�˻����,... FROM ���̺��1 CROSS JOIN ���̺��2

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ�� ���������Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP CROSS JOIN DEPT;

--NATURAL JOIN : ���� ���̺� ���� �̸��� �÷��� �ϳ��� �ִ� ��� ���� �̸��� �÷��� ����� �÷������� 
--���� ���� �����Ͽ� �˻� - �������� ����
--����)SELECT �˻����,�˻����,... FROM ���̺��1 NATURAL JOIN ���̺��2

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� ���� ����
--���� ���̺� ���� �̸��� �÷����� �̿��Ͽ� �ڵ����� ���� �����ϹǷ� �������� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��̸�,�μ���ġ �˻�
--NATURAL JOIN�� ����� ��� ���� ���̺��� ���� �̸��� �÷��� ����� �� ���̺��� �������� �ʾƵ� �˻� ����
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--JOIN USING : ���� ���̺� ���� �̸��� �÷��� ������ �ִ� ��� ���� �̸��� �÷��� ����� �÷������� 
--���� ���� �����Ͽ� �˻� - �������� ����
--����)SELECT �˻����,�˻����,... FROM ���̺��1 JOIN ���̺��2 USING(�÷���)

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� ���� ����
--���� ���̺� ���� �̸��� �÷����� �̿��Ͽ� �ڵ����� ���� �����ϹǷ� �������� ����
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP JOIN DEPT USING(DEPTNO);

--INNER JOIN : ���������� ��(TRUE)�� ���� �����Ͽ� �˻�
--����)SELECT �˻����,�˻����,... FROM ���̺��1 INNER JOIN ���̺��2 ON ��������

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� ���� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
--INNER Ű���� ���� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��̸�,�μ���ġ �˻�
--���� ���̺� ���� �̸��� �÷��� �˻��� ��� �ݵ�� ���̺��� ��Ȯ�ϰ� �����Ͽ� ǥ��
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DEPT.DEPTNO,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� SALGRADE ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,��޹�ȣ �˻�
--�������� : EMP ���̺��� �޿�(SAL)�� SALGRADE ���̺��� �ּұ޿�(LOSAL)���� �ִ�޿�(HISAL) ������
--���ԵǴ� ���� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--EMP ���̺�� DEPT ���̺�, SALGRADE ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�
--,�μ��̸�,�μ���ġ,��޹�ȣ �˻�
--��������-1 : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� ���� ����
--��������-2 : EMP ���̺��� �޿�(SAL)�� SALGRADE ���̺��� �ּұ޿�(LOSAL)���� �ִ�޿�(HISAL) ������
--���ԵǴ� ���� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--EMP ���̺�� DEPT ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';

--OUTER JOIN : ���������� ���� �ุ �����Ͽ� �˻��ϴ� ���� �ƴ϶� ���������� ���� �ʴ� �൵ NULL�� �����Ͽ� �˻�
--����)SELECT �˻����,�˻����,... FROM ���̺��1 {LEFT|RIGHT|FULL} OUTER JOIN ���̺��2 ON ��������
--LEFT OUTER JOIN : ���� ���̺��� ��� ���� �˻��ϰ� ���������� ���� �ʴ� ������ ���̺��� ���� NULL�� ����
--RIGHT OUTER JOIN : ������ ���̺��� ��� ���� �˻��ϰ� ���������� ���� �ʴ� ���� ���̺��� ���� NULL�� ����
--FULL OUTER JOIN : ���� ���̺��� ��� ���� �˻��ϰ� ���������� ���� �ʴ� ���� ���̺��� ���� NULL�� ����

--EMP ���̺�� DEPT ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� ���� ����
--���������� ���� �ʴ� ���� �̰˻� - 40�� �μ��� �μ��̸�,�μ���ġ �̰˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--���������� ���� �ʴ� ���� NULL�� �����Ͽ� �˻� - OUTER Ű���� ���� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP LEFT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP RIGHT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP FULL JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--����1.�μ� ���̺�� ��� ���̺��� ���,�����,�μ��ڵ�,�μ����� �˻��Ͻÿ�.(��������� �������� ������ ��)
SELECT EMPNO,ENAME,EMP.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;
SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;

--����2.�μ� ���̺�� ��� ���̺��� ���,�����,�޿�,�μ��� �˻��Ͻÿ�.��,�޿��� 2000 �̻��� �����
--���Ͽ� ����� �������� �������� ������ ��
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO 
    WHERE SAL>=2000 ORDER BY EMPNO;
    
--����3.�μ� ���̺�� ��� ���̺��� ���,�����,����,�޿�,�μ����� �˻��Ͻÿ�. ��, ������ MANAGER �̸� 
--�޿��� 2500 �̻��� ����� ���Ͽ� ����� �������� �������� ������ �� 
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
    WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;
    
--����4.��� ���̺�� �޿���� ���̺��� ���,�����,�޿�,����� �˻��Ͻÿ�. ��, ����� �޿��� ���Ѱ���
--���Ѱ� ������ ���Եǰ� ����� 4�̸� �޿��� �������� �������� ������ ��    
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL
    WHERE GRADE=4 ORDER BY SAL DESC;
    
--����5.�μ� ���̺�, ��� ���̺�, �޿���� ���̺��� ���,�����,�μ���,�޿�,����� �˻��Ͻÿ�. 
--��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���ԵǸ� ����� �������� �������� ������ ��    
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
    
--����6.��� ���̺��� ������ �ش� ����� �����ڸ��� �˻��Ͻÿ�.
SELECT W.ENAME "�����",M.ENAME "�����ڸ�" FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO;

--����7.��� ���̺��� ������ �ش� ����� �����ڸ�,�ش� ����� �������� �����ڸ��� �˻��Ͻÿ�.
SELECT W.ENAME "�����",M.ENAME "�����ڸ�",MM.ENAME "�������� �����ڸ�" 
    FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO JOIN EMP MM ON M.MGR=MM.EMPNO;
    
--����8.7�� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� �����Ͻÿ�.   
SELECT W.ENAME "�����",M.ENAME "�����ڸ�",MM.ENAME "�������� �����ڸ�" 
    FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO LEFT JOIN EMP MM ON M.MGR=MM.EMPNO;
    
--��������(SUBQUERY) : SQL ��ɿ� ���ԵǾ� ����Ǵ� SELECT ���
--�ټ��� SQL ������� ���� �� �ִ� ����� �ϳ��� SQL ������� ��� ���� ����ϴ� ���

--SELECT ���(MAINQUERY)�� ���ԵǾ� ����Ǵ� SELECT ���(SUBQUERY)
--���������� ����� ���� �����ϰ� �˻��Ǵ� ������� ����Ͽ� ���������� ��� �����Ͽ� �˻�
--SELECT ����� ���������� FROM, WHERE, HAVING���� () �ȿ� �ۼ��Ͽ� ����

--EMP ���̺��� ����̸��� SCOTT�� ������� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻�
--SELECT ����� 2�� ����Ͽ� ���ϴ� ��� �˻�
SELECT SAL FROM EMP WHERE ENAME='SCOTT';--�˻���� : 3000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>3000;

--���������� ����Ͽ� �ϳ��� SELECT ������� ���ϴ� ��� �˻� ����
--WHERE���� ���ǽ��� �񱳰� ��� ���������� �˻� ������� �����޾� �˻�
--���ǽ��� �񱳴��(�÷�)�� ���� �ڷ����� ���� �ϳ��� �˻��ǵ��� �������� �ۼ�
--���������� ������(SINGLE-ROW)�� �����÷�(SINGLE-COLUMN)�� ���� ���� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

--EMP ���̺��� �����ȣ�� 7844�� ����� ���� ������ �ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--EMP ���̺��� �����ȣ�� 7521�� ����� ���� ������ �ϴ� ��� �� �����ȣ�� 7844�� ������� ����
--�޿��� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7521)
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7844);
    
--EMP ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
--�μ��̸��� DEPT ���̺� ����Ǿ� �����Ƿ� ���̺� ������ ����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';

--���̺� ���� ��� ���������� ����Ͽ� �˻� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');    

--EMP ���̺� ����� ��� ��� �� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP);
    
--EMP ���̺��� SALES �μ��� �ٹ��ϴ� ��� �� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
--����Ŭ�� �������� �ȿ� ���������� ����Ͽ� �˻� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'));

--EMP ���̺��� �μ��� ��� �޿� �� ���� ���� ��� �޿��� �޴� �μ��� �μ���ȣ,��ձ޿� �˻�
--HAVING�� �׷����ǽĿ��� �񱳰� ��� ���������� ������� ����Ͽ� �˻�
SELECT DEPTNO,CEIL(AVG(SAL)) FROM EMP GROUP BY DEPTNO 
    HAVING AVG(SAL)=(SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);
    
--EMP ���̺��� �μ����� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--���������� �˻������ ������(MULTI-ROW SUBQUERY)�� ���_= �����ڸ� ����Ͽ� �÷����� ���� ��� ���� �߻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);--���� �߻�

--���������� �˻������ �������� ��� = ������ ��� IN Ű���带 ����Ͽ� �÷��� �˻� ����
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);

--���������� �˻������ �������� ��� > �Ǵ� < �����ڷ� �÷����� ���ϱ� ���� �������� �տ� ANY 
--�Ǵ� ALL Ű���带 ����Ͽ� �˻�

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT SAL FROM EMP WHERE DEPTNO=10);

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=20);

--������ ���������� ANY �Ǵ� ALL Ű���� ��� ������ ���������� MIN �Ǵ� MAX �Լ��� ����ϴ� ���� ����

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���<ANY(������ ��������) ��� �÷���<(������ �������� - MAX �Լ�) ���
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���<ALL(������ ��������) ��� �÷���<(������ �������� - MIN �Լ�) ���
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���>ANY(������ ��������) ��� �÷���>(������ �������� - MIN �Լ�) ���
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���>ALL(������ ��������) ��� �÷���>(������ �������� - MAX �Լ�) ���
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--EMP ���̺��� ����̸��� ALLEN�� ����� �����ڰ� ������ ������ ���� ����� �����ȣ,����̸�,�����ڹ�ȣ,����,�޿� �˻�
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE MGR=(SELECT MGR FROM EMP WHERE ENAME='ALLEN')
    AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--���������� �˻������ ���� ��(MULTI-COLUMN SUBQUERY)�� ��� �� �÷��� () �ȿ� ,�� �����Ͽ� �˻� ����     
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP 
    WHERE (MGR,JOB)=(SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';
    
--����1.��� ���̺��� BLAKE ���� �޿��� ���� ������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');

--����2.��� ���̺��� MILLER ���� �ʰ� �Ի��� ����� ���,�̸�,�Ի����� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');

--����3.��� ���̺��� ��� ��ü ��� �޿����� �޿��� ���� ������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

--����4.��� ���̺��� CLARK�� ���� �μ��̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� 
--������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='CLARK')
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698);
    
--����5.��� ���̺��� �μ��� �ִ� �޿��� �޴� ������� ���,�̸�,�μ��ڵ�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP E1 WHERE SAL IN
    (SELECT MAX(SAL) FROM EMP E2 WHERE E1.DEPTNO=E2.DEPTNO GROUP BY DEPTNO);