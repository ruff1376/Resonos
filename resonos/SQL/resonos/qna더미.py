import random
import datetime

N_USERS = 100
N_QNA_TOTAL = 300
N_QNA_WITHOUT_ANSWER = 100
N_QNA_WITH_ANSWER = N_QNA_TOTAL - N_QNA_WITHOUT_ANSWER

# 샘플 질문 제목, 내용, 답변 예시
sample_titles = [
    "음악 앱 질문입니다.",
    "로그인 문제 문의",
    "재생목록 설정 관련",
    "앱 오류 신고",
    "계정 탈퇴 관련",
    "추천 기능 개선 요청",
    "음질 관련 피드백",
    "검색 기능 불편함",
    "버그 제보",
    "기능 제안"
]

sample_contents = [
    "앱에서 음악이 재생이 안됩니다. 확인 부탁드려요.",
    "로그인이 자꾸 실패해요. 어떻게 해야하나요?",
    "재생목록이 저장이 안 되는데 해결방법이 있나요?",
    "앱 실행 중 자꾸 강제 종료가 됩니다.",
    "회원 탈퇴 후에도 데이터가 남아있습니다.",
    "추천 음악이 너무 한정적입니다. 개선 부탁드립니다.",
    "음질이 기대보다 낮습니다.",
    "검색이 원하는 곡을 잘 찾지 못합니다.",
    "최근 업데이트 후 오류가 많습니다.",
    "새로운 기능이 추가되면 좋겠습니다."
]

sample_answer_contents = [
    "문의주신 내용 확인 후 빠른 시일 내에 처리하겠습니다.",
    "로그인 관련 문제는 패치 예정입니다. 양해 부탁드립니다.",
    "재생목록 저장문제는 서버 점검 중이니 잠시 기다려주세요.",
    "앱 충돌 문제를 해결하기 위한 수정 버전을 준비 중입니다.",
    "회원 탈퇴 시 데이터 삭제는 다음 업데이트에 적용 예정입니다.",
    "추천 기능은 AI 기반으로 개선 계획이 있습니다.",
    "음질 개선을 위한 서버 최적화를 진행하고 있습니다.",
    "검색 정확도 향상을 위한 연구개발 중입니다.",
    "버그 제보 감사드리며 신속히 대응하겠습니다.",
    "제안해주신 기능은 검토 중입니다."
]

def random_date(days_ago=60):
    start = datetime.datetime.now() - datetime.timedelta(days=days_ago)
    end = datetime.datetime.now()
    delta = (end - start).days
    day = random.randint(0, delta)
    sec = random.randint(0, 86399)
    dt = start + datetime.timedelta(days=day, seconds=sec)
    return dt.strftime('%Y-%m-%d %H:%M:%S')

sqls = []

# 1) QNA 300건 중 200건은 답변 있는 질문, 100건은 답변 없는 질문 생성
for qna_id in range(1, N_QNA_TOTAL + 1):
    qna_type = random.choice(['general', 'account', 'bug', 'feature'])
    title = random.choice(sample_titles)
    content = random.choice(sample_contents)
    created_at = random_date()
    status = random.choice([True, False])
    user_id = random.randint(1, N_USERS)

    sql = f"INSERT INTO qna (id, type, title, content, created_at, status, user_id) " \
          f"VALUES ({qna_id}, '{qna_type}', '{title}', '{content}', '{created_at}', {int(status)}, {user_id});"
    sqls.append(sql)

# 2) 답변은 qna_id 1~200 까지만 연결 (200개 답변 생성)
for answer_id in range(1, N_QNA_WITH_ANSWER + 1):
    qna_id = random.randint(1, N_QNA_WITH_ANSWER)
    content = random.choice(sample_answer_contents)
    answered_at = random_date()
    admin_id = random.randint(1, N_USERS)  # admin id도 1~100 user id에서 랜덤 선택

    sql = f"INSERT INTO qna_answer (id, content, answered_at, qna_id, admin_id) " \
          f"VALUES ({answer_id}, '{content}', '{answered_at}', {qna_id}, {admin_id});"
    sqls.append(sql)

# 출력 또는 파일 저장
with open('qna_dummy_data.sql', 'w', encoding='utf-8') as file:
    for s in sqls:
        file.write(s + '\n')

print(f"총 {len(sqls)}개 SQL 쿼리를 qna_dummy_data.sql 에 생성하였습니다.")
