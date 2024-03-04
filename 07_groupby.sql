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
    