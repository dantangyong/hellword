package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowTeachers;
/**
 * 教职工职称统计表 接口
 * @ClassName: CmsIndexShowTeachersDao
 * @Description:教职工职称 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowTeachersDao extends CrudDao<CmsIndexShowTeachers> {
	
	
	/**
	 * 查询教职工职称的legend的data数据
	 */
	public List<CmsIndexShowTeachers> getTeachersLegendData();
	/**
	 * 查询教职工职称的series中的data数据
	 */
	public List<CmsIndexShowTeachers> getTeachersSeriesData();
	
	
	
}
