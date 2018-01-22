package com.mht.define.portal.cms.entity;

import java.util.Date;
import com.mht.common.persistence.DataEntity;
import com.mht.modules.sys.entity.Office;
import com.mht.modules.sys.entity.User;
/**
 * @ClassName: AppBlocksUserRecord
 * @Description: 门户版块访问记录
 * @author com.mhout.dty
 * @date 2017年12月18日 下午4:26:44
 * @version 1.0.0
 */
public class AppBlocksUserRecord extends DataEntity<AppBlocksUserRecord> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private User user; // 用户信息
	private FrontApp frontApp; // 应用信息
	private Office office; //院系
	
	private Date beginDate; // 开始日期
	private Date endDate; // 结束日期
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public FrontApp getFrontApp() {
		return frontApp;
	}
	public void setFrontApp(FrontApp frontApp) {
		this.frontApp = frontApp;
	}
	public Office getOffice() {
		return office;
	}
	public void setOffice(Office office) {
		this.office = office;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	

}
