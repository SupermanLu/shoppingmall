package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Bbs;
import com.shoppingmall.model.Order;

public interface BbsMapper {
    int deleteByPrimaryKey(String bbsid);

    int insert(Bbs record);

    int insertSelective(Bbs record);

    Bbs selectByPrimaryKey(String bbsid);

    int updateByPrimaryKeySelective(Bbs record);

    int updateByPrimaryKey(Bbs record);
    
    List<Bbs> selectList(Bbs record);
    
    List<Bbs> selectCount(Bbs record);
    
    List<Bbs> selectAll();
    
    int deleteAll();
}