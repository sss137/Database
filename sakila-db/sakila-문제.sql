# MySQL의 Sakila 샘플 데이터베이스
# DVD 대여점을 모델링한 표준 예시 데이터베이스로 아래 과정을 통해 데이터베이스를 준비합니다.

# 1. Example Database 다운로드 받기
#   1) https://dev.mysql.com/doc/index-other.html 접속
#   2) Example Databases - sakila database - zip 파일 다운로드
#   3) 다운로드 받은 sakila-db.zip 파일의 압축을 풀어 D:/dev/Database/sakila 경로에 저장
#      D:/dev/Database/sakila-db/sakila-schema.sql  (스키마 파일 : CREATE TABLE)
#      D:/dev/Database/sakila-db/sakila-data.sql    (데이터 파일 : INSERT)
#      D:/dev/Database/sakila-db/sakila.mwb         (모델링 파일 : ERD 확인)

# 2. 명령 프롬프트 열고 MySQL 접속
#   mysql -u root -p

# 3. 스키마 파일과 데이터 파일을 순서대로 실행
#   source D:/dev/Database/sakila-db/sakila-schema.sql;
#   source D:/dev/Database/sakila-db/sakila-data.sql;

# 4. MySQL Workbench 접속 후 데이터베이스 생성 확인
#   USE sakila;
#   SHOW FULL TABLES;
#   SELECT COUNT(*) FROM film;  -- 1000개 데이터 존재

# 5. sakila.mwb 파일 열기
#   1) Workbench 메뉴에서 [File] → [Open Model]을 클릭합니다.
#   2) 저장된 sakila.mwb 파일을 선택하여 엽니다.

# sakila-db 내 테이블 목록
# --------------+------------------------------------------------------------------------------------
# 테이블명      | 설명
# --------------+------------------------------------------------------------------------------------
# actor         | 영화에 출연하는 배우 정보 (actor_id, first_name, last_name 등)
# film          | 대여 가능한 영화 정보 (title, description, release_year, rating 등)
# film_actor    | 영화와 배우의 다대다 관계 (film_id, actor_id)
# category      | 영화의 장르 정보 (category_id, name)
# film_category | 영화와 장르의 다대다 관계 (film_id, category_id)
# language      | 영화의 언어 정보 (language_id, name)
# store         | 대여점 정보 (store_id, manager_staff_id, address_id 등)
# staff         | 점포 직원 정보 (staff_id, first_name, last_name, address_id, store_id 등)
# customer      | 고객 정보 (customer_id, first_name, last_name, email, address_id, store_id 등)
# address       | 주소 정보 (address_id, address, district, city_id, postal_code 등)
# city          | 도시 정보 (city_id, city, country_id)
# country       | 국가 정보 (country_id, country)
# inventory     | 점포별 영화 재고 정보 (inventory_id, film_id, store_id 등)
# rental        | 대여 내역 (rental_id, rental_date, inventory_id, customer_id, staff_id 등)
# payment       | 결제 내역 (payment_id, customer_id, staff_id, rental_id, amount, payment_date 등)
# film_text     | 영화의 텍스트 검색을 위한 정보 (film_id, title, description)
# --------------+------------------------------------------------------------------------------------

# sakila 데이터베이스 사용
USE sakila;

############################## 조회 문제 ##############################

# 1. 고객 테이블에서 각 고객의 이름별로 등록된 고객 수를 구하고, 고객 수가 2명 이상인 이름만 조회하세요.
/*
  first_name  cnt
  KELLY        2
  TRACY        2
  LESLIE       2
  JAMIE        2
  MARION       2
  JESSIE       2
  WILLIE       2
  TERRY        2
*/

# 2. 영화 테이블에서 등급(rating)별 평균 상영시간(length)을 구하고, 평균이 110분 이상인 등급만 조회하세요.
/*
    rating  ave_length
    PG      112.0052
    G       111.0506
    NC-17   113.2286
    PG-13   120.4439
    R       118.6615
*/


# 3. 고객 테이블에서 이메일이 "gmail.com"으로 끝나는 고객의 수를 구하세요.
/*
  gmail_count
  0
*/


# 4. 영화 테이블에서 대여료(rental_rate)가 2.99 이상인 영화의 등급(rating) 종류를 중복 없이 조회하세요.
/*
    rating
    G
    NC-17
    PG
    PG-13
    R
*/


# 5. 고객 테이블에서 성(last_name)에 "LL"이 포함된 고객의 이름과 성을 조회하세요.
/*
    first_name  last_name
    LINDA       WILLIAMS
    MARIA       MILLER
    ...
    IVAN        CROMWELL
    WADE        DELVALLE
*/


# 6. 영화 테이블에서 각 등급(rating)별 영화 수를 구하고, 영화 수가 200편 미만인 등급만 조회하세요.
/*
    rating  film_count
    PG      194
    G       178
    R       195
*/


