package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Swip;

public interface SwipMapper {
    int deleteByPrimaryKey(String swipid);

    int insert(Swip record);

    int insertSelective(Swip record);

    Swip selectByPrimaryKey(String swipid);

    int updateByPrimaryKeySelective(Swip record);

    int updateByPrimaryKey(Swip record);
    
    List<Swip> selectList(Swip record);
    
    List<Swip> selectCount(Swip record);
    
    List<Swip> selectAll();
    
    int deleteAll();
}