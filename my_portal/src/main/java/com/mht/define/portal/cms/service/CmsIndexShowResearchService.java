package com.mht.define.portal.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowResearchDao;
import com.mht.define.portal.cms.entity.CmsIndexShowResearch;

/** 
 * 科研获奖级别表 service
 * @ClassName: CmsIndesShowResearch
 * @Description:科研获奖级别表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowResearchService extends CrudService<CmsIndexShowResearchDao, CmsIndexShowResearch>{
	
	@Autowired
	private CmsIndexShowResearchDao cmsIndexShowResearchDao;
	
    /**
     * 查询科研获奖级别的数据
     * @return：list
     */
	@Transactional(readOnly = false)
	public List<CmsIndexShowResearch> getDataList(){
		return cmsIndexShowResearchDao.getDataList();
	};
	
	/**
	 * 查询科研获奖级别的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowResearch> getResearchLegendData(){
		return cmsIndexShowResearchDao.getResearchLegendData();
	};
	
	/**
	 * 查询科研获奖级别的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowResearch> getResearchSeriesData(){
		return cmsIndexShowResearchDao.getResearchSeriesData();
	};
}
