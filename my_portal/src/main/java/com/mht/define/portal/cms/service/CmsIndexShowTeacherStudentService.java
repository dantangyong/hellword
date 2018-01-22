package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowTeacherStudentDao;
import com.mht.define.portal.cms.entity.CmsIndexShowTeacherStudent;
import com.mht.define.portal.cms.utils.ConstantShow;

/** 
 * 师生比统计表 service
 * @ClassName: CmsIndexShowTeacherStudentService
 * @Description:师生比统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowTeacherStudentService extends CrudService<CmsIndexShowTeacherStudentDao, CmsIndexShowTeacherStudent>{
	
	@Autowired
	private CmsIndexShowTeacherStudentDao cmsIndexShowTeacherStudentDao;
	
	/**
	 * 查询师生比的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowTeacherStudent> getTeacherStudentLegendData(){
		return cmsIndexShowTeacherStudentDao.getTeacherStudentLegendData();
	};
	
	/**
	 * 查询师生比统计的yAxis中的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowTeacherStudent> getTeacherStudentYAxisData(){
		return cmsIndexShowTeacherStudentDao.getTeacherStudentYAxisData();
	};
	
	/**
	 * 查询师生比的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public Map<String, List<Integer>> getTeacherStudentSeriesData(){
		List<CmsIndexShowTeacherStudent> teacherStudentdata = cmsIndexShowTeacherStudentDao.getTeacherStudentSeriesData();
		
		Map<String, List<Integer>> seriesMap = new HashMap<>();
		List<Integer> seriesDataTeacherList = new ArrayList<>();
		List<Integer> seriesDataStudentList = new ArrayList<>();
		
		for (CmsIndexShowTeacherStudent teacherStudentList : teacherStudentdata) {
			Integer series = teacherStudentList.getSeries();
			String legend = teacherStudentList.getLegend();
			if (ConstantShow.TEACHERSTUDENT_SERIESDATA_TEACHER.equals(legend)) {
				seriesDataTeacherList.add(series);
			}else if (ConstantShow.TEACHERSTUDENT_SERIESDATA_STUDENT.equals(legend)) {
				seriesDataStudentList.add(series);
			}
			
			seriesMap.put(ConstantShow.TEACHERSTUDENT_SERIESDATA_TEACHER, seriesDataTeacherList);
			seriesMap.put(ConstantShow.TEACHERSTUDENT_SERIESDATA_STUDENT, seriesDataStudentList);
			
			
		}
		System.out.println("+++++++++++++++++++++++++++service_seriesMap+++++++++++++++++++++"+seriesMap);
		return seriesMap;
	};
}
