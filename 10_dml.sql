-- DML(Data Manipulation Language)
-- 데이터 조작언어, 테이블에 값을 삽입하거나 수정하거나 삭제하는 (select 는 단순 조회하는것이지 데이터의 변화는 없기 때문에 제외하는 것이다)
-- (데이터베이스 내의 데이터를 조작하는데 사용하는) SQL 의 한 부분이다

-- insert
-- 새로운 행을 추가하는 구문이다
-- 테이블의 행의 수가 증가한다

-- 테이블 정보 확인용
select
	*
from
	tbl_menu;
-- -------------------------------------------------------------------------------    
insert  				-- 삽입할거야
into tbl_menu           -- 어디에? tbl_menu에 
value (null,'바나나해장국',8500,4,'Y');       -- value (~) : 이러한 값을 집어 넣을거임

-- 테이블의 정보확인 describe
describe tbl_menu;     
-- 정보를 확인해보면 menu_code 의 타입은 int 이고 auto_increment 라고 쓰여있다
-- auto_increment : 자동으로 증가되는 기능 / 값을 넣지 않는다면 자동으로 번호를 부여함 ( 따라서 insert 의 value 값 가장 앞의 category_code 에 null 을 집어넣어 자동으로 증가시킴)   
-- null 허용가능한(nullable) 컬럼이나 auto_increment 가 있는 컬럼은 null 을 부여 할 수있다

insert into tbl_menu(menu_name, menu_price,category_code,orderable_status)  -- 띄어쓰기 하면 안된다 
value('초콜릿',6500,7,'Y');          -- menu_code 는 auto_increment 이기 때문에 쓰지 않아도 자동으로 부여받는다

-- multi insert
insert into
	tbl_menu
value 
	(null,'참치맛아이스크림', 1700,12,'Y')
   ,(null,'멸치맛아이스크림', 1500,11,'Y')
   ,(null,'소시지맛아이스크림', 2500,8,'Y');

select * from tbl_menu;

-- update
-- 테이블에 기록된 컬럼의 값을 수정하는 구문
-- 테이블의 전체 행 갯수에는 변화가 없다

-- 수정 대상
select
	*
from
	tbl_menu
where
	menu_name = '민트미역국';
    
update tbl_menu
set
	category_code = 7,            -- category_code 를 7로 수정하겠다
    menu_name = '민트초코'          -- 이런식으로 다중으로 업데이트 할수있다
where
	menu_code =7;        -- 어떤 녀석을 ? menu_code가 7인 놈을

select
	*
from
	tbl_menu
where
	menu_name = '민트초코';
    
-- delete
-- 테이블의 행을 삭제하는 구문이다
-- 테이블의 행의 갯수가 줄어든다

-- 삭제 확인 용
select * from tbl_menu;

delete from tbl_menu

where menu_name = '소시지맛아이스크림';

-- limit 을 활용한 delete

select * from tbl_menu;

delete from tbl_menu
order by menu_price
limit 3;

-- 테이블 행 전체 삭제
delete from tbl_menu;
    
select * from tbl_menu;
-- 연습--------------------------------------------------------------------------------------------
insert into tbl_menu
value (null,'카레맛똥',3000,1,'Y');

select * from tbl_menu;

insert into tbl_menu
value (null,'똥맛카레',12000,2,'Y')
	 ,(null,'하늘에서 내리는 똥',2222,3,'N')
     ,(null,'맛있는 카레',43000,4,'N');
     
select * from tbl_menu;

update tbl_menu
set orderable_status ='Y'
where 
menu_code = 31;

insert into tbl_menu(menu_price,category_code,orderable_status,menu_name)

value (30000,5,'Y','황금맛 초콜릿');

insert into tbl_menu
value (null,'독맛사과','2000',5,'Y');

select * from tbl_menu;

update tbl_menu
set menu_name = '카카오 0% 초콜릿'
where menu_code = 32;

select * from tbl_menu;

update tbl_menu
set menu_name = '하늘맛 사탕'
where menu_code =30;

select * from tbl_menu;
-- 연습 종-----------------------------------------------------------------------------------------------------------------

-- replace
-- update : 특정 조건을 만족하는 행의 값을 update 함.
-- replace : 특정 행이 이미 존재하는 경우에는 그 행을 갱신
-- 			 그렇지 않은 경우 새 행을 삽입
-- 			 즉, 해당 행을 삭제하고 새로운 값을 삽입하는 것이다

select * from tbl_menu;

-- insert 시 primary key 또는 unique key 가 중복이 발생하면 충돌이 발생한다.
-- insert into tbl_menu value(1,'열무김치아메리카노',5000,8,'Y');       -- menu_code 는 프라이머리 키로 중복이 불가능

describe tbl_menu;        -- menu_code 가 primary 키임을 확인 할 수 있다

-- into는 생략이 가능하다
replace into tbl_menu value(1,'열무김치아메리카노',5000,8,'Y');  -- 이렇듯 프라이머리키가 중복 될때는 relplace 를 통해 교체를 할 수 있다

select * from tbl_menu;

replace tbl_menu
set menu_code = 2,
	menu_name= '우럭주스',
    menu_price=2000,
    category_code = 9,
    orderable_status = 'N';



