package com.mht.define.portal.cms.dao;

import com.mht.define.portal.cms.entity.SysOffice;
import com.mht.define.portal.cms.entity.SysOfficeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SysOfficeDao {
    long countByExample(SysOfficeExample example);

    int deleteByExample(SysOfficeExample example);

    int deleteByPrimaryKey(String id);

    int insert(SysOffice record);

    int insertSelective(SysOffice record);

    List<SysOffice> selectByExample(SysOfficeExample example);

    SysOffice selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") SysOffice record, @Param("example") SysOfficeExample example);

    int updateByExample(@Param("record") SysOffice record, @Param("example") SysOfficeExample example);

    int updateByPrimaryKeySelective(SysOffice record);

    int updateByPrimaryKey(SysOffice record);
}