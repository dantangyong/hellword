package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowHotSearch;
/**
 * 热门搜索 接口
 * @ClassName: CmsIndexShowHotSearchDao
 * @Description:热门搜索 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowHotSearchDao extends CrudDao<CmsIndexShowHotSearch> {
	
	/**
	 * 查询热门搜索的series中的data的name数据
	 */
	public List<CmsIndexShowHotSearch> getHotSearchSeriesData(); 
	

	
	
}
