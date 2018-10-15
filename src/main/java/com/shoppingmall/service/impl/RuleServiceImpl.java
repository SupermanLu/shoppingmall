package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.RuleMapper;
import com.shoppingmall.model.Role;
import com.shoppingmall.model.Rule;
import com.shoppingmall.service.RuleService;


@Service("RuleService")  
public class RuleServiceImpl implements RuleService {

	  	@Resource  
	    private RuleMapper objectDao; 
	  	
	  	public Rule getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }
	 
	    public Rule getObject() {  
	        // TODO Auto-generated method stub  
	    	Rule rule=new Rule();
	        List<Rule> list=this.objectDao.selectAll();  
	        if(list.size()>0) {
	        	rule=list.get(0);
	        }
	        return rule;
	    }


		public int insert(Rule object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Rule object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

	
		


}