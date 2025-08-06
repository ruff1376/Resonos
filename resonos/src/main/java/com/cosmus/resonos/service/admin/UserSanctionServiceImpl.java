package com.cosmus.resonos.service.admin;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.UserSanction;
import com.cosmus.resonos.mapper.admin.UserSanctionMapper;
import com.cosmus.resonos.mapper.user.UserMapper;

@Service
public class UserSanctionServiceImpl implements UserSanctionService {

    @Autowired
    private UserSanctionMapper userSanctionMapper;

    @Override
    public List<UserSanction> list() throws Exception {
        return userSanctionMapper.list();
    }

    @Override
    public UserSanction select(Long id) throws Exception {
        return userSanctionMapper.select(id);
    }

    @Override
    public boolean insert(UserSanction sanction) throws Exception {
        return userSanctionMapper.insert(sanction) > 0;
    }

    @Override
    public boolean update(UserSanction sanction) throws Exception {
        return userSanctionMapper.update(sanction) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return userSanctionMapper.delete(id) > 0;
    }
    @Override
    public List<UserSanction> getSanctionsByUserId(Long userId) throws Exception {
        return userSanctionMapper.getSanctionsByUserId(userId);
    }

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private NotificationService notificationService;

    @Override
    public void banUser(Long userId, String reason, Long adminId) throws Exception {
        // 1. 제재 이력 저장 (UserSanction 객체는 반드시 각 제재마다 "새로" 생성!)
        UserSanction sanction = new UserSanction();
        sanction.setUserId(userId);
        sanction.setType("BAN");
        sanction.setReason(reason);
        Date now = new Date();
        sanction.setStartAt(now);        // 즉시 제재 시작
        sanction.setEndAt(null);         // 기간제는 사용 시 따로 set
        sanction.setCreatedAt(now);
        sanction.setAdminId(adminId);

        userSanctionMapper.insert(sanction);

        // 2. 반복 제재 검사 (최근 90일, 3회 이상이면 자동 정지)
        int banCnt = userSanctionMapper.countRecentBan(userId, 90);
        if (banCnt >= 3) {
            userMapper.autoBanRepeatOffender(userId, "반복 제재 자동 처리");
            notificationService.createNotification(
                adminId,                           // 알림 받을 사람(관리자)
                "policy_violation",                // 타입
                "반복 제재 자동화 발생",             // 제목
                "userId " + userId + "가 90일 이내 3회 이상 제재되어 자동 정지 처리되었습니다.", // 내용
                String.valueOf(userId)             // 연관 객체
            );
        }
    }



    @Override
    public void unbanUser(Long userId, Long adminId) throws Exception {
        userMapper.updateBan(userId, false);
        // 알림 전송 (알림 규격에 맞게 파라미터 전달)
        notificationService.createNotification(
            adminId,                                  // 알림 받을 관리자 ID
            "policy_violation",                       // 타입
            "유저 제재 해제",                          // 메시지(제목)
            "userId " + userId + "의 제재가 해제되었습니다.", // 내용
            String.valueOf(userId)                    // 관련 객체 ID(문자열)
        );
    }

}
