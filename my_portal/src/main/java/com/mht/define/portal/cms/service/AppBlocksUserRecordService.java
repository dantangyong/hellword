package com.mht.define.portal.cms.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mht.common.datasource.DynamicDataSource;
import com.mht.common.service.CrudService;
import com.mht.common.utils.StringUtils;
import com.mht.define.portal.cms.dao.AppBlocksUserRecordDao;
import com.mht.define.portal.cms.entity.AppBlocksUserRecord;
import com.mht.define.portal.cms.entity.FrontApp;
import com.mht.modules.sys.dao.OfficeDao;
import com.mht.modules.sys.entity.Office;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;

/**
 * @ClassName: AppUserRecordService
 * @Description: 门户版块访问记录
 * @author com.mhout.dty
 * @date 2017年12月18日 下午5:36:44
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class AppBlocksUserRecordService extends CrudService<AppBlocksUserRecordDao, AppBlocksUserRecord> {

	@Autowired
	private OfficeDao officeDao;

	/**
	 * @Title: record
	 * @Description: 门户版块访问记录
	 * @param frontApp
	 * @author com.mhout.dty
	 */
	@Transactional(readOnly = false)
	public void record(FrontApp frontApp) {
		/**
		 * 进入方法切换数据库数据源为portal数据库
		 */
//		String oldDataSource = DynamicDataSource.getCurrentLookupKey();
//		logger.info("===============================oldDataSource:"+oldDataSource);
//		DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE);
//		logger.info("===============================office:"+DynamicDataSource.getCurrentLookupKey());
		User user = UserUtils.getUser();
		if (user != null && frontApp != null) {
			AppBlocksUserRecord AppBlocksUserRecord = new AppBlocksUserRecord();
			// 获取用户学院
		
			List<Office> offices = officeDao.findOfficeByUser(user.getId());
			if (offices != null && !offices.isEmpty()) {
				Office office = offices.get(0);
				String ids = office.getParentIds();
				if (StringUtils.isNotBlank(ids)) {
					String[] values = ids.split("\\,");
					for (String id : values) {
						Office reoffice = officeDao.get(id);
						if (reoffice != null && "2".equals(reoffice.getGrade())) {
							AppBlocksUserRecord.setOffice(reoffice);
							break;
						}
					}
				}
				if (AppBlocksUserRecord.getOffice() == null && "2".equals(office.getGrade())) {
					AppBlocksUserRecord.setOffice(office);
				}
			}
			
			AppBlocksUserRecord.setFrontApp(frontApp);
			AppBlocksUserRecord.setUser(user);
			super.save(AppBlocksUserRecord);
			/**
			 * 操作完成还回数据源
			 */
//			DynamicDataSource.setCurrentLookupKey(DynamicDataSource.DATA_SOURCE_PORTAL);
//			DynamicDataSource.setCurrentLookupKey(oldDataSource);
		}
	}

}
