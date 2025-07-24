import random
from datetime import datetime, timedelta

# 예시 액션 리스트
actions = ["login", "logout", "update_profile", "change_password", "post_comment", "like", "share"]
target_types = [None, "post", "comment", "profile", "album", "track"]
ip_pool = [
    "192.168.0.1",
    "203.0.113.5",
    "198.51.100.23",
    "8.8.8.8",
    "123.45.67.89"
]

user_agents = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
    "Mozilla/5.0 (Linux; Android 10; SM-G975F)",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X)"
]

def random_datetime(start_days_ago=30):
    """최근 30일 내 랜덤 날짜 생성"""
    now = datetime.now()
    delta = timedelta(days=random.randint(0, start_days_ago),
                      hours=random.randint(0,23),
                      minutes=random.randint(0,59),
                      seconds=random.randint(0,59))
    return (now - delta).strftime('%Y-%m-%d %H:%M:%S')

sql_values = []

for user_id in range(1, 101):
    action = random.choice(actions)
    target_type = random.choice(target_types)
    # target_type이 None 이면 target_id도 None, 아니면 랜덤 숫자 (예: 1~500)
    if target_type is None:
        target_id = "NULL"
    else:
        target_id = random.randint(1, 500)
    detail = f"Action {action} performed by user {user_id}"
    ip_address = random.choice(ip_pool)
    user_agent = random.choice(user_agents)
    created_at = random_datetime()

    # NULL 값은 따옴표 없이, 문자열은 따옴표로 감싸서 SQL 문자열 생성
    target_type_sql = f"'{target_type}'" if target_type is not None else "NULL"
    detail_sql = f"'{detail}'"
    ip_sql = f"'{ip_address}'" if ip_address is not None else "NULL"
    ua_sql = f"'{user_agent}'" if user_agent is not None else "NULL"
    created_at_sql = f"'{created_at}'"

    sql_values.append(
        f"(NULL, '{action}', {target_type_sql}, {target_id}, {detail_sql}, {ip_sql}, {ua_sql}, {created_at_sql}, {user_id})"
    )

sql = "INSERT INTO user_activity_log (id, action, target_type, target_id, detail, ip_address, user_agent, created_at, user_id) VALUES\n"
sql += ",\n".join(sql_values) + ";"

print(sql)
