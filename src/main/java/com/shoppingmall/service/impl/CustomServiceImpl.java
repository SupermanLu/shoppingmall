package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CustomMapper;
import com.shoppingmall.model.Custom;
import com.shoppingmall.service.CustomService;


@Service("CustomService")  
public class CustomServiceImpl implements CustomService {

	  	@Resource  
	    private CustomMapper objectDao;  
	 
	    public Custom getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Custom> selectList(Custom object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Custom> selectCount(Custom object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Custom object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Custom object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Custom> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		
		public List<Custom> selectByCustomName(Custom object){
			return this.objectDao.selectByCustomName(object);
		}

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}


}