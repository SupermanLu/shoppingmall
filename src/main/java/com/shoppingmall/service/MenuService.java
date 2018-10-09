package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Menu;

public interface MenuService {
	public Menu getObjectById(String objectid);
	
	public List<Menu> selectList(Menu object);
	
	public List<Menu> selectCount(Menu object);
	
	public int insert(Menu object);
	
	public int update(Menu object);
	
	public int deletebyid(String objectid);
	
	public List<Menu> selectAll();
	
	public int deleteAll();
	
	public List<Menu> selectOption(String parentcateid);
	
	public List<Menu> selectOptionIn(String parentcateid,List<String> menulist);
}
