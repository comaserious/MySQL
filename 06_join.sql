-- join
-- 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합하는데 사용된다
-- 두 개 이상의 테이블은 반드시 연관있는 칼럼이 존재해야 하며,
-- 이를 통해 join 된 테이블들의 칼럼을 모두 사용 할 수 있다

-- alias (as) 
-- sql 문의 컬럼 또는 테이블에 별칭을 달아줄 수 있다
-- 이러한 별칭을 alias 라고 한다

-- 별칭에 띄어쓰기나 특수기호가 없다면 single quatation (') 와 as 는 생략 가능
select 
	menu_code as 'code'
   ,menu_name name
   ,menu_price as 'price'
from
	tbl_menu
order by
	price;
    
-- 테이블 별칭
-- 테이블 별칭을 작성할 수 있으며 어떤 테이블 소속인지를 쉽게 알 수 있게 한다

select
	a.category_code
   ,a.menu_name
from
	tbl_menu a;
    
-- join 의 종류
-- inner join
-- 두 테이블의 교집합을 반환하는 join 유형
-- inner join 에서 inner 키워드는 생략이 가능

select
	menu_name
  --  category_name    from 테이블 상에 존재하지 않는 컬럼이다 따라서 오류가 발생하게 된다
from 
	tbl_menu;
    
-- on 키워드를 활용한 join
-- 칼럼명이 같거나 다를 경우 on 으로 연관 있는 컬럼에 대한 조건 작성하여
-- join

select 
	b.category_name
   ,a.category_code
from
	tbl_menu a
join
	tbl_category b on a.category_code = b.category_code;

-- using 을 활용한 join 
-- 칼럼명이 같을 경우 using 으로 서로 연관있는 칼럼에 대한 조건을 작성하여
-- join 하는 경우

select
	a.menu_name
   ,b.category_name
from
	tbl_menu a
join
	tbl_category b 
using
	(category_code);

-- left join (from 에 있는 테이블이 첫번째(left) 테이블로 생각해야한다 그후 join 하는 테이블이 right 테이블 인것이다)
-- 첫 번째 (왼쪽) 테이블의 모든 레코드와 두 번째 (오른쪽) 테이블에서 일치하는 레코드를
-- 반환 하는 sql join 유형

select 
	a.menu_name
   ,b.category_code
   ,a.category_code
from 
	tbl_category b
left join 
	tbl_menu a on a.category_code = b.category_code;
    
-- right join
-- 두번째(오른쪽) 테이블의 모든 레코드와 첫번째(왼쪽) 테이블에서 일치하는 레코드를 반환하는
-- sql join 유형

select
	b.category_name
   ,a.menu_name
from 
	tbl_category b
right join
	tbl_menu a on a.category_code = b.category_code;
    
-- cross join
-- 두 테이블의 모든 가능한 조합을 반환하는 sql join 유형

select
	a.menu_name
   ,b.category_name
from
	tbl_menu a
cross join 
	tbl_category b;

-- inner join은 교집합만을 출력해주는 join
-- outter join(left, right) 은 합집합을 보여주는 join
-- cross join 은 가능한 모든 조합을 제공해준다

-- self join 
-- 같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용되는 sql join 유형
select
	*
from
	tbl_category;

select 
	a.category_name
   ,b.category_name
from
	tbl_category a
join
	tbl_category b on  a.ref_category_code = b.category_code ;

-- select : 셀렉트한 데이터를 출력할것이다
-- from : (right가 아닌이상) from 문에 적은 테이블을 기준으로 하겠다
-- join :join 문에 적은 테이블을 기준 테이블에 붙이겠다
-- on : 무엇을 기준으로 붙일것인가? (예제로는 ref_category_code에 해당하는 category_name을 전부다 출력 하고 거기에다가 ref_category_code와 category_code가 같으면 category_name 을 붙이겠다

-- (inner) join : on 문에 적은 테이블이 같은 것들 만 출력
-- left join : from tbl 기준이기 때문에 from 테이블은 전부 출력후 join 한 테이블을 on 에 적힌 조건에 맞는 것들을 붙이겠다
-- right join : 기준 테이블이 from 이 아닌 join 문에 적은 테이블 기준
-- crorss join : 가능한 모든 조합을 출력





