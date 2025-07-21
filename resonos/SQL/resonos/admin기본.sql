

-- BCryptPasswordEncoder - 암호화 시
-- 사용자
INSERT INTO user ( username, password, nickname, email )
VALUES ( 'user', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자', 'user@mail.com' );

-- 관리자
INSERT INTO user ( username, password, nickname, email )
VALUES ( 'admin', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '관리자', 'admin@mail.com' );


-- 테스트
INSERT INTO user ( username, password, nickname, email )
VALUES ( 'test', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '테스트', 'test@mail.com' );

-- 비밀번호: 123456
INSERT INTO user (username, password, nickname, email) VALUES
('user1', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자1', 'user1@mail.com'),
('user2', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자2', 'user2@mail.com'),
('user3', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자3', 'user3@mail.com'),
('user4', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자4', 'user4@mail.com'),
('user5', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자5', 'user5@mail.com'),
('user6', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자6', 'user6@mail.com'),
('user7', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자7', 'user7@mail.com'),
('user8', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자8', 'user8@mail.com'),
('user9', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자9', 'user9@mail.com'),
('user10', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자10', 'user10@mail.com'),
('user11', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자11', 'user11@mail.com'),
('user12', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자12', 'user12@mail.com'),
('user13', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자13', 'user13@mail.com'),
('user14', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자14', 'user14@mail.com'),
('user15', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자15', 'user15@mail.com'),
('user16', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자16', 'user16@mail.com'),
('user17', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자17', 'user17@mail.com'),
('user18', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자18', 'user18@mail.com'),
('user19', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자19', 'user19@mail.com'),
('user20', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자20', 'user20@mail.com');


-- 권한
-- 사용자 
-- * 권한 : ROLE_USER
INSERT INTO user_auth ( username,  auth )
VALUES ( 'user1', 'ROLE_USER' );

-- 관리자
-- * 권한 : ROLE_USER, ROLE_ADMIN
INSERT INTO user_auth ( username,  auth )
VALUES ( 'admin', 'ROLE_USER' );

INSERT INTO user_auth ( username,  auth )
VALUES ( 'admin', 'ROLE_ADMIN' );

-- 사용자 
-- * 권한 : ROLE_USER
INSERT INTO user_auth ( username,  auth )
VALUES ( 'test', 'ROLE_USER' );




-- 배지 자동 배분 
-- 배지 2개(10개 글, 5개 댓글)
INSERT INTO badge (name, description, icon_url, criteria, created_at)
VALUES
  ('글 10개', '게시글 10개 작성 시 획득', 'icon-post.png', '10회', NOW()),
  ('댓글 5개', '댓글 5개 작성 시 획득',  'icon-comment.png', '5회', NOW());

-- 지급 조건: 게시글 10·댓글 5 (badge_id 자동증가 주의, 1,2 라고 가정)
INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
SELECT id, name, description, 'POST_COUNT', 10 FROM badge WHERE name='글 10개'
UNION ALL
SELECT id, name, description, 'COMMENT_COUNT', 5 FROM badge WHERE name='댓글 5개';

--  게시글, 댓글 데이터 
-- 커뮤니티 임의 생성(for FK)
INSERT INTO community (name, creator_id, description, created_at) VALUES ('커뮤니티', 1, '테스트', NOW());

-- user1: 글 11개
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u1 글', x), '내용', NULL, 1, 1, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) tmp;

-- user2: 글 4개
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u2 글', x), '내용', NULL, 1, 2, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) tmp;

-- user4: 글 20개
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u4 글', x), '내용', NULL, 1, 4, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20) tmp;

-- user1: 댓글 4개 (기준 미달)
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u1 댓글', NOW(), 1, 'posts', 1 FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t;

-- user2: 댓글 6개 (기준 초과)
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u2 댓글', NOW(), 2, 'posts', 1 FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) t;

-- user4: 댓글 10개
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u4 댓글', NOW(), 4, 'posts', 1 FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) t;

-- 스케줄러 or 개발용 
userBadgeService.grantPostBadges();      -- 게시글 배지 자동 지급
userBadgeService.grantCommentBadges();   -- 댓글 배지 자동 지급

--  확인용 쿼리 
-- 누가 배지 지급받았는지
SELECT ub.*, u.username, b.name AS badge_name, b.description
FROM user_badge ub
  JOIN user u ON ub.user_id = u.id
  JOIN badge b ON ub.badge_id = b.id
ORDER BY ub.created_at DESC;

-- 지급/회수 이력(로그)도 확인
SELECT * FROM user_badge_log ORDER BY created_at DESC;

-- 실제 알림(Notification)이 있다면
SELECT * FROM notification ORDER BY created_at DESC;


-- 디버깅용
-- 각 유저별 게시글 수
SELECT user_id, COUNT(*) as post_count FROM board_post GROUP BY user_id;
-- badge_condition ("POST_COUNT") 상태 확인
SELECT * FROM badge_condition WHERE condition_type='POST_COUNT';
-- 게시글 배지 지급 쿼리가 반환하는 데이터 미리 확인
SELECT u.id as user_id, bc.badge_id, p.post_count
FROM user u
JOIN badge_condition bc ON bc.condition_type = 'POST_COUNT'
LEFT JOIN user_badge ub ON ub.user_id = u.id AND ub.badge_id = bc.badge_id
JOIN (
    SELECT user_id, COUNT(*) as post_count FROM board_post GROUP BY user_id
) p ON p.user_id = u.id
WHERE p.post_count >= bc.condition_value
  AND ub.id IS NULL;

-- insert 테스트 
INSERT INTO user_badge (user_id, badge_id, created_at)
SELECT u.id, bc.badge_id, NOW()
FROM user u
JOIN badge_condition bc ON bc.condition_type = 'POST_COUNT'
LEFT JOIN user_badge ub ON ub.user_id = u.id AND ub.badge_id = bc.badge_id
JOIN (
    SELECT user_id, COUNT(*) as post_count FROM board_post GROUP BY user_id
) p ON p.user_id = u.id
WHERE p.post_count >= bc.condition_value
  AND ub.id IS NULL;

--  확인용
SELECT * FROM user_badge;


-- 지급된 user_id, badge_id 확인
SELECT ub.*, u.username, b.name AS badge_name
FROM user_badge ub
JOIN user u ON ub.user_id = u.id
JOIN badge b ON ub.badge_id = b.id
ORDER BY ub.created_at DESC;

-- 댓글 배지 지급 
INSERT INTO user_badge (user_id, badge_id, created_at)
SELECT u.id, bc.badge_id, NOW()
FROM user u
JOIN badge_condition bc ON bc.condition_type = 'COMMENT_COUNT'
LEFT JOIN user_badge ub ON ub.user_id = u.id AND ub.badge_id = bc.badge_id
JOIN (
    SELECT user_id, COUNT(*) as comment_count FROM comment GROUP BY user_id
) c ON c.user_id = u.id
WHERE c.comment_count >= bc.condition_value
  AND ub.id IS NULL;

-- 배지, 조건 추가 
-- 보상 진입 문턱 낮은 샘플 배지도 추가
INSERT INTO badge (name, description, icon_url, criteria, created_at)
VALUES
  ('글 3개', '게시글 3개 작성', 'icon-post3.png', '3회', NOW()),
  ('댓글 2개', '댓글 2개 작성', 'icon-comment2.png', '2회', NOW());

-- 지급 조건 추가
INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
SELECT id, name, description, 'POST_COUNT', 3 FROM badge WHERE name='글 3개'
UNION ALL
SELECT id, name, description, 'COMMENT_COUNT', 2 FROM badge WHERE name='댓글 2개';

--  테스트 유저 
-- user5: 글 2개, 댓글 1개 (모두 미달, 배지 못 받음)
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u5글', x), '...', NULL, 1, 5, NOW() FROM (SELECT 1 x UNION SELECT 2) tmp;
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u5댓글', NOW(), 5, 'posts', 1 FROM (SELECT 1) t;

-- user6: 글 3개, 댓글 2개 (신규 '글 3개', '댓글 2개' 배지 받을 것)
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u6글', x), '...', NULL, 1, 6, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3) tmp;
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u6댓글', NOW(), 6, 'posts', 1 FROM (SELECT 1 UNION SELECT 2) t;

-- user7: 글 4개, 댓글 5개 (모든 테스트 배지 획득 가능)
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u7글', x), '...', NULL, 1, 7, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) tmp;
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u7댓글', NOW(), 7, 'posts', 1 FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t;

-- user8: 글/댓글 각각 딱 2개 (필요 최저 기준만 충족)
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u8글', x), '...', NULL, 1, 8, NOW() FROM (SELECT 1 x UNION SELECT 2) tmp;
INSERT INTO comment (content, created_at, user_id, type, target_id)
SELECT 'u8댓글', NOW(), 8, 'posts', 1 FROM (SELECT 1 UNION SELECT 2) t;

-- user9: 글 10개, 댓글 0개 (글 배지만 지급 예상)
INSERT INTO board_post (title, content, type, community_id, user_id, created_at)
SELECT CONCAT('u9글', x), '...', NULL, 1, 9, NOW() FROM (SELECT 1 x UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) tmp;

-- 게시글 15개 
INSERT INTO badge (name, description, icon_url, criteria, created_at)
VALUES ('글 15개', '15개 이상 작성', 'icon-post15.png', '15회', NOW());
INSERT INTO badge_condition (badge_id, badge_name, description, condition_type, condition_value)
SELECT id, name, description, 'POST_COUNT', 15 FROM badge WHERE name='글 15개';


--  확인 
SELECT ub.*, u.username, b.name AS badge_name
FROM user_badge ub
JOIN user u ON ub.user_id = u.id
JOIN badge b ON ub.badge_id = b.id
WHERE u.username IN ('user5','user6','user7','user8','user9')
ORDER BY ub.user_id, ub.badge_id;

SELECT * FROM badge ORDER BY id;

SELECT * FROM badge_condition ORDER BY id;

SELECT * FROM badge_condition;


-- 게시글 수 자동 배지 지급 쿼리 
INSERT INTO user_badge (user_id, badge_id, created_at)
SELECT u.id, bc.badge_id, NOW()
FROM user u
JOIN badge_condition bc ON bc.condition_type = 'POST_COUNT'
LEFT JOIN user_badge ub ON ub.user_id = u.id AND ub.badge_id = bc.badge_id
JOIN (
  SELECT user_id, COUNT(*) as post_count
  FROM board_post
  GROUP BY user_id
) p ON p.user_id = u.id
WHERE p.post_count >= bc.condition_value
  AND ub.id IS NULL;

-- 댓글 수 자동 배지 지급 쿼리
INSERT INTO user_badge (user_id, badge_id, created_at)
SELECT u.id, bc.badge_id, NOW()
FROM user u
JOIN badge_condition bc ON bc.condition_type = 'COMMENT_COUNT'
LEFT JOIN user_badge ub ON ub.user_id = u.id AND ub.badge_id = bc.badge_id
JOIN (
  SELECT user_id, COUNT(*) as comment_count
  FROM comment
  GROUP BY user_id
) c ON c.user_id = u.id
WHERE c.comment_count >= bc.condition_value
  AND ub.id IS NULL;
