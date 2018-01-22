package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mht.common.service.CrudService;
import com.mht.common.utils.DateUtils;
import com.mht.define.portal.cms.dao.AppBlocksUserRecordDao;
import com.mht.define.portal.cms.dao.AppBlocksVisitDao;
import com.mht.define.portal.cms.dao.FrontAppDao;
import com.mht.define.portal.cms.entity.AppBlocksUserRecord;
import com.mht.define.portal.cms.entity.AppBlocksUserRecordData;
import com.mht.define.portal.cms.entity.AppBlocksUserRecordList;
import com.mht.modules.audit.entity.AppUserRecordData;
import com.mht.modules.sys.dao.OfficeDao;
import com.mht.modules.sys.entity.Office;

/**
 * @ClassName: AppVisitService
 * @Description: 门户版块访问历史业务层
 * @author com.mhout.dty
 * @date 2017年12月18日 下午5:24:35 
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class AppBlocksVisitService extends CrudService<AppBlocksUserRecordDao, AppBlocksUserRecord> {
	@Autowired
	private AppBlocksVisitDao appBlocksVisitDao;
	
	@Autowired
	private OfficeDao officeDao;
	
	@Autowired
	private FrontAppDao frontAppDao;
	
	/**
	 * @Title: findVisitStatistics 
	 * @Description: 访问统计图
	 * @param AppBlocksUserRecord
	 * @return
	 * @author com.mhout.xyb
	 */
	public AppBlocksUserRecordList findVisitStatistics(String type, Office office) {
		AppBlocksUserRecord AppBlocksUserRecord = new AppBlocksUserRecord();
		AppBlocksUserRecord.setOffice(office);
		if (StringUtils.isNotBlank(type)) {
			this.setDate(type, AppBlocksUserRecord);
		} else {
			Date date = DateUtils.parseDate(DateUtils.getDate());
			AppBlocksUserRecord.setBeginDate(date);
			AppBlocksUserRecord.setEndDate(DateUtils.addDays(date, 1));
		}
		List<AppBlocksUserRecordData> list = appBlocksVisitDao.findVisitStatistics(AppBlocksUserRecord);
		AppBlocksUserRecordList appRecord = new AppBlocksUserRecordList();
		if (CollectionUtils.isNotEmpty(list)) {
			List<Integer> count = new ArrayList<Integer>();
			List<String> value = new ArrayList<String>(); 
			for (AppBlocksUserRecordData data : list) {
				count.add(data.getValue());
				value.add(data.getName());
			}
			appRecord.setCount(count);
			appRecord.setValue(value);
			appRecord.setList(list);
		}
		return appRecord;
	}
	
	/**
	 * @Title: setDate 
	 * @Description: 设置日期范围
	 * @param type
	 * @param AppBlocksUserRecord
	 * @author com.mhout.dty
	 */
	private void setDate(String type, AppBlocksUserRecord appBlocksUserRecord) {
		Date date = DateUtils.parseDate(DateUtils.getDate());
		switch (type) {
		case "1":
			appBlocksUserRecord.setBeginDate(date);
			appBlocksUserRecord.setEndDate(DateUtils.addDays(date, 1));
			break;
		case "2":
			appBlocksUserRecord.setBeginDate(DateUtils.addDays(date, -1));
			appBlocksUserRecord.setEndDate(date);		
			break;
		case "3":
			appBlocksUserRecord.setBeginDate(DateUtils.getBeginDayOfWeek());
			appBlocksUserRecord.setEndDate(DateUtils.getEndDayOfWeek());
			break;
		case "4":
			appBlocksUserRecord.setBeginDate(DateUtils.getBeginDayOfMonth());
			appBlocksUserRecord.setEndDate(DateUtils.getEndDayOfMonth());
			break;
		case "5":
			appBlocksUserRecord.setBeginDate(DateUtils.getBeginDayOfYear());
			appBlocksUserRecord.setEndDate(DateUtils.getEndDayOfYear());
			break;
		case "6":
			appBlocksUserRecord.setBeginDate(null);
			appBlocksUserRecord.setEndDate(null);
			break;
		default:
			appBlocksUserRecord.setBeginDate(null);
			appBlocksUserRecord.setEndDate(null);
			break;
		}
	}

	/**
	 * @Title: findVisitAmount 
	 * @Description: 访问量TOP10统计
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitAmount(String grade) {
		if (StringUtils.isNotBlank(grade)) {
			return appBlocksVisitDao.findOfficeAmount(10, grade);
		}
		return appBlocksVisitDao.findVisitAmount(10);
	}

	/**
	 * @Title: findVisitUser 
	 * @Description: 用户占比TOP10
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitUser(String grade) {
		if (StringUtils.isNotBlank(grade)) {
			return appBlocksVisitDao.findOfficeUser(10, grade);
		}
		return appBlocksVisitDao.findVisitUser(10);
	}

	/**
	 * @Title: findVisitTrend 
	 * @Description: 应用访问趋势TOP10
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitTrend(String grade) {
		if (StringUtils.isNotBlank(grade)) {
			return appBlocksVisitDao.findDepartTrend(10, grade);
		}
		return appBlocksVisitDao.findVisitTrend(10);
	}
	
	/**
	 * @Title: findVisitHistory 
	 * @Description: 访问历史总览
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitHistory() {
		return appBlocksVisitDao.findVisitHistory();
	}

	
} 
