-- Active: 1751625569683@@127.0.0.1@3306@resonos

-- 실행 순서
-- 1. 테이블 삭제 DROP PROCEDURE IF EXISTS create_tables;
-- 2. 테이블 생성 CREATE PROCEDURE create_tables()
-- 3. 프로시저 호출 CALL create_tables();

DROP PROCEDURE IF EXISTS create_tables;
DROP TABLE IF EXISTS
        user_auth, liked_album, album_review, user_follow, user_badge,
        track_review, notification, chart_entry, persistent_logins,
        board_post, playlist_detail, artist_follow, album,
        playlist, comment, chart_element, album_mood_vote, report,
        liked_playlist, liked_track, qna_answer, qna, community,
        track_mood_vote, user_sanction, admin_log, user_role, review_like, review_report,
        notice, setting, badge, policy, external_api_config, plugin,
        track, artist, user, role, tag, user_activity_log;

CALL create_tables(); -- 밑에 정의된 프로시저 호출

DELIMITER //

CREATE PROCEDURE create_tables()
BEGIN
    -- 1. 외래키 제약 조건 비활성화
    SET FOREIGN_KEY_CHECKS = 0;

    -- 2. 테이블 삭제
    DROP TABLE IF EXISTS
        user_auth, liked_album, album_review, user_follow, user_badge,
        track_review, notification, chart_entry,
        board_post, playlist_detail, artist_follow, album,
        playlist, comment, chart_element, album_mood_vote, report,
        liked_playlist, liked_track, qna_answer, qna, community,
        track_mood_vote, user_sanction, admin_log, user_role, review_like, review_report,
        notice, setting, badge, policy, external_api_config, plugin,
        track, artist, user, role, tag, user_activity_log,
        badge_condition, review_like, review_report;

    -- 3. PK/AI/UNIQUE/FK 없이, NOT NULL/NULL, DEFAULT 값 반영해서 테이블 생성
    CREATE TABLE IF NOT EXISTS `notice` (
        `id` BIGINT NOT NULL,
        `title` VARCHAR(200) NOT NULL,
        `content` TEXT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        `is_active` BOOLEAN NOT NULL,
        `start_at` DATETIME NULL,
        `end_at` DATETIME NULL,
        `author_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `qna_answer` (
        `id` BIGINT NOT NULL,
        `content` TEXT NOT NULL,
        `answered_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `qna_id` BIGINT NOT NULL,
        `admin_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `role` (
        `id` BIGINT NOT NULL,
        `name` VARCHAR(100) NOT NULL,
        `description` VARCHAR(200) NULL
    );

    CREATE TABLE IF NOT EXISTS `community` (
        `id` BIGINT NOT NULL,
        `name` VARCHAR(200) NOT NULL,
        `description` TEXT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `creator_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `qna` (
        `id` BIGINT NOT NULL,
        `type` VARCHAR(50) NOT NULL,
        `title` VARCHAR(100) NOT NULL,
        `content` TEXT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `status` BOOLEAN NOT NULL DEFAULT FALSE,
        `user_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `liked_track` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `artist` (
        `id` VARCHAR(200) NOT NULL,
        `name` VARCHAR(100) NOT NULL,
        `profile_image` VARCHAR(200) NULL,
        `genres` VARCHAR(64) NULL
    );

    CREATE TABLE IF NOT EXISTS `tag` (
<<<<<<< HEAD
        `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
=======
        `id` BIGINT NOT NULL,
>>>>>>> main
        `name` VARCHAR(50) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `track` (
        `id` VARCHAR(200) NOT NULL,
        `title` VARCHAR(100) NOT NULL,
        `duration` INT NOT NULL,
        `genre` VARCHAR(64) NULL,
        `streaming_url` VARCHAR(200) NULL,
        `mv_url` VARCHAR(200) NULL,
        `album_id` VARCHAR(200) NOT NULL,
        `artist_id` VARCHAR(200) NOT NULL,
        `popularity` INT NOT NULL,
        `track_no` INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `user` (
        `id` BIGINT NOT NULL,
        `username` VARCHAR(100) NOT NULL,
        `email` VARCHAR(100) NOT NULL,
        `password` VARCHAR(100) NOT NULL,
        `nickname` VARCHAR(100) NOT NULL,
        `profile_image` VARCHAR(200) NOT NULL DEFAULT '/img/resonosLogo.png',
        `bio` TEXT NULL,
        `is_pro` BOOLEAN NOT NULL DEFAULT FALSE,
        `enabled` BOOLEAN NOT NULL DEFAULT TRUE,
        `provider` VARCHAR(200) NULL,
        `provider_id` VARCHAR(200) NULL,
        `current_badge` BIGINT NULL,
        `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `external_api_config` (
        `id` BIGINT NOT NULL,
        `provider` VARCHAR(100) NOT NULL,
        `apiKey` VARCHAR(100) NOT NULL,
        `secret` VARCHAR(100) NOT NULL,
        `enabled` BOOLEAN NOT NULL DEFAULT FALSE,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `plugin` (
        `id` BIGINT NOT NULL,
        `name` VARCHAR(100) NOT NULL,
        `enabled` BOOLEAN NOT NULL DEFAULT FALSE,
        `config_json` TEXT,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `liked_playlist` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `playlist_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `report` (
        `id` BIGINT NOT NULL,
        `target_type` ENUM('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna') NOT NULL,
        `target_id` BIGINT NOT NULL,
        `reason` TEXT NOT NULL,
        `status` ENUM('PENDING', 'DONE', 'REJECTED') NOT NULL DEFAULT 'PENDING',
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `reporter_id` BIGINT NOT NULL,
        `processed_by` BIGINT NULL,
        `processed_at` DATETIME NULL,
        `process_memo` TEXT NULL
    );

    CREATE TABLE IF NOT EXISTS `album_mood_vote` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL,
        `mood` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `chart_element` (
        `id` BIGINT NOT NULL,
        `lyric` INT NOT NULL,
        `sound` INT NOT NULL,
        `melody` INT NOT NULL,
        `storytelling` INT NOT NULL,
        `cohesiveness` INT NOT NULL,
        `creativity` INT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `comment` (
        `id` BIGINT NOT NULL,
        `content` TEXT NULL,
        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `type` ENUM('posts', 'playlist', 'comment') NOT NULL,
        `target_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `playlist` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `title` VARCHAR(200) NOT NULL,
        `description` TEXT NULL,
        `thumbnail_url` VARCHAR(200) NOT NULL DEFAULT '/img/resonosLogo.png',
        `is_public` BOOLEAN NOT NULL,
        `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `album` (
        `id` VARCHAR(200) NOT NULL,
        `title` VARCHAR(100) NOT NULL,
        `cover_image` VARCHAR(200) NULL,
        `release_date` DATE NOT NULL,
        `genre` VARCHAR(64) NULL,
        `label` VARCHAR(100) NULL,
        `description` TEXT NULL,
        `artist_id` VARCHAR(200) NOT NULL,
        `country` CHAR(3) NULL
    );

    CREATE TABLE IF NOT EXISTS `user_sanction` (
        `id` BIGINT NOT NULL,
        `type` VARCHAR(50) NOT NULL,
        `reason` TEXT NOT NULL,
        `start_at` DATETIME NOT NULL,
        `end_at` DATETIME NULL,
        `created_at` DATETIME NOT NULL,
        `user_id` BIGINT NOT NULL,
        `admin_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `admin_log` (
        `id` BIGINT NOT NULL,
        `action` VARCHAR(50) NOT NULL,
        `target_type` VARCHAR(50) NOT NULL,
        `meta` JSON NULL,
        `reason` TEXT NULL,
        `description` TEXT NULL,
        `ip_address` VARCHAR(45) NULL,
        `user_agent` TEXT NULL,
        `created_at` DATETIME NOT NULL,
        `actor_id` BIGINT NOT NULL,
        `target_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `artist_follow` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `artist_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `playlist_detail` (
        `id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL,
        `playlist_id` BIGINT NOT NULL,
        `order_no` INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `policy` (
        `id` BIGINT NOT NULL,
        `type` VARCHAR(100) NULL,
        `content` TEXT NULL,
        `version` VARCHAR(100) NULL,
        `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `board_post` (
        `id` BIGINT NOT NULL,
        `title` VARCHAR(200) NOT NULL,
        `content` TEXT NOT NULL,
        `type` VARCHAR(50) NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `community_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `chart_entry` (
        `id` BIGINT NOT NULL,
        `type` VARCHAR(100) NULL,
        `rank` INT NULL,
        `calculated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `track_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `user_role` (
        `id` BIGINT NOT NULL,
        `assigned_at` DATETIME NOT NULL,
        `user_id` BIGINT NOT NULL,
        `role_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `badge` (
        `id` BIGINT NOT NULL,
        `name` VARCHAR(100) NULL,
        `description` TEXT NULL,
        `icon_url` VARCHAR(200) NULL,
        `criteria` VARCHAR(200) NULL,
        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `notification` (
        `id` BIGINT NOT NULL,
        `type` ENUM('comment', 'mention', 'like','follow','reply','badge','qna','announcement','system') NOT NULL,
        `message` TEXT NOT NULL,
        `content` TEXT NULL,
        `is_read` BOOLEAN NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `target_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `setting` (
        `id` BIGINT NOT NULL,
        `value` VARCHAR(100) NULL,
        `updated_at` DATETIME NULL
    );

    CREATE TABLE IF NOT EXISTS `track_mood_vote` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL,
        `mood` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `track_review` (
        `id` BIGINT NOT NULL,
        `rating` FLOAT NOT NULL,
        `content` TEXT NOT NULL,
        `blinded` BOOLEAN NOT NULL,
        `likes` INT NOT NULL DEFAULT 0,
        `dislikes` INT NOT NULL DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `critic` BOOLEAN NOT NULL,
        `user_id` BIGINT NOT NULL,
        `track_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `user_activity_log` (
        `id` BIGINT NOT NULL,
        `action` VARCHAR(50) NOT NULL,
        `target_type` VARCHAR(50) NULL,
        `target_id` BIGINT NULL,
        `detail` TEXT NULL,
        `ip_address` VARCHAR(45) NULL,
        `user_agent` TEXT NULL,
        `created_at` DATETIME NOT NULL,
        `user_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `user_badge` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `badge_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `badge_condition` (
        `id` BIGINT NOT NULL,
        `badge_id` BIGINT NOT NULL,
        `badge_name` VARCHAR(100) NOT NULL,
        `description` VARCHAR(255),
        `condition_type` VARCHAR(50),
        `condition_value` INT
    );

    CREATE TABLE IF NOT EXISTS `review_like` (
        `id` BIGINT NOT NULL,
        `review_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `review_type` ENUM('TRACK', 'ALBUM') NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `is_reported` BOOLEAN NOT NULL DEFAULT FALSE
    );

    CREATE TABLE IF NOT EXISTS `review_report` (
        `id` BIGINT NOT NULL,
        `review_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `review_type` ENUM('TRACK', 'ALBUM') NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE IF NOT EXISTS `user_follow` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `follower_id` BIGINT NOT NULL,
        `following_id` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `album_review` (
        `id` BIGINT NOT NULL,
        `rating` FLOAT NOT NULL,
        `content` TEXT NOT NULL,
        `blinded` BOOLEAN NOT NULL,
        `likes` INT NOT NULL DEFAULT 0,
        `dislikes` INT NOT NULL DEFAULT 0,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `critic` BOOLEAN NOT NULL,
        `user_id` BIGINT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `liked_album` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `user_id` BIGINT NOT NULL,
        `album_id` VARCHAR(200) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `user_auth` (
        `no` BIGINT NOT NULL,
        `username` VARCHAR(100) NOT NULL,
        `auth` VARCHAR(100) NOT NULL
    );

    -- 4. PK, AUTO_INCREMENT, UNIQUE, FK 일괄 추가
    -- ... (이전 답변과 동일하게 ALTER TABLE 구문 추가)

    -- (ALTER TABLE 구문은 위 답변과 동일하게 붙여 넣으시면 됩니다)
    -- PK & AUTO_INCREMENT
    ALTER TABLE `notice` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `qna_answer` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `role` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `community` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `qna` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `liked_track` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `artist` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);
    ALTER TABLE `tag` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `track` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `external_api_config` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `liked_playlist` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `report` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `album_mood_vote` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `chart_element` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `comment` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `playlist` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `album` MODIFY COLUMN `id` VARCHAR(200) NOT NULL, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_sanction` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `admin_log` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `artist_follow` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `playlist_detail` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `policy` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `board_post` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `chart_entry` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_role` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `badge` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `notification` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `setting` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `track_mood_vote` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `track_review` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_activity_log` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_badge` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_follow` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `album_review` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `liked_album` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `plugin` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `badge_condition` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `review_like` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `review_report` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
    ALTER TABLE `user_auth` MODIFY COLUMN `no` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`no`);

    -- UNIQUE, FK 등은 이전 답변과 동일하게 추가

    -- 5. 외래키 제약 조건 활성화
    SET FOREIGN_KEY_CHECKS = 1;
END //

DELIMITER ;
