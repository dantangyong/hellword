package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.AppAuthUser;

/**
 * 
 * @ClassName: AppAuthUserDao
 * @Description:应用管理权限设置 == 用户 
 * @author wangjie
 * @date 2017年8月4日 上午11:55:42 
 * @version 1.0.0
 */
@MyBatisDao
public interface AppAuthUserDao extends CrudDao<AppAuthUser> {

	/**
	 * 
	 * @Title: findListByUserId 
	 * @Description: 用户app授权列表
	 * @param id
	 * @return List<AppAuthUser>
	 * @author wangjie
	 */
	List<AppAuthUser> findListByUserId(@Param("userId") String id);

	/**
	 * 
	 * @Title: deleteByUserId 
	 * @Description: 删除用户关联的应用信息
	 * @param userId void
	 * @author wangjie
	 */
	void deleteByUserId(String userId);

}
