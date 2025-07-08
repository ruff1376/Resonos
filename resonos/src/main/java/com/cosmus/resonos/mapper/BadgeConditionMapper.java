package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.BadgeCondition;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface BadgeConditionMapper {
    public void insert(BadgeCondition condition);
    public void update(BadgeCondition condition);
    public void delete(Long id);
    public BadgeCondition select(Long id);
    public List<BadgeCondition> selectAll();
    public List<BadgeCondition> selectByBadgeId(Long badgeId);
    public void deleteByBadgeId(Long badgeId);
}
