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

N_USER = 50
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


# 2. playlist (각 user 3개, 썸네일 고정)
playlist_id = 1
for user_id in range(1, N_USER+1):
    for pl_num in range(1, 4):
        sqls.append(
            f"INSERT INTO playlist(id, user_id, title, description, thumbnail_url, is_public) "
            f"VALUES ({playlist_id}, {user_id}, '플리{user_id}_{pl_num}', 'desc{user_id}_{pl_num}', '/img/profileImg.png', 1);"
        )
        playlist_id += 1

total_playlists = playlist_id - 1

# 3. playlist_detail (각 playlist 3개 track)
for pid in range(1, total_playlists + 1):
    tracks_sampled = random.sample(track_ids, 3)
    for order_no, tid in enumerate(tracks_sampled, 1):
        sqls.append(f"INSERT INTO playlist_detail(playlist_id, track_id, order_no) VALUES ({pid}, '{tid}', {order_no});")


# 4. user_follow
user_follow_set = set()
while len(user_follow_set) < N_FOLLOW:
    a, b = random.randint(1, N_USER), random.randint(1, N_USER)
    if a != b:
        user_follow_set.add((a, b))
for a, b in user_follow_set:
    sqls.append(f"INSERT INTO user_follow(follower_id, following_id) VALUES({a}, {b});")


# 5. liked_track
liked_track_set = set()
while len(liked_track_set) < N_LIKED_TRACK:
    u = random.randint(1, N_USER)
    t = random.choice(track_ids)
    liked_track_set.add((u, t))
for u, t in liked_track_set:
    sqls.append(f"INSERT INTO liked_track(user_id, track_id) VALUES({u}, '{t}');")


# 6. liked_album
liked_album_set = set()
target = N_LIKED_TRACK // 3
while len(liked_album_set) < target:
    u = random.randint(1, N_USER)
    a = random.choice(album_ids)
    liked_album_set.add((u, a))
for u, a in liked_album_set:
    sqls.append(f"INSERT INTO liked_album(user_id, album_id) VALUES({u}, '{a}');")


# 7. liked_playlist
liked_playlist_set = set()
target = N_LIKED_TRACK // 4
while len(liked_playlist_set) < target:
    u = random.randint(1, N_USER)
    p = random.randint(1, total_playlists)
    liked_playlist_set.add((u, p))
for u, p in liked_playlist_set:
    sqls.append(f"INSERT INTO liked_playlist(user_id, playlist_id) VALUES({u}, {p});")


# 8. album_review
album_review_set = set()
while len(album_review_set) < N_USER:
    u = random.randint(1, N_USER)
    a = random.choice(album_ids)
    album_review_set.add((u, a))
for u, a in album_review_set:
    sqls.append(
        f"INSERT INTO album_review(user_id, album_id, rating, content, blinded, critic) "
        f"VALUES({u}, '{a}', {random.randint(1,5)}, '코멘트 {random.randint(1,10000)}', 0, {random.choice([0,1])});"
    )


# 9. track_review
track_review_set = set()
while len(track_review_set) < N_USER:
    u = random.randint(1, N_USER)
    t = random.choice(track_ids)
    track_review_set.add((u, t))
for u, t in track_review_set:
    sqls.append(
        f"INSERT INTO track_review(user_id, track_id, rating, content, blinded, critic) "
        f"VALUES({u}, '{t}', {random.randint(1,5)}, '리뷰 {random.randint(1,10000)}', 0, {random.choice([0,1])});"
    )

# 16. tag 50개 생성
tags = [
    'Pop', 'Rock', 'HipHop', 'Jazz', 'Classical', 'Electronic', 'Dance', 'EDM', 'R&B', 'Soul',
    'Blues', 'Country', 'Reggae', 'Metal', 'Folk', 'Indie', 'Alternative', 'Latin', 'Kpop', 'Ballad',
    'Trap', 'House', 'Techno', 'Dubstep', 'Trance', 'Synthpop', 'Jazz Fusion', 'Disco', 'Gospel', 'Ambient',
    'Funk', 'Ska', 'Opera', 'Lo-fi', 'Swing', 'Acoustic', 'Bluegrass', 'Chillout', 'Grunge', 'New Age',
    'Pop Rock', 'Post Punk', 'Electropop', 'Synthwave', 'Garage Rock', 'Hard Rock', 'Experimental', 'Punk Rock', 'Dream Pop', 'Vocal Jazz'
]
for tag_name in tags:
    sqls.append(f"INSERT INTO tag(name) VALUES ('{tag_name}');")

# 17. community 50건 생성
for i in range(1, 51):
    name = f"커뮤니티{i}"
    description = f"커뮤니티 설명 {i}"
    creator_id = random.randint(1, N_USER)
    sqls.append(
        f"INSERT INTO community(id, name, description, created_at, creator_id) "
        f"VALUES({i}, '{name}', '{description}', NOW(), {creator_id});"
    )

# 10. track_mood_vote
for i in range(1, N_USER+1):
    tid = random.choice(track_ids)
    mood = random.randint(1, 10)
    sqls.append(f"INSERT INTO track_mood_vote(user_id, track_id, mood) VALUES({i}, '{tid}', {mood});")


# 11. artist_mood_vote
for i in range(1, N_USER+1):
    aid = random.choice(artist_ids)
    mood = random.randint(1, 10)
    sqls.append(f"INSERT INTO artist_mood_vote(user_id, artist_id, mood) VALUES({i}, '{aid}', {mood});")


