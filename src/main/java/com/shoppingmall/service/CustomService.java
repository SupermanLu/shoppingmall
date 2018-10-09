package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Custom;


public interface CustomService {
	public Custom getObjectById(String objectid);
	
	public List<Custom> selectList(Custom object);
	
	public List<Custom> selectCount(Custom object);
	
	public int insert(Custom object);
	
	public int update(Custom object);
	
	public int deletebyid(String objectid);
	
	public List<Custom> selectAll();
	
	public List<Custom> selectByCustomName(Custom object);
	
	public int deleteAll();
}
