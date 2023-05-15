--�����Լ� : �Ű������� ���ڰ��� ���޹޾� �����Ͽ� ������� ��ȯ�ϴ� �Լ�
 
--ROUND(���ڰ�,�Ҽ����ڸ���) : ���ڰ��� ���޹޾� �Ҽ����ڸ��� ��ġ��ŭ �˻��ǵ��� �ݿø� ó���Ͽ� ��ȯ�ϴ� �Լ�
--DUAL ���̺� : ���̺� ���� �˻������ SELECT ������� �ۼ��� ��� ���Ǵ� ������ ���̺�
SELECT ROUND(45.582, 2), ROUND(45.582, 0), ROUND(45.582, -1) FROM DUAL;

--TRUNC(���ڰ�, �Ҽ����ڸ���) : ���ڰ��� ���޹޾� �Ҽ����ڸ��� ��ġ��ŭ �˻��ǵ��� ���� ó���Ͽ� ��ȯ�ϴ� �Լ�
SELECT TRUNC(45.582, 2), TRUNC(45.582, 0), TRUNC(45.582, -1) FROM DUAL;

--CEIL(���ڰ�) : ���ڰ��� ���޹޾� �Ҽ��� ���� ���� ������ ��� ������ ���ڰ�(������)�� ��ȯ�ϴ� �Լ�
SELECT CEIL(15.3), CEIL(-15.3) FROM DUAL;

--FLOOR(���ڰ�) : ���ڰ��� ���޹޾� �Ҽ��� ���� ���� ������ ��� ���ҵ� ���ڰ�(������)�� ��ȯ�ϴ� �Լ�
SELECT FLOOR(15.3), FLOOR(-15.3) FROM DUAL;

--MOD(���ڰ�1,���ڰ�2) : �ΰ��� ���ڰ��� ���޹޾� ���ڰ�1�� ���ڰ�2�� ���� �������� ��ȯ�ϴ� �Լ�
SELECT 20/8, MOD(20,8) FROM DUAL;

--POWER(���ڰ�1,���ڰ�2) : �ΰ��� ���ڰ��� ���޹޾� ���ڰ�1�� ���� ���ڰ�2�� �������� ��ȯ�ϴ� �Լ�
SELECT 3*3*3*3*3, POWER(3, 5) FROM DUAL;

--��¥�Լ� : �Ű������� ��¥���� ���޹޾� �����Ͽ� ������� ��ȯ�ϴ� �Լ�

--SYSDATE : �ý����� ���� ��¥�� �ð��� �����ϱ� ���� Ű����
--SYSDATE Ű������ �˻����� �⺻������ [RR/MM/DD] �������� �˻������� ���������δ� ��¥�� �ð� ����
SELECT SYSDATE FROM DUAL;

--ADD_MONTHS(��¥��, ���ڰ�) : ��¥���� ���޹޾� ���ڰ���ŭ �������� ���� ��¥���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 5) FROM DUAL;

--��¥���� + ������ �� - �����ڸ� �̿��Ͽ� ���� ����
--��¥�� + ���ڰ� = ��¥�� >> �� ����
SELECT SYSDATE, SYSDATE+7 FROM DUAL;

--��¥�� + ���ڰ�/24 = ��¥�� >> �ð� ����
SELECT SYSDATE, SYSDATE+100/24 FROM DUAL;

--��¥�� - ���ڰ� = ��¥�� >> �� ����
SELECT SYSDATE, SYSDATE-7 FROM DUAL;

--��¥�� - ���ڰ�/24 = ��¥�� >> �ð� ����
SELECT SYSDATE, SYSDATE-100/24 FROM DUAL;

--��¥�� - ��¥�� = ���ڰ� >> ��(�Ǽ���)
SELECT EMPNO,ENAME,HIREDATE,SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE)||'��' "�ټ��ϼ�" FROM EMP WHERE EMPNO=7499;

--NEXT_DAY(��¥��, ����) : ��¥���� ���޹޾� �̷��� Ư�� ���Ͽ� ���� ��¥���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;

--����Ŭ�� ���ӵ� ���� ����� ȯ��(���� : SESSION)�� ���� ��� ��� �� ��¥�� �ð� ������ �ٸ��� ����
--������ ��� ��� �� ��¥�� �ð� ���� ���� ����
ALTER SESSION SET NLS_LANGUAGE='AMERICAN';--��� ��� ���� : AMERICAN
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE='KOREAN';--��� ��� ���� : KOREAN
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;

