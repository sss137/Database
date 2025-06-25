#db_company 데이터베이스 사용
USE db_company;

/*
클러스터 인덱스
1. Primary Index입니다.
2. 테이블에 1개만 존재할 수 있습니다.
3. PK로 설정된 칼럼은 클러스터 인덱스를 자동으로 가집니다.
*/

#부서아이디 1인 부서 조회하기: 인덱스 태우기 성공(PK의 정확한 위치 파악이 가능)
EXPLAIN 
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id = 1;              #인덱스가 설정된 칼럼을 그대로 WHERE절에서 사용
#결과
#type = const: PK 또는 UK를 WHERE절에서 상수 값과 비교하여 항상 const 하나의 행만 반환하는 접근 방식
#rows = 1: Mysql이 검사할 것으로 예상되는 행의 수 = 1

#부서아이디 1인 부서 조회하기: 인덱스 태우기 실패(동일한 결과가 나오지만 속도 저하가 발생합니다.)
EXPLAIN 
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id * 2 = 2;          #인덱스가 설정된 칼럼을 조작하면(연산, 함수 등) 더 이상 인덱스를 타지 않습니다.
#결과
#type = ALL: 테이블의 모든 행을 처음부터 모두 읽는 Full Table Scan 방식(가장 안 좋은 방식)
#rows = 5: Mysql이 검사할 것으로 예상되는 행의 수 = 5(전체 행의 수)

#부서아이디가 1 이상인 부서 조회하기
EXPLAIN 
SELECT dept_id, dept_name, dept_location
FROM tbl_department
WHERE dept_id >= 1;             #Mysql이 Index Range Scan 또는 Full Table Scan 중 선택해서 동작합니다.
#결과
#type = range: Index Range Scan 실시(비교적 효율적인 방법)
#rows = 5: Mysql이 검사할 것으로 예상되는 행의 수 = 5(전체 행의 수)

/*
논클러스터 인덱스
1. Secondary Index입니다.
2. 테이블에 1개 이상 존재할 수 있습니다.
3. UNIQUE로 설정된 칼럼 또는 CREATE INDEX문을 이용해서 설정합니다.
*/

#보조 인덱스 생성
CREATE INDEX ix_name
ON tbl_employee(emp_name ASC);   #직원 테이블의 직원명 칼럼에 인덱스를 설정

#직원명이 "이은영"인 직원 정보 조회하기
EXPLAIN
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE emp_name = "이은영";
#결과
#type = ref: 비고유 인덱스(Non Unique)의 동등 비교(=)에서 나타나는 방식(여러 행을 찾는 효율적인 방식)
#rows = 1: Mysql이 검사할 것으로 예상되는 행의 수 = 1

#성이 "이"인 직원 정보 조회하기
#1. Index Range Scan
EXPLAIN
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE emp_name LIKE "이%";

#2. Full Table Scan
EXPLAIN
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
FROM tbl_employee
WHERE SUBSTRING(emp_name, 0, 1) = "이";