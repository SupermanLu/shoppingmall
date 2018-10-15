package com.shoppingmall.dao;

import java.util.List;

import com.shoppingmall.model.Role;
import com.shoppingmall.model.Rule;

public interface RuleMapper {
    int deleteByPrimaryKey(String ruleid);

    int insert(Rule record);

    int insertSelective(Rule record);

    Rule selectByPrimaryKey(String ruleid);

    int updateByPrimaryKeySelective(Rule record);

    int updateByPrimaryKeyWithBLOBs(Rule record);
    
    List<Rule> selectAll();
}