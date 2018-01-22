package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowEducation;
/**
 * 教职工学历统计 接口
 * @ClassName: CmsIndexShowEducationDao
 * @Description:教职工学历统计 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowEducationDao extends CrudDao<CmsIndexShowEducation> {
	
	/**
	 * 查询教职工学历统计的legend的data数据
	 */
	//@Select("SELECT  c.education_legend as legend from mht_portal.cms_index_show_education c group by legend")
	public List<CmsIndexShowEducation> getEducationLegendData();
	
	/**
	 * 查询教职工学历统计的xAxis中的data数据
	 */
	
	//@Select("SELECT c.education_xAxis AS xAxis FROM mht_portal.cms_index_show_education c GROUP BY xAxis")
	public List<CmsIndexShowEducation> getEducationXAxisData();
	
	/**
	 * 查询教职工学历统计的series中的data数据
	 */
	//@Select("SELECT c.education_series AS series,c.education_legend AS legend ,c.education_xAxis AS xAxis FROM mht_portal.cms_index_show_education c ORDER BY legend ")
	public List<CmsIndexShowEducation> getEducationSeriesData();
	
	
	
}
