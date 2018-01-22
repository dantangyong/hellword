package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowEducationDao;
import com.mht.define.portal.cms.entity.CmsIndexShowEducation;
import com.mht.define.portal.cms.utils.ConstantShow;

/** 
 * 教职工学历统计表 service
 * @ClassName: CmsIndexShowEducationService
 * @Description:教职工学历统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowEducationService extends CrudService<CmsIndexShowEducationDao, CmsIndexShowEducation>{
	
	@Autowired
	private CmsIndexShowEducationDao cmsIndexShowEducationDao;
	
	/**
	 * 查询教职工学历的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowEducation> getEducationLegendData(){
		return cmsIndexShowEducationDao.getEducationLegendData();
	};
	
	/**
	 * 查询教职工学历统计的xAxis中的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowEducation> getEducationXAxisData(){
		return cmsIndexShowEducationDao.getEducationXAxisData();
	};
	
	/**
	 * 查询教职工学历的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public Map<String, List<Integer>> getEducationSeriesData(){
		List<CmsIndexShowEducation> educationdata = cmsIndexShowEducationDao.getEducationSeriesData();
		
		Map<String, List<Integer>> seriesMap = new HashMap<>();
		List<Integer> legendJuniorList = new ArrayList<>();
		List<Integer> legendRegularList = new ArrayList<>();
		List<Integer> legendMasterList = new ArrayList<>();
		List<Integer> legendDoctorList = new ArrayList<>();
		List<Integer> legendPostDoctorList = new ArrayList<>();
		
		for (CmsIndexShowEducation educationList : educationdata) {
			Integer series = educationList.getSeries();
			String legend = educationList.getLegend();
			if (ConstantShow.EDUCATION_SERIESLEGEND_JUNIOR.equals(legend)) {
				legendJuniorList.add(series);
			}else if (ConstantShow.EDUCATION_SERIESLEGEND_REGULAR.equals(legend)) {
				legendRegularList.add(series);
			}else if (ConstantShow.EDUCATION_SERIESLEGEND_MASTER.equals(legend)) {
				legendMasterList.add(series);
			}else if (ConstantShow.EDUCATION_SERIESLEGEND_DOCTOR.equals(legend)) {
				legendDoctorList.add(series);
			}else if(ConstantShow.EDUCATION_SERIESLEGEND_POSTDOCTOR.equals(legend)) {
				legendPostDoctorList.add(series);
			}
			
			seriesMap.put(ConstantShow.EDUCATION_SERIESLEGEND_JUNIOR, legendJuniorList);
			seriesMap.put(ConstantShow.EDUCATION_SERIESLEGEND_REGULAR, legendRegularList);
			seriesMap.put(ConstantShow.EDUCATION_SERIESLEGEND_MASTER, legendMasterList);
			seriesMap.put(ConstantShow.EDUCATION_SERIESLEGEND_DOCTOR, legendDoctorList);
			seriesMap.put(ConstantShow.EDUCATION_SERIESLEGEND_POSTDOCTOR, legendPostDoctorList);
			
			
		}
		System.out.println("+++++++++++++++++++++++++++service_seriesMap+++++++++++++++++++++"+seriesMap);
		return seriesMap;
	};
}
