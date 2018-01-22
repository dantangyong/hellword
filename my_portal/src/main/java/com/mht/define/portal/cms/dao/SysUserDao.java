package com.mht.define.portal.cms.dao;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.SysUser;
import com.mht.define.portal.cms.entity.SysUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
@MyBatisDao
public interface SysUserDao {
    long countByExample(SysUserExample example);

    int deleteByExample(SysUserExample example);

    int deleteByPrimaryKey(String id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    List<SysUser> selectByExample(SysUserExample example);

    SysUser selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") SysUser record, @Param("example") SysUserExample example);

    int updateByExample(@Param("record") SysUser record, @Param("example") SysUserExample example);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);
}