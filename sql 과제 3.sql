use employee;

select
	*
from
	employee;
select
	*
from
	department;
select
	*
from
	job;
select
	*
from
	location;
-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)

select
	a.EMP_ID as 사번,
    a.EMP_NAME AS 이름,
    a.JOB_NAME AS 직급명,
    b.DEPT_TITLE AS 부서명,
    b.LOCAL_NAME AS 근무지역명,
    a.SALARY AS 급여
FROM
	(	SELECT 
			A.EMP_ID,
            A.EMP_NAME,
			A.DEPT_CODE,
			B.JOB_CODE,
            B.JOB_NAME,
            A.SALARY
		FROM
			employee A
		join
			job B on A.job_code = B.job_code) a
join 
	(   select 
			C.DEPT_ID,
            C.DEPT_TITLE,
            C.LOCATION_ID,
            D.LOCAL_NAME
		FROM
			department C
		join
			location D
            on C.LOCATION_ID=D.LOCAL_CODE) b
on
	a.DEPT_CODE = b.DEPT_ID
WHERE
	a.JOB_NAME = '대리'
    and
    b.LOCAL_NAME LIKE CONCAT('%' , 'ASIA','%');
    
-- 이런식으로 JOIN 을 자유롭게 연장하여 사용하면 더 간단하게 문제를 해결할수 있다

select
	a.EMP_ID as 사번,
    a.EMP_NAME AS 이름,
    B.JOB_NAME AS 직급명,
    C.DEPT_TITLE AS 부서명,
    D.LOCAL_NAME AS 근무지역명,
    a.SALARY AS 급여
FROM
	employee a
JOIN
	job B on a.JOB_CODE = B.JOB_CODE
JOIN
	department C on a.DEPT_CODE = C.DEPT_ID
JOIN
	location D ON C.LOCATION_ID = D.LOCAL_CODE
WHERE
	B.JOB_NAME = '대리'
    and
    D.LOCAL_NAME LIKE CONCAT('%' , 'ASIA','%');


-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)

SELECT
	a.EMP_NAME AS 사원명,
	a.EMP_NO AS 주민번호,
    a.DEPT_TITLE AS 부서명,
    b.JOB_NAME AS 직급명
from
	( select
		A.EMP_NAME,
        A.EMP_NO,
        A.JOB_CODE,
        B.DEPT_TITLE
        FROM 
			employee A
		join
			department B
		ON	
			A.DEPT_CODE = B.DEPT_ID) a
join
	job b 
    on a.JOB_CODE = b.JOB_CODE
WHERE 
		SUBSTRING(EMP_NO,1,2) between 70 AND 79
        AND
        a.EMP_NO LIKE '______-2%'
        and
        a.EMP_NAME LIKE '전%';
        
    
-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)

SELECT
	a.EMP_ID AS 사번,
    a.EMP_NAME AS 사원명,
    b.JOB_NAME AS 지급명
    
from
	employee a
join
	job b
on
	a.JOB_CODE = b.JOB_CODE
WHERE
	a.EMP_NAME LIKE CONCAT('%','형','%');
    

-- 4. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)

SELECT
	a.EMP_NAME,
    b.JOB_NAME,
    c.DEPT_ID,
    c.DEPT_TITLE
FROM
	employee a
join 
	department c 
on
	a.DEPT_CODE = c.DEPT_ID
JOIN
	job b
on	
	a.JOB_CODE = b.JOB_CODE
WHERE
	c.DEPT_TITLE LIKE CONCAT('%','해외영업','%');
    
	

-- 5. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)
SELECT
	A.EMP_NAME AS 사원명,
    A.BONUS AS 보너스포인트,
    B.DEPT_TITLE AS 부서명,
    C.LOCAL_NAME AS 근무지역명
FROM
	department B
JOIN
	employee A
ON
	A.DEPT_CODE = B.DEPT_ID
JOIN 
	location C
on
	B.LOCATION_ID = C.LOCAL_CODE
WHERE
	A.BONUS IS NOT NULL;
    


-- 6. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)

SELECT
	A.EMP_NAME AS 사원명,
    B.JOB_NAME AS 직급명,
    C.DEPT_TITLE AS 부서명,
    C.LOCAL_NAME AS 근무지역명
FROM
	employee A
JOIN job B ON A.JOB_CODE = B.JOB_CODE
JOIN
( SELECT 
	a.DEPT_ID,
	a.DEPT_TITLE,
    b.LOCAL_NAME
FROM
	department a
join location b on a.LOCATION_ID = b.LOCAL_CODE) C
ON A.DEPT_CODE = C.DEPT_ID
WHERE
	C.DEPT_ID = 'D2';


-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)

SELECT
	a.EMP_NAME AS 사원명,
    b.JOB_NAME AS 직급명,
    a.SALARY AS 급여,
	a.SALARY*11+a.SALARY*(1+coalesce(a.BONUS,0)) as 연봉
FROM
	employee a
join 
	job b on a.JOB_CODE = b.JOB_CODE
JOIN
	sal_grade c on a.SAL_LEVEL = c.SAL_LEVEL
WHERE
	a.SALARY > C.MIN_SAL;
    
    



-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.

SELECT
	A.EMP_NAME AS 사원명,
    B.DEPT_TITLE AS 부서명,
    C.LOCAL_NAME AS 지역명,
    C.NATIONAL_CODE AS 국가명
FROM
	department B
JOIN employee A ON A.DEPT_CODE = B.DEPT_ID
JOIN location C ON B.LOCATION_ID = C.LOCAL_CODE
WHERE
	C.NATIONAL_CODE IN('KO','JP');