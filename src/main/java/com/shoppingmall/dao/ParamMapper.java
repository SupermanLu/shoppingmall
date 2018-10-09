package com.shoppingmall.dao;

import com.shoppingmall.model.Param;

public interface ParamMapper {
    int deleteByPrimaryKey(String paramid);

    int insert(Param record);

    int insertSelective(Param record);

    Param selectByPrimaryKey(String paramid);

    int updateByPrimaryKeySelective(Param record);

    int updateByPrimaryKey(Param record);
}