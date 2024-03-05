-- grouping
-- group by 절은 결과 집합을 특정 열의 값에 따라 그룹화 하는데 사용된다
use menudb;

select 
	category_code
from 
	tbl_menu;
    
select
	category_code
from 
	tbl_menu
group by 
	category_code;
    
-- count() : 갯수를 세준다
select 
	category_code,
    count(*)
from
	tbl_menu
group by category_code;

-- sum() : 합계
select
	category_code
    ,sum(menu_price)
from
	tbl_menu
group by
	category_code;
    
select 
	category_code
    ,avg(menu_price)
from 
	tbl_menu
group by
	category_code;

select
	category_code
    ,menu_price
    ,count(*)
from
	tbl_menu
group by
	category_code,
    menu_price;

-- rollup
-- 컬럼들의 총합을 구하는 방식
select
	category_code,
    sum(menu_price)
from 
	tbl_menu
group by
	category_code
with rollup;

select
	category_code,
    menu_price,
    sum(menu_price)
from
	tbl_menu
group by
	category_code,
    menu_price
with rollup;

select 
	menu_price,
    category_code
from
	tbl_menu
group by
	category_code
having category_code between 5 and 8; -- where 가 사용이 안된다

select
	menu_price,
    category_code,
    menu_name
from 
	tbl_menu
group by
	category_code
having
	menu_name like '민트';

-- group by 를 쓴 쿼리의 경우 where 이 아닌 having 으로 조건을 집어넣는다 ( 또한 select 로 조회한 것만 having을 쓸수 있다)
    
    