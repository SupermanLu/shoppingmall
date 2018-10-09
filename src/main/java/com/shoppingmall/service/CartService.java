package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Cart;

public interface CartService {
	public Cart getObjectById(String objectid);
	
	public int insert(Cart object);
	
	public int update(Cart object);
	
	public int deletebyid(String objectid);
	
	
	public List<Cart> selectByPid(String pid);
	
	public List<Cart> selectByCid(String cid);
	
	public List<Cart> selectByCPid(Cart object);
}
