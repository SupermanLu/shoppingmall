package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CategoryMapper;
import com.shoppingmall.dao.SwipMapper;
import com.shoppingmall.model.Category;
import com.shoppingmall.model.Swip;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.SwipService;


@Service("SwipService")  
public class SwipServiceImpl implements SwipService {

	  	@Resource  
	    private SwipMapper objectDao;  
	 
	    public Swip getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Swip> selectList(Swip object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Swip> selectCount(Swip object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Swip object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Swip object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Swip> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
	
}