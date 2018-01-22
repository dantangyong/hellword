package com.mht.define.portal.cms.dao;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.UserContent;
import com.mht.define.portal.cms.entity.UserContentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
@MyBatisDao
public interface UserContentDao {
    long countByExample(UserContentExample example);

    int deleteByExample(UserContentExample example);

    int deleteByPrimaryKey(String id);

    int insert(UserContent record);

    int insertSelective(UserContent record);

    List<UserContent> selectByExample(UserContentExample example);

    UserContent selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") UserContent record, @Param("example") UserContentExample example);

    int updateByExample(@Param("record") UserContent record, @Param("example") UserContentExample example);

    int updateByPrimaryKeySelective(UserContent record);

    int updateByPrimaryKey(UserContent record);

	List<UserContent> selectByUserId(String id);
}