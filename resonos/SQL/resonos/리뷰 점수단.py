import random

def generate_update_queries(table_name, start_id, end_id):
    queries = []
    for i in range(start_id, end_id + 1):
        rating = random.randint(60, 100)
        queries.append(f"UPDATE {table_name} SET rating = {rating} WHERE id = {i};")
    return queries

album_review_updates = generate_update_queries("album_review", 1, 566)
track_review_updates = generate_update_queries("track_review", 1, 562)

# 결과 출력 (각각의 UPDATE 쿼리를 한 줄씩 출력)
# print("-- album_review rating 업데이트 쿼리")
# for q in album_review_updates:
#     print(q)

print("\n-- track_review rating 업데이트 쿼리")
for q in track_review_updates:
    print(q)
