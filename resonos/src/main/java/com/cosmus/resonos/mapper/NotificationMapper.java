package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Notification;

@Mapper
public interface NotificationMapper {
    // 전체 조회
    public List<Notification> list() throws Exception;
    // 조회
    public Notification select(Long id) throws Exception;
    // 삽입
    public int insert(Notification notification) throws Exception;
    // 수정
    public int update(Notification notification) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 유저
    public List<Notification> findByUser(Long userId) throws Exception;
}
