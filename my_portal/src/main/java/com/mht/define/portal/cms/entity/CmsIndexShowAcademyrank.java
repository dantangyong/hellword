package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
/**
 * @ClassName:  CmsIndexShowAcademyrank
 * @Description:学院排名表
 * @author wxw
 * @date 2017年9月30日
 * @version 1.0.0
 *
 */
public class CmsIndexShowAcademyrank extends DataEntity<CmsIndexShowAcademyrank>{


	private static final long serialVersionUID = 1L;
	private String title;//标题
	private String xAxis;//横坐标
	private Integer data;//数据
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getxAxis() {
		return xAxis;
	}
	public void setxAxis(String xAxis) {
		this.xAxis = xAxis;
	}
	public Integer getData() {
		return data;
	}
	public void setData(Integer data) {
		this.data = data;
	}
	
	
	

	
}
