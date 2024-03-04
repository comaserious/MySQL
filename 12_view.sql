use menudb;

-- cte : 쿼리내부 ( 1개의 쿼리문) 에서 with ~ as 절을 사용해서 "임시"로 정의되는 테이블 ( 즉 쿼리문이 끝나는 ; 이 지나가면 더이상 쓸수 없는 테이블인것이다)

-- view 
-- select 쿼리문을 저장한 객체로 가상테이블 이라고 불린다
-- 실질적인 데이터를 물리적으로 저장하지 않고, 쿼리만 저장했지만
-- 테이블을 사용하는 것과 동일하게 사용 할 수 있다

-- view 는 데이터를 쉽게 읽고 이해할수 있도록 돕는 동시에
-- 원본 데이터의 보안을 유지하는데 도움이 된다 ( 테이블의 모든 컬럼을 전부다 보여주지 않고 일부만 보여줄수 있다)

select * from tbl_menu;

-- view 생성
create view hansik as
select menu_code, menu_name, menu_price, category_code, orderable_status
from tbl_menu
where category_code = 4;

select * from hansik;       --  실제로 menudb 에 테이블이 생성 되지 않았지만 가상의 테이블 hasik 테이블이 생성된것을 확인 할 수 있다

-- view 라는 가상의 테이블은 베이스테이블(tbl_menu) 의 정보가 변경되면
-- view 의 결과도 같이 변경된다

insert into tbl_menu
value(null,'식혜맛국밥',5500,4,'Y');

select * from tbl_menu;
select * from hansik;

insert into hansik
value(null, '초콜릿게장',22000,4,'Y');
select * from hansik;
select * from tbl_menu;   -- 결국 쌍방향으로 값이 들어간다 베이스 테이블이던 view 던 

update hansik
set menu_name = '버터국밥',
menu_price = 5500
where 
menu_code = 23;

select * from hansik;
select * from tbl_menu;

-- view로 dml 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중 베이스테이블 컬럼이 not null 제약 조건이 지정된 경우
-- 3. 산술표현식이 정의된 경우
-- 4. join 을 이용해 여러 테이블을 연결한 경우
-- 5. distinct 를 포함한 경우
-- 6. 그룹함수 (avg, sum 등등) 이나 group by 절을 포함한 경우

-- view 삭제
drop view hansik;

select * from hansik;   -- 더이상 조회가 불가능 하다