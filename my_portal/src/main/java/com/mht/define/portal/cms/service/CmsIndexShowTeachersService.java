package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowTeachersDao;
import com.mht.define.portal.cms.entity.CmsIndexShowTeachers;

/** 
 * 教职工职称统计表 service
 * @ClassName: CmsIndexShowTeachers
 * @Description:教职工职称统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowTeachersService extends CrudService<CmsIndexShowTeachersDao, CmsIndexShowTeachers>{
	
	@Autowired
	private CmsIndexShowTeachersDao cmsIndexShowTeachersDao;
	
	
	/**
	 * 教职工职称的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowTeachers> getTeachersLegendData(){
		return cmsIndexShowTeachersDao.getTeachersLegendData();
	};
	
	/**
	 * 教职工职称的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowTeachers> getTeachersSeriesData(){
		return cmsIndexShowTeachersDao.getTeachersSeriesData();
	};
}
