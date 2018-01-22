package com.mht.define.portal.cms.dao;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.DisplaySetting;

/**
 * 显示设置dao接口
 * @author 王杰
 *
 */
@MyBatisDao
public interface DisplaySettingDao extends CrudDao<DisplaySetting> {

}
