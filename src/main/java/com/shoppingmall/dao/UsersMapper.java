package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Users;

public interface UsersMapper {
    int deleteByPrimaryKey(String userid);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(String userid);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);
    
    List<Users> selectList(Users record);
    
    List<Users> selectCount(Users record);
    
    List<Users> selectAll();
    
    List<Users> selectByUserName(Users record);
    
    int deleteAll();
}