--TRUNC(��¥��, ǥ������) : ��¥���� ���޹޾� ���ϴ� ������ ǥ���ϰ� �������� �����Ͽ� �ʱⰪ���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, TRUNC(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;

--��ȯ�Լ� : �Ű������� ���޹��� ���� ���ϴ� �ڷ����� ������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--TO_NUMBER(���ڰ�) : ���ڰ��� ���޹޾� ���ڰ����� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--�Ű������� ���޹��� ���ڰ��� ���ڰ� �ƴ� ������ ���ڰ� ������ ��� ���� �߻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7839;
--�� �÷��� �ڷ����� �������� ��� �񱳰��� ���ڰ��̸� TO_NUMBER �Լ��� ����Ͽ� ���ڰ��� ���ڰ����� 
--��ȯ�Ͽ� ��ȯ�޾� �� ���� - ���� ����ȯ
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--�� �÷��� �ڷ����� �������� ��� �񱳰��� ���ڰ��̸� �ڵ����� ���ڰ����� ��ȯ�Ǿ� �� - �ڵ� ����ȯ
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO='7839';

--���ڃ��� ��� ������ ��� ���ڰ��� �ڵ����� ���ڰ����� ��ȯ�Ǿ� ���� ó�� - �ڵ� ����ȯ
SELECT 100+200 FROM DUAL;
SELECT 100+'200' FROM DUAL;

--EMP ���̺��� �����ȣ�� 7839�� ����� �����ȣ,����̸�,�޿�,���ı޿�(�޿�*0.9) �˻�
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;

--TO_DATE(���ڰ�[,���Ϲ���]) : ���ڰ��� ���޹޾� ��¥������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--��¥�� �ð� ���� ���Ϲ��ڸ� ����Ͽ� ���ϴ� ������ ���ڰ��� ���޹޾� ��¥������ ��ȯ
--���Ͽ� ���� �ʴ� ���ڰ��� ���޹��� ��� ���� �߻� - �⺻���� : [RR/MM/DD]
--�� �÷��� �ڷ����� ��¥���� ��� �񱳰��� ���ڰ��̸� TO_DATE �Լ��� ����Ͽ� ���ڰ��� ��¥������ 
--��ȯ�Ͽ� ��ȯ�޾� �� ���� - ���� ����ȯ
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('82/01/23');
--�� �÷��� �ڷ����� ��¥���� ��� �񱳰��� ���ڰ��̸� �ڵ����� ��¥������ ��ȯ�Ǿ� �� - �ڵ� ����ȯ
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='82/01/23';

--��¥���� [RR/MM/DD] ������ �⺻���� ��������� [YYYY-MM-DD] ���ϵ� ��� ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='1982-01-23';

--���Ͽ� ���� �ʴ� ���ڰ��� ����� ��� ���� �߻�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='01-23-1982';--���� �߻�
--TO_DATE �Լ��� ���Ϲ��ڸ� ����Ͽ� ���ϴ� ������ ���ڰ��� ���޹޾� ��¥������ ��ȯ ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('01-23-1982','MM-DD-YYYY');

--2000�� 1�� 1�Ͽ� �¾ ����� ���ñ��� ��ƿ� ��¥�� �˻�
SELECT SYSDATE-'2000-01-01' FROM DUAL;--���� �߻� : ��¥���� �ƴ� ���ڰ��� ���� ó��
SELECT SYSDATE-TO_DATE('2000-01-01') FROM DUAL;
SELECT CEIL(SYSDATE-TO_DATE('2000-01-01'))||'��' "���ñ��� ��ƿ� ��¥`" FROM DUAL;

--TO_CHAR({���ڰ�|��¥��},���Ϲ���) : ���ڰ� �Ǵ� ��¥���� ���޹޾� ���ϴ� ������ ���ڰ����� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--��¥���Ϲ��� : RR(��),YYYY(��),MM(��),DD(��),HH24(�ð�),HH12(�ð�),MI(��),SS(��)
SELECT SYSDATE,TO_CHAR(SYSDATE,'YYYY-MM-DD'),TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP ���̺��� 1981�⿡ �Ի��� ����� �����ȣ,����̸�,�Ի��� �˻�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE BETWEEN '81/01/01'  AND '81/12/31';
--���� ���ӵ� ����� ȯ��(����)�� ��¥�� �ð��� �⺻������ [RR/MM/DD/]�� ��쿡�� �˻� ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';
--TO_CHAR �Լ��� ����Ͽ� ��¥���� ���ϴ� ������ ���ڰ����� ��ȯ�Ͽ� ��ȯ�޾� �� ó��
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY')='1981'; 

--�������Ϲ��� : 9(���� �Ǵ� ����), 0(����), L(ȭ�����), $(�޷�)
SELECT 1000000000,TO_CHAR(1000000000,'9,999,999,990') FROM DUAL;
--�Ű������� ���޹��� ���ڰ��� ���̰� ���Ϲ����� ���̺��� ū ��� ��� ���Ϲ��ڰ� [#]���� ��ȯ�Ǿ� ��ȯ
SELECT 1000000000000,TO_CHAR(1000000000000,'9,999,999,990') FROM DUAL;

--EMP ���̺��� �����ȣ�� 7844�� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'L99,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'$99,990.00') SAL FROM EMP WHERE EMPNO=7844;

--�Ϲ��Լ� : �Ű������� ���޹��� ���� Ư�� ���ǿ� ��(TRUE)�� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--NVL(���ް�,���氪) : ���ް��� NULL�� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--���氪�� ���ް��� ������ �ڷ����� �����θ� ���� ���� - �ٸ� �ڷ����� ������ ������ ��� ���� �߻�

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,����(�޿�*12) �˻�
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,����((�޿�+������)*12) �˻�
--�������� NULL�� ��� ������ �Ұ����ϹǷ� NULL ����� �˻�
SELECT EMPNO,ENAME,(SAL+COMM)*12 ANNUAL FROM EMP;--�˻� ����
--NVL �Լ��� ����Ͽ� �������� NULL�ΰ�� 0���� ��ȯ�Ͽ� ���� ó��
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(���ް�,���氪1,���氪2) : ���ް��� NULL�� �ƴ� ��� ���氪1�� ��ȯ�Ͽ� ��ȯ�ϰ� NULL�� ��� 
--���氪2���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO,ENAME,NVL2(COMM,(SAL+COMM)*12,SAL*12) ANNUAL FROM EMP;

--DECODE(���ް�,�񱳰�1,���氪1,�񱳰�2,���氪,...[,�⺻��]) : ���ް��� �񱳰��� ���ʴ�� ���Ͽ�
--���� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--�񱳰��� ��� �ٸ� ��� �⺻������ ��ȯ�Ͽ� ��ȯ - �⺻���� ������ ��� NULL ��ȯ

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,����,�޿�,������ �Ǳ޿� �˻�
--������ �Ǳ޿� : ����� ������ �����Ͽ� ������ ���ҵ� �޿�
SELECT DISTINCT JOB FROM EMP;
--ANALYST:�޿�*1.1, CLERK:�޿�*1.2, MANAGER:�޿�*1.3, PRESIDENT:�޿�*1.4, SALESMAN:�޿�*1.5
SELECT EMPNO,ENAME,JOB,SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2
    ,'MANAGER',SAL*1.3,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "������ �Ǳ޿�" FROM EMP;
    
--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,������ �޿� �˻� - �ش� ������ �ƴ� ��쿡�� NULL �˻�
SELECT EMPNO,ENAME,DECODE(JOB,'ANALIST',SAL) "ANALIST",DECODE(JOB,'CLERK',SAL) "CLERK"
    ,DECODE(JOB,'MANAGER',SAL) "MANAGER",DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT"
    ,DECODE(JOB,'SALESMAN',SAL) "SALESMAN" FROM EMP;

--����1. ������̺��� �Ի����� 12���� ����� ���, �����, �Ի��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '%/12/%';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '__/12/__';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';

--����2.������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "�޿�" FROM EMP;

--����3.������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "�Ի���" FROM EMP;

--�׷��Լ� : �Ű������� �ټ��� ���� ���޹޾� �����Ͽ� ������� ��ȯ�ϴ� �Լ�

--COUNT(�÷���) : �Ű������� ���޹��� �÷����� ������ ��ȯ�ϴ� �Լ� - �˻����� ���� ��ȯ
SELECT COUNT(EMPNO) FROM EMP;

--�׷��Լ��� �ٸ� �˻����� ���� ����� ��� �׷��Լ��� �˻���� �˻����� ������ ���� �ٸ��Ƿ� ���� �߻�
SELECT EMPNO,COUNT(EMPNO) FROM EMP;--���� �߻�

--�׷��Լ��� NULL�� ������ ó������ �ʴ� ����� ��ȯ
SELECT COUNT(EMPNO),COUNT(COMM) FROM EMP;

--COUNT �Լ��� �÷��� ��� [*] ��ȣ�� ����Ͽ� ��� �÷��� ǥ���Ͽ� ���̺� ����� ���� ���� ��ȯ
SELECT COUNT(*) FROM EMP;

--MAX(�÷���) : �Ű������� ���޹��� �÷��� �� �ִ밪�� ��ȯ�ϴ� �Լ�
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP;
SELECT MAX(HIREDATE) FROM EMP;

--MIN(�÷���) : �Ű������� ���޹��� �÷��� �� �ּҰ��� ��ȯ�ϴ� �Լ�
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP;

--SUM(�÷���) : �Ű������� ���޹��� �÷���(���ڰ�)�� �հ踦 ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT SUM(SAL) FROM EMP;

--AVG(�÷���) : �Ű������� ���޹��� �÷���(���ڰ�)�� ����� ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT AVG(SAL) FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP ���̺� ����� ��� ����� ��� �������� ����Ͽ� �˻�
SELECT AVG(COMM) FROM EMP;--�˻� ���� : �������� NULL�� �ƴ� ����� ��� ������ ���
--NVL �Լ��� ����Ͽ� �������� NULL�� ��� 0���� ��ȯ�޾� ��� ������ ���
SELECT AVG(NVL(COMM,0)) FROM EMP;--��� ����� ��� ������ ���
SELECT CEIL(AVG(NVL(COMM,0))) "��� ������" FROM EMP;--��� ����� ��� ������ ���

--EMP ���̺� ����� ��� ����� ���� �ο��� �˻�
SELECT COUNT(*) FROM EMP;
--EMP ���̺� ����� ��� ����� �μ��� �����Ͽ� �ο��� �˻�
SELECT DISTINCT DEPTNO FROM EMP;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;

--GROUP BY : �׷��Լ� ���� �÷������� �׷��� ������ �����Ͽ� �˻��ϴ� ���
--�÷����� ���� ��� ���� �׷����� ó���Ͽ� �׷��Լ��� ����� ��ȯ
--����)SELECT �׷��Լ�(�÷���)[,�˻����,...] FROM ���̺�� [WHERE ���ǽ�]
--    GROUP BY {�÷���|�����|�Լ�},{�÷���|�����|�Լ�},...
--    [ORDER BY {�÷���|�����|��Ī|COLUMN_INDEX} {ASC|DESC},...]

--EMP ���̺� ����� ��� ����� �μ��� �����Ͽ� �ο��� �˻�
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;

--GROUP BY���� ����� ǥ����(�÷���|�����|�Լ�)�� �׷��Լ��� ���� �˻�������� �˻� ����
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;
--GROUP BY�� ǥ�������� �÷��� ��Ī ��� �Ұ���
SELECT DEPTNO DNO,COUNT(*) FROM EMP GROUP BY DNO;--���� �߻�

--EMP ���̺� ����� ��� ����� ������ ��� �޿��� ����Ͽ� �˻�
SELECT JOB,AVG(SAL) FROM EMP GROUP BY JOB;
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB;

--EMP ���̺��� ������ PRESIDENT�� ����� ������ ��� ����� ������ ��� �޿��� ��� �޿��� �������� �����Ͽ� �˻� 
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' 
    GROUP BY JOB ORDER BY AVG_SAL DESC;
    
--HAVING : GROUP BY�� ���� �׷�ȭ�� �˻�������� �׷������� ��(TRUE)�� ���� �׷츸 �˻��ϴ� ��� ����    
--����)SELECT �׷��Լ�(�÷���)[,�˻����,...] FROM ���̺�� [WHERE ���ǽ�]
--    GROUP BY {�÷���|�����|�Լ�},{�÷���|�����|�Լ�},... HAVING �׷����ǽ�
--    [ORDER BY {�÷���|�����|��Ī|COLUMN_INDEX} {ASC|DESC},...]

