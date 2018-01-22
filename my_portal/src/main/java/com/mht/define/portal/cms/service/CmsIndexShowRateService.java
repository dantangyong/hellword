package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mht.common.service.CrudService;
import com.mht.define.portal.cms.dao.CmsIndexShowRateDao;
import com.mht.define.portal.cms.entity.CmsIndexShowRate;
import com.mht.define.portal.cms.utils.ConstantShow;

/** 
 * 就业率统计表 service
 * @ClassName: CmsIndexShowRateService
 * @Description:就业率统计表 service
 * @author wxw
 * @date 2017年9月30日
 */
@Service
@Transactional(readOnly = true)
public class CmsIndexShowRateService extends CrudService<CmsIndexShowRateDao, CmsIndexShowRate>{
	
	@Autowired
	private CmsIndexShowRateDao cmsIndexShowRateDao;
	
	/**
	 * 查询就业率的legend的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowRate> getRateLegendData(){
		return cmsIndexShowRateDao.getRateLegendData();
	};
	
	/**
	 * 查询就业率统计的xAxis中的data数据
	 */
	@Transactional(readOnly = false)
	public List<CmsIndexShowRate> getRateXAxisData(){
		return cmsIndexShowRateDao.getRateXAxisData();
	};
	
	/**
	 * 查询就业率的series中的data数据 
	 */
	@Transactional(readOnly = false)
	public Map<String, List<Integer>> getRateSeriesData(){
		List<CmsIndexShowRate> ratedata = cmsIndexShowRateDao.getRateSeriesData();
		Map<String, List<Integer>> seriesMap = new HashMap<>();
		List<Integer> seriesDataBoyList = new ArrayList<>();
		List<Integer> seriesDataGirlList = new ArrayList<>();
		
		for (CmsIndexShowRate rateList : ratedata) {
			Integer series = rateList.getSeries();
			String legend = rateList.getLegend();
			if (ConstantShow.RATE_SERIESDATA_BOY.equals(legend)) {
				seriesDataBoyList.add(series);
			}else if (ConstantShow.RATE_SERIESDATA_GIRL.equals(legend)) {
				seriesDataGirlList.add(series);
			}
			
			seriesMap.put(ConstantShow.RATE_SERIESDATA_BOY, seriesDataBoyList);
			seriesMap.put(ConstantShow.RATE_SERIESDATA_GIRL, seriesDataGirlList);
			
			
		}
		System.out.println("+++++++++++++++++++++++++++service_seriesMap+++++++++++++++++++++"+seriesMap);
		return seriesMap;
	};
}
