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