--EMP ���̺��� ������ PRESIDENT�� ����� ������ ��� ����� ������ ��� �޿��� ��� �޿��� �������� �����Ͽ� �˻� 
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP
    GROUP BY JOB HAVING JOB<>'PRESIDENT' ORDER BY AVG_SAL DESC;

--EMP ���̺� ����� ��� ����� �μ��� �޿� �հ� �� �޿� �հ谡 9000 �̻��� �μ���ȣ�� �޿� �հ� �˻�
SELECT DEPTNO,SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--����1.������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ� �˻�
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6;

--����2.������̺�κ��� �μ���ȣ,������ �޿��հ踦 ����ϰ��� �Ѵ�. ������ ���� ����� ����� �� �ִ� SQL���� �ۼ�
SELECT DEPTNO,SUM(DECODE(JOB,'CLERK',SAL)) "CLERK",SUM(DECODE(JOB,'MANAGER',SAL)) "MANAGER"
    ,SUM(DECODE(JOB,'PRESIDENT',SAL)) "PRESIDENT",SUM(DECODE(JOB,'ANALYST',SAL)) "ANALYST"
    ,SUM(DECODE(JOB,'SALESMAN',SAL)) "SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
    
--����3.������̺�κ��� �⵵��, ���� �޿��հ踦 ����� �� �ִ� SQL���� �ۼ�
SELECT TO_CHAR(HIREDATE,'YYYY') ��, TO_CHAR(HIREDATE,'MM') ��, SUM(SAL) FROM EMP
    GROUP BY TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY ��,��;

