package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Score;

public interface ScoreService {
	public Score getObjectById(String objectid);
	
	public int insert(Score object);
	
	public int update(Score object);
	
	public int deletebyid(String objectid);
	
	
	public List<Score> selectByCid(String cid);
	
	public List<Score> selectListByCid(String customid);

}
