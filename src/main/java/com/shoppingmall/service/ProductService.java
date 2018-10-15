package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Product;
import com.shoppingmall.model.ProductWithBLOBs;

public interface ProductService {
	public ProductWithBLOBs getObjectById(String objectid);
	
	public List<ProductWithBLOBs> selectList(ProductWithBLOBs object);
	
	public List<ProductWithBLOBs> selectCount(ProductWithBLOBs object);
	
	public int insert(ProductWithBLOBs object);
	
	public int update(ProductWithBLOBs object);
	
	public int deletebyid(String objectid);
	
	public List<ProductWithBLOBs> selectAll();
	
	public int deleteAll();
	
	public List<ProductWithBLOBs> selectpbycid(String cid);
	
	public List<ProductWithBLOBs> getHot();
	
	public List<ProductWithBLOBs> getTJ();
    
	public List<ProductWithBLOBs> getJPTJ();
    
	public List<ProductWithBLOBs> getRXJP();
    
	public List<ProductWithBLOBs> getXP();
	
	public List<ProductWithBLOBs> getQG();
	
	public List<ProductWithBLOBs> getTG();
	
}
