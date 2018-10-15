package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.BbsMapper;
import com.shoppingmall.dao.BbsMapper;
import com.shoppingmall.model.Bbs;
import com.shoppingmall.service.BbsService;
import com.shoppingmall.service.BbsService;


@Service("BbsService")  
public class BbsServiceImpl implements BbsService {

	  	@Resource  
	    private BbsMapper objectDao;  
	 
	    public Bbs getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Bbs> selectList(Bbs object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Bbs> selectCount(Bbs object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Bbs object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Bbs object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Bbs> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		


}