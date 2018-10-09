package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.ProductMapper;
import com.shoppingmall.model.Product;
import com.shoppingmall.model.ProductWithBLOBs;
import com.shoppingmall.service.ProductService;


@Service("ProductService")  
public class ProductServiceImpl implements ProductService {

	  	@Resource  
	    private ProductMapper objectDao;  
	 
	    public ProductWithBLOBs getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<ProductWithBLOBs> selectList(ProductWithBLOBs object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<ProductWithBLOBs> selectCount(ProductWithBLOBs object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(ProductWithBLOBs object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(ProductWithBLOBs object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<ProductWithBLOBs> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		
		public List<ProductWithBLOBs> selectpbycid(String cid){
			return this.objectDao.selectpbycid(cid);
		}
		
		public List<ProductWithBLOBs> getHot(){
			return this.objectDao.getHot();
		}
	

}