# 12. board_post (3개 community 가정)
for i in range(1, N_USER+1):
    community_id = random.randint(1, 3)
    title = f"게시글 제목 {i}"
    content = f"게시글 내용 {i}"
    type_ = random.choice(['NOTICE', 'QNA', 'REVIEW'])
    sqls.append(f"INSERT INTO board_post(title, content, type, community_id, user_id) VALUES ('{title}', '{content}', '{type_}', {community_id}, {i});")


# 13. report (50건)
for i in range(1, 51):
    target_type = random.choice(['boardPost', 'comment', 'review', 'playlist', 'album', 'track', 'user', 'artist', 'qna'])
    target_id = random.randint(1, 1000)
    reason = f"신고 이유 {i}"
    status = random.choice(['PENDING', 'DONE', 'REJECTED'])
    reporter_id = random.randint(1, N_USER)
    processed_by = 'NULL' if status == 'PENDING' else random.randint(1, N_USER)
    processed_at = 'NULL' if status == 'PENDING' else "'2025-07-22 17:31:00'"
    process_memo = 'NULL'
    sqls.append(
        f"INSERT INTO report(target_type, target_id, reason, status, reporter_id, processed_by, processed_at, process_memo) "
        f"VALUES('{target_type}', {target_id}, '{reason}', '{status}', {reporter_id}, {processed_by}, {processed_at}, {process_memo});"
    )


# 14. comment (1000건, 스키마 맞춤)
comment_id = 1
for _ in range(1000):
    uid = random.randint(1, N_USER)
    ctype = random.choice(['posts', 'playlist', 'comment'])
    if ctype == 'posts':
        target = random.randint(1, 1000)
    elif ctype == 'playlist':
        target = random.randint(1, total_playlists)
    else:
        target = random.randint(1, max(comment_id - 1, 1))
    sqls.append(
        f"INSERT INTO comment(id, content, user_id, type, target_id) VALUES"
        f"({comment_id}, '댓글 내용 {comment_id}', {uid}, '{ctype}', {target});"
    )
    comment_id += 1


# 15. notification (각 user 10개)
notification_types = ['comment', 'mention', 'like', 'follow', 'reply', 'badge', 'qna', 'announcement', 'system', 'playlist']
for uid in range(1, N_USER+1):
    for i in range(10):
        ntype = random.choice(notification_types)
        msg = f"{ntype} 알림 {uid}-{i+1}"
        is_read = random.randint(0, 1)
        sqls.append(
            f"INSERT INTO notification(type, message, user_id, is_read) VALUES ('{ntype}', '{msg}', {uid}, {is_read});"
        )



# 18. badge, badge_condition, user_badge, user_badge_log 관련 데이터 생성

# badge 10개 샘플
badges = [
    ('리뷰왕', '리뷰 10회', '/img/badge1.png', '10 reviews'),
    ('플리마스터', '플리 5개 생성', '/img/badge2.png', '5 playlists'),
    ('팔로우리더', '팔로워 20명', '/img/badge3.png', '20 followers'),
    ('Q&A전문가', 'Q&A 5회', '/img/badge4.png', '5 QnA'),
    ('댓글왕', '댓글 30개', '/img/badge5.png', '30 comments'),
    ('앨범러버', '앨범 좋아요 10', '/img/badge6.png', '10 liked album'),
    ('트랙스타', '트랙 좋아요 10', '/img/badge7.png', '10 liked track'),
    ('팔로우매니아', '아티스트 팔로우 10', '/img/badge8.png', '10 artist follow'),
    ('큐레이터', '플리 좋아요 10', '/img/badge9.png', '10 liked playlist'),
    ('논란청정수호자', '신고 5회', '/img/badge10.png', '5 reports')
]

for idx, (name, desc, icon, criteria) in enumerate(badges, 1):
    sqls.append(
        f"INSERT INTO badge(id, name, description, icon_url, criteria) VALUES ({idx}, '{name}', '{desc}', '{icon}', '{criteria}');"
    )

# badge_condition 샘플 (badge_id, badge_name, description, condition_type, condition_value)
badge_conditions = [
    (1, '리뷰왕', '리뷰 10회 달성', 'REVIEW_COUNT', 10),
    (2, '플리마스터', '플리 5개 생성', 'PLAYLIST_COUNT', 5),
    (3, '팔로우리더', '팔로우 20명', 'FOLLOWER_COUNT', 20),
    (4, 'Q&A전문가', 'Q&A 5회', 'QNA_COUNT', 5),
    (5, '댓글왕', '댓글 30개', 'COMMENT_COUNT', 30),
]

for (bid, bname, desc, ctype, cvalue) in badge_conditions:
    sqls.append(
        f"INSERT INTO badge_condition(badge_id, badge_name, description, condition_type, condition_value) "
        f"VALUES({bid}, '{bname}', '{desc}', '{ctype}', {cvalue});"
    )

# user_badge (유저와 뱃지 매핑, 50명 중 랜덤 매핑)
for i in range(1, N_USER + 1):
    badge_id = random.randint(1, len(badges))
    sqls.append(
        f"INSERT INTO user_badge(user_id, badge_id) VALUES({i}, {badge_id});"
    )

# user_badge_log (간단히 GRANT 액션 예시)
for i in range(1, N_USER + 1):
    badge_id = random.randint(1, len(badges))
    actor_id = random.randint(1, N_USER)
    sqls.append(
        f"INSERT INTO user_badge_log(user_id, badge_id, action, actor_id, reason) "
        f"VALUES({i}, {badge_id}, 'GRANT', {actor_id}, '자동부여');"
    )

# 최종 쿼리를 file로 저장
output_file = 'dummy_data.sql'
with open(output_file, 'w', encoding='utf-8') as f:
    for line in sqls:
        f.write(line + '\n')

print(f"총 {len(sqls)}개 쿼리를 '{os.path.abspath(output_file)}'에 생성 완료했습니다.")
