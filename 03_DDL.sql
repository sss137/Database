#데이터베이스 생성하기
CREATE DATABASE IF NOT EXISTS db_ddl;

#데이터베이스 사용하기
USE db_ddl;

#테이블 생성하기(데이터 저장을 위한 데이터베이스 객체)
#기본 문법: 칼럼명 -> 데이터타입 -> 제약조건 순으로 작성
#행(Row), 열(Colum)
CREATE TABLE IF NOT EXISTS tbl_product(
product_id    INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,          #AUTO_INCREMENT 숫자가 자동으로 증가, PRIMARY KEY=기본 키(데이터 식별자)
product_name  VARCHAR(50)   NOT NULL,                #VARCHAR=가변 길이 문자열(Variable Character), NOT NULL=필수로 입력이 되어 있어야 한다.
price         DECIMAL(10,2) NOT NULL,
discount      DECIMAL(10,2) NULL,
created_at    DATETIME      DEFAULT NOW()            #DEFAULT NOW()=자동으로 현재 날짜와 시간이 들어감
) ENGINE=InnoDB;              #ENGINE=데이터 저장 방법, 일반적으로 InnoDB를 사용, MyISAM은 검색용 엔진

#스토리지 엔진
#InooDB: 트랜잭션 지원(동시성 지원=여러명 사용 가능), 외래키 지원(무결성 지원=잘못된 데이터를 사용하지 않는다), 주로 은행 또는 쇼핑에 사용
#MyISAM: 풀텍스트 인덱스 지원(읽기 위주 작업에 특화)

#AUTO_INCREMENT 시작값을 바꾸는 방법
ALTER TABLE tbl_product AUTO_INCREMENT = 1000;              #기본 시작값은 1

#테이블 삭제하기(취소 불가능)
DROP TABLE IF EXISTS tbl_product;

#데이터베이스 삭제하기(취소 불가능)
DROP DATABASE IF EXISTS db_ddl;