--����4.������̺��� �μ��� comm(Ŀ�̼�)�� �������� ���� ������ �հ� ������ ������ ���� ���ϴ� SQL�� �ۼ��Ͻÿ�.    
SELECT DEPTNO,SUM(SAL*12) "����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT DEPTNO,SUM((SAL+NVL(COMM,0))*12) "����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--����5.������̺��� SALESMAN�� ������ JOB�� �޿� �հ� �˻�
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB<>'SALESMAN' GROUP BY JOB;
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--JOIN : �ΰ��̻��� ���̺��� ���� �����Ͽ� ���ϴ� �÷����� �˻��ϱ� ���� ���

--EMP ���̺� ����� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--DEPT ���̺� ����� ��� �μ��� �μ���ȣ,�μ��̸�,�μ���ġ �˻�
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�ΰ��̻��� ���̺��� �÷����� �˻��ϱ� ���ؼ��� �ݵ�� �˻����� �����ϱ� ���� ������ �����Ͽ� �˻�
--ī�ٽþ� ���δ�Ʈ(CATSIAN PRODUCT) : �ΰ��̻��� ���̺��� �������� ���� �˻��� ��� �߻��Ǵ� �˻� ���
--�������� ���� �˻��� ��� �ΰ��̻��� ���̺� ����� ��� ���� ���� �����Ͽ� �˻� ��� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT;

