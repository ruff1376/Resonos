CREATE TABLE badge_condition (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,         -- 조건 고유 번호(자동 증가, PK)
  badge_id BIGINT NOT NULL,                     -- 배지 고유 번호(외래키, badge 테이블 참조)
  badge_name VARCHAR(100) NOT NULL,            -- 배지 이름(조건에서 직접 사용, 조회 편의용)
  description VARCHAR(255),                     -- 배지 설명(조건에서 직접 사용, 조회 편의용)
  condition_type VARCHAR(50),                   -- 획득 조건 유형(예: POST_COUNT, FOLLOWER_COUNT 등)
  condition_value INT,                          -- 획득 조건 값(예: 10, 100 등, 유형에 따라 의미 다름)
  FOREIGN KEY (badge_id) REFERENCES badge(id)   -- badge_id는 badge 테이블의 id를 참조(외래키 제약)
);


drop Table badge_condition;


    DROP TABLE IF EXISTS `badge`;
    
    CREATE TABLE IF NOT EXISTS `badge` (
        `id` BIGINT NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(100) NULL,
        `description` TEXT NULL,
        `icon_url` VARCHAR(200) NULL,
        `criteria` VARCHAR(200) NULL,
        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP
    );

ALTER TABLE badge MODIFY id BIGINT NOT NULL AUTO_INCREMENT;

DESC badge;

ALTER TABLE badge MODIFY id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY;



-- user_badge 테이블 구조 보완
ALTER TABLE user_badge
  MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT,
  MODIFY COLUMN user_id BIGINT NOT NULL,
  MODIFY COLUMN badge_id BIGINT NOT NULL;

-- 중복 지급 방지 UNIQUE 인덱스 추가
ALTER TABLE user_badge
  ADD UNIQUE KEY uk_user_badge (user_id, badge_id);

-- 외래키 추가 (users, badge 참조)
ALTER TABLE user_badge
  ADD CONSTRAINT fk_userbadge_user FOREIGN KEY (user_id) REFERENCES user(id),
  ADD CONSTRAINT fk_userbadge_badge FOREIGN KEY (badge_id) REFERENCES badge(id);

-- badge_condition 테이블은 이미 구조가 적합하니 추가 ALTER 불필요



-- 배지 자동 배분 테스트

-- 배지, 배지 조건 
INSERT INTO badge (id, name, description, icon_url)
VALUES (1, '테스트 배지', '테스트용 배지', '/static/img/default-badge.png'),
       (2, '활동가', '게시글 10개 작성 시 지급', '/static/img/default-badge.png')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
VALUES (1, '테스트 배지', '게시글 2개 작성', 'POST_COUNT', 2),
       (2, '활동가', '게시글 10개 작성', 'POST_COUNT', 10)
ON DUPLICATE KEY UPDATE badge_name=VALUES(badge_name);

-- 커뮤니티, 유저, 게시글 

-- 3) 커뮤니티 생성 (user: id=1, admin: id=2, test: id=3로 가정)
INSERT INTO community (name, description, creator_id)
VALUES
  ('테스트커뮤니티', '배지 지급 테스트용', 1),
  ('관리자커뮤니티', '관리자 테스트용', 2);

-- 4) 게시글 생성
-- user: 게시글 2개 (테스트 배지 조건 충족)
INSERT INTO board_post (title, content, type, community_id, user_id)
VALUES
  ('user 첫 글', 'user의 첫 게시글', 'free', 1, 1),
  ('user 두번째 글', 'user의 두번째 게시글', 'free', 1, 1);

-- admin: 게시글 10개 (활동가 조건 충족)
INSERT INTO board_post (title, content, type, community_id, user_id)
VALUES
  ('admin 첫 글', 'admin의 첫 게시글', 'free', 2, 2),
  ('admin 두번째 글', 'admin의 두번째 게시글', 'free', 2, 2),
  ('admin 세번째 글', 'admin의 세번째 게시글', 'free', 2, 2),
  ('admin 네번째 글', 'admin의 네번째 게시글', 'free', 2, 2),
  ('admin 다섯번째 글', 'admin의 다섯번째 게시글', 'free', 2, 2),
  ('admin 여섯번째 글', 'admin의 여섯번째 게시글', 'free', 2, 2),
  ('admin 일곱번째 글', 'admin의 일곱번째 게시글', 'free', 2, 2),
  ('admin 여덟번째 글', 'admin의 여덟번째 게시글', 'free', 2, 2),
  ('admin 아홉번째 글', 'admin의 아홉번째 게시글', 'free', 2, 2),
  ('admin 열번째 글', 'admin의 열번째 게시글', 'free', 2, 2);

-- test: 게시글 1개 (조건 미달)
INSERT INTO board_post (title, content, type, community_id, user_id)
VALUES ('test 첫 글', 'test의 첫 게시글', 'free', 1, 3);

-- 5) 배지 및 배지 조건
INSERT INTO badge (id, name, description, icon_url)
VALUES (1, '테스트 배지', '테스트용 배지', '/static/img/default-badge.png'),
       (2, '활동가', '게시글 10개 작성 시 지급', '/static/img/default-badge.png')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
VALUES (1, '테스트 배지', '게시글 2개 작성', 'POST_COUNT', 2),
       (2, '활동가', '게시글 10개 작성', 'POST_COUNT', 10)
ON DUPLICATE KEY UPDATE badge_name=VALUES(badge_name);


-- 트리거 실행 

-- user_id=1이 게시글 2개 이상이면 배지 지급
INSERT IGNORE INTO user_badge (user_id, badge_id)
SELECT 1, 1 FROM DUAL
WHERE (SELECT COUNT(*) FROM board_post WHERE user_id=1) >= 2;

-- user_id=2가 게시글 10개 이상이면 배지 지급
INSERT IGNORE INTO user_badge (user_id, badge_id)
SELECT 2, 2 FROM DUAL
WHERE (SELECT COUNT(*) FROM board_post WHERE user_id=2) >= 10;


-- 확인 
SELECT * FROM user_badge;



-- 오류 발생 user_badge 지급이 안됨 
-- 유저 확인
SELECT id, username FROM user;

-- 배지 확인
SELECT id, name FROM badge;

-- 배지 조건 확인
SELECT * FROM badge_condition;

-- 게시글 수 확인
SELECT user_id, COUNT(*) FROM board_post GROUP BY user_id;

SELECT * FROM user_badge;


