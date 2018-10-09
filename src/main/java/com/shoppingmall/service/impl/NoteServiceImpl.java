package com.shoppingmall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.dao.NoteMapper;
import com.shoppingmall.model.Note;
import com.shoppingmall.service.NoteService;


@Service("NoteService")  
public class NoteServiceImpl implements NoteService {

	  	@Resource  
	    private NoteMapper objectDao;  
	 
	    public Note getObjectById(String objectid) {  
	        // TODO Auto-generated method stub  
	        return this.objectDao.selectByPrimaryKey(objectid);  
	    }

		public List<Note> selectList(Note object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectList(object);
		}

		public List<Note> selectCount(Note object) {
			// TODO Auto-generated method stub
			return this.objectDao.selectCount(object);
		}

		public int insert(Note object) {
			// TODO Auto-generated method stub
			return this.objectDao.insertSelective(object);
		}

		public int update(Note object) {
			// TODO Auto-generated method stub
			return this.objectDao.updateByPrimaryKeySelective(object);
		}

		public int deletebyid(String objectid) {
			// TODO Auto-generated method stub
			return this.objectDao.deleteByPrimaryKey(objectid);
		}

		public List<Note> selectAll() {
			// TODO Auto-generated method stub
			return this.objectDao.selectAll();
		}
		

		public int deleteAll() {
			return this.objectDao.deleteAll();
		}


}