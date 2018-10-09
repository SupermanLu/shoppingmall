package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Note;

public interface NoteMapper {
    int deleteByPrimaryKey(String noteid);

    int insert(Note record);

    int insertSelective(Note record);

    Note selectByPrimaryKey(String noteid);

    int updateByPrimaryKeySelective(Note record);

    int updateByPrimaryKey(Note record);
    
    List<Note> selectList(Note record);
    
    List<Note> selectCount(Note record);
    
    List<Note> selectAll();
    
    
    int deleteAll();
}