package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
/**
 * @ClassName:  CmsIndexShowHotSearch
 * @Description:热门搜索统计表
 * @author wxw
 * @date 2017年9月30日
 * @version 1.0.0
 *
 */
public class CmsIndexShowHotSearch extends DataEntity<CmsIndexShowHotSearch>{


	private static final long serialVersionUID = 1L;
	private String title;//标题
	private String name;//数据名称
	private String value;//数据值
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	
	
	
	

	
}
