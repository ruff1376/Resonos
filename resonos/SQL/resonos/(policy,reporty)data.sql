-- Active: 1751337677491@@127.0.0.1@3306@resonos
INSERT INTO `policy` (`id`, `type`, `content`, `version`, `updated_at`) VALUES
  (1, 'terms', '이용약관 v1', 'v1.0', '2025-06-01 10:00:00'),
  (2, 'privacy', '개인정보처리방침 v1', 'v1.0', '2025-06-01 10:05:00'),
  (3, 'terms', '이용약관 v2', 'v2.0', '2025-07-01 09:00:00'),
  (4, 'privacy', '개인정보처리방침 v2', 'v2.0', '2025-07-01 09:10:00'),
  (5, 'cookie', '쿠키 정책', 'v1.0', '2025-06-15 12:00:00'),
  (6, 'security', '보안정책 안내', 'v1.0', '2025-06-20 15:30:00'),
  (7, 'refund', '환불 정책', 'v1.0', '2025-06-22 11:45:00'),
  (8, 'location', '위치정보 이용약관', 'v1.0', '2025-06-18 13:00:00'),
  (9, 'ads', '광고 정책', 'v1.0', '2025-06-10 08:00:00'),
  (10, 'third_party', '3자 제공 정책', 'v1.0', '2025-06-25 17:00:00');


INSERT INTO `report` (`id`, `reporter_id`, `target_id`, `target_type`, `reason`, `status`, `created_at`) VALUES
(1, 2, 3, 'user', '부적절한 언행', 'PENDING', '2025-06-10 11:00:00'),
(2, 4, 1, 'user', '스팸 게시물', 'PENDING', '2025-06-11 12:00:00'),
(3, 5, 6, 'user', '허위 정보', 'PENDING', '2025-06-12 13:00:00'),
(4, 7, 2, 'user', '광고성 활동', 'PENDING', '2025-06-13 14:00:00'),
(5, 6, 8, 'user', '욕설 사용', 'PENDING', '2025-06-14 15:00:00'),
(6, 8, 5, 'user', '도배성 댓글', 'PENDING', '2025-06-15 16:00:00'),
(7, 9, 10, 'user', '불건전한 내용', 'PENDING', '2025-06-16 17:00:00'),
(8, 3, 4, 'user', '지속적 괴롭힘', 'PENDING', '2025-06-17 18:00:00'),
(9, 10, 7, 'user', '기타 사유', 'PENDING', '2025-06-18 19:00:00'),
(10, 1, 9, 'user', '이중 계정 의심', 'PENDING', '2025-06-19 20:00:00');

ALTER TABLE `setting`
  ADD COLUMN `name` VARCHAR(255) NULL,
  ADD COLUMN `description` VARCHAR(255) NULL,
  ADD COLUMN `created_at` DATETIME NULL;
