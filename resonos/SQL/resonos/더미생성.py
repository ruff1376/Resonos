import random
import os

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

USER_PASSWORD = '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92'  # bcrypt 123456

N_USER = 100
N_FOLLOW = 400
N_LIKED_TRACK = 500

sqls = []

# 1. user (profile_image 고정)
for i in range(1, N_USER+1):
    sqls.append(
        f"INSERT INTO user(username, email, password, nickname, profile_image, is_pro, enabled) "
        f"VALUES ('test{i:04d}', 'test{i:04d}@test.com', '{USER_PASSWORD}', '닉{i}', '/img/profileImg.png', 0, 1);"
    )

# 1-1. user_auth 권한 부여 (90% USER / 10% ADMIN 비율)
for i in range(1, N_USER+1):
    role = 'ROLE_ADMIN' if random.random() < 0.1 else 'ROLE_USER'
    sqls.append(
        f"INSERT INTO user_auth(username, auth) VALUES ('test{i:04d}', '{role}');"
    )

# 2. playlist & playlist_detail - 각 user 3개씩 playlist, 썸네일 고정, track 3곡 랜덤 추가
playlist_id = 1
for user_id in range(1, N_USER+1):
    for pl_num in range(1, 4):
        sqls.append(
            f"INSERT INTO playlist(id, user_id, title, description, thumbnail_url, is_public) "
            f"VALUES ({playlist_id}, {user_id}, '플리{user_id}_{pl_num}', 'desc{user_id}_{pl_num}', '/img/profileImg.png', 1);"
        )
        tracks_sampled = random.sample(track_ids, 3)
        for order_no, track_id in enumerate(tracks_sampled, 1):
            sqls.append(
                f"INSERT INTO playlist_detail(playlist_id, track_id, order_no) VALUES({playlist_id}, '{track_id}', {order_no});"
            )
        playlist_id += 1

# 3. user_follow (중복 방지)
user_follow_set = set()
while len(user_follow_set) < N_FOLLOW:
    f_id = random.randint(1, N_USER)
    flw_id = random.randint(1, N_USER)
    if f_id != flw_id and (f_id, flw_id) not in user_follow_set:
        user_follow_set.add((f_id, flw_id))
for f_id, flw_id in user_follow_set:
    sqls.append(f"INSERT INTO user_follow(follower_id, following_id) VALUES({f_id}, {flw_id});")

# 4. liked_track (중복 방지)
liked_track_set = set()
while len(liked_track_set) < N_LIKED_TRACK:
    uid = random.randint(1, N_USER)
    tid = random.choice(track_ids)
    if (uid, tid) not in liked_track_set:
        liked_track_set.add((uid, tid))
for uid, tid in liked_track_set:
    sqls.append(f"INSERT INTO liked_track(user_id, track_id) VALUES({uid}, '{tid}');")

# 5. liked_album (중복 방지)
liked_album_set = set()
target = N_LIKED_TRACK // 3
while len(liked_album_set) < target:
    uid = random.randint(1, N_USER)
    aid = random.choice(album_ids)
    if (uid, aid) not in liked_album_set:
        liked_album_set.add((uid, aid))
for uid, aid in liked_album_set:
    sqls.append(f"INSERT INTO liked_album(user_id, album_id) VALUES({uid}, '{aid}');")

# 6. artist_follow (중복 방지)
artist_follow_set = set()
target = N_LIKED_TRACK // 2
while len(artist_follow_set) < target:
    uid = random.randint(1, N_USER)
    aid = random.choice(artist_ids)
    if (uid, aid) not in artist_follow_set:
        artist_follow_set.add((uid, aid))
for uid, aid in artist_follow_set:
    sqls.append(f"INSERT INTO artist_follow(user_id, artist_id) VALUES({uid}, '{aid}');")

# 7. liked_playlist (중복 방지)
liked_playlist_set = set()
target = N_LIKED_TRACK // 4
while len(liked_playlist_set) < target:
    uid = random.randint(1, N_USER)
    pid = random.randint(1, playlist_id - 1)  # 기존 생성 playlist_id 기준
    if (uid, pid) not in liked_playlist_set:
        liked_playlist_set.add((uid, pid))
for uid, pid in liked_playlist_set:
    sqls.append(f"INSERT INTO liked_playlist(user_id, playlist_id) VALUES({uid}, {pid});")

# 8. album_review, track_review (중복 방지 없이 적절 수만 생성)
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

# 9. comment (comment 테이블 스키마 반영: type ENUM('posts','playlist','comment'), target_id BIGINT)
comment_id = 1
for _ in range(N_USER * 10):  # 각 user 10개 댓글
    uid = random.randint(1, N_USER)
    ctype = random.choice(['posts', 'playlist', 'comment'])
    if ctype == 'posts':
        target = random.randint(1, 1000)  # 임의 게시글 id 범위
    elif ctype == 'playlist':
        target = random.randint(1, playlist_id - 1)
    else:  # comment (대댓글), target_id는 이미 생성된 comment id 범위
        target = random.randint(1, max(comment_id - 1, 1))
    sqls.append(
        f"INSERT INTO comment(id, content, user_id, type, target_id) VALUES "
        f"({comment_id}, '댓글 내용 {comment_id}', {uid}, '{ctype}', {target});"
    )
    comment_id += 1

# 10. notification (각 user 10개 생성)
notification_types = ['comment', 'mention', 'like', 'follow', 'reply', 'badge', 'qna', 'announcement', 'system', 'playlist']
for uid in range(1, N_USER+1):
    for i in range(10):
        ntype = random.choice(notification_types)
        msg = f"{ntype} 알림 {uid}-{i+1}"
        is_read = random.randint(0,1)
        sqls.append(
            f"INSERT INTO notification(type, message, user_id, is_read) VALUES ('{ntype}', '{msg}', {uid}, {is_read});"
        )


with open('dummy_data.sql', 'w', encoding='utf-8') as f:
    for line in sqls:
        f.write(line + '\n')

print(f"{len(sqls)}개의 쿼리를 dummy_data.sql에 생성하였습니다.")
print("경로:", os.path.abspath('dummy_data.sql'))

