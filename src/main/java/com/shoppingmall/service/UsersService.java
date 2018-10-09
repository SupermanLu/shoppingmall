package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Users;


public interface UsersService {
	public Users getObjectById(String objectid);
	
	public List<Users> selectList(Users object);
	
	public List<Users> selectCount(Users object);
	
	public int insert(Users object);
	
	public int update(Users object);
	
	public int deletebyid(String objectid);
	
	public List<Users> selectAll();
	
	public List<Users> selectByUserName(Users object);
	
	public int deleteAll();
}
