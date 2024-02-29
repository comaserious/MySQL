-- distinct
-- distinct 는 중복된 값을 제거하는데 사용된다
-- 칼럼에 있는 칼럼들의 종류를 쉽게 파악할 수 있다

select 
	*
from
	tbl_menu
order by
	category_code;
    
-- 단일 열(칼럼) 중복 제거
select
	-- menu_code,   안되는 이유는 중복된 category_code 중에 어떤걸 조회할지 알 수가 없기 때문에 오류가 나는것이다
	distinct category_code
from 
tbl_menu
order by 
category_code;

-- null 값을 포함한 열의 distinct 사용
select *
from tbl_category;

select 
	distinct ref_category_code
from tbl_category;         -- 중복 된 null 하나의 종류로 포함해서 출력되는 것을 확인 할 수 있다

-- 다중 열(column) distinct 사용
-- 다중열의 값들이 모두 동일하면 중복된 것으로 판별한다

select 
	category_code,
    orderable_status
from
	tbl_menu;
    
select distinct                  -- 조회한 두가지 값이 모두 동일한 것을 하나의 종류로 파악한다 따라서 둘중 하나라도 다른게 있다면 다른 종류가 되는 것이다
    category_code,
    orderable_status
from tbl_menu
order by 
	category_code;


