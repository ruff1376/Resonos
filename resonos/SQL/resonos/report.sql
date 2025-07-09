-- 1. id를 AUTO_INCREMENT PRIMARY KEY로 변경
ALTER TABLE report MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;

-- 3. status를 ENUM으로 변경하고 기본값 추가
ALTER TABLE report MODIFY COLUMN status ENUM('PENDING', 'DONE', 'REJECTED') NOT NULL DEFAULT 'PENDING';

-- 4. processed_by 컬럼 추가 (처리한 관리자)
ALTER TABLE report ADD COLUMN processed_by BIGINT NULL AFTER reporter_id;

-- 5. processed_at 컬럼 추가 (처리 일시)
ALTER TABLE report ADD COLUMN processed_at DATETIME NULL AFTER processed_by;

-- 6. process_memo 컬럼 추가 (처리 메모)
ALTER TABLE report ADD COLUMN process_memo TEXT NULL AFTER processed_at;

-- 7. reporter_id에 외래키 추가 (이미 있으면 생략)
ALTER TABLE report ADD CONSTRAINT FK_report_user FOREIGN KEY (reporter_id) REFERENCES user(id);


    CREATE TABLE IF NOT EXISTS `report` (
        `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `target_type` ENUM('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna') NOT NULL,
        `target_id` BIGINT NOT NULL,
        `reason` TEXT NOT NULL,
        `status` ENUM('PENDING', 'DONE', 'REJECTED') NOT NULL DEFAULT 'PENDING',
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `reporter_id` BIGINT NOT NULL,
        `processed_by` BIGINT NULL,
        `processed_at` DATETIME NULL,
        `process_memo` TEXT NULL,
        FOREIGN KEY (`reporter_id`) REFERENCES `user`(`id`)
    );


-- 신고 더미 데이터 

    INSERT INTO report (target_type, target_id, reason, status, created_at, reporter_id, processed_by, processed_at, process_memo)
VALUES
('track', 1001, '도배성 댓글', 'PENDING', NOW(), 1, NULL, NULL, NULL),
('album', 2002, '음란성', 'DONE', NOW(), 2, 3, NOW(), '처리 완료'),
('artist', 3003, '욕설', 'PENDING', NOW(), 3, NULL, NULL, NULL),
('user', 4, '스팸', 'REJECTED', NOW(), 4, 2, NOW(), '허위 신고'),
('track', 1005, '도배성 댓글', 'PENDING', NOW(), 5, NULL, NULL, NULL),
('album', 2006, '광고', 'DONE', NOW(), 6, 1, NOW(), '완료'),
('playlist', 4007, '욕설', 'PENDING', NOW(), 7, NULL, NULL, NULL),
('review', 5008, '음란성', 'DONE', NOW(), 8, 2, NOW(), '확인 후 처리'),
('comment', 6009, '스팸', 'PENDING', NOW(), 9, NULL, NULL, NULL),
('qna', 7010, '광고', 'PENDING', NOW(), 10, NULL, NULL, NULL),

('track', 1002, '욕설', 'DONE', NOW(), 2, 1, NOW(), '처리 완료'),
('album', 2003, '도배성 댓글', 'PENDING', NOW(), 3, NULL, NULL, NULL),
('artist', 3004, '음란성', 'REJECTED', NOW(), 4, 5, NOW(), '허위 신고'),
('user', 5, '광고', 'PENDING', NOW(), 5, NULL, NULL, NULL),
('track', 1006, '스팸', 'DONE', NOW(), 6, 2, NOW(), '완료'),
('album', 2007, '도배성 댓글', 'PENDING', NOW(), 7, NULL, NULL, NULL),
('playlist', 4008, '욕설', 'DONE', NOW(), 8, 3, NOW(), '완료'),
('review', 5009, '음란성', 'PENDING', NOW(), 9, NULL, NULL, NULL),
('comment', 6010, '광고', 'REJECTED', NOW(), 10, 4, NOW(), '허위 신고'),
('qna', 7011, '스팸', 'PENDING', NOW(), 1, NULL, NULL, NULL),

('track', 1003, '광고', 'PENDING', NOW(), 3, NULL, NULL, NULL),
('album', 2004, '욕설', 'DONE', NOW(), 4, 2, NOW(), '완료'),
('artist', 3005, '도배성 댓글', 'PENDING', NOW(), 5, NULL, NULL, NULL),
('user', 6, '음란성', 'PENDING', NOW(), 6, NULL, NULL, NULL),
('track', 1007, '스팸', 'DONE', NOW(), 7, 3, NOW(), '완료'),
('album', 2008, '광고', 'PENDING', NOW(), 8, NULL, NULL, NULL),
('playlist', 4009, '욕설', 'REJECTED', NOW(), 9, 1, NOW(), '허위 신고'),
('review', 5010, '음란성', 'PENDING', NOW(), 10, NULL, NULL, NULL),
('comment', 6011, '도배성 댓글', 'PENDING', NOW(), 1, NULL, NULL, NULL),
('qna', 7012, '광고', 'DONE', NOW(), 2, 4, NOW(), '완료');


-- 1차 가공 더미 데이터 
-- target_type은 'review', 'boardPost', 'comment', 'user' 네 가지 중 하나
-- target_id, reporter_id는 1~3 사이 값만 사용
-- 나머지 컬럼은 예시로 작성(상태 랜덤, 처리 관련 컬럼은 NULL)

INSERT INTO report (target_type, target_id, reason, status, created_at, reporter_id, processed_by, processed_at, process_memo)
VALUES
('review',     1, '스팸',         'PENDING',  NOW(), 1, NULL, NULL, NULL),
('review',     2, '도배',         'DONE',     NOW(), 2, 1, NOW(), '처리 완료'),
('review',     3, '욕설',         'REJECTED', NOW(), 3, 2, NOW(), '허위 신고'),
('boardPost',  1, '광고',         'PENDING',  NOW(), 2, NULL, NULL, NULL),
('boardPost',  2, '음란성',       'DONE',     NOW(), 3, 1, NOW(), '완료'),
('boardPost',  3, '도배',         'PENDING',  NOW(), 1, NULL, NULL, NULL),
('comment',    1, '욕설',         'DONE',     NOW(), 3, 2, NOW(), '확인'),
('comment',    2, '스팸',         'PENDING',  NOW(), 1, NULL, NULL, NULL),
('comment',    3, '광고',         'REJECTED', NOW(), 2, 3, NOW(), '허위 신고'),
('user',       1, '음란성',       'PENDING',  NOW(), 3, NULL, NULL, NULL),
('user',       2, '스팸',         'DONE',     NOW(), 1, 2, NOW(), '완료'),
('user',       3, '욕설',         'PENDING',  NOW(), 2, NULL, NULL, NULL),
('review',     1, '광고',         'DONE',     NOW(), 3, 1, NOW(), '완료'),
('review',     2, '음란성',       'PENDING',  NOW(), 1, NULL, NULL, NULL),
('review',     3, '도배',         'REJECTED', NOW(), 2, 3, NOW(), '허위 신고'),
('boardPost',  1, '욕설',         'PENDING',  NOW(), 3, NULL, NULL, NULL),
('boardPost',  2, '스팸',         'DONE',     NOW(), 1, 2, NOW(), '완료'),
('boardPost',  3, '광고',         'PENDING',  NOW(), 2, NULL, NULL, NULL),
('comment',    1, '음란성',       'DONE',     NOW(), 3, 1, NOW(), '확인'),
('comment',    2, '도배',         'PENDING',  NOW(), 1, NULL, NULL, NULL),
('comment',    3, '욕설',         'REJECTED', NOW(), 2, 3, NOW(), '허위 신고'),
('user',       1, '광고',         'PENDING',  NOW(), 3, NULL, NULL, NULL),
('user',       2, '음란성',       'DONE',     NOW(), 1, 2, NOW(), '완료'),
('user',       3, '스팸',         'PENDING',  NOW(), 2, NULL, NULL, NULL),
('review',     1, '욕설',         'DONE',     NOW(), 3, 1, NOW(), '완료'),
('review',     2, '스팸',         'PENDING',  NOW(), 1, NULL, NULL, NULL),
('review',     3, '광고',         'REJECTED', NOW(), 2, 3, NOW(), '허위 신고'),
('boardPost',  1, '음란성',       'PENDING',  NOW(), 3, NULL, NULL, NULL),
('boardPost',  2, '도배',         'DONE',     NOW(), 1, 2, NOW(), '완료'),
('boardPost',  3, '욕설',         'PENDING',  NOW(), 2, NULL, NULL, NULL);
