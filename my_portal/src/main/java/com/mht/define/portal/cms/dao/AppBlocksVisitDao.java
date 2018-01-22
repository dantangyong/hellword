package com.mht.define.portal.cms.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.AppBlocksUserRecord;
import com.mht.define.portal.cms.entity.AppBlocksUserRecordData;

/**
 * @ClassName: AppVisitDao
 * @Description: 应用访问历史持久层
 * @author com.mhout.dty
 * @date 2017年12月18日 下午4:47:21 
 * @version 1.0.0
 */
@MyBatisDao
public interface AppBlocksVisitDao extends CrudDao<AppBlocksUserRecord> {
   
	/**
	 * @Title: findVisitStatistics 
	 * @Description: 查询门户版块统计
	 * @param appBlocksUserRecord
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitStatistics(AppBlocksUserRecord appBlocksUserRecord);

	/**
	 * @Title: findVisitAmount 
	 * @Description: 访问量TOP10
	 * @param appUserRecord
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitAmount(@Param("limit")Integer limit);
	
	/**
	 * @Title: findVisitAmount 
	 * @Description: 院系访问量TOP10
	 * @param limit
	 * @param grade
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findOfficeAmount(@Param("limit")Integer limit,@Param("grade")String grade);

	/**
	 * @Title: findVisitUser 
	 * @Description: 用户占比TOP10
	 * @param limit
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitUser(@Param("limit")Integer limit);
	
	/**
	 * @Title: findOfficeUser 
	 * @Description: 院系用户占比TOP10
	 * @param limit
	 * @param grade
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findOfficeUser(@Param("limit")Integer limit, @Param("grade")String grade);

	/**
	 * @Title: findVisitUser 
	 * @Description: 应用访问趋势TOP10
	 * @param limit
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitTrend(@Param("limit")Integer limit);
	
	/**
	 * @Title: findDepartTrend 
	 * @Description: 院系访问趋势TOP10
	 * @param limit
	 * @param grade
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findDepartTrend(@Param("limit")Integer limit, @Param("grade")String grade);
	
	/**
	 * @Title: findVisitHistory 
	 * @Description: 访问历史总览
	 * @return
	 * @author com.mhout.dty
	 */
	public List<AppBlocksUserRecordData> findVisitHistory();
}