# 7. 고객 테이블에서 스토어 ID(store_id)별 고객 수를 구하세요.
/*
    store_id  cnt
    1         326
    2         273
*/


# 8. 영화 테이블에서 제목(title)에 "THE"가 포함된 영화의 평균 대여료(rental_rate)를 구하세요.
/*
    avg_rate
    2.430000
*/


# 9. 고객 테이블에서 이름(first_name)이 5글자인 고객의 수를 구하세요.
/*
    five_letter_names
    158
*/


# 10. 영화 테이블에서 중복 없이 대여 기간(rental_duration)을 조회하고, 오름차순으로 정렬하세요.
/*
    rental_duration
    3
    4
    5
    6
    7
*/


# 11. 영화 테이블에서 각 대여 기간(rental_duration)별로 영화 수를 구하고, 영화 수가 200편 이상인 대여 기간만 조회하세요.
/*
    rental_duration  film_count
    6                212
    3                203
    4                203
*/


# 12. 반납일(return_date)과 대여일(rental_date)의 차이가 10일 이상인 대여 내역을 조회하세요.
/*
    rental_id  rental_date          return_date
    4          2005-05-24 23:04:41  2005-06-03 01:43:41
    106        2005-05-25 18:18:19  2005-06-04 00:01:19
    ...
    16005      2005-08-23 21:00:22  2005-09-02 02:35:22
    16040      2005-08-23 22:19:33  2005-09-02 02:19:33
*/


# 13. 고객 테이블에서 동일한 이름(first_name)이 존재하는 고객의 이름을 조회하세요.
/*
    first_name
    KELLY
    TRACY
    LESLIE
    JAMIE
    MARION
    JESSIE
    WILLIE
    TERRY
*/


# 14. 영화 테이블에서 대여료(rental_rate)가 4.99인 영화의 등급(rating)별 평균 상영시간(length)을 구하세요.
/*
    rating  avg_length
    G       112.9636
    PG-13   123.3636
    R       115.8923
    NC-17   114.4648
    PG      110.9559
*/


# 15. 고객 테이블에서 등록일(create_date)이 2006년 2월에 해당하는 고객의 수를 구하세요.
/*
    feb_2006_customers
    599
*/


# 16. 영화 테이블에서 상영시간(length)이 150분 이상인 영화의 등급(rating)별 영화 수를 구하세요.
/*
    rating  film_count
    PG      41
    NC-17   47
    R       53
    PG-13   68
    G       41
*/


# 17. 고객 테이블에서 이메일(email)에 "NET"이 포함된 고객의 이름(first_name)별 고객 수를 구하고, 내림차순으로 정렬하세요.
/*
    first_name  cnt
    JANET       1
    JANE        1
    ANNETTE     1
    JEANETTE    1
    CAROLE      1
    KENNETH     1
    JAIME       1
*/


# 18. 영화 테이블에서 대여료(rental_rate)가 0.99, 2.99, 4.99 중 하나인 영화의 등급(rating)별 평균 상영시간(length)을 구하세요.
/*
    rating  avg_length
    PG      112.0052
    G       111.0506
    NC-17   113.2286
    PG-13   120.4439
    R       118.6615
*/


# 19. 고객 테이블에서 스토어 ID(store_di)별로 비활성화 되어 있는 고객(active가 0인 고객)이 몇 명인지 조회하세요.
/*
    store_id  count
    1         8
    2         7
*/


# 20. 영화 테이블에서 상영시간(length)이 100분 이상이고, 등급(rating)별 영화 수가 120편 이상인 등급만 조회하세요.
/*
    rating  film_count
    PG-13   151
    NC-17   123
    R       128
*/


############################## 조인 문제 ##############################

# 1. 고객의 이름과 그들이 대여한 영화 제목을 조회하세요.
/*
    first_name  last_name   title
    AMBER       DIXONACE    GOLDFINGER
    STACY       CUNNINGHAM  ACE GOLDFINGER
    ...
    JAMIE       WAUGH       ANALYZE HOOSIERS
    TIM         CARY        ANALYZE HOOSIERS
*/


# 2. 고객의 이름과 대여 일자를 조회하세요.
# 모든 고객 정보를 빠짐 없이 조회하세요.
/*
    first_name  last_name   rental_date
    MARY        SMITH       2005-05-25 11:30:37
    MARY        SMITH       2005-05-28 10:35:23
    ...
    HELEN       HARRIS      2005-08-02 09:29:11
    HELEN       HARRIS      2005-08-02 15:48:08
*/


# 3. 고객의 이름과 그들이 대여한 영화 제목을 조회하세요.
/*
    title               first_name  last_name
    SMOKING BARBARELLA  LISA        ANDERSON
    COLOR PHILADELPHIA  LISA        ANDERSON
    ...
    GENTLEMEN STAGE     HELEN       HARRIS
    FLYING HOOK         HELEN       HARRIS
*/


