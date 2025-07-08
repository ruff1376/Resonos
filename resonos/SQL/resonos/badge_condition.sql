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



-- 테스트 데이터 추가 
-- 1. 커뮤니티 (community) - board_post에 필요
INSERT INTO community (id, name, description, created_at, creator_id)
VALUES (1, '테스트커뮤니티', '배지 지급 테스트용', NOW(), 1)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 3. 배지 (badge)
INSERT INTO badge (id, name, description, icon_url)
VALUES
  (1, '테스트 배지', '테스트용 배지', '/static/img/default-badge.png'),
  (2, '활동가', '게시글 10개 작성 시 지급', '/static/img/default-badge.png')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 4. 배지 조건 (badge_condition)
INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
VALUES
  (1, '테스트 배지', '게시글 2개 작성', 'POST_COUNT', 2),
  (2, '활동가', '게시글 10개 작성', 'POST_COUNT', 10)
ON DUPLICATE KEY UPDATE badge_name=VALUES(badge_name);

-- 5. 게시글 (board_post) - user_id=1(2개), user_id=2(10개), user_id=3(1개), user_id=4(0개)
INSERT INTO board_post (id, title, content, type, created_at, community_id, user_id)
VALUES
  (101, '테스터1 첫 글', '테스트 게시글1', 'free', NOW(), 1, 1),
  (102, '테스터1 두번째 글', '테스트 게시글2', 'free', NOW(), 1, 1),
  (201, '테스터2 첫 글', '테스트 게시글3', 'free', NOW(), 1, 2),
  (202, '테스터2 두번째 글', '테스트 게시글4', 'free', NOW(), 1, 2),
  (203, '테스터2 세번째 글', '테스트 게시글5', 'free', NOW(), 1, 2),
  (204, '테스터2 네번째 글', '테스트 게시글6', 'free', NOW(), 1, 2),
  (205, '테스터2 다섯번째 글', '테스트 게시글7', 'free', NOW(), 1, 2),
  (206, '테스터2 여섯번째 글', '테스트 게시글8', 'free', NOW(), 1, 2),
  (207, '테스터2 일곱번째 글', '테스트 게시글9', 'free', NOW(), 1, 2),
  (208, '테스터2 여덟번째 글', '테스트 게시글10', 'free', NOW(), 1, 2),
  (209, '테스터2 아홉번째 글', '테스트 게시글11', 'free', NOW(), 1, 2),
  (210, '테스터2 열번째 글', '테스트 게시글12', 'free', NOW(), 1, 2),
  (301, '테스터3 첫 글', '테스트 게시글13', 'free', NOW(), 1, 3)
ON DUPLICATE KEY UPDATE title=VALUES(title);

-- 6. 팔로우 (user_follow) - tester2(2)가 tester1(1) 팔로우
INSERT INTO user_follow (id, created_at, follower_id, following_id)
VALUES (1, NOW(), 2, 1)
ON DUPLICATE KEY UPDATE follower_id=VALUES(follower_id);

-- 7. 댓글 (comment) - type은 'posts', target_id는 board_post.id
INSERT INTO comment (id, content, created_at, user_id, type, target_id)
VALUES
  (401, '테스터1 댓글', NOW(), 1, 'posts', 101),
  (402, '테스터2 댓글', NOW(), 2, 'posts', 201),
  (403, '테스터3 댓글', NOW(), 3, 'posts', 301)
ON DUPLICATE KEY UPDATE content=VALUES(content);

-- 8. (자동 지급 테스트 결과는 user_badge 테이블에서 확인)
-- 지급 로직 실행 후 user_badge에 데이터가 들어가는지 확인하세요!
