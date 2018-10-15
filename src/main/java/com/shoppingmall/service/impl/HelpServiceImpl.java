package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.HelpMapper;
import com.shoppingmall.model.Help;
import com.shoppingmall.service.HelpService;


@Service("HelpService")  
public class HelpServiceImpl implements HelpService {

	  	@Resource  
	    private HelpMapper objectDao;  
	 
	    public Help getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Help> selectList(Help object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Help> selectCount(Help object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Help object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Help object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Help> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}
		
		public List<Help> selectOption(String parenthelpid){
			return this.objectDao.selectOption(parenthelpid);
		}


}