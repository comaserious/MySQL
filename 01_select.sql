-- select 절은 Mysql의 가장 기본적인 명령어로 특정 테이블에서 원하는 데이터를 조회 할 수 있다

SELECT            -- 조회 해줘
	menu_name     -- 이걸 
FROM              -- 어디서? 
	tbl_menu;     -- 여기서
select 
	menu_code
   ,menu_name
   ,menu_price
from
	tbl_menu;

-- tbl_menu 테이블에서 메뉴 코드 와 카테고리코드, 메뉴가격을 조회해줘

select 
	menu_code
   ,category_code
   ,menu_price
from
	tbl_menu;

-- tbl_menu 테이블에서 모든 컬럼을 조회해줘
select
	menu_code
   ,menu_name
   ,menu_price
   ,category_code
   ,orderable_status
from 
	tbl_menu;

-- 개선
select
	*
from
	tbl_menu;

-- mysql 도 내장 함수가 존재

select 
	now();

select 
	concat('조',' ','평훈');

-- column 에 별칭을 부여할수 있다
select 
	concat('조',' ','평훈') as 내이름 ;
select 
	concat('조','평','훈') as  '내 이름';    -- 뛰어 쓰기나 특수기호가 들어가 가게 되면은 '' single quatation으로 감싸줘야한다