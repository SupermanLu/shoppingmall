package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.LocationMapper;
import com.shoppingmall.dao.NoteMapper;
import com.shoppingmall.model.Location;
import com.shoppingmall.model.Note;
import com.shoppingmall.service.LocationService;
import com.shoppingmall.service.NoteService;


@Service("LocationService")  
public class LocationServiceImpl implements LocationService {

	  	@Resource  
	    private LocationMapper objectDao;  
	 
	    public Location getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Location> selectList(Location object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Location> selectCount(Location object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Location object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Location object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Location> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}


}