package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.FriendlinkMapper;
import com.shoppingmall.model.Friendlink;
import com.shoppingmall.service.FriendlinkService;


@Service("FriendlinkService")  
public class FriendlinkServiceImpl implements FriendlinkService {

	  	@Resource  
	    private FriendlinkMapper objectDao;  
	 
	    public Friendlink getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Friendlink> selectList(Friendlink object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Friendlink> selectCount(Friendlink object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Friendlink object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Friendlink object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Friendlink> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}


}