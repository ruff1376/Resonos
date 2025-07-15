-- Active: 1751542958734@@127.0.0.1@3306@resonos
INSERT INTO setting (id, name, description, value, updated_at, created_at) VALUES
(1, 'allow_registration', '신규 가입 허용 여부', 'yes', NOW(), NOW()),
(2, 'community_board_enabled', '커뮤니티 게시판 활성화 여부', 'yes', NOW(), NOW()),
(3, 'external_music_data_sync', '음악 데이터 외부 연동 활성화 여부', 'yes', NOW(), NOW()),
(4, 'default_theme', '기본 테마 설정 (다크/라이트)', 'dark', NOW(), NOW());




DESCRIBE setting;

ALTER TABLE setting ADD COLUMN name VARCHAR(255);
ALTER TABLE setting ADD COLUMN description TEXT;

-- created_at, updated_at 컬럼 추가
ALTER TABLE setting ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE setting ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


SHOW CREATE TABLE policy;
