-- Active: 1745889699154@@127.0.0.1@3306@aloha

-- 💥 기존 테이블 모두 삭제
DROP TABLE IF EXISTS
    user_activity_log, admin_log, user_role, role, user_sanction,
    plugin, liked_album, album_review, user_follow, user_badge,
    track_review, setting, notification, badge, chart_entry,
    board_post, policy, playlist_detail, artist_follow, album,
    playlist, comment, chart_element, album_mood_vote, report,
    liked_playlist, external_api_config, user, track, tag,
    artist, liked_track, qna, community, qna_answer, notice,
    track_mood_vote;

CREATE TABLE `notice` (
	`id`	BIGINT	NOT NULL,
	`title`	VARCHAR(200)	NOT NULL,
	`content`	TEXT	NOT NULL,
	`created_at`	DATETIME	NOT NULL,
	`updated_at`	DATETIME	NULL,
	`is_active`	BOOLEAN	NOT NULL,
	`start_at`	DATETIME	NULL,
	`end_at`	DATETIME	NULL,
	`author_id`	BIGINT	NOT NULL
);

CREATE TABLE `qna_answer` (
	`id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`answered_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`qna_id`	BIGINT	NOT NULL,
	`admin_id`	BIGINT	NOT NULL
);

CREATE TABLE `role` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(100)	NOT NULL,
	`description`	VARCHAR(200)	NULL
);

CREATE TABLE `community` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(200)	NOT NULL,
	`description`	TEXT	NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`creator_id`	BIGINT	NOT NULL
);

CREATE TABLE `qna` (
	`id`	BIGINT	NOT NULL,
	`type`	VARCHAR(50)	NOT NULL,
	`title`	VARCHAR(100)	NOT NULL,
	`content`	TEXT	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`status`	BOOLEAN	NOT NULL	DEFAULT false,
	`user_id`	BIGINT	NOT NULL
);

