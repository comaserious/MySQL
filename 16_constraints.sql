-- constraints
-- 제약조건으로 테이블에 데이터가 입력되거나 수정될 때의
-- 규칙을 정한다

-- 1-1 not null
-- null 값을 허용하지 않는 제약 조건

drop table if exists user_notnull;
create table if not exists user_notnull (

user_no int not null ,
user_id varchar(255) not null,
user_pwd varchar(255) not null,
user_name varchar(255) not null,
gender varchar(3),
phone varchar(255) not null,
email varchar(255)  

)engine = innodb;

describe user_notnull;

insert into user_notnull
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(1, 'user01','pass01','홍길동','남','010-1234-5678','honggil@gmail.com'),
(2, 'user02','pass02','유관순','여','010-456-4354','Ugwan@gmail.com');

-- not null 로 설정한 user_pwd null 값을 넣어보기

insert into user_notnull
values(3,'user01',null,'홍길동','남','010-1234-5757','email@email.com');    -- pwd 는 제약조건으로 not null 임으로 null 값을 기입하면 오류가 발생한다

-- unique
-- 중복값을 허용하지 않는 제약조건

drop table if exists user_unique;
create table if not exists user_unique (

user_no int not null unique ,
user_id varchar(255) not null,
user_pwd varchar(255) not null,
user_name varchar(255) not null,
gender varchar(3),
phone varchar(255) not null,
email varchar(255) ,
unique(phone)

)engine = innodb;

-- not null 제약조건과 unique 제약조건을 합친것이 primary key 라는 것이다
-- phone 의 경우도 마찬가지인데 primary key 가 아닌 unique 가 출력되었는데 한줄로 정의되지 않아서 그렇다고 생각하면 좋을거 같다

describe user_unique;

insert into user_unique
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(1, 'user01','pass01','홍길동','남','010-1234-5678','honggil@gmail.com'),
(2, 'user02','pass02','유관순','여','010-456-4354','Ugwan@gmail.com');

select * from user_unique;

-- unique 제약조건 에러( 전화번호 중복)
insert into user_unique
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(3, 'user03','pass03','이순신','남','010-1234-5678','sunshin@gmail.com');

-- primary key(PK)
-- 테이블에서의 한 행의 정보를 찾기 위해 사용할 칼럼을 의미한다
-- 테이블에 대한 식별자 역할을 한다(한 행씩 구분하는 역할) 
-- not null + unique 제약조건의 의미
-- 한 테이블당 1개만 설정이 가능하다
-- 컬럼레벨, 테이블 레벨 둘다 설정이 가능하다
-- 컬럼레벨 : 한줄로 쓰는 것 user_no int not null unique 
-- 테이블 레벨 : phone varchar(255) not null, unique(phone) 테이블 전체를 봐야 파악이 가능한 경우
-- 한 개 컬럼에 설정할 수 도 있고 여러개를 묶어서 설정할 수 도 있다(복합키)

create table if not exists user_primary (

-- user_no int primary key,       -- 컬럼레벨
user_no int,
user_id varchar(255) not null,
user_pwd varchar(255) not null,
user_name varchar(255) not null,
gender varchar(3),
phone varchar(255) not null,
email varchar(255) ,
primary key(user_no)               -- 테이블 레벨

)engine = innodb;

describe user_primary;

insert into user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(1, 'user01','pass01','홍길동','남','010-1234-5678','honggil@gmail.com'),
(2, 'user02','pass02','유관순','여','010-456-4354','Ugwan@gmail.com');

select * from user_primary;

-- not null 확인
insert into user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(null, 'user01','pass01','홍길동','남','010-1234-5678','honggil@gmail.com');   -- primary key 는 not null unique 이기 때문에 오류가 발생

-- unique 확인
insert into user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
values
(2, 'user01','pass01','홍길동','남','010-1234-5678','honggil@gmail.com');      -- primary key 는 not null unique 이기 때문에 오류가 발생

-- foreign key(FK)
-- 참조된 다른 테이블에서 제공하는 값만 사용 할 수 있다
-- FK 제약조건에 의해 테이블간의 관계(relationship)가 형성된다
-- 제공되는 값 이외에는 null 을 사용할 수 있다

