package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Order;
import com.shoppingmall.model.Score;

public interface ScoreMapper {
    int deleteByPrimaryKey(String scoreid);

    int insert(Score record);

    int insertSelective(Score record);

    Score selectByPrimaryKey(String scoreid);

    int updateByPrimaryKeySelective(Score record);

    int updateByPrimaryKey(Score record);
    
    List<Score> selectByCid(String cid);
    
    List<Score> selectListByCid(String customid);
}