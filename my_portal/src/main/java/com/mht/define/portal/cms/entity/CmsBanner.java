package com.mht.define.portal.cms.entity;

import com.mht.common.config.Global;
import com.mht.common.persistence.DataEntity;

/**
 * BannerEntity
 * @author 王杰
 * @version 2017-07-05
 */
public class CmsBanner extends DataEntity<CmsBanner>{

	private static final long serialVersionUID = 1L;
	
	private int sort; //排序
	private String description;//配文
	private String imageUrl;
	private String disable = Global.DISABLE;//是否禁用
	
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getDisable() {
		return disable;
	}
	public void setDisable(String disable) {
		this.disable = disable;
	}
	
}
