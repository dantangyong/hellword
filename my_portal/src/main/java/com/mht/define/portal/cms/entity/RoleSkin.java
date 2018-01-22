package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

public class RoleSkin extends DataEntity<RoleSkin>{

	private static final long serialVersionUID = 1L;
	
	private String roleId; //用户ID
	private Boolean isUpload; //是否为用户上传
	private int num; //透明度
	private String pid; //图片id(系统图片)
	private Boolean history; //是否为以往使用过的图片
	private String imageUrl;//图片地址
	
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public Boolean getIsUpload() {
		return isUpload;
	}
	public void setIsUpload(Boolean isUpload) {
		this.isUpload = isUpload;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public Boolean getHistory() {
		return history;
	}
	public void setHistory(Boolean history) {
		this.history = history;
	}
	
	
}
