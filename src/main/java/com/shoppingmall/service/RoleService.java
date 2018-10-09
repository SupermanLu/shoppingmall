package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Role;

public interface RoleService {
	public Role getObjectById(String objectid);
	
	public List<Role> selectList(Role object);
	
	public List<Role> selectCount(Role object);
	
	public int insert(Role object);
	
	public int update(Role object);
	
	public int deletebyid(String objectid);
	
	public List<Role> selectAll();
	
	public int deleteAll();
}
