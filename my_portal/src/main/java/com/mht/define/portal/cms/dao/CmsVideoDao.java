/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.PageBean;

/**
 * 视频DAO接口
 * @author 王杰
 * @version 2017-07-25
 */
@MyBatisDao
public interface CmsVideoDao extends CrudDao<CmsVideo> {

	List<CmsVideo> selectList(@Param("video") CmsVideo video,@Param("pb") PageBean<CmsVideo> pb);

	void disableVideo(@Param("videoType")CmsVideoType videoType);

	Number selectcount();

	void updateHitsAddOne(String id);

	
}