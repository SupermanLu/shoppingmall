package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CartMapper;
import com.shoppingmall.model.Cart;
import com.shoppingmall.service.CartService;


@Service("CartService")  
public class CartServiceImpl implements CartService {

	  	@Resource  
	    private CartMapper objectDao;  
	 
	    public Cart getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public int insert(Cart object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Cart object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Cart> selectByPid(String pid) {
			// TODO Auto-generated method stub
			return this.objectDao.selectByPid(pid);
		}

		public List<Cart> selectByCid(String cid) {
			// TODO Auto-generated method stub
			return this.objectDao.selectByCid(cid);
		}

		public List<Cart> selectByCPid(Cart object){
			return this.objectDao.selectByCPid(object);
		}


}