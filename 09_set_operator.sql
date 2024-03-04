-- 두개 이상의 select 문의 결과 집합을 결합하는데 사용한다

-- union
-- 두개 이상의 select 문의 결과를 결합하여 중복된 레코드를 제거후 
-- 반환하는 sql 연산자이다
-- 두 데이터를 합치면 중복되는 데이터는 값이 2개가 되는데 그중 하나를 제거 하고 반환하는 것이다 (합집합이다)

-- 1
select
	*
from
	tbl_menu
where
	category_code = 10
union
-- 2
select
	*
from
	tbl_menu
where
	menu_price < 9000;
    
-- 1번 쿼리와 2번 쿼리를 하나로 묶고 싶다

-- union all
-- 두개 이상의 select 문의 결과를 결합하여 중복된 레코드를 제거하지 않고 모두 반환 (합집합 + 교집합)

-- 1
select
	*
from
	tbl_menu
where
	category_code = 10
union all
-- 2
select
	*
from
	tbl_menu
where
	menu_price < 9000;
    
-- intersect
-- 두 select 문의 결과 중 공통되는 레코드만 반환하는 sql 연산자이다
-- mysql 은 intersect를 제공하지 않는다
-- 하지만 inner join 또는 in 연산자를 활용해서 구현하는 것은 가능하다

-- inner join 활용
-- 1
select
	 menu_code,
     menu_name,
     menu_price,
     category_code,
     orderable_status
from
	tbl_menu;
    
-- 2
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
	tbl_menu
where
	menu_price < 9000;

-- 결과
select
	 a.menu_code,
     a.menu_name,
     a.menu_price,
     a.category_code,
     a.orderable_status
from
	tbl_menu a
inner join
	(
		select
			menu_code,
			menu_name,
			menu_price,
			category_code,
			orderable_status
		from
			tbl_menu
		where
			menu_price < 9000) as b on (a.menu_code = b.menu_code);


