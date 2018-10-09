package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Cart;

public interface CartMapper {
    int deleteByPrimaryKey(String cartid);

    int insert(Cart record);

    int insertSelective(Cart record);

    Cart selectByPrimaryKey(String cartid);

    int updateByPrimaryKeySelective(Cart record);

    int updateByPrimaryKey(Cart record);
    
    List<Cart> selectByPid(String pid);
    
    List<Cart> selectByCid(String cid);
    
    List<Cart> selectByCPid(Cart object);
}