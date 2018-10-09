package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Custom;

public interface CustomMapper {
    int deleteByPrimaryKey(String customid);

    int insert(Custom record);

    int insertSelective(Custom record);

    Custom selectByPrimaryKey(String customid);

    int updateByPrimaryKeySelective(Custom record);

    int updateByPrimaryKey(Custom record);
    
    List<Custom> selectList(Custom record);
    
    List<Custom> selectCount(Custom record);
    
    List<Custom> selectAll();
    
    List<Custom> selectByCustomName(Custom record);
    
    int deleteAll();
}