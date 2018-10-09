package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Friendlink;


public interface FriendlinkService {
	public Friendlink getObjectById(String objectid);
	
	public List<Friendlink> selectList(Friendlink object);
	
	public List<Friendlink> selectCount(Friendlink object);
	
	public int insert(Friendlink object);
	
	public int update(Friendlink object);
	
	public int deletebyid(String objectid);
	
	public List<Friendlink> selectAll();
	
	public int deleteAll();
}
