-- 🧹 테이블 정리
-- (생성 직후에 데이터가 들어있지는 않기 때문에 일반적으로 TRUNCATE는 DROP 이후에는 불필요하지만,
-- 만약 DROP이 실패하고 CREATE만 성공했던 경우를 대비해서 추가함)
TRUNCATE TABLE
    user_activity_log;
TRUNCATE TABLE admin_log;
TRUNCATE TABLE user_role;
TRUNCATE TABLE role;
TRUNCATE TABLE user_sanction;
TRUNCATE TABLE plugin;
TRUNCATE TABLE liked_album;
TRUNCATE TABLE album_review;
TRUNCATE TABLE user_follow;
TRUNCATE TABLE user_badge;
TRUNCATE TABLE track_review;
TRUNCATE TABLE setting;
TRUNCATE TABLE notification;
TRUNCATE TABLE badge;
TRUNCATE TABLE chart_entry;
TRUNCATE TABLE board_post;
TRUNCATE TABLE policy;
TRUNCATE TABLE playlist_detail;
TRUNCATE TABLE artist_follow;
TRUNCATE TABLE album;
TRUNCATE TABLE playlist;
TRUNCATE TABLE comment;
TRUNCATE TABLE chart_element;
TRUNCATE TABLE album_mood_vote;
TRUNCATE TABLE report;
TRUNCATE TABLE liked_playlist;
TRUNCATE TABLE external_api_config;
TRUNCATE TABLE user;
TRUNCATE TABLE track;
TRUNCATE TABLE tag;
TRUNCATE TABLE artist;
TRUNCATE TABLE liked_track;
TRUNCATE TABLE qna;
TRUNCATE TABLE community;
TRUNCATE TABLE qna_answer;
TRUNCATE TABLE notice;
TRUNCATE TABLE track_mood_vote;