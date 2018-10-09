package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Location;


public interface LocationService {
	public Location getObjectById(String objectid);
	
	public List<Location> selectList(Location object);
	
	public List<Location> selectCount(Location object);
	
	public int insert(Location object);
	
	public int update(Location object);
	
	public int deletebyid(String objectid);
	
	public List<Location> selectAll();
	
	public int deleteAll();
}
