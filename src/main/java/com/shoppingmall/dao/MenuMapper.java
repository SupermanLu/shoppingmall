package com.shoppingmall.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Menu;

public interface MenuMapper {
    int deleteByPrimaryKey(String menuid);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(String menuid);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    
    List<Menu> selectList(Menu record);
    
    List<Menu> selectCount(Menu record);
    
    List<Menu> selectAll();
    
    List<Menu> selectOption(String parentcateid);
    
    List<Menu> selectOptionIn(String parentcateid,@Param("menulist")List<String> menulist);
    
    int deleteAll();
}