package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Category;

public interface CategoryService {
	public Category getObjectById(String objectid);
	
	public List<Category> selectList(Category object);
	
	public List<Category> selectCount(Category object);
	
	public int insert(Category object);
	
	public int update(Category object);
	
	public int deletebyid(String objectid);
	
	public List<Category> selectAll();
	
	public int deleteAll();
	
	public List<Category> selectOption(String parentcateid);
}
