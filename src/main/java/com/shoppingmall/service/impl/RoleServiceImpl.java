package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.CategoryMapper;
import com.shoppingmall.dao.RoleMapper;
import com.shoppingmall.model.Category;
import com.shoppingmall.model.Role;
import com.shoppingmall.service.CategoryService;
import com.shoppingmall.service.RoleService;


@Service("RoleService")  
public class RoleServiceImpl implements RoleService {

	  	@Resource  
	    private RoleMapper objectDao;  
	 
	    public Role getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Role> selectList(Role object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Role> selectCount(Role object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Role object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Role object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeyWithBLOBs(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Role> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		

}