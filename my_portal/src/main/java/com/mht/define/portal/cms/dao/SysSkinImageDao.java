package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.mht.define.portal.cms.entity.SysSkinImage;

/**
 * 
 * @ClassName: SysSkinImageDao
 * @Description: 系统皮肤图片管理
 * @author wangjie
 * @date 2017年8月1日 上午10:26:26 
 * @version 1.0.0
 */
public interface SysSkinImageDao {

	@Select(" select * from mht_portal.sys_skin_image")
	List<SysSkinImage> findList();
}
