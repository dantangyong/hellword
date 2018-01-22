package com.mht.define.portal.cms.dao;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.AppBlocksUserRecord;
/**
 * @ClassName: AppUserRecordDao
 * @Description: 门户版块访问历史
 * @author com.mhout.dty
 * @date 2017年12月18日 下午4:50:30 
 * @version 1.0.0
 */
@MyBatisDao
public interface AppBlocksUserRecordDao extends CrudDao<AppBlocksUserRecord> {
    
	
}
