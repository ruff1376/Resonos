import random

ARTIST_PATH = r'C:/yhm/ProjectTeam/Resonos/resonos/SQL/resonos/artist.txt'
ALBUM_PATH  = r'C:/yhm/ProjectTeam/Resonos/resonos/SQL/resonos/album.txt'
TRACK_PATH  = r'C:/yhm/ProjectTeam/Resonos/resonos/SQL/resonos/track.txt'

def load_ids(path):
    with open(path, encoding='utf-8') as f:
        return [l.strip() for l in f
                if l.strip() and
                not l.lower().startswith('artist id') and
                not l.lower().startswith('album id') and
                not l.lower().startswith('track id')]

artist_ids = load_ids(ARTIST_PATH)
album_ids  = load_ids(ALBUM_PATH)
track_ids  = load_ids(TRACK_PATH)

USER_PASSWORD = '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92'

N_USER = 100
N_FOLLOW = 400
N_LIKED_TRACK = 500

sqls = []

# 1. user (username만 유니크)
for i in range(1, N_USER+1):
    sqls.append(
        f"INSERT INTO user(username, email, password, nickname, profile_image, is_pro, enabled) "
        f"VALUES ('test{i:04d}', 'test{i:04d}@test.com', '{USER_PASSWORD}', '닉{i}', '/img/{i%10+1}.png', 0, 1);"
    )

# 2. user_follow (follower_id, following_id) 중복 방지
user_follow_set = set()
while len(user_follow_set) < N_FOLLOW:
    u1 = random.randint(1, N_USER)
    u2 = random.randint(1, N_USER)
    if u1 != u2 and (u1, u2) not in user_follow_set:
        user_follow_set.add((u1, u2))
for u1, u2 in user_follow_set:
    sqls.append(f"INSERT INTO user_follow(follower_id, following_id) VALUES({u1}, {u2});")

# 3. liked_track (user_id, track_id) 중복 방지
liked_track_set = set()
while len(liked_track_set) < N_LIKED_TRACK:
    uid = random.randint(1, N_USER)
    tid = random.choice(track_ids)
    if (uid, tid) not in liked_track_set:
        liked_track_set.add((uid, tid))
for uid, tid in liked_track_set:
    sqls.append(f"INSERT INTO liked_track(user_id, track_id) VALUES({uid}, '{tid}');")

# 4. liked_album (user_id, album_id) 중복 방지
liked_album_set = set()
target = N_LIKED_TRACK//3
while len(liked_album_set) < target:
    uid = random.randint(1, N_USER)
    aid = random.choice(album_ids)
    if (uid, aid) not in liked_album_set:
        liked_album_set.add((uid, aid))
for uid, aid in liked_album_set:
    sqls.append(f"INSERT INTO liked_album(user_id, album_id) VALUES({uid}, '{aid}');")



# 6. artist_follow (user_id, artist_id) 중복 방지
artist_follow_set = set()
target = N_LIKED_TRACK//2
while len(artist_follow_set) < target:
    uid = random.randint(1, N_USER)
    aid = random.choice(artist_ids)
    if (uid, aid) not in artist_follow_set:
        artist_follow_set.add((uid, aid))
for uid, aid in artist_follow_set:
    sqls.append(f"INSERT INTO artist_follow(user_id, artist_id) VALUES({uid}, '{aid}');")

# 7. playlist & playlist_detail - playlist_id, track_id
for i in range(1, N_USER+1):
    sqls.append(
        f"INSERT INTO playlist(user_id, title, description, thumbnail_url, is_public) "
        f"VALUES ({i}, '플리{i}', 'desc{i}', '/img/pl{i%10+1}.png', 1);"
    )
playlist_detail_set = set()
for i in range(1, N_USER+1):
    track = random.choice(track_ids)
    if (i, track) not in playlist_detail_set:
        playlist_detail_set.add((i, track))
for pid, tid in playlist_detail_set:
    sqls.append(f"INSERT INTO playlist_detail(playlist_id, track_id, order_no) VALUES({pid}, '{tid}', 1);")

# 5. liked_playlist (user_id, playlist_id) 중복 방지
liked_playlist_set = set()
target = N_LIKED_TRACK//4
while len(liked_playlist_set) < target:
    uid = random.randint(1, N_USER)
    pid = random.randint(1, N_USER)
    if (uid, pid) not in liked_playlist_set:
        liked_playlist_set.add((uid, pid))
for uid, pid in liked_playlist_set:
    sqls.append(f"INSERT INTO liked_playlist(user_id, playlist_id) VALUES({uid}, {pid});")

# 8. album_review, track_review (user_id, album_id/track_id) 중복 방지 없이 랜덤(적은 수라 가능)
album_review_set = set()
while len(album_review_set) < N_USER:
    uid = random.randint(1, N_USER)
    aid = random.choice(album_ids)
    if (uid, aid) not in album_review_set:
        album_review_set.add((uid, aid))
for uid, aid in album_review_set:
    sqls.append(
        f"INSERT INTO album_review(user_id, album_id, rating, content, blinded, critic) "
        f"VALUES({uid}, '{aid}', {random.randint(1,5)}, '코멘트 {random.randint(1,10000)}', 0, {random.choice([0,1])});"
    )
track_review_set = set()
while len(track_review_set) < N_USER:
    uid = random.randint(1, N_USER)
    tid = random.choice(track_ids)
    if (uid, tid) not in track_review_set:
        track_review_set.add((uid, tid))
for uid, tid in track_review_set:
    sqls.append(
        f"INSERT INTO track_review(user_id, track_id, rating, content, blinded, critic) "
        f"VALUES({uid}, '{tid}', {random.randint(1,5)}, '리뷰 {random.randint(1,10000)}', 0, {random.choice([0,1])});"
    )

# 9. comment (user_id, type, target_id) - 데이터 특성상 중복 신경 안써도 됨(유니크X)
for _ in range(N_USER):
    uid = random.randint(1, N_USER)
    target_type = random.choice(['playlist', 'track', 'album', 'user'])
    if target_type == 'playlist':
        target = random.randint(1, N_USER)
    elif target_type == 'track':
        target = f"'{random.choice(track_ids)}'"
    elif target_type == 'album':
        target = f"'{random.choice(album_ids)}'"
    else:
        target = random.randint(1, N_USER)
    sqls.append(
        f"INSERT INTO comment(content, user_id, type, target_id) VALUES('댓글{random.randint(1,10000)}', {uid}, '{target_type}', {target});"
    )

import os
with open('dummy_data.sql', 'w', encoding='utf-8') as f:
    for line in sqls:
        f.write(line + '\n')

print(f'쿼리 {len(sqls)}건 생성 완료 -> {os.path.abspath("dummy_data.sql")} 파일을 DB에 import 하세요.')
print("파일이 생성되는 디렉토리:", os.getcwd())
