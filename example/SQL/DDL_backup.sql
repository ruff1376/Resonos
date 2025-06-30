DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`id`	BIGINT	NULL,
	`username`	VARCHAR	NOT NULL,
	`email`	VARCHAR	NOT NULL,
	`password`	VARCHAR	NOT NULL,
	`nickname`	VARCHAR	NOT NULL,
	`profile_image`	VARCHAR	NULL,
	`bio`	TEXT	NULL,
	`is_pro`	BOOLEAN	NULL,
	`enabled`	BOOLEAN	NULL,
	`provider`	VARCHAR	NULL,
	`provider_id`	VARCHAR	NULL
);

DROP TABLE IF EXISTS `artist`;

CREATE TABLE `artist` (
	`id`	VARCHAR	NULL,
	`name`	VARCHAR	NOT NULL,
	`profile_image`	VARCHAR	NULL,
	`genres`	VARCHAR	NULL
);

DROP TABLE IF EXISTS `album`;

CREATE TABLE `album` (
	`id`	VARCHAR	NULL,
	`title`	VARCHAR	NOT NULL,
	`cover_image`	VARCHAR	NULL,
	`release_date`	DATE	NULL,
	`genre`	VARCHAR	NULL,
	`label`	VARCHAR	NULL,
	`description`	TEXT	NULL,
	`artist_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `track`;

CREATE TABLE `track` (
	`id`	VARCHAR	NULL,
	`title`	VARCHAR	NOT NULL,
	`duration`	INT	NULL,
	`genre`	VARCHAR	NULL,
	`streaming_url`	VARCHAR	NOT NULL,
	`mv_url`	VARCHAR	NULL,
	`artist_id`	BIGINT	NOT NULL,
	`album_id`	BIGINT	NOT NULL,
	`popularity`	INT	NOT NULL
);

DROP TABLE IF EXISTS `playlist`;

CREATE TABLE `playlist` (
	`id`	BIGINT	NULL,
	`name`	VARCHAR	NOT NULL,
	`description`	TEXT	NULL,
	`thumbnail_url`	VARCHAR	NULL,
	`is_public`	BOOLEAN	NULL,
	`user_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
	`id`	BIGINT	NULL,
	`rating`	FLOAT	NULL,
	`content`	TEXT	NULL,
	`blinded`	BOOLEAN	NULL,
	`likes`	INT	NULL,
	`dislikes`	INT	NULL,
	`created_at`	DATETIME	NULL,
	`critic`	BOOLEAN	NULL,
	`user_id`	BIGINT	NULL,
	`album_id`	BIGINT	NULL,
	`track_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`id`	BIGINT	NULL,
	`content`	TEXT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`review_id`	BIGINT	NULL,
	`parent_id`	BIGINT	NULL,
	`board_post_id`	BIGINT	NULL,
	`playlist_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `board_post`;

CREATE TABLE `board_post` (
	`id`	BIGINT	NULL,
	`title`	VARCHAR	NULL,
	`content`	TEXT	NULL,
	`type`	VARCHAR	NULL,
	`created_at`	DATETIME	NULL,
	`community_id`	BIGINT	NULL,
	`author_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `mood_vote`;

CREATE TABLE `mood_vote` (
	`id`	BIGINT	NULL,
	`count`	INT	NULL,
	`mood`	BIGINT	NULL,
	`user_id`	BIGINT	NULL,
	`album_id`	BIGINT	NULL,
	`track_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
	`id`	BIGINT	NULL,
	`name`	VARCHAR	NULL
);

DROP TABLE IF EXISTS `qna`;

CREATE TABLE `qna` (
	`id`	BIGINT	NULL,
	`type`	VARCHAR	NULL,
	`title`	VARCHAR	NULL,
	`content`	TEXT	NULL,
	`created_at`	DATETIME	NULL,
	`status`	VARCHAR	NULL,
	`user_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `qna_answer`;

CREATE TABLE `qna_answer` (
	`id`	BIGINT	NULL,
	`content`	TEXT	NULL,
	`answered_at`	DATETIME	NULL,
	`qna_id`	BIGINT	NULL,
	`admin_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
	`id`	BIGINT	NULL	DEFAULT ('comment, 'mention', 'like','follow','reply','badge','qna','announcement','system'),
	`type`	ENUM	NULL,
	`message`	TEXT	NULL,
	`content`	TEXT	NULL,
	`is_read`	BOOLEAN	NOT NULL,
	`created_at`	DATETIME	NOT NULL,
	`target_type`	ENUM	NULL	DEFAULT ('boardPost', 'review', 'comment', 'playlist'),
	`target_id`	BIGINT	NULL,
	`user_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `admin_log`;

CREATE TABLE `admin_log` (
	`id`	BIGINT	NULL,
	`action`	VARCHAR	NULL,
	`target_type`	VARCHAR	NULL,
	`detail`	TEXT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`target_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `external_api_config`;

CREATE TABLE `external_api_config` (
	`id`	BIGINT	NULL,
	`provider`	VARCHAR	NULL,
	`apiKey`	VARCHAR	NULL,
	`secret`	VARCHAR	NULL,
	`enabled`	BOOLEAN	NULL,
	`created_at`	DATETIME	NULL
);

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
	`id`	BIGINT	NULL,
	`target_type`	ENUM	NULL	DEFAULT ('boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna'),
	`reason`	TEXT	NULL,
	`status`	VARCHAR	NULL,
	`created_at`	DATETIME	NULL,
	`reporter_id`	BIGINT	NULL,
	`target_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `community`;

CREATE TABLE `community` (
	`id`	BIGINT	NULL,
	`name`	VARCHAR	NULL,
	`description`	TEXT	NULL,
	`created_at`	DATETIME	NULL,
	`creator_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `plugin`;

CREATE TABLE `plugin` (
	`id`	BIGINT	NULL,
	`name`	VARCHAR	NULL,
	`enabled`	BOOLEAN	NULL,
	`config_json`	TEXT	NULL,
	`created_at`	DATETIME	NULL
);

DROP TABLE IF EXISTS `policy`;

CREATE TABLE `policy` (
	`id`	BIGINT	NULL,
	`type`	VARCHAR	NULL,
	`content`	TEXT	NULL,
	`version`	VARCHAR	NULL,
	`updated_at`	DATETIME	NULL
);

DROP TABLE IF EXISTS `chart_entry`;

CREATE TABLE `chart_entry` (
	`id`	BIGINT	NULL,
	`type`	VARCHAR	NULL,
	`rank`	INT	NULL,
	`calculated_at`	DATETIME	NULL,
	`track_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `setting`;

CREATE TABLE `setting` (
	`id`	BIGINT	NULL,
	`value`	VARCHAR	NULL,
	`updated_at`	DATETIME	NULL
);

DROP TABLE IF EXISTS `user_follow`;

CREATE TABLE `user_follow` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`follower_id`	BIGINT	NULL,
	`following_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `artist_follow`;

CREATE TABLE `artist_follow` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`artist_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `liked_playlist`;

CREATE TABLE `liked_playlist` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`playlist_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `liked_album`;

CREATE TABLE `liked_album` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`album_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `liked_track`;

CREATE TABLE `liked_track` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`track_id`	BIGINT	NULL
);

DROP TABLE IF EXISTS `badge`;

CREATE TABLE `badge` (
	`id`	BIGINT	NULL,
	`name`	VARCHAR	NULL,
	`description`	TEXT	NULL,
	`icon_url`	VARCHAR	NULL,
	`criteria`	VARCHAR	NULL,
	`created_at`	DATETIME	NULL
);

DROP TABLE IF EXISTS `user_badge`;

CREATE TABLE `user_badge` (
	`id`	BIGINT	NULL,
	`created_at`	DATETIME	NULL,
	`user_id`	BIGINT	NULL,
	`badge_id`	BIGINT	NULL
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `artist` ADD CONSTRAINT `PK_ARTIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `album` ADD CONSTRAINT `PK_ALBUM` PRIMARY KEY (
	`id`
);

ALTER TABLE `track` ADD CONSTRAINT `PK_TRACK` PRIMARY KEY (
	`id`
);

ALTER TABLE `playlist` ADD CONSTRAINT `PK_PLAYLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`id`
);

ALTER TABLE `board_post` ADD CONSTRAINT `PK_BOARD_POST` PRIMARY KEY (
	`id`
);

ALTER TABLE `mood_vote` ADD CONSTRAINT `PK_MOOD_VOTE` PRIMARY KEY (
	`id`
);

ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (
	`id`
);

ALTER TABLE `qna` ADD CONSTRAINT `PK_QNA` PRIMARY KEY (
	`id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `PK_QNA_ANSWER` PRIMARY KEY (
	`id`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`id`
);

ALTER TABLE `admin_log` ADD CONSTRAINT `PK_ADMIN_LOG` PRIMARY KEY (
	`id`
);

ALTER TABLE `external_api_config` ADD CONSTRAINT `PK_EXTERNAL_API_CONFIG` PRIMARY KEY (
	`id`
);

ALTER TABLE `report` ADD CONSTRAINT `PK_REPORT` PRIMARY KEY (
	`id`
);

ALTER TABLE `community` ADD CONSTRAINT `PK_COMMUNITY` PRIMARY KEY (
	`id`
);

ALTER TABLE `plugin` ADD CONSTRAINT `PK_PLUGIN` PRIMARY KEY (
	`id`
);

ALTER TABLE `policy` ADD CONSTRAINT `PK_POLICY` PRIMARY KEY (
	`id`
);

ALTER TABLE `chart_entry` ADD CONSTRAINT `PK_CHART_ENTRY` PRIMARY KEY (
	`id`
);

ALTER TABLE `setting` ADD CONSTRAINT `PK_SETTING` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_follow` ADD CONSTRAINT `PK_USER_FOLLOW` PRIMARY KEY (
	`id`
);

ALTER TABLE `artist_follow` ADD CONSTRAINT `PK_ARTIST_FOLLOW` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_playlist` ADD CONSTRAINT `PK_LIKED_PLAYLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_album` ADD CONSTRAINT `PK_LIKED_ALBUM` PRIMARY KEY (
	`id`
);

ALTER TABLE `liked_track` ADD CONSTRAINT `PK_LIKED_TRACK` PRIMARY KEY (
	`id`
);

ALTER TABLE `badge` ADD CONSTRAINT `PK_BADGE` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_badge` ADD CONSTRAINT `PK_USER_BADGE` PRIMARY KEY (
	`id`
);

ALTER TABLE `album` ADD CONSTRAINT `FK_artist_TO_album_1` FOREIGN KEY (
	`artist_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `track` ADD CONSTRAINT `FK_album_TO_track_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `playlist` ADD CONSTRAINT `FK_user_TO_playlist_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_user_TO_review_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_album_TO_review_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_track_TO_review_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_review_TO_comment_1` FOREIGN KEY (
	`review_id`
)
REFERENCES `review` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_comment_TO_comment_1` FOREIGN KEY (
	`parent_id`
)
REFERENCES `comment` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_post_TO_comment_1` FOREIGN KEY (
	`board_post_id`
)
REFERENCES `board_post` (
	`id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_playlist_TO_comment_1` FOREIGN KEY (
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

ALTER TABLE `board_post` ADD CONSTRAINT `FK_artist_TO_board_post_1` FOREIGN KEY (
	`author_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `mood_vote` ADD CONSTRAINT `FK_tag_TO_mood_vote_1` FOREIGN KEY (
	`mood`
)
REFERENCES `tag` (
	`id`
);

ALTER TABLE `mood_vote` ADD CONSTRAINT `FK_user_TO_mood_vote_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `mood_vote` ADD CONSTRAINT `FK_album_TO_mood_vote_1` FOREIGN KEY (
	`album_id`
)
REFERENCES `album` (
	`id`
);

ALTER TABLE `mood_vote` ADD CONSTRAINT `FK_track_TO_mood_vote_1` FOREIGN KEY (
	`track_id`
)
REFERENCES `track` (
	`id`
);

ALTER TABLE `qna` ADD CONSTRAINT `FK_user_TO_qna_1` FOREIGN KEY (
	`user_id`
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

ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `admin_log` ADD CONSTRAINT `FK_user_TO_admin_log_1` FOREIGN KEY (
	`user_id`
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

ALTER TABLE `community` ADD CONSTRAINT `FK_user_TO_community_1` FOREIGN KEY (
	`creator_id`
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

ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_artist_TO_artist_follow_1` FOREIGN KEY (
	`artist_id`
)
REFERENCES `artist` (
	`id`
);

ALTER TABLE `artist_follow` ADD CONSTRAINT `FK_user_TO_artist_follow_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
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

