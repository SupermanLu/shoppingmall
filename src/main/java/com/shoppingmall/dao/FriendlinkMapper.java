package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Friendlink;

public interface FriendlinkMapper {
    int deleteByPrimaryKey(String linkid);

    int insert(Friendlink record);

    int insertSelective(Friendlink record);

    Friendlink selectByPrimaryKey(String linkid);

    int updateByPrimaryKeySelective(Friendlink record);

    int updateByPrimaryKey(Friendlink record);
    
    List<Friendlink> selectList(Friendlink record);
    
    List<Friendlink> selectCount(Friendlink record);
    
    List<Friendlink> selectAll();
    
    
    int deleteAll();
}