CREATE TABLE `liked_track` (
	`id`	BIGINT	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NOT NULL,
	`track_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `artist` (
	`id`	VARCHAR(200)	NOT NULL,
	`name`	VARCHAR(100)	NOT NULL,
	`profile_image`	VARCHAR(200)	NULL,
	`genres`	VARCHAR(64)	NULL
);

CREATE TABLE `tag` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

CREATE TABLE `track` (
	`id`	VARCHAR(200)	NOT NULL,
	`title`	VARCHAR(100)	NOT NULL,
	`duration`	INT	NOT NULL,
	`genre`	VARCHAR(64)	NULL,
	`streaming_url`	VARCHAR(200)	NULL,
	`mv_url`	VARCHAR(200)	NULL,
	`album_id`	VARCHAR(200)	NOT NULL,
	`artist_id`	VARCHAR(200)	NOT NULL,
	`popularity`	INT	NOT NULL,
	`track_no`	INT	NOT NULL
);

CREATE TABLE `user` (
	`id`	BIGINT	NOT NULL,
	`username`	VARCHAR(100)	NOT NULL,
	`email`	VARCHAR(100)	NOT NULL,
	`password`	VARCHAR(100)	NOT NULL,
	`nickname`	VARCHAR(100)	NOT NULL,
	`profile_image`	VARCHAR(200)	NULL,
	`bio`	TEXT	NULL,
	`is_pro`	BOOLEAN	NOT NULL,
	`enabled`	BOOLEAN	NOT NULL,
	`provider`	VARCHAR(200)	NULL,
	`provider_id`	VARCHAR(200)	NULL,
	`created_at`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `external_api_config` (
	`id`	BIGINT	NOT NULL,
	`provider`	VARCHAR(100)	NULL,
	`apiKey`	VARCHAR(100)	NULL,
	`secret`	VARCHAR(100)	NULL,
	`enabled`	BOOLEAN	NULL,
	`created_at`	DATETIME	NULL
);

CREATE TABLE `liked_playlist` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NOT NULL,
	`playlist_id`	BIGINT	NOT NULL
);

CREATE TABLE `report` (
	`id`	BIGINT	NOT NULL,
	`target_type`	ENUM('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna')	NOT NULL,
	`reason`	TEXT	NOT NULL,
	`status`	VARCHAR(10)	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`reporter_id`	BIGINT	NOT NULL,
	`target_id`	BIGINT	NOT NULL
);

CREATE TABLE `album_mood_vote` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`album_id`	VARCHAR(200)	NOT NULL,
	`mood`	BIGINT	NOT NULL
);

CREATE TABLE `chart_element` (
	`id`	BIGINT	NOT NULL,
	`lyric`	INT	NOT NULL,
	`sound`	INT	NOT NULL,
	`melody`	INT	NOT NULL,
	`storytelling`	INT	NOT NULL,
	`cohesiveness`	INT	NOT NULL,
	`creativity`	INT	NOT NULL,
	`album_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `comment` (
	`id`	BIGINT	NOT NULL,
	`content`	TEXT	NULL,
	`created_at`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NOT NULL,
	`type`	ENUM('posts', 'playlist', 'comment')	NOT NULL,
	`target_id`	BIGINT	NOT NULL
);

CREATE TABLE `playlist` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`title`	VARCHAR(200)	NOT NULL,
	`description`	TEXT	NULL,
	`thumbnail_url`	VARCHAR(200)	NULL,
	`is_public`	BOOLEAN	NOT NULL,
	`created_at`	TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`track_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `album` (
	`id`	VARCHAR(200)	NOT NULL,
	`title`	VARCHAR(100)	NOT NULL,
	`cover_image`	VARCHAR(200)	NULL,
	`release_date`	DATE	NOT NULL,
	`genre`	VARCHAR(64)	NULL,
	`label`	VARCHAR(100)	NULL,
	`description`	TEXT	NULL,
	`artist_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `user_sanction` (
	`id`	BIGINT	NOT NULL,
	`type`	VARCHAR(50)	NOT NULL,
	`reason`	TEXT	NOT NULL,
	`start_at`	DATETIME	NOT NULL,
	`end_at`	DATETIME	NULL,
	`created_at`	DATETIME	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`admin_id`	BIGINT	NOT NULL
);

CREATE TABLE `admin_log` (
	`id`	BIGINT	NOT NULL,
	`action`	VARCHAR(50)	NOT NULL,
	`target_type`	VARCHAR(50)	NOT NULL,
	`meta`	JSON	NULL,
	`reason`	TEXT	NULL,
	`description`	TEXT	NULL,
	`ip_address`	VARCHAR(45)	NULL,
	`user_agent`	TEXT	NULL,
	`created_at`	DATETIME	NOT NULL,
	`actor_id`	BIGINT	NOT NULL,
	`target_id`	BIGINT	NOT NULL
);

CREATE TABLE `artist_follow` (
	`id`	VARCHAR(200)	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NOT NULL,
	`artist_id`	VARCHAR(100)	NOT NULL
);

CREATE TABLE `playlist_detail` (
	`id`	BIGINT	NOT NULL,
	`track_id`	VARCHAR(200)	NOT NULL,
	`playlist_id`	BIGINT	NOT NULL,
	`order_no`	INT	NOT NULL,
	`Field`	VARCHAR(255)	NULL
);

CREATE TABLE `policy` (
	`id`	BIGINT	NOT NULL,
	`type`	VARCHAR(100)	NULL,
	`content`	TEXT	NULL,
	`version`	VARCHAR(100)	NULL,
	`updated_at`	DATETIME	NULL
);

CREATE TABLE `board_post` (
	`id`	BIGINT	NOT NULL,
	`title`	VARCHAR(200)	NOT NULL,
	`content`	TEXT	NOT NULL,
	`type`	VARCHAR(50)	NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`community_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL
);

CREATE TABLE `chart_entry` (
	`id`	BIGINT	NOT NULL,
	`type`	VARCHAR(100)	NULL,
	`rank`	INT	NULL,
	`calculated_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`track_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `user_role` (
	`id`	BIGINT	NOT NULL,
	`assigned_at`	DATETIME	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`role_id`	BIGINT	NOT NULL
);

CREATE TABLE `badge` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(100)	NULL,
	`description`	TEXT	NULL,
	`icon_url`	VARCHAR(200)	NULL,
	`criteria`	VARCHAR(200)	NULL,
	`created_at`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `notification` (
	`id`	BIGINT	NOT NULL,
	`type`	ENUM('comment', 'mention', 'like','follow','reply','badge','qna','announcement','system')	NOT NULL,
	`message`	TEXT	NOT NULL,
	`content`	TEXT	NULL,
	`is_read`	BOOLEAN	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`target_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL
);

CREATE TABLE `setting` (
	`id`	BIGINT	NOT NULL,
	`value`	VARCHAR(100)	NULL,
	`updated_at`	DATETIME	NULL
);

CREATE TABLE `track_mood_vote` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`track_id`	VARCHAR(200)	NOT NULL,
	`mood`	BIGINT	NOT NULL
);

CREATE TABLE `track_review` (
	`id`	BIGINT	NOT NULL,
	`rating`	FLOAT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`blinded`	BOOLEAN	NOT NULL,
	`likes`	INT	NOT NULL	DEFAULT 0,
	`dislikes`	INT	NOT NULL	DEFAULT 0,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`critic`	BOOLEAN	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`track_id`	VARCHAR (200)	NOT NULL
);

