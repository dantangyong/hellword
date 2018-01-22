package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.modules.sys.entity.User;

/**
 * 视频类型dao接口
 * @ClassName: CmsVideoTypeDao
 * @Description: 
 * @author wangjie
 * @date 2017年7月27日 下午1:43:41 
 * @version 1.0.0
 */
@MyBatisDao
public interface CmsVideoTypeDao extends CrudDao<CmsVideoType> {

	/**
	 * 
	 * @Title: getMaxSort 
	 * @Description: 获取当前排序最大值
	 * @return String
	 * @author wangjie
	 */
	@Select("select MAX(sort) from mht_portal.cms_video_type")
	Integer getMaxSort();

	/**
	 * 
	 * @Title: findAuthors 
	 * @Description: 获取上传视频的作者
	 * @return List<User>
	 * @author wangjie
	 */
	@Select("select distinct u.id,u.name from mht_base.sys_user u "
			+ "	join mht_portal.cms_video v on v.create_by = u.id ")
	List<User> findAuthors();
/**
 * 
 * @Title: selectByName 
 * @Description: 通过视频分类名称查询视频分类
 * @param videoType
 * @return
 * @author com.mhout.wzw
 */
	CmsVideoType selectVideoType(@Param("videoType")CmsVideoType videoType);

	@Select("select type_name from mht_portal.cms_video_type where del_flag = '0' and type_name = #{typeName} ")
    CmsVideoType getByName(String typeName);

}
