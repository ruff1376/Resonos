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
