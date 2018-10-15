package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Bbs;
import com.shoppingmall.model.Cart;
import com.shoppingmall.model.Category;

public interface BbsService {
	public Bbs getObjectById(String objectid);
	
	public int insert(Bbs object);
	
	public int update(Bbs object);
	
	public int deletebyid(String objectid);
	
	
	public List<Bbs> selectList(Bbs object);
	
	public List<Bbs> selectCount(Bbs object);
	
	public List<Bbs> selectAll();
	
	public int deleteAll();
}
