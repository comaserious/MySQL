-- where
-- where 절은 특정 조건에 맞는 레코드만 선택하는데
-- 사용되며, 다양한 방법으로 조건을 설정할 수 있다

select
	menu_name
   ,menu_price
   ,orderable_status
from
	tbl_menu
where 
	orderable_status = 'Y';
    
-- tbl_menu 테이블에서 메뉴이름, 가격, 판매상태를 조회할건데 메뉴가격이 13000원 이상인 친구들만 조회

select
	menu_name
   ,menu_price
   ,orderable_status
from 
	tbl_menu
where 
	menu_price >=13000;
    
-- tbl_menu 테이블에서 메뉴코드, 이름, 판매상태를 조회할건데 판매상태가 Y가 아닌 애들만 조회해줘

select 
	menu_code
   ,menu_name
   ,orderable_status
from
	tbl_menu
where
-- (!= , <>) 부정 연산자이다
	orderable_status <> 'Y';

-- tbl_menu 에서 메뉴 코드, 이름 ,가격 조회할건데 가격이 20000 초과인 녀석들만 조회

select
	menu_code
   ,menu_name
   ,menu_price
from 
	tbl_menu
where
	menu_price > 20000;
    
select 
	menu_code
   ,menu_name
   ,menu_price
from
	tbl_menu
where
	menu_price <= 20000;
    
-- tbl_menu 테이블에서 메뉴코드, 이름, 가격 을 조회 10000원 이상 20000이하 조회

select
	menu_code
   ,menu_name
   ,menu_price
from 
	tbl_menu
where
	menu_price >=10000 AND menu_price <=20000;
    -- AND 아니면 && 둘다 사용 가능
    
-- and / or 연산자
-- where 절과 함께 사용을 하며 
-- or 는 둘중 하나라도 true면 true를
-- and 는 둘중 하나라도 false면 false를 반환한다
-- or 둘다 null 이 아니면서 하나라도 0 이 아닌 값이 있을 경우 1을 반환한다

-- or 테스트

select 1 or 1, 1 or 0, 0 or 1;
select 0 or 0;

select
	menu_name
   ,menu_price
   ,category_code
   ,orderable_status
from
	tbl_menu
where 
	orderable_status ='Y'
    or category_code = 10
order by
	category_code;
    
-- tbl_menu 에서 모든 컬럼을 조회하는데,
-- 가격이 5000원 넘거나 카데고리 코드가 10인 녀석들

select
	*
from
	tbl_menu
where
	menu_price>5000
 or category_code =10
 order by 
	menu_code;

-- (and) 연산자
-- and 연산자와 함께 where 절 사용

select 1 and 1 ;
select 1 and 0 , 0 and 1, 0 and 0;

-- tbl_menu 테이블에서 모든 컬럼을 조회하는데, 판매상태가 y 이면서 카테고리코드가 10인 녀석들만 조회

select
	*
from 
	tbl_menu
where
	orderable_status = 'Y'
    and
    category_code=10;
    
-- and 와 or 의 우선순위
-- and 가 or 보다 우선순위가 높다.
-- 따라서 or 의 우선순위를 높이고 싶으면 소괄호를 사용한다

select 
	*
from
	tbl_menu
where
	category_code =4
    or 
    menu_price = 9000
    and
    menu_code >10;
    
-- between 연산자랑 where

select 
	menu_name
   ,menu_price
   ,category_code
from
	tbl_menu
where
	menu_price between 10000 and 20000;
    
-- 부정 between
select 
	menu_name
   ,menu_price
   ,category_code
from
	tbl_menu
where
	menu_price not between 10000 and 20000;
    
-- like 연산자
-- tbl_menu 테이블에서 메뉴이름, 가격을 조회하는데
-- 메뉴이름이 '마늘'이라는 단어를 포함하고 있는 녀석들만 조회해줘

select
	menu_name
   ,menu_price
from
	tbl_menu
where
	menu_name like '%마늘%';
    
-- tbl menu 테이블에서 모든 칼럼을 조회하는데
-- 가격이5000원이 넘으면서 카테고리 코드 10이면서 '갈치'를 포함하는 녀석들

select
	*
from 
	tbl_menu
where
	menu_price >5000
    and
    category_code =10
    and
    menu_name not like '%갈치%';
    
-- in 연산자 활용
-- tbl_menu 테이블에서 메뉴이름, 카테고리코드 조회하는데
-- 카테고리 코드 가 4,5,6 인 애들 조회

select 
	menu_name
    ,category_code
from
	tbl_menu
where 
	category_code =4
    or
    category_code=5
    or
    category_code=6;
    
-- 너무 귀찮다

select
	menu_name
    ,category_code
from
	tbl_menu
where
	category_code in (4,5,6);    -- 역시나 not in 을 이용해 4,5,6 포함하지 않은 값을 찾을수도 있다
    
-- is null 연산자 활용
select
	category_code
    ,category_name
    ,ref_category_code
from
	tbl_category
where
-- ref_category_code = null;         = 연산자로 찾을 수 는 없다
ref_category_code is null;           -- is null 을 통해서 찾는게 좋다 (부정문은 is not null 이다)
    