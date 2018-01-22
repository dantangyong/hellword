package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

/**
 * 
 * @ClassName: FrontApp
 * @Description: 门户首页应用管理
 * @author wangjie
 * @date 2017年7月27日 下午3:33:19 
 * @version 1.0.0
 */
public class FrontApp extends DataEntity<FrontApp>{

	private static final long serialVersionUID = 1L;

	private String appName;//应用名称
	private String appImg; //应用图标
	private String appUrl; //应用地址
	private String disable; //是否启用 （1：启用；2：禁用）
	private Integer sort; //应用排序
	
	public String getAppUrl() {
		return appUrl;
	}
	public void setAppUrl(String appUrl) {
		this.appUrl = appUrl;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public String getAppImg() {
		return appImg;
	}
	public void setAppImg(String appImg) {
		this.appImg = appImg;
	}
	public String getDisable() {
		return disable;
	}
	public void setDisable(String disable) {
		this.disable = disable;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}
