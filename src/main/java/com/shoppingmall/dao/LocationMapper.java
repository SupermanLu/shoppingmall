package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Location;

public interface LocationMapper {
    int deleteByPrimaryKey(String locationid);

    int insert(Location record);

    int insertSelective(Location record);

    Location selectByPrimaryKey(String locationid);

    int updateByPrimaryKeySelective(Location record);

    int updateByPrimaryKey(Location record);
    
    List<Location> selectList(Location record);
    
    List<Location> selectCount(Location record);
    
    List<Location> selectAll();
    
    
    int deleteAll();
}