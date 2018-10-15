package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Help;

public interface HelpService {
	public Help getObjectById(String objectid);
	
	public List<Help> selectList(Help object);
	
	public List<Help> selectCount(Help object);
	
	public int insert(Help object);
	
	public int update(Help object);
	
	public int deletebyid(String objectid);
	
	public List<Help> selectAll();
	
	public int deleteAll();
	
	public List<Help> selectOption(String parenthelpid);
}
