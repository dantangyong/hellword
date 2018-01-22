package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.FrontApp;

/**
 * 排版dao接口
 * @ClassName: FrontAppDao
 * @Description: 
 * @author wangjie
 * @date 2017年5月22日 下午5:17:37 
 * @version 1.0.0
 */
@MyBatisDao
public interface FrontAppDao extends CrudDao<FrontApp>{

	/**
	 * 查询首页右上角的应用
	 * @Title: findShowApps 
	 * @Description: TODO
	 * @param app
	 * @return List<FrontApp>
	 * @author wangjie
	 */
	List<FrontApp> findShowApps(FrontApp app);

	FrontApp getByAPPUrl(String appUrl);
	
	FrontApp getByAPPName(String appName);

}
