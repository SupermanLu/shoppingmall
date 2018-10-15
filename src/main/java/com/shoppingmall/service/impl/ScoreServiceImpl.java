package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.ScoreMapper;
import com.shoppingmall.model.Order;
import com.shoppingmall.model.Score;
import com.shoppingmall.service.ScoreService;


@Service("ScoreService")  
public class ScoreServiceImpl implements ScoreService {

	  	@Resource  
	    private ScoreMapper objectDao;  
	 
	    public Score getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public int insert(Score object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Score object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}


		public List<Score> selectByCid(String cid) {
			// TODO Auto-generated method stub
			return this.objectDao.selectByCid(cid);
		}

		public List<Score> selectListByCid(String customid){
			return this.objectDao.selectListByCid(customid);
		}

}