package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Order;

public interface OrderService {
	public Order getObjectById(String objectid);
	
	public List<Order> selectList(Order object);
	
	public List<Order> selectCount(Order object);
	
	public int insert(Order object);
	
	public int update(Order object);
	
	public int deletebyid(String objectid);
	
	public List<Order> selectAll();
	
	public int deleteAll();
	
}
