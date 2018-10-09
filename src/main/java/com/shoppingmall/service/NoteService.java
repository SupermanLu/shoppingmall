package com.shoppingmall.service;

import java.util.List;

import com.shoppingmall.model.Note;


public interface NoteService {
	public Note getObjectById(String objectid);
	
	public List<Note> selectList(Note object);
	
	public List<Note> selectCount(Note object);
	
	public int insert(Note object);
	
	public int update(Note object);
	
	public int deletebyid(String objectid);
	
	public List<Note> selectAll();
	
	public int deleteAll();
}
