package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Category;

public interface CategoryMapper {
    int deleteByPrimaryKey(String cateid);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(String cateid);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
    
    List<Category> selectList(Category record);
    
    List<Category> selectCount(Category record);
    
    List<Category> selectAll();
    
    List<Category> selectOption(String parentcateid);
    
    int deleteAll();
}