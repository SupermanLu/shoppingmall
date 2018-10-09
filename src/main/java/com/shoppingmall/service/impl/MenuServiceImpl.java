package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CategoryMapper;
import com.shoppingmall.dao.MenuMapper;
import com.shoppingmall.model.Category;
import com.shoppingmall.model.Menu;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.MenuService;


@Service("MenuService")  
public class MenuServiceImpl implements MenuService {

	  	@Resource  
	    private MenuMapper objectDao;  
	 
	    public Menu getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Menu> selectList(Menu object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Menu> selectCount(Menu object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Menu object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Menu object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Menu> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		
		public List<Menu> selectOption(String parentcateid){
			return this.objectDao.selectOption(parentcateid);
		}
		
		public List<Menu> selectOptionIn(String parentcateid,List<String> menulist){
			return this.objectDao.selectOptionIn(parentcateid,menulist);
		}


}