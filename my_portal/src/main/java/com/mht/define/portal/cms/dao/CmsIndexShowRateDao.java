package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowRate;
/**
 * 就业率统计 接口
 * @ClassName: CmsIndexShowRateDao
 * @Description:就业率统计 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowRateDao extends CrudDao<CmsIndexShowRate> {
	
	/**
	 * 查询就业率统计的legend的data数据
	 */
	//@Select("SELECT  c.rate_legend as legend from mht_portal.cms_index_show_rate c group by legend")
	public List<CmsIndexShowRate> getRateLegendData();
	
	/**
	 * 查询就业率统计的xAxis中的data数据
	 */
	
	//@Select("SELECT c.rate_xAxis AS xAxis FROM mht_portal.cms_index_show_rate c GROUP BY xAxis")
	public List<CmsIndexShowRate> getRateXAxisData();
	
	/**
	 * 查询就业率统计的series中的data数据
	 */
	//@Select("SELECT c.rate_series AS series,c.rate_legend AS legend ,c.rate_xAxis AS xAxis FROM mht_portal.cms_index_show_rate c ORDER BY legend ")
	public List<CmsIndexShowRate> getRateSeriesData();
	
	
	
}