-- 부모테이블
drop table if exists user_grade;

create table if not exists user_grade (
grade_code int not null unique,
grade_name varchar(255) not null
) engine = innodb;

describe user_grade;

insert into user_grade 
values
(10,'일반회원'),
(20,'우수회원'),
(30,'특별회원');

select * from user_grade;

-- 자식 테이블
drop table if exists user_foreignkey1 ;
create table if not exists user_foreignkey1 (

user_no int primary key,
user_id varchar(255) not null,
user_pwd varchar(255) not null,
user_name varchar(255) not null,
gender varchar(3),
phone varchar(255) not null,
email varchar(255) ,
grade_code int ,
foreign key(grade_code)      -- 괄호 안에 있는 값은 자식 테이블의 컬럼명
references user_grade(grade_code)    -- 부모 테이블의 컬럼이름        -- fk 를 생성하기 위해서는 테이블 레벨에서 가능하고 references 를 통해 어디를 참조하는지 알려주어야한다
     
)engine = innodb;

describe user_foreignkey1;

select * from user_foreignkey1;    -- fk 는 null 을 허용한다
select * from user_grade;

insert into user_foreignkey1
(user_no,user_id,user_pwd,user_name,gender,phone,email,grade_code)
values
(3, 'user03','pass03','이순신','남','010-5555-4354','sunshin@gmail.com',10),
(4, 'user04','pass04','김구','남','010-6457-4354','99999@gmail.com',20);

insert into user_foreignkey1 
(user_no,user_id,user_pwd,user_name,gender,phone,email,grade_code)
values
(5, 'user05','pass05','안중근','남','010-6457-4354','99999@gmail.com',50);  -- 참조 테이블에 존재하지 않는 값을 불러오는 것은 말이 안된다

-- check
-- check 제약조건 : 위반시 허용하지 않는다

drop table if exists user_check ;
create table if not exists user_check(
user_no int auto_increment primary key,
user_name varchar(255) not null,
gender varchar(3) check(gender in ( '남', '여')),
age int check(age >=19)

) engine = innodb;

describe user_check;

insert into user_check(user_no , user_name,gender,age)
values
(null,'홍길동','남',25),
(null,'이순신','남',33);

select * from user_check;

-- check 제약조건 성별 위반
insert into user_check(user_no , user_name,gender,age)
values
(null,'홍길동','남성',25);         -- '남' '여' 이외의 값을 받았기에 오류가 난다

-- check 제약조건 나이 위반
insert into user_check(user_no , user_name,gender,age)
values
(null,'유관순','여',15);           -- 19세 이상이라는 조건을 만족 하지 못하기에 에러

-- default
-- 컬럼에 null 대신 기본값을 적용
-- date 주의
-- 컬럼타입이 date 일시 current_date 만 가능
-- 컬럼타입이 datetime 일시 current_time 과 current_timesmap, now() 모두 사용 가능

drop table if exists tbl_country;
create table if not exists tbl_country(
country_code int auto_increment primary key,
country_name varchar(255) default '한국',
population varchar(255) default '0 명',
add_day date default(current_date),
add_time datetime default(current_time)
) engine = innodb;

select * from tbl_country;

-- default 설정이 되어 있는 컬럼들에 default 값이 들어갈 수 있도록한다

describe tbl_country;
insert into tbl_country
values
(null, default,default,default,default);

-- ----------------------------------------------------------------------------------------------
-- primary key 가 2개가 되는가

drop table if exists test;
create table if not exists test(
age int auto_increment primary key,
name varchar(255) not null primary key,
gender varchar(255) check( gender in ('남', '여'))

) engine = innodb;
-- primary key 는 2개 이상은 안된다

drop table if exists test;
create table if not exists test(
age int auto_increment not null,
name varchar(255) not null not null unique,
gender varchar(255) check( gender in ('남', '여')),
primary key(age)

) engine = innodb;

describe test;

-- 컬럼레벨의 값을 우선적으로 primary key 로 인식한다 따라서 테이블 레벨에서의 primary key 는 unique 로 인식되는 것이다
-- 다만 not null, unique 컬럼레벨과 primary key 테이블 레벨이 만나면 primary key 테이블이 이긴다


