package com.shoppingmall.dao;

import com.shoppingmall.model.Help;

public interface HelpMapper {
    int deleteByPrimaryKey(String helpid);

    int insert(Help record);

    int insertSelective(Help record);

    Help selectByPrimaryKey(String helpid);

    int updateByPrimaryKeySelective(Help record);

    int updateByPrimaryKeyWithBLOBs(Help record);

    int updateByPrimaryKey(Help record);
}