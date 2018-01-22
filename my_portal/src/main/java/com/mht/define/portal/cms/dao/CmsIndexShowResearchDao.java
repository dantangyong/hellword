package com.mht.define.portal.cms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowResearch;
/**
 * 科研获奖级别表 接口
 * @ClassName: CmsIndesShowResearch
 * @Description:科研获奖级别表 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowResearchDao extends CrudDao<CmsIndexShowResearch> {
	
	/**
	 * 查询科研获奖级别数据
	 * @return list
	 */
	@Select("SELECT c.id , c.research_legend as legend, c.research_series as series from mht_portal.cms_index_show_research c")
	public List<CmsIndexShowResearch> getDataList();
	
	/**
	 * 查询科研获奖级别的legend的data数据
	 */
	//@Select("SELECT  c.research_legend as legend from mht_portal.cms_index_show_research c")
	public List<CmsIndexShowResearch> getResearchLegendData();
	/**
	 * 查询科研获奖级别的series中的data数据
	 */
	public List<CmsIndexShowResearch> getResearchSeriesData();
	
	
	
}
