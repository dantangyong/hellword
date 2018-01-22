package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
/**
 * @ClassName:  CmsIndexShowTeacherStudent
 * @Description:师生比统计表
 * @author wxw
 * @date 2017年9月30日
 * @version 1.0.0
 *
 */
public class CmsIndexShowTeacherStudent extends DataEntity<CmsIndexShowTeacherStudent>{


	private static final long serialVersionUID = 1L;
	private String title;//标题
	private String yAxis;//纵坐标
	private String legend;//类别
	private Integer series;//数据
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getyAxis() {
		return yAxis;
	}
	public void setyAxis(String yAxis) {
		this.yAxis = yAxis;
	}
	public String getLegend() {
		return legend;
	}
	public void setLegend(String legend) {
		this.legend = legend;
	}
	public Integer getSeries() {
		return series;
	}
	public void setSeries(Integer series) {
		this.series = series;
	}
	
	
	
	

	
}
