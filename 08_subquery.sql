-- 관계형 데이터베이스
-- 2차원 표 같은 곳에 데이터를 저장하고 있는 것
-- 서로 다른 표들 끼리 관계를 가지고 있는 것
-- 식별자는 비어 있으면 안되고 (not null) 자주 바뀌는 값이 있으면 안된다, 중복 또한 있으면 안된다
-- 인조 식별자 : 테이블의 컬럼내에 적절한 식별자가 없는 경우 인위적으로 식별자를 만드는 것이다(ex> id_code, category_num 등등)
-- 중복되는 데이터를 없애기 위해서 테이블을 쪼개고 관련된 것을 인조 식별자를 통해서 테이블간 연결을 한다 (이것이 관계형 데이터베이스의 핵심이다)
-- ----------------------------------------------------------------------------------------------------------------
-- subqueries
-- 다른 쿼리 내에서 실행되는 쿼리이다
-- select 부터 ; 까지를 하나의 쿼리라고 한다
-- subquery 의 결과를 활용하여 복잡한 mainquery 를 작성해 한번에
-- 여러작업을 수행 할 수 있다

-- tbl_menu 테이블에서 민트 미역국과 같은 카테고리 코드를 가지고 있는 행들의 모든 정보를 조회하시오

select
	category_code
from
	tbl_menu
where
	menu_name like '민트미역국';       -- subquery
    
select
	*
from
	tbl_menu
where
	category_code = 4;				-- mainquery

-- 쿼리문을 2개나 작성해야하는 비효율성이 발생 이를 해결하는 방법

select
	*
from
	tbl_menu
where
	category_code =	(
						select 
							category_code
						from 
							tbl_menu
						where
							menu_name = '민트미역국'
					);
                    
-- count() : 특정 열 또는 행의 수를 반환 하는데 사용
select 
	category_code
   ,count(*) as count
from
	tbl_menu
group by
	category_code;
    
-- from 절에 쓰인 서브쿼리(derived table, 파생 테이블)
-- 반드시 자신의 별칭이 있어야 한다
-- 이 count 라는 컬럼이 가진 가장 큰 값 -> 6 이라는 값을 도출하고 싶다
-- max() : 최댓값을 반환

select
	max(count)
from
	( select
		category_code
	   ,count(*) as count
	  from
		tbl_menu
	  group by 
		category_code) as countmenu;  -- 이런식으로 subquery 의 이름을 지정해주어야 한다
        
-- 이런식으로 일정한 조건에 맞는 테이블을 가상의 테이블로써 사용이 가능하다 이를 파생 테이블이라고 한다

-- 상관 서브쿼리
-- 메인 쿼리가 서브쿼리 결과에 영향을 주는 경우 상관서브쿼리 라고 한다

-- tbl_menu 테이블에서 카테고리 코드가 4번인 친구들의 메뉴 가격 평균을 조회하시오

select
	avg(menu_price) as average
from
	tbl_menu
where
	category_code =4;
    
-- 카테고리별 평균 가격보다 높은 가격의 메뉴의 메뉴코드, 메뉴이름, 메뉴가격, 카테고리 코드를 조회하시오
	
select
	menu_code
    ,menu_name
    ,menu_price
    ,category_code
from
	tbl_menu a
where
	menu_price > (
    select
     avg(menu_price)
     from
     tbl_menu 
     where
     category_code = a.category_code);
     
-- cte(common table expressions)
-- 파생 테이블과 비슷한 개념이며 코드의 가독성과 재사용성을 위해 파생테이블
-- 대신 사용하게 된다

select
	a.menu_name,
    b.category_code
from
	tbl_menu a
join
	tbl_category b on a.category_code = b.category_code;
    
with menucate as (
	select
		a.menu_name,
		b.category_code
	from
		tbl_menu a
	join
		tbl_category b on a.category_code = b.category_code
        )       -- 해당 테이블을 menucate라는 별칭으로 가상의 테이블을 만든것이다
        
select
	*
from
	menucate;

			

	



	