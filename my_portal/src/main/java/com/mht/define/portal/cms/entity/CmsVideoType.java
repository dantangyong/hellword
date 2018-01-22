package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

/**
 * 视频类别
 * @ClassName: CmsVideoType
 * @Description: 
 * @author wangjie
 * @date 2017年7月27日 上午11:50:54 
 * @version 1.0.0
 */
public class CmsVideoType extends DataEntity<CmsVideoType>{

	private static final long serialVersionUID = 1L;
	
	private String disable;//是否可用 
	private String typeName; //类别名称
	private Integer sort;//排序 
	
	public String getDisable() {
		return disable;
	}
	public void setDisable(String disable) {
		this.disable = disable;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}

}
