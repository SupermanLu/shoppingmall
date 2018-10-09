package com.shoppingmall.dao;

import com.shoppingmall.model.Comment;

public interface CommentMapper {
    int deleteByPrimaryKey(String commentid);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(String commentid);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);
}