CREATE TABLE `user_activity_log` (
	`id`	BIGINT	NOT NULL,
	`action`	VARCHAR(50)	NOT NULL,
	`target_type`	VARCHAR(50)	NULL,
	`target_id`	BIGINT	NULL,
	`detail`	TEXT	NULL,
	`ip_address`	VARCHAR(45)	NULL,
	`user_agent`	TEXT	NULL,
	`created_at`	DATETIME	NOT NULL,
	`user_id`	BIGINT	NOT NULL
);

CREATE TABLE `user_badge` (
	`id`	BIGINT	NOT NULL,
	`created_at`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NULL,
	`badge_id`	BIGINT	NULL
);

CREATE TABLE `user_follow` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`follower_id`	BIGINT	NOT NULL,
	`following_id`	BIGINT	NOT NULL
);

CREATE TABLE `album_review` (
	`id`	BIGINT	NOT NULL,
	`rating`	FLOAT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`blinded`	BOOLEAN	NOT NULL,
	`likes`	INT	NOT NULL	DEFAULT 0,
	`dislikes`	INT	NOT NULL	DEFAULT 0,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`critic`	BOOLEAN	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`album_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `liked_album` (
	`id`	BIGINT	NOT NULL,
	`created_at`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`user_id`	BIGINT	NOT NULL,
	`album_id`	VARCHAR(200)	NOT NULL
);

CREATE TABLE `plugin` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(100)	NULL,
	`enabled`	BOOLEAN	NULL,
	`config_json`	TEXT	NULL,
	`created_at`	DATETIME	NULL
);

ALTER TABLE `notice` ADD CONSTRAINT `PK_NOTICE` PRIMARY KEY (
	`id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `PK_QNA_ANSWER` PRIMARY KEY (
	`id`
);

ALTER TABLE `role` ADD CONSTRAINT `PK_ROLE` PRIMARY KEY (
	`id`
);

ALTER TABLE `community` ADD CONSTRAINT `PK_COMMUNITY` PRIMARY KEY (
	`id`
);

ALTER TABLE `qna` ADD CONSTRAINT `PK_QNA` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_track` ADD CONSTRAINT `PK_LIKED_TRACK` PRIMARY KEY (
	`id`
);

ALTER TABLE `artist` ADD CONSTRAINT `PK_ARTIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (
	`id`
);

ALTER TABLE `track` ADD CONSTRAINT `PK_TRACK` PRIMARY KEY (
	`id`
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `external_api_config` ADD CONSTRAINT `PK_EXTERNAL_API_CONFIG` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_playlist` ADD CONSTRAINT `PK_LIKED_PLAYLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `report` ADD CONSTRAINT `PK_REPORT` PRIMARY KEY (
	`id`
);

ALTER TABLE `album_mood_vote` ADD CONSTRAINT `PK_ALBUM_MOOD_VOTE` PRIMARY KEY (
	`id`
);

ALTER TABLE `chart_element` ADD CONSTRAINT `PK_CHART_ELEMENT` PRIMARY KEY (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`id`
);

ALTER TABLE `playlist` ADD CONSTRAINT `PK_PLAYLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `album` ADD CONSTRAINT `PK_ALBUM` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_sanction` ADD CONSTRAINT `PK_USER_SANCTION` PRIMARY KEY (
	`id`
);

ALTER TABLE `admin_log` ADD CONSTRAINT `PK_ADMIN_LOG` PRIMARY KEY (
	`id`
);

ALTER TABLE `artist_follow` ADD CONSTRAINT `PK_ARTIST_FOLLOW` PRIMARY KEY (
	`id`
);

ALTER TABLE `playlist_detail` ADD CONSTRAINT `PK_PLAYLIST_DETAIL` PRIMARY KEY (
	`id`
);

ALTER TABLE `policy` ADD CONSTRAINT `PK_POLICY` PRIMARY KEY (
	`id`
);

ALTER TABLE `board_post` ADD CONSTRAINT `PK_BOARD_POST` PRIMARY KEY (
	`id`
);

ALTER TABLE `chart_entry` ADD CONSTRAINT `PK_CHART_ENTRY` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_role` ADD CONSTRAINT `PK_USER_ROLE` PRIMARY KEY (
	`id`
);

ALTER TABLE `badge` ADD CONSTRAINT `PK_BADGE` PRIMARY KEY (
	`id`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`id`
);

ALTER TABLE `setting` ADD CONSTRAINT `PK_SETTING` PRIMARY KEY (
	`id`
);

ALTER TABLE `track_mood_vote` ADD CONSTRAINT `PK_TRACK_MOOD_VOTE` PRIMARY KEY (
	`id`
);

ALTER TABLE `track_review` ADD CONSTRAINT `PK_TRACK_REVIEW` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_activity_log` ADD CONSTRAINT `PK_USER_ACTIVITY_LOG` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_badge` ADD CONSTRAINT `PK_USER_BADGE` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_follow` ADD CONSTRAINT `PK_USER_FOLLOW` PRIMARY KEY (
	`id`
);

ALTER TABLE `album_review` ADD CONSTRAINT `PK_ALBUM_REVIEW` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_album` ADD CONSTRAINT `PK_LIKED_ALBUM` PRIMARY KEY (
	`id`
);

ALTER TABLE `plugin` ADD CONSTRAINT `PK_PLUGIN` PRIMARY KEY (
	`id`
);

ALTER TABLE qna_answer MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE community MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE qna MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE liked_track MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE tag MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE external_api_config MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE liked_playlist MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE report MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE album_mood_vote MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE track_mood_vote MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE comment MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE playlist MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE artist_follow MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE playlist_detail MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE policy MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE board_post MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE chart_entry MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE badge MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE notification MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE setting MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE track_review MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user_badge MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user_follow MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE album_review MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE liked_album MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE plugin MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE chart_element MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user_sanction MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE role MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user_role MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE admin_log MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE user_activity_log MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;
ALTER TABLE notice MODIFY COLUMN id BIGINT NOT NULL AUTO_INCREMENT;

ALTER TABLE `notice` ADD CONSTRAINT `FK_user_TO_notice_1` FOREIGN KEY (
	`author_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (
	`qna_id`
)
REFERENCES `qna` (
	`id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_user_TO_qna_answer_1` FOREIGN KEY (
	`admin_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `community` ADD CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (
	`creator_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `qna` ADD CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `liked_track` ADD CONSTRAINT `FK_user_TO_liked_track_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `liked_track` ADD CONSTRAINT `FK_track_TO_liked_track_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `track` ADD CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `track` ADD CONSTRAINT `FK_artist_TO_track_1` FOREIGN KEY (
	`artist_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_user_TO_liked_playlist_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `liked_playlist` ADD CONSTRAINT `FK_playlist_TO_liked_playlist_1` FOREIGN KEY (
	`playlist_id`
)
REFERENCES `playlist` (
	`id`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_1` FOREIGN KEY (
	`reporter_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_user_TO_report_2` FOREIGN KEY (
	`target_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_user_TO_album_mood_vote_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_album_TO_album_mood_vote_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `album_mood_vote` ADD CONSTRAINT `FK_tag_TO_album_mood_vote_1` FOREIGN KEY (
	`mood`
)
REFERENCES `tag` (
	`id`
);

ALTER TABLE `chart_element` ADD CONSTRAINT `FK_album_TO_chart_element_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `playlist` ADD CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `album` ADD CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (
	`artist_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_sanction` ADD CONSTRAINT `FK_user_TO_user_sanction_2` FOREIGN KEY (
	`admin_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (
	`actor_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_2` FOREIGN KEY (
	`target_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (
	`artist_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_track_TO_playlist_detail_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `playlist_detail` ADD CONSTRAINT `FK_playlist_TO_playlist_detail_1` FOREIGN KEY (
	`playlist_id`
)
REFERENCES `playlist` (
	`id`
);

ALTER TABLE `board_post` ADD CONSTRAINT `FK_community_TO_board_post_1` FOREIGN KEY (
	`community_id`
)
REFERENCES `community` (
	`id`
);

ALTER TABLE `board_post` ADD CONSTRAINT `FK_user_TO_board_post_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `chart_entry` ADD CONSTRAINT `FK_track_TO_chart_entry_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `user_role` ADD CONSTRAINT `FK_user_TO_user_role_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_role` ADD CONSTRAINT `FK_role_TO_user_role_1` FOREIGN KEY (
	`role_id`
)
REFERENCES `role` (
	`id`
);

ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_user_TO_track_mood_vote_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_track_TO_track_mood_vote_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `track_mood_vote` ADD CONSTRAINT `FK_tag_TO_track_mood_vote_1` FOREIGN KEY (
	`mood`
)
REFERENCES `tag` (
	`id`
);

ALTER TABLE `track_review` ADD CONSTRAINT `FK_user_TO_track_review_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `track_review` ADD CONSTRAINT `FK_track_TO_track_review_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `user_activity_log` ADD CONSTRAINT `FK_user_TO_user_activity_log_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_badge` ADD CONSTRAINT `FK_user_TO_user_badge_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_badge` ADD CONSTRAINT `FK_badge_TO_user_badge_1` FOREIGN KEY (
	`badge_id`
)
REFERENCES `badge` (
	`id`
);

ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_1` FOREIGN KEY (
	`follower_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_follow` ADD CONSTRAINT `FK_user_TO_user_follow_2` FOREIGN KEY (
	`following_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `album_review` ADD CONSTRAINT `FK_user_TO_album_review_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `album_review` ADD CONSTRAINT `FK_album_TO_album_review_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `liked_album` ADD CONSTRAINT `FK_user_TO_liked_album_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `liked_album` ADD CONSTRAINT `FK_album_TO_liked_album_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

