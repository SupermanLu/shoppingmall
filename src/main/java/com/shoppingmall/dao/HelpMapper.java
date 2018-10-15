package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Help;

public interface HelpMapper {
    int deleteByPrimaryKey(String helpid);

    int insert(Help record);

    int insertSelective(Help record);

    Help selectByPrimaryKey(String helpid);

    int updateByPrimaryKeySelective(Help record);

    int updateByPrimaryKeyWithBLOBs(Help record);

    int updateByPrimaryKey(Help record);
    
    List<Help> selectList(Help record);
    
    List<Help> selectCount(Help record);
    
    List<Help> selectAll();
    
    List<Help> selectOption(String helppid);
    
    int deleteAll();
}