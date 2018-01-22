package com.mht.define.portal.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowAcademyrankDao;
import com.mht.define.portal.cms.entity.CmsIndexShowAcademyrank;

/** 
 * 学院排名统计表 service
 * @ClassName: CmsIndexShowAcademyrankService
 * @Description:学院排名统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowAcademyrankService extends CrudService<CmsIndexShowAcademyrankDao, CmsIndexShowAcademyrank>{
	
	@Autowired
	private CmsIndexShowAcademyrankDao cmsIndexShowAcademyrankDao;
	
	
	/**
	 * 学院排名的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowAcademyrank> getAcademyrankLegendData(){
		System.out.println("+++++++++++++service+++++++++++++++"+cmsIndexShowAcademyrankDao.getAcademyrankLegendData());
		return cmsIndexShowAcademyrankDao.getAcademyrankLegendData();
	};
	
	/**
	 * 学院排名的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowAcademyrank> getAcademyrankSeriesData(){
		return cmsIndexShowAcademyrankDao.getAcademyrankSeriesData();
	};
}
