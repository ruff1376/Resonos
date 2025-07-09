-- tag 컬럼 추가 가능 is_active, type 활성화 여부
CREATE TABLE IF NOT EXISTS `tag` (
    `id` BIGINT NOT NULL,
    `name` VARCHAR(50) NOT NULL
);


ALTER TABLE tag MODIFY id BIGINT NOT NULL AUTO_INCREMENT;


SELECT * from album_mood_vote

select * from track_mood_vote

select * from tag

SELECT * FROM tag WHERE id IS NULL;
