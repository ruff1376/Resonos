-- SELECT a.title, ar.name AS artist_name, a.genre
-- FROM album a
-- LEFT JOIN artist ar ON ar.id = a.artist_id
-- WHERE a.country IS NULL
--   AND a.genre LIKE '%k-%';

UPDATE album
SET country = 'KOR'
WHERE country IS NULL
  AND genre LIKE '%k-%';

-- SELECT a.title, ar.name AS artist_name, a.genre
-- FROM album a
-- LEFT JOIN artist ar ON ar.id = a.artist_id
-- WHERE a.country IS NULL;

-- album 테이블의 country 컬럼이 null이고, genre 컬럼에 'k-'가 포함된 경우 country를 'KOR'로 업데이트
UPDATE album a
SET a.country = 'KOR'
WHERE a.genre LIKE '%k-%';
