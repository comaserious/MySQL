-- DDL(Data Definition Language)
-- DDL 은 데이터베이스의 스키마(테이블)을 정의하거나 수정하는데 사용되는
-- SQL의 한부분이다 

-- 1-1 create
-- 테이블 생성을 위한 구문
-- if not exists 를 적용하면 기존에 존재하는 테이블이라도 에러가 발생하지 않는다(존재하지 않으면 만든다는거니깐)

-- 테이블의 컬럼 설정 방법
-- 컬럼이름 데이터타입(길이) [not null] [default value] [auto_increment] column_constraint;

-- tb1 예시 테이블
create table if not exists tb1 (
pk int primary key,    -- primary key 가 column_constraint 이다
fk int ,
col1 varchar(255),
check(col1 in ('Y','N'))     -- Y 아니면 N 이외의 값이 들어오면 에라가 발생
) ENGINE = INNODB;

-- ENGINE = INNODB : 테이블 INNODB 라고 불리는 스토리지 엔진으로 생성하겠다는 의미 ( mySQL 에서 가장 많이 사용하는 엔진이다)

describe tb1;

insert into tb1 value(1,10,'Y');

select * from tb1;

-- auto_increment
-- insert 시 primary 키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게) 시켜 저장할 수있다

create table if not exists tb2 (
pk int auto_increment primary key,
fk int ,
col1 varchar(255),
check(col1 in ('Y','N'))    
) ENGINE = INNODB;

describe tb2;
create table if not exists tb3 (
pk int auto_increment primary key,
fk int ,
col1 varchar(255),
check(col1 in ('Y','N'))     -- Y 아니면 N 이외의 값이 들어오면 에라가 발생
) ENGINE = INNODB;

describe tb3;

insert into tb3 value(null,10,'Y');
insert into tb3 value(null,10,'Y');
insert into tb3 value(null,10,'Y');
insert into tb3 value(null,10,'Y');

select * from tb3;   -- 자동으로 pk 가 증가하는 것을 확인 할 수 있다

-- alter
-- 테이블에 추가/변경/수정/삭제 하는 모든 alter 명령어를 사용하여 적용한다

-- 열추가
-- alter table 테이블명 add 컬럼명 컬럼정의

-- tb2 테이블에 col2 라는 컬럼 추가( int 형, not null 제약조건)
alter table tb2 add col2 int not null;
describe tb2;

-- 열삭제
-- alter table 테이블명 drop column 컬럼명

alter table tb2 drop column col2;

describe tb2;

-- 열의 이름 및 데이터 형식 변경
-- alter table 테이블명 change column 기존컬럼명 바꿀컬럼명 컬럼정의

-- fk -> change_fk 컬럼으로 변경 not null 제한으로 변경

alter table tb2 change column fk change_fk int not null;

describe tb2;

-- 열의 제약조건 추가 및 삭제
-- alter table 테이블명 drop 제약조건
-- tb2 테이블의 primary key 제약 조건 삭제

alter table tb2 drop primary key;

alter table tb3 drop primary key;
-- auto_increment 가 걸려 있는 컬럼은 primary key 제거가 안된다
-- 따라서 modify 명령어로 제거한다

alter table tb3 modify pk int;     -- auto_increment 삭제

describe tb3;

alter table tb3 drop primary key;    -- 그후 primary key 제약조건을 drop 한다

describe tb3;

-- tb3 테이블의 pk 컬럼에 primary key 추가하기

alter table tb3 add primary key(pk);

describe tb3;
select * from tb3;

-- 컬럼 여러개 추가히기

alter table tb3 
add col3 date not null,
add co4 tinyint not null;

-- date 형이 추가안되는 것은 MySQL 이 5.7 버전 이후 0 으로 채워진 date 컬럼이 존재하면 안되기 때문이다

select @@global.sql_mode;   -- (mySQL 전역 설정을 확인하는 방법)

describe tb3;

-- drop
-- 테이블을 삭제하기 위한 구문

drop table if exists tb3;

drop table if exists tb1, tb2;

-- truncate 
-- 논리적으로는 where 절이 없는 delete 구문과 큰 차이가 없어 보인다
-- 하지만 어짜피 데이터를 다 삭제할 경우 행마다 하나씩 지워지는 delete 보다
-- drop 이후 바로 테이블을 재생성해주는 truncate 가 훨씬 효율적으로
-- 한번에 테이블을 초기화 시켜준다

create table if not exists tb1 ( 
pk int auto_increment primary key,
fk int,
col1 varchar(255)
check (col1 in('Y','N'))
) Engine = INNODB;

insert into tb1 value(null, 10, 'Y');
insert into tb1 value(null, 20, 'Y');
insert into tb1 value(null, 30, 'Y');
insert into tb1 value(null, 40, 'Y');

select * from tb1;

-- 테이블 초기화
-- truncate table tb1;

truncate tb1;      -- table 을 생략해도 좋다


