package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsBanner;

/**
 * bannerDAO接口
 * @author 王杰
 * @version 2017-07-05
 */
@MyBatisDao
public interface CmsBannerDao extends CrudDao<CmsBanner>{

	/**
	 * 获取首页显示的banner图
	 * @Title: getShowBanners 
	 * @Description: TODO
	 * @return List<ServiceBanner>
	 * @author wangjie
	 */
	List<CmsBanner> getShowBanners(CmsBanner banner);
	 @Select("select count(*) from mht_portal.cms_banner where del_flag = '0' and disable ='1'")
		int getEnableCount();


}
