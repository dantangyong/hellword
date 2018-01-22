package com.mht.define.portal.cms.dao;

import com.mht.define.portal.cms.entity.CmsComposing;
import com.mht.define.portal.cms.entity.CmsComposingExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CmsComposingDao {
    long countByExample(CmsComposingExample example);

    int deleteByExample(CmsComposingExample example);

    int deleteByPrimaryKey(String id);

    int insert(CmsComposing record);

    int insertSelective(CmsComposing record);

    List<CmsComposing> selectByExample(CmsComposingExample example);

    CmsComposing selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") CmsComposing record, @Param("example") CmsComposingExample example);

    int updateByExample(@Param("record") CmsComposing record, @Param("example") CmsComposingExample example);

    int updateByPrimaryKeySelective(CmsComposing record);

    int updateByPrimaryKey(CmsComposing record);
}