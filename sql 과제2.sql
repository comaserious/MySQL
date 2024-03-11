USE employee;
-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.
SELECT EMP_NO,
	   year(cast(substring(EMP_NO,1,6) as date)),
       month(cast(substring(EMP_NO,1,6) AS DATE)),
       DAY(CAST(SUBSTRING(EMP_NO,1,6) AS DATE))
FROM employee;

select 
	EMP_NAME AS '사원명',
    concat('19',SUBSTRING(EMP_NO,1,2)) as '생년',
    substring(EMP_NO,3,2) as '생월',
	SUBSTRING(EMP_NO,5,2) as '생일'        -- DATE로 캐스팅하기에는 맞지 않는 숫자체계가 있어 string 값을 출력하여 값을 바꿨다
FROM employee;

    
-- 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회
describe employee;      -- 입사일은 date 타입이다 바로 사용 가능
select
	year(HIRE_DATE) AS '입사년도',
    MONTH(HIRE_DATE) AS '입사월',
    DAY(HIRE_DATE) AS '입사날짜'
from
	employee;

-- WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회
select * from employee;

select
	*
from
	employee
where
	substring_index(EMP_NO,'-',-1) LIKE '2%';

-- 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력
select
	EMP_NAME,
    RPAD(SUBSTRING(EMP_NO,1,7),14,'*')
FROM
	employee;

-- EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회

select * from employee;
SELECT
	EMP_NAME,
    SUBSTRING_INDEX(EMAIL,'@',1)
FROM
	employee;


-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회
select
	EMP_NAME,
    HIRE_DATE,
    adddate(HIRE_DATE,interval 6 month)
FROM
	employee;

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
SELECT 
	*
FROM 
	employee
WHERE 
	DATEDIFF(CURDATE(),HIRE_DATE)/365 >= 20;

-- EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요
select
	EMP_NAME,
    HIRE_DATE,
    DATEDIFF(LAST_DAY(HIRE_DATE),HIRE_DATE)
FROM
	employee;

-- EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회
SELECT 
	EMP_NAME,
    HIRE_DATE,
    YEAR(curdate())-YEAR(HIRE_DATE) AS '근무년수'
from
	employee;
-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)
select *
from employee
where
EMP_ID%2!=0;