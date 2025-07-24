UPDATE album a
JOIN artist ar ON a.artist_id = ar.id
SET a.genre = ar.genres
WHERE a.genre = '';



-- artist 컬럼중 gerne값을 album 테이블에 넣는 sql 쿼리 
UPDATE album a
JOIN artist ar ON a.artist_id = ar.id
SET a.genre = ar.genres
WHERE a.genre IS NULL OR a.genre = '';