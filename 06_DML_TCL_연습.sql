/*
문제. 계좌 이체 처리하기
1. db_bank 데이터베이스와 은행, 고객, 계좌 테이블을 생성합니다.
  1) 관계 설정
    (1) 은행과 고객은 다대다 관계입니다.
    (2) 하나의 은행에는 여러 개의 계좌 정보가 존재합니다.
    (3) 하나의 고객은 여러 개의 계좌를 가질 수 있습니다.
  2) 칼럼 설정
    (1) 은행: 은행 아이디, 은행 이름
    (2) 고객: 고객 아이디, 고객 이름, 고객 연락처
    (3) 계좌: 계좌 아이디, 잔고 등
  3) 레코드 설정(행 설정)
    (1)각 테이블에 최소 2개의 샘플 데이터를 입력합니다.
    (2)100,000원 이상의 잔고를 가지도록 입력합니다.
2. 계좌 이체 트랜잭션을 처리합니다.
  1) 1번 고객이 2번 고객으로 100,000원을 계좌 이체하는 트랜잭션을 작성하고 실행합니다.
  2) 쿼리문 실행 중 발생하는 오류는 없다고 가정하고 ROLLBACK 처리는 하지 않습니다.
*/

CREATE SCHEMA IF NOT EXISTS db_bank;

USE db_bank;

CREATE TABLE IF NOT EXISTS bank(
bank_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bank_name VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS client(
client_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
client_name VARCHAR(20) NOT NULL,
phone CHAR(11) NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS account(
account_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bank_id INT NOT NULL,
client_id INT NOT NULL,
balance DECIMAL(20,2) NOT NULL,
FOREIGN KEY(bank_id) REFERENCES bank(bank_id) ON DELETE CASCADE,
FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE,
UNIQUE KEY(bank_id, client_id)
) ENGINE=InnoDB;

INSERT INTO bank(bank_name)
VALUES("신한");
INSERT INTO client(client_name, phone)
VALUES("김성수", "01011111111"),
       ("이성수", "01022222222");
INSERT INTO account(bank_id, client_id, balance)
VALUES("1", "1", "100000"),
       ("1", "2", "0");

# 샘플 데이터 저장
COMMIT;

#계좌 이체 트랜잭션 처리(1번 계좌 -> 2번 계좌로 10만원 이체)
START TRANSACTION;

# 1번 계좌에서 100,000 출금
UPDATE account
SET balance = balance - 100000
WHERE account_id = 1 AND balance >= 100000;

# 2번 계좌로 100,000 입금
UPDATE account
SET balance = balance + 100000
WHERE account_id = 2;

#작업 완료
COMMIT;

DROP TABLE IF EXISTS account;

DROP TABLE IF EXISTS client;

DROP TABLE IF EXISTS bank;

DROP DATABASE IF EXISTS db_bank;

