package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsIndexShowTeacherStudent;
/**
 * 师生比统计 接口
 * @ClassName: CmsIndexShowTeacherStudentDao
 * @Description:师生比统计 接口
 * @author wxw
 * @date 2017年9月30日
 */
@MyBatisDao
public interface CmsIndexShowTeacherStudentDao extends CrudDao<CmsIndexShowTeacherStudent> {
	
	/**
	 * 查询师生比统计的legend的data数据
	 */
	//@Select("SELECT  c.teacherStudent_legend as legend from mht_portal.cms_index_show_teacherStudent c group by legend")
	public List<CmsIndexShowTeacherStudent> getTeacherStudentLegendData();
	
	/**
	 * 查询师生比统计的xAxis中的data数据
	 */
	
	//@Select("SELECT c.teacherStudent_xAxis AS xAxis FROM mht_portal.cms_index_show_teacherStudent c GROUP BY xAxis")
	public List<CmsIndexShowTeacherStudent> getTeacherStudentYAxisData();
	
	/**
	 * 查询师生比统计的series中的data数据
	 */
	//@Select("SELECT c.teacherStudent_series AS series,c.teacherStudent_legend AS legend ,c.teacherStudent_xAxis AS xAxis FROM mht_portal.cms_index_show_teacherStudent c ORDER BY legend ")
	public List<CmsIndexShowTeacherStudent> getTeacherStudentSeriesData();
	
	
	
}
