-- 형변환
-- sql 데이터 형변환은 명시적 형변환과 암시적(묵시적) 형변환이 있다

-- 명시적 형변환(Explicit Conversion) 

-- cast(표현식 as 데이터 형식[(길이)])
-- convert( 표현식, 데이터형식[(길이)])    [] 생략 가능 따라서 (길이) 는 없어도 된다

-- 데이터 형식으로 가능한 것은 BINARY, CHAR , DATE, DATETIME, JSON,DECIMAL , SIGNED INTEGER
-- TIME , USIGNED INTEGER

-- SINGNED : 부호가 있는 정수
-- UNSIGNED : 부호가 없는 정수

select avg(menu_price) from tbl_menu;

select cast( avg(menu_price) as signed integer) from tbl_menu;

select convert(avg(menu_price), Signed integer ) from tbl_menu;

select cast( '2024$3$4' as Date);
select cast( '2024/3/4' as Date);
select cast( '2024-3-4' as Date);
select cast( '2024@3@4' as Date);

-- 메뉴의 가격 구하기
select
	concat( cast(menu_price as char(5)), '원')        -- concat() "문자열" 붙이기 임으로 정수 값을 문자열로 casting 해주어야 한다
from
	tbl_menu;
    
-- 암시적 형변환( Implicit Conversion)
-- 따로 처리 하지 않아도 내부적으로 자동으로 형변환이 이루어진다

select '1' + '2';     -- 각 문자가 정수로 변환됨
select concat(menu_price , '원') from tbl_menu ;       -- menu_price 가 문자로 변환됨
select 3 > 'May' ;        -- 문자는 0 으로 반환됨 따라서 (true 인 0 이나옴)

select 5 > '6May' ;       -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다 (따라서 false 1 이 출력됨)
select 5 > 'M6ay' ;       -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 반환된다

select '2024-5-30';       -- 날짜 형으로 바뀔수 있는 문자들은 DATE 형으로 변환된다