package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.Navigation;

/**
 * 导航接口Dao
 * @author 王杰
 *
 */
@MyBatisDao
public interface NavigationDao extends CrudDao<Navigation>{

	List<Navigation> findByDisplay(String displaySettingId);

	List<Navigation> findChildren(String id);

}
