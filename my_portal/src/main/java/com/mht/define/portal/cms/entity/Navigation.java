package com.mht.define.portal.cms.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mht.common.persistence.DataEntity;

public class Navigation extends DataEntity<Navigation> {

	private static final long serialVersionUID = 1L;
	
    private String naviName;//导航名称
    private String url;//导航url
    private String parentId; // 父节点
    private List<Navigation> children;	// 子级菜单
    private boolean status = true;//是否显示 默认显示
    private String icon;//子类有图标
    private int sort;//导航排序
    private DisplaySetting displaySetting;//页面设置
    
    @JsonIgnore
	public DisplaySetting getDisplaySetting() {
		return displaySetting;
	}
	public void setDisplaySetting(DisplaySetting displaySetting) {
		this.displaySetting = displaySetting;
	}
	public String getNaviName() {
		return naviName;
	}
	public void setNaviName(String naviName) {
		this.naviName = naviName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public List<Navigation> getChildren() {
		return children;
	}
	public void setChildren(List<Navigation> children) {
		this.children = children;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
    
}
