-- user_auth
CREATE TABLE `user_auth` (
      no bigint NOT NULL AUTO_INCREMENT          -- 권한번호
    , username varchar(100) NOT NULL             -- 아이디
    , auth varchar(100) NOT NULL                 -- 권한 (ROLE_USER, ROLE_ADMIN, ...)
    , PRIMARY KEY(no)                      
);