--��������(EQUI JOIN) : �ΰ��̻��� ���̺��� �������ǿ� = �����ڸ� ����Ͽ� ��(TRUE)�� �ุ �����Ͽ� �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ ����
--���������� WHERE�� ���ǽ��� ����Ͽ� ����
--�ΰ��̻��� ���̺� ���� �̸��� �÷��� �����ϴ� ��� �ݵ�� [���̺��.�÷���] �������� �����Ͽ� ǥ��
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��̸�,�μ���ġ �˻�
--�������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ ����
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--���� ���̺� ���� �̸��� �÷��� ���ÿ� �˻��� ��� ù��°�� �˻��Ǵ� �÷��� ������ ������ �÷��� �̸���
--�ڵ����� ����Ǿ� �˻�
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--���� ���̺� ���� �̸��� �÷��� ���ÿ� �˻��� ��� �÷� ��Ī�� ����Ͽ� �˻��ϴ� ���� ����
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO EMP_DEPTNO,DEPT.DEPTNO DEPT_DEPTNO,DNAME,LOC 
    FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
    
--TABLE ALIAS : ���̺� �Ͻ������� ���ο� �̸��� �ο��Ͽ� ����ϴ� ��� - ���̺� ��Ī
--����)SELECT �˻����,... FROM ���̺�� ��Ī, ���̺�� ��Ī,...
--���̺� ���ս� ���̺��� �̸��� �����ϰ� ǥ���ϱ� ���� ����ϰų� �ϳ��� ���̺��� �ټ��� ���̺�� ǥ���ϱ� ���� ���
SELECT EMPNO,ENAME,SAL,E.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--���̺� ��Ī ���� �� ���� ���̺���� ����ϸ� ���� �߻�
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;--���� �߻