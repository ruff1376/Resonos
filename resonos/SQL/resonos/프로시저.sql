-- Active: 1750388008084@@127.0.0.1@3306@resonos

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
        track_mood_vote, artist_mood_vote, user_sanction, admin_log, user_role, review_like, review_report,
        notice, setting, badge, policy, external_api_config, plugin,
        track, artist, user, role, tag, user_activity_log;

-- CALL create_tables(); -- 밑에 정의된 프로시저 호출

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
        track_mood_vote, artist_mood_vote, user_sanction, admin_log, user_role, review_like, review_report,
        notice, setting, badge, policy, external_api_config, plugin,
        track, artist, user, role, tag, user_activity_log,
        badge_condition;

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
        `id` BIGINT NOT NULL,
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
        `playlist_id` BIGINT NOT NULL,
        UNIQUE (user_id, playlist_id)
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
        `album_id` VARCHAR(200) NOT NULL,
        `user_id` BIGINT NOT NULL
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
        `artist_id` VARCHAR(200) NOT NULL,
        UNIQUE(user_id, artist_id)
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

    CREATE TABLE IF NOT EXISTS `artist_mood_vote` (
        `id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `artist_id` VARCHAR(200) NOT NULL,
        `mood` BIGINT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS `track_review` (
        `id` BIGINT NOT NULL,
        `rating` INT NOT NULL,
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
        UNIQUE (review_id, user_id, review_type)
    );

    CREATE TABLE IF NOT EXISTS `review_report` (
        `id` BIGINT NOT NULL,
        `review_id` BIGINT NOT NULL,
        `user_id` BIGINT NOT NULL,
        `review_type` ENUM('TRACK', 'ALBUM') NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (review_id, user_id, review_type)
    );

    CREATE TABLE IF NOT EXISTS `user_follow` (
        `id` BIGINT NOT NULL,
        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `follower_id` BIGINT NOT NULL,
        `following_id` BIGINT NOT NULL,
        UNIQUE (follower_id, following_id)
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
        `album_id` VARCHAR(200) NOT NULL,
        UNIQUE (user_id, album_id)
    );

    CREATE TABLE IF NOT EXISTS `user_auth` (
        `no` BIGINT NOT NULL,
        `username` VARCHAR(100) NOT NULL,
        `auth` VARCHAR(100) NOT NULL
    );

    -- 4. PK, AUTO_INCREMENT, UNIQUE, FK 일괄 추가

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
    ALTER TABLE `artist_mood_vote` MODIFY COLUMN `id` BIGINT NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (`id`);
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

    -- UNIQUE
    ALTER TABLE `user` ADD UNIQUE KEY `UK_username` (`username`);
    ALTER TABLE `liked_playlist` ADD CONSTRAINT UK_user_playlist UNIQUE (user_id, playlist_id);
    ALTER TABLE `user_badge` ADD UNIQUE KEY uk_user_badge (user_id, badge_id);
    ALTER TABLE `playlist_detail` ADD CONSTRAINT UK_track_playlist UNIQUE (track_id, playlist_id);
    ALTER TABLE `user_follow` ADD CONSTRAINT UK_following_and_follower UNIQUE (follower_id, following_id);
    ALTER TABLE `track_review` ADD UNIQUE KEY `uniq_user_track` (`user_id`, `track_id`);
    ALTER TABLE `review_like` ADD UNIQUE (review_id, user_id, review_type);
    ALTER TABLE `review_report` ADD UNIQUE (review_id, user_id, review_type);

    -- FK
    ALTER TABLE `notice` ADD CONSTRAINT `FK_user_TO_notice_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);
    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (`qna_id`) REFERENCES `qna` (`id`);
    ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_user_TO_qna_answer_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);
    ALTER TABLE `community` ADD CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);
    ALTER TABLE `qna` ADD CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_user_TO_liked_track_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_track` ADD CONSTRAINT `FK_track_TO_liked_track_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `track` ADD CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;
    ALTER TABLE `track` ADD CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;
    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (`reporter_id`) REFERENCES `user` (`id`);
    -- ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`); -- target_id는 다양한 타입일 수 있으니 주석 처리
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_user_TO_album_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_album_TO_album_mood_vote_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;
    ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_tag_TO_album_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);
    ALTER TABLE `chart_element` ADD CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;
    ALTER TABLE `chart_element` ADD CONSTRAINT `FK_user_TO_chart_element_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
    ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `playlist` ADD CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `album` ADD CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;
    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_2` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`);
    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`);
    ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_2` FOREIGN KEY (`target_id`) REFERENCES `user` (`id`);
    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE;
    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `board_post` ADD CONSTRAINT `FK_community_TO_board_post_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`);
    ALTER TABLE `board_post` ADD CONSTRAINT `FK_user_TO_board_post_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `chart_entry` ADD CONSTRAINT `FK_track_TO_chart_entry_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `user_role` ADD CONSTRAINT `FK_user_TO_user_role_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `user_role` ADD CONSTRAINT `FK_role_TO_user_role_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
    ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_user_TO_track_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_track_TO_track_mood_vote_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_tag_TO_track_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);
    ALTER TABLE `artist_mood_vote` ADD CONSTRAINT `FK_user_TO_artist_mood_vote_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `artist_mood_vote` ADD CONSTRAINT `FK_artist_TO_artist_mood_vote_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`);
    ALTER TABLE `artist_mood_vote` ADD CONSTRAINT `FK_tag_TO_artist_mood_vote_1` FOREIGN KEY (`mood`) REFERENCES `tag` (`id`);
    ALTER TABLE `track_review` ADD CONSTRAINT `FK_user_TO_track_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `track_review` ADD CONSTRAINT `FK_track_TO_track_review_1` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`);
    ALTER TABLE `user_activity_log` ADD CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `user_badge` ADD CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (`following_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `album_review` ADD CONSTRAINT `FK_user_TO_album_review_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `album_review` ADD CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;
    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_user_TO_liked_album_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
    ALTER TABLE `liked_album` ADD CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`) ON DELETE CASCADE;
    ALTER TABLE `user_auth` ADD CONSTRAINT `FK_user_TO_user_auth` FOREIGN KEY (`username`) REFERENCES `user` (`username`);
    ALTER TABLE `user` ADD CONSTRAINT `FK_use_badge_TO_user` FOREIGN KEY (`current_badge`) REFERENCES `user_badge` (`badge_id`) ON DELETE CASCADE ON UPDATE CASCADE;
    ALTER TABLE `badge_condition` ADD CONSTRAINT `FK_badge_TO_badge_condition_1` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`);
    ALTER TABLE `review_like` ADD CONSTRAINT `FK_user_TO_review_like_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
    ALTER TABLE `review_report` ADD CONSTRAINT `FK_user_TO_review_report_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;


    -- 5. 외래키 제약 조건 활성화
    SET FOREIGN_KEY_CHECKS = 1;
END //

DELIMITER ;
