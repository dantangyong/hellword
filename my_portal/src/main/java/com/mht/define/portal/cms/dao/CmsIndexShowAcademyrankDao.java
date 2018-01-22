package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowAcademyrank;
/**
 * 学院排名 接口
 * @ClassName: CmsIndexShowAcademyrankDao
 * @Description:学院排名 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowAcademyrankDao extends CrudDao<CmsIndexShowAcademyrank> {
	
	/**
	 * 查询学院排名的xAxis的data数据
	 */
	//@Select("SELECT  c.academyrank_legend as legend from mht_portal.cms_index_show_academyrank c")
	public List<CmsIndexShowAcademyrank> getAcademyrankLegendData();
	/**
	 * 查询学院排名的series中的data数据
	 */
	public List<CmsIndexShowAcademyrank> getAcademyrankSeriesData();
	
	
	
}
