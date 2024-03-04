-- build in functions
-- MySQL 은 문자열, 숫자, 날짜, 시간 에 관한 다양한 작업 수행에 많은
-- 내장 함수를 제공하고 있다


-- concat(문자열 1, 문자열 2, ....)
-- concat_ws(구분자, 문자열1, 문자열2 .....)

select concat( '호랑이','기린','토끼');

select concat_ws('/','호랑이','기린','토끼');
select concat_ws('-','2024','05','06');

-- elt : 해당 위치의 문자열 반환
-- field : 찾을 문자열 위치 반환
-- find_in_set : 찾을 문자열 위치 반환
-- instr : 기준 문자열에서 부분 문자열의 시작 위치 반환
-- locate : instr 과 동일하고 순서만 반대

select
	elt(2,'사과', '딸기','바나나'),
    field('딸기', '사과', '딸기', '바나나'),
    find_in_set('바나나','사과,딸기,바나나'),
    instr('사과딸기바나나','딸기'),
    locate('딸기','사과딸기바나나');
    
-- format (숫자, 소수점 자리수)
-- 1000 단위 마다 콤마(,) 표시를 해주며 소수점 아래 자릿수까지 반올림 표현한다

select format(12142412352351243511.2131242412435354214,3);        -- 천단위로 콤마를 달아주고 , 소숫점 아래 3자리수까지 나타낸다

-- insert(기준 문자열, 위치,길이,삽입할 문자열);

select insert('내 이름은 아무개 입니다',7,3,'이호준');           -- 인덱스 체계가 아니다 첫글자는 1부터 시작한다ㅏ

-- left , right
-- left : 왼쪽에서 문자열의 길이만큼을 반환 
-- right : 오른쪽에서 문자열의 길이만큼 반환

select left('hello world',3);          -- hel
select right('hello wordl',3);         -- rdl

-- upper, lower
select upper('hello world');         -- 모든 문자열을 대문자로 변환
select lower('hello world');		 -- 모든 문자열을 소문자로 변환

-- lpad(문자열, 길이, 채울 문자열) , rpad( 문자열 , 길이, 채울 문자열)
-- lpad 문자열을 길이만큼 왼쪽으로 늘린후에 빈곳을 문자열로 채운다

select lpad('왼쪽',6,'@'), rpad('오른쪽',6,'@');

-- ltrim(문자열) , rtrim(문자열)
-- ltrim(문자열)은 왼쪽 공백을 제거한다

select ltrim('             공백              ');

-- trim(문자열), trim(방향 자를 문자열 from 문자열)
-- 방향 : leading(앞) , both(양쪽) , trailing(뒤) 해당 방향에 대한 지정한 문자열을 제거 할 수 있다

select trim(both '@' from '@@@@@@chelsea@@@@@@@@@');

-- repeat(문자열, 횟수)
-- replace(문자열, 찾을 문자열, 바꿀 문자열);
-- reverse(문자열) 뒤집는다

select replace('MySQL','My','마이');

-- substring(문자열, 시작 위치, 길이)
-- 시작 위치부터 길이 만큼의 문자를 반환(길이를 생략하면 시작위치부터 끝까지 반환)

select substring('안녕하세요 반갑습니다',7,2) , substring('안녕하세요 , 반갑습니다 ' , 7);        -- 자바와 달리 이것또한 인덱스번호 체계가 아니다 

-- substring_index(문자열, 구분자, 횟수) 
-- 구분자가 왼쪽 부터 횟수번째 나오면 그 이후의 오른쪽은 버린다
-- 횟수가 음수일 때는 오른쪽 부터세고 왼쪽을 버린다

select substring_index('hong.test@gmail.com','.',2);
select substring_index('hong.test@gmail.com','.',-2);

-- 수학 관련 함수
-- abs(숫자) : 절댓값 반환

select abs(-123);

-- ceiling(숫자) : 올림값 반환
-- round(숫자) : 반올림
-- floor(숫자) : 내림

select ceiling(123.36) , floor(123.56) , round(123.56);

-- mod (숫자1, 숫자2) or 숫자1 % 숫자2 or 숫자1 mod 숫자2
-- 숫자1을 숫자2로 나눈후 나머지 값을 반환

select mod(12,5) , 12%5 , 12 mod 5;

-- pow(숫자1 , 숫자2 ) 
-- 숫자 1의 숫자2승
-- sqrt(숫자) : 제곱근을 추출

select pow(2,4) , sqrt(16);

-- rand() : 0 이상 1미만의 실수를 구한다 
-- m<= 임의의 정수 < n 을 구하고 싶다
-- floor( rand()*(n-m)+m)

-- 1부터 10까지 변수
select rand();
select floor(10*rand() +1);

-- sign(숫자)
-- 양수면 1 0 이면 0 음수면 -1 을 반환한다
select sign(123) , sign(0) , sign(-123);

-- truncate(숫자, 정수) ; 
-- 소수점을 기준으로 정수 위치까지 구하고 나머지 버림

select truncate(123144.123142,2);
select truncate(123144.123142,-2);    -- 음수이면 반대로 소수점 기준으로 왼쪽으로 없애고 0을 붙인다

-- 날짜 및 시간 관련 함수
-- adddate(날짜, 차이) : 날짜를 기준으로 차이를 더함
-- subdate(날짜, 차이) : 날짜를 기준으로 차이를 뺌

select adddate('2024-03-04',interval 30 day);
select adddate('2024-03-04',interval 6 month);
select adddate('2024-03-04',interval 6 year);

select subdate('2024-03-04',interval 30 day);
select subdate('2024-03-04',interval 6 month);
select subdate('2024-03-04',interval 6 year);

-- addtime(날짜/시간, 시간)
-- subtime(날짜/시간, 시간)

select addtime('2024-03-04 17:42:00','0:30:00');
select subtime('2024-03-04 17:42:00','0:30:00');

-- curdate : 현재 년-월-일
-- curtime : 현재 시:분:초
-- now() or sysdate() : 현재 연-원-일 시:분:초

select curdate() , curtime(), now(), sysdate();

-- year(날짜) , month(날짜) , day(날짜) 
-- 연, 월 ,일, 초 ,시,분,초, 밀리초

select year(curdate())  , month(curdate()), day(curdate()) , second(curtime());          -- 이런식으로 괄호안에 값을 추출할수 있다

-- datediff(날짜 1, 날짜 2 ) 
-- timediff(날짜 1 or 시간1 , 날짜2 or 시간2)

-- datediff : 날짜1 - 날짜2의 일수를 반환
-- timediff : 시간1 - 시간2 의 결과

select datediff("2023-3-12",now()) , timediff('17:00:11',curtime());

-- dayofweek(날쨔) : 요일 반환 ( 일요일이 1 이다)
-- monthname() : 해당 달의 이름 반환
-- dayofyear() : 해당 년도에서 몇일이 흘렀는지 

select dayofweek(curdate()) , monthname(curdate()) , dayofyear(curdate());      -- 마지막 dayofyear는 입력받은 date 에서 해당 연도에 몇일 지났는지 확인 할 수있다 

-- last_day(날짜)
-- 해당 날짜의 달에서 마지막 날의 날짜를 구한다
select last_day("2024-2-10");

-- quarter(날짜) : 해당 날짜의 분기를 구한다
select quarter(curdate());

-- time_to_sec(시간) : 시간을 초단위로 구함
select time_to_sec("1:30:1");

