package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Bbs;
import com.shoppingmall.model.Cart;
import com.shoppingmall.model.Category;
import com.shoppingmall.model.Rule;

public interface RuleService {
	public Rule getObject();
	
	public Rule getObjectById(String objectid);
	
	public int insert(Rule object);
	
	public int update(Rule object);
	
	public int deletebyid(String objectid);
}
