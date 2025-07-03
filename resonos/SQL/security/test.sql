-- user 테이블 초기화 및 데이터 삽입
DELETE FROM user;
INSERT INTO user (username, password, nickname, email, is_pro, enabled) VALUES
('user',  '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자', 'user@mail.com', false, true),
('admin', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '관리자', 'admin@mail.com', false, true),
('test',  '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '테스트', 'test@mail.com', false, true);

-- user_auth 테이블 초기화 및 권한 삽입
DELETE FROM user_auth;
INSERT INTO user_auth (username, auth) VALUES
('user', 'ROLE_USER'),
('admin', 'ROLE_USER'),
('admin', 'ROLE_ADMIN'),
('test', 'ROLE_USER');
