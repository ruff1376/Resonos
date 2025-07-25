-- Active: 1751337677491@@127.0.0.1@3306@resonos
-- 아티스트 장르 공백 지정
UPDATE artist
SET genres = 'pop'
WHERE genres IS NULL OR genres = '';

-- 앨범 장르 = 아티스트 장르
UPDATE album a
JOIN artist ar ON a.artist_id = ar.id
SET a.genre = ar.genres
WHERE a.genre IS NULL OR a.genre = '';

-- 대한민국 (KOR)
UPDATE album SET country = 'KOR'
WHERE label LIKE '%Starship%'
   OR label LIKE '%SM%'
   OR label LIKE '%YG%'
   OR label LIKE '%JYP%'
   OR label LIKE '%BIGHIT%'
   OR label LIKE '%Genie%'
   OR label LIKE '%DOOROODOOROO%'
   OR label LIKE '%CUBE%'
   OR label LIKE '%뮤직그라운드%'
   OR label LIKE '%TOON STUDIO%';

-- 미국 (USA)
UPDATE album SET country = 'USA'
WHERE label LIKE '%Atlantic%'
   OR label LIKE '%Interscope%'
   OR label LIKE '%Warner%'
   OR label LIKE '%Aftermath%'
   OR label LIKE '%Shady%'
   OR label LIKE '%Taylor Swift%';

-- 영국 (GBR)
UPDATE album SET country = 'GBR'
WHERE label LIKE '%UK%'
   OR label LIKE '%X5 Music Group%';

-- 일본 (JPN)
UPDATE album SET country = 'JPN'
WHERE label LIKE '%japan%'
   OR label LIKE '%avex%'
   OR label LIKE '%sony%';

-- 장르에 'k-' 들어간 앨범 국가 한국으로
UPDATE album
SET country = 'KOR'
WHERE country IS NULL
  AND genre LIKE '%k-%';
