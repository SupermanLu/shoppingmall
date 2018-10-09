package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Order;

public interface OrderMapper {
    int deleteByPrimaryKey(String orderid);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(String orderid);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
    
    List<Order> selectList(Order record);
    
    List<Order> selectCount(Order record);
    
    List<Order> selectAll();
    
    int deleteAll();
}