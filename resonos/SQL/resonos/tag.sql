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



-- 더미 데이터 
INSERT INTO `tag` (`id`, `name`) VALUES
  -- (1, '밝음'),
  -- (2, '어둠'),
  -- (3, '신남'),
  -- (4, '잔잔함'),
  (5, '몽환'),
  (6, '감성'),
  (7, '파워풀');

-- user, album, tag에 해당하는 id가 실제로 있어야 정상적으로 들어갑니다!
INSERT INTO `album_mood_vote` (`id`, `user_id`, `album_id`, `mood`) VALUES
  (1, 1, '002MjQVkI2aHS733fGjj3S', 1),
  (2, 2, '01Lc5SkGnpLjjVx4QHae8a', 2),
  (3, 3, '01LQ7acjTLVDDj5rhcFXhE', 3),
  (4, 1, '01RsFGO7W7xaRM4T2p1Xdn', 4),
  (5, 2, '02pi98kE0nra0yBqCStzbC', 5),
  (6, 3, '04hy4jb1GDD00otiwzsFUB', 6),
  (7, 1, '05c49JgPmL4Uz2ZeqRx5SP', 7),
  (8, 2, '05K5RSyTasOI8cQTFHhTLS', 1),
  (9, 3, '05V1ld4qvJUnOQopUK8uSY', 2),
  (10, 1, '07Rq17GzCnIdWJcyVHb57G', 3);


-- user, track, tag에 해당하는 id가 실제로 있어야 정상적으로 들어갑니다!
INSERT INTO `track_mood_vote` (`id`, `user_id`, `track_id`, `mood`) VALUES
  (1, 1, '001ae7LXhrHvaFfrfADqn5', 1),
  (2, 2, '002K47DeMoZ2RU3yFHJKjl', 2),
  (3, 3, '003gX7eEbhdNuLD5ChIH9k', 3),
  (4, 1, '008UTycE9hMdoltMklrMOM', 4),
  (5, 2, '00aqkszH1FdUiJJWvX6iEl', 5),
  (6, 3, '00b0FVWyvEjX2n70d6PhI1', 6),
  (7, 1, '00Blm7zeNqgYLPtW6zg8cj', 7),
  (8, 2, '00bLSnliElWSOs1Ybt9dZm', 1),
  (9, 3, '00Cxlg96EHYJG2VoTh7Q3D', 2),
  (10, 1, '00FpTQ1Ws3iJPwAOAY5iVS', 3);

-- track 중복 허용된 태그 투표 
INSERT INTO `track_mood_vote` (`id`, `user_id`, `track_id`, `mood`) VALUES
  (201, 1, '001ae7LXhrHvaFfrfADqn5', 1),
  (202, 2, '001ae7LXhrHvaFfrfADqn5', 2),
  (203, 3, '001ae7LXhrHvaFfrfADqn5', 3),

  (204, 1, '002K47DeMoZ2RU3yFHJKjl', 2),
  (205, 2, '002K47DeMoZ2RU3yFHJKjl', 4),

  (206, 1, '003gX7eEbhdNuLD5ChIH9k', 3),
  (207, 2, '003gX7eEbhdNuLD5ChIH9k', 5),
  (208, 3, '003gX7eEbhdNuLD5ChIH9k', 1),

  (209, 1, '008UTycE9hMdoltMklrMOM', 4),
  (210, 2, '008UTycE9hMdoltMklrMOM', 6),

  (211, 1, '00aqkszH1FdUiJJWvX6iEl', 5),
  (212, 2, '00aqkszH1FdUiJJWvX6iEl', 7),

  (213, 1, '00b0FVWyvEjX2n70d6PhI1', 6),
  (214, 2, '00b0FVWyvEjX2n70d6PhI1', 1),

  (215, 1, '00Blm7zeNqgYLPtW6zg8cj', 7),
  (216, 2, '00Blm7zeNqgYLPtW6zg8cj', 3),

  (217, 1, '00bLSnliElWSOs1Ybt9dZm', 1),
  (218, 2, '00bLSnliElWSOs1Ybt9dZm', 2),

  (219, 1, '00Cxlg96EHYJG2VoTh7Q3D', 2),
  (220, 2, '00Cxlg96EHYJG2VoTh7Q3D', 3),

  (221, 1, '00FpTQ1Ws3iJPwAOAY5iVS', 3),
  (222, 2, '00FpTQ1Ws3iJPwAOAY5iVS', 4);

-- 앨범 더미 추가 
INSERT INTO `album_mood_vote` (`id`, `user_id`, `album_id`, `mood`) VALUES
  -- (301, 1, '01Lc5SkGnpLjjVx4QHae8a', 1),
  (302, 2, '01Lc5SkGnpLjjVx4QHae8a', 2),
  (303, 3, '01Lc5SkGnpLjjVx4QHae8a', 3),
  (304, 2, '01Lc5SkGnpLjjVx4QHae8a', 4),
  (305, 1, '01Lc5SkGnpLjjVx4QHae8a', 5),
  (306, 1, '01LQ7acjTLVDDj5rhcFXhE', 2),
  (307, 2, '01LQ7acjTLVDDj5rhcFXhE', 3),
  (308, 3, '01LQ7acjTLVDDj5rhcFXhE', 4),
  (309, 2, '01LQ7acjTLVDDj5rhcFXhE', 5),
  (310, 1, '01LQ7acjTLVDDj5rhcFXhE', 1),
  (311, 1, '01RsFGO7W7xaRM4T2p1Xdn', 3),
  (312, 2, '01RsFGO7W7xaRM4T2p1Xdn', 4),
  (313, 3, '01RsFGO7W7xaRM4T2p1Xdn', 5),
  (314, 2, '01RsFGO7W7xaRM4T2p1Xdn', 1),
  (315, 1, '01RsFGO7W7xaRM4T2p1Xdn', 2),
  (316, 1, '04hy4jb1GDD00otiwzsFUB', 4),
  (317, 2, '04hy4jb1GDD00otiwzsFUB', 5),
  (318, 3, '04hy4jb1GDD00otiwzsFUB', 1),
  (319, 2, '04hy4jb1GDD00otiwzsFUB', 2),
  (320, 1, '04hy4jb1GDD00otiwzsFUB', 3),
  (321, 1, '07Rq17GzCnIdWJcyVHb57G', 5),
  (322, 2, '07Rq17GzCnIdWJcyVHb57G', 1),
  (323, 3, '07Rq17GzCnIdWJcyVHb57G', 2),
  (324, 2, '07Rq17GzCnIdWJcyVHb57G', 3),
  (325, 1, '07Rq17GzCnIdWJcyVHb57G', 4);