# 4. 2005년 8월에 직원별로 처리한 총 결제 금액을 조회하세요.
/*
    first_name  last_name   total_amount
    Mike        Hillyer     11853.65
    Jon         Stephens    12216.49
*/


# 5. 영화 제목과 해당 영화에 출연한 배우 수를 조회하세요.
/*
    title             actor_count
    ACADEMY DINOSAUR  10
    ACE GOLDFINGER    4
    ...
    HAROLD FRENCH     7
    HARPER DYING      4
*/


# 6. "Canada"에 거주하는 고객의 이름과 이메일을 조회하세요.
/*
    first_name  last_name   email
    DERRICK     BOURQUE     DERRICK.BOURQUE@sakilacustomer.org
    DARRELL     POWER       DARRELL.POWER@sakilacustomer.org
    LORETTA     CARPENTER   LORETTA.CARPENTER@sakilacustomer.org
    CURTIS      IRBY        CURTIS.IRBY@sakilacustomer.org
    TROY        QUIGLEY     TROY.QUIGLEY@sakilacustomer.org
*/


# 7. 카테고리가 "Family"인 영화 제목을 조회하세요.
/*
    title
    AFRICAN EGG
    APACHE DIVINE
    ...
    VIRTUAL SPOILERS
    WILLOW TRACY
*/


# 8. 직원의 이름과 주소를 함께 조회하세요.
/*
    first_name  last_name   address
    Mike        Hillyer     23 Workhaven Lane
    Jon         Stephens    1411 Lillydale Drive
*/


# 9. "London" 도시에 거주하는 고객의 이름을 조회하세요.
/*
    first_name  last_name
    MATTIE      HOFFMAN
    CECIL       VINES
*/


# 10. 카테고리별 평균 상영시간을 조회하세요.
/*
    name      ave_length
    Action    111.6094
    Animation 111.0152
    ...
    Sports    128.2027
    Travel    113.3158
*/


############################## 서브쿼리 문제 ##############################

# 1. "Alone Trip"이라는 영화에 출연한 배우의 이름을 조회하세요.
/*
    first_name  last_name
    ED          CHASE
    KARL        BERRY
    UMA         WOOD
    WOODY       JOLIE
    SPENCER     DEPP
    CHRIS       DEPP
    LAURENCE    BULLOCK
    RENEE       BALL
*/


# 2. 언어가 "English"로 된 영화 중 제목이 "K"로 시작하는 영화 제목을 조회하세요.
/*
    title
    KANE EXORCIST
    KARATE MOON
    ...
    KRAMER CHOCOLATE
    KWAI HOMEWARD
*/


# 3. 상영시간이 전체 평균 상영시간보다 긴 영화의 제목을 조회하세요.
/*
    title
    AFFAIR PREJUDICE
    AFRICAN EGG
    ...
    SOUP WISDOM
    SOUTH WAIT
*/


# 4. 영화가 60개 이상 속해 있는 카테고리들의 이름을 조회하세요.
/*
    name
    Action
    Animation
    Children
    Documentary
    Drama
    Family
    Foreign
    Games
    New
    Sci-Fi
    Sports
*/


# 5. 제목이 "Academy Dinosaur"인 영화를 스토어 ID(store_id) 1인 곳에서 대여할 수 있는지 인벤토리 내역을 조회하세요.
/*
    inventory_id  film_id  store_id  last_update
    1             1        1         2006-02-15 05:09:17
    2             1        1         2006-02-15 05:09:17
    3             1        1         2006-02-15 05:09:17
    4             1        1         2006-02-15 05:09:17
      
*/


# 6. 배우 아이디가 8인 배우와 같은 이름(first_name)을 가진 고객을 조회하세요.
/*
    first_name  last_name
    MATTHEW     MAHAN
*/


# 7. 가장 많이 출연한 배우의 이름을 조회하세요.
/*
    first_name  last_name
    GINA        DEGENERES
*/


# 8. 한 번이라도 대여한 적이 있는 고객 중, 대여 횟수가 전체 고객의 평균 대여 횟수보다 많은 고객의 이름과 대여 횟수를 조회하세요.
/*
    first_name  last_name  rental_count
    MARY        SMITH      32
    PATRICIA    JOHNSON    27
    ...
    TERRENCE    GUNDERSON  30
    ENRIQUE     FORSYTHE   28
*/


# 9. 평균 대여료가 가장 높은 카테고리 이름을 조회하세요.
/*
    name
    Games
*/


# 10. 성(last_name)이 "SMITH"인 고객의 총 대여 횟수를 조회하세요.
/*
    first_name  last_name  rental_count
    MARY        SMITH      32
*/
