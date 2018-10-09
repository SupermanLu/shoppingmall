package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(String roleid);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(String roleid);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKeyWithBLOBs(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> selectList(Role record);
    
    List<Role> selectCount(Role record);
    
    List<Role> selectAll();
    
    int deleteAll();
}