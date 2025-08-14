INSERT INTO track_mood_vote (user_id, track_id, mood)
WITH RECURSIVE seq AS (
    SELECT 1 AS user_id
    UNION ALL
    SELECT user_id + 1
    FROM seq
    WHERE user_id < 30      -- 유저 1~30번 순회
)
SELECT
    user_id,
    '55h7vJchibLdUkxdlX3fK7' AS track_id,       -- 투표할 트랙 id
    3 AS mood       -- 투표할 태그 id
FROM seq
;
