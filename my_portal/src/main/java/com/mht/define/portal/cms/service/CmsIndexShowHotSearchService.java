package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowHotSearchDao;
import com.mht.define.portal.cms.entity.CmsIndexShowHotSearch;

/** 
 * 热门搜索统计表 service
 * @ClassName: CmsIndexShowHotSearchService
 * @Description:热门搜索统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowHotSearchService extends CrudService<CmsIndexShowHotSearchDao, CmsIndexShowHotSearch>{
	
	@Autowired
	private CmsIndexShowHotSearchDao cmsIndexShowHotSearchDao;
	
	/**
	 * 查询热门搜索的中的data数据 
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> getHotSearchSeriesData(){
		List<CmsIndexShowHotSearch> hotsearchdata = cmsIndexShowHotSearchDao.getHotSearchSeriesData();
		
		//List<Map<String, Object>> hotsearchDataList = new ArrayList<>();
		Map<String, Object> seriesMap = new HashMap<>();
		List<String> seriesDataNameList = new ArrayList<>();
		List<Object> seriesDataValueList = new ArrayList<>();
		

		for (CmsIndexShowHotSearch hotsearchList : hotsearchdata) {
			String name = hotsearchList.getName();
			String value = hotsearchList.getValue();
				seriesDataNameList.add(name);
				seriesDataValueList.add(value);
				seriesMap.put(name, value);
			}
		//hotsearchDataList.add(seriesMap);
			
		System.out.println("+++++++++++++++++++++++++++service_seriesMap+++++++++++++++++++++"+seriesMap);
		//System.out.println("+++++++++++++++++++++++++++service_hotsearchDataList+++++++++++++++++++++"+hotsearchDataList);
		return seriesMap;
	};
}
