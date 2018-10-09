package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Swip;

public interface SwipService {
	public Swip getObjectById(String objectid);
	
	public List<Swip> selectList(Swip object);
	
	public List<Swip> selectCount(Swip object);
	
	public int insert(Swip object);
	
	public int update(Swip object);
	
	public int deletebyid(String objectid);
	
	public List<Swip> selectAll();
	
	public int deleteAll();
	
}
