package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CategoryMapper;
import com.shoppingmall.model.Category;
import com.shoppingmall.service.CategoryService;


@Service("CategoryService")  
public class CategoryServiceImpl implements CategoryService {

	  	@Resource  
	    private CategoryMapper objectDao;  
	 
	    public Category getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Category> selectList(Category object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Category> selectCount(Category object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Category object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Category object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Category> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		
		public List<Category> selectOption(String parentcateid){
			return this.objectDao.selectOption(parentcateid);
		}


}