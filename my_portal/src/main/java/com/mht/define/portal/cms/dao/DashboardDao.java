package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.DashboardBoard;

/**
 * bi 零时暂时使用
 * @ClassName: DashboardDao
 * @Description: 
 * @author wangjie
 * @date 2017年7月14日 下午2:13:04 
 * @version 1.0.0
 */
@MyBatisDao
public interface DashboardDao {

	@Select("SELECT * from mht_bi.dashboard_board d "
			+ "LEFT JOIN mht_bi.dashboard_category c on d.category_id = c.category_id "
			+ "ORDER BY d.category_id")
	List<DashboardBoard> findList();

}
