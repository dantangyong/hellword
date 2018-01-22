package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;

import com.mht.define.portal.cms.entity.NewNotice;
import com.mht.define.portal.cms.entity.PageBean;
/**
 * 通告DAO接口
 * @author dty
 * @version 2017-10-20
 */
@MyBatisDao
public interface NewNoticeDao extends CrudDao<NewNotice> {
	List<NewNotice> selectByNotify(@Param("pb") PageBean pb);

	NewNotice selectClickNotice(@Param("name") String name);

	Number selectcount();

	Number selectcountByKeys(@Param("pb") PageBean pb);
	@Select("SELECT content from mht_portal.oa_notify where id=#{id} ")
	String selectNotice(String id);
}
