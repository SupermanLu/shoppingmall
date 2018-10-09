package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.UsersMapper;
import com.shoppingmall.model.Users;
import com.shoppingmall.service.UsersService;


@Service("UsersService")  
public class UsersServiceImpl implements UsersService {

	  	@Resource  
	    private UsersMapper objectDao;  
	 
	    public Users getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Users> selectList(Users object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Users> selectCount(Users object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Users object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Users object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Users> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		
		public List<Users> selectByUserName(Users object){
			return this.objectDao.selectByUserName(object);
		}

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}


}