package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.AppAuthRole;

/**
 * 
 * @ClassName: AppAuthRoleDao
 * @Description:应用管理权限设置 == 角色 
 * @author wangjie
 * @date 2017年8月4日 上午11:55:42 
 * @version 1.0.0
 */
@MyBatisDao
public interface AppAuthRoleDao extends CrudDao<AppAuthRole> {
	
	/**
	 * 
	 * @Title: findListById
	 * @Description: 获取当前角色拥有的应用
	 * @param roleId
	 * @return
	 * @author com.mhout.wj
	 */
	List<AppAuthRole> findListByRoleId(@Param("roleId") String roleId );

	/**
	 * 
	 * @Title: deleteByRoleId 
	 * @Description: 通过角色ID删除应用中间表数据
	 * @param roleId void
	 * @author wangjie
	 */
	void deleteByRoleId(String roleId);
}
