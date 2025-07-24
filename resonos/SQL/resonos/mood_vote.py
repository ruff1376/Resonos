import random

user_ids = range(10, 36)
mood_values = [10, 3, 14, 7, 17]

sql_values = []
for uid in user_ids:
    mood = random.choice(mood_values)  # 한 개만 랜덤 선택
    sql_values.append(f"({uid}, '4JjJ1KNRrzqstSY0uDuys3', {mood})")

sql = "INSERT INTO track_mood_vote (user_id, track_id, mood) VALUES\n" + ",\n".join(sql_values) + ";"

print(sql)
