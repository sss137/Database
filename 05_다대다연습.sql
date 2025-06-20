# 고객(Customer), 제품(Product), 구매(Purchase), 구매상세(PurchaseDetail) 테이블을 생성합니다.
# 한 고객은 여러 번 구매할 수 있습니다.(고객 - 구매)
# 여러 번의 구매에는 각각 여러 제품이 포함될 수 있습니다.(구매 - 구매상세 - 제품)
# 고객명, 고객연락처, 제품명, 제품가격, 재고, 구매일, 구매한제품갯수 정보를 저장하세요.

# db_model 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

#고객 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_customer(
  customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  phone CHAR(11) NULL
) ENGINE=InnoDB;

#구매 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchase(
  purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NULL,
  purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(customer_id) REFERENCES tbl_customer(customer_id) ON DELETE SET NULL
  ) ENGINE=InnoDB;

#제품 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product(
  product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL
) ENGINE=InnoDB;

#구매상세 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchase_detail(
  purchase_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  purchase_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  FOREIGN KEY(purchase_id) REFERENCES tbl_purchase(purchase_id),
  FOREIGN KEY(product_id) REFERENCES tbl_product(product_id)
) ENGINE=InnoDB;