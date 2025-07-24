import random

user_ids = range(10, 36)
mood_values = list(range(1, 19))  # 1부터 18까지 mood 리스트

sql_values = []
for uid in user_ids:
    mood = random.choice(mood_values)  # 1개만 랜덤 선택
    sql_values.append(f"({uid}, '41MozSoPIsD1dJM0CLPjZF', {mood})")

sql = "INSERT INTO album_mood_vote (user_id, artist_id, mood) VALUES\n" + ",\n".join(sql_values) + ";"

print(sql)
