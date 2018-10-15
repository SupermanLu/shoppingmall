package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Category;
import com.shoppingmall.model.Product;
import com.shoppingmall.model.ProductWithBLOBs;

public interface ProductMapper {
    int deleteByPrimaryKey(String productid);

    int insert(ProductWithBLOBs record);

    int insertSelective(ProductWithBLOBs record);

    ProductWithBLOBs selectByPrimaryKey(String productid);

    int updateByPrimaryKeySelective(ProductWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(ProductWithBLOBs record);

    int updateByPrimaryKey(Product record);
    
    List<ProductWithBLOBs> selectList(ProductWithBLOBs record);
    
    List<ProductWithBLOBs> selectCount(ProductWithBLOBs record);
    
    List<ProductWithBLOBs> selectAll();
    
    List<ProductWithBLOBs> selectpbycid(String cid);
    
    int deleteAll();
    
    List<ProductWithBLOBs> getHot();
    
    List<ProductWithBLOBs> getTJ();
    
    List<ProductWithBLOBs> getJPTJ();
    
    List<ProductWithBLOBs> getRXJP();
    
    List<ProductWithBLOBs> getXP();
    
    List<ProductWithBLOBs> getQG();
    
    List<ProductWithBLOBs> getTG();
}