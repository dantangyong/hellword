package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
/**
 * @ClassName:  CmsIndexShowEducation
 * @Description:教职工学历统计表
 * @author wxw
 * @date 2017年9月30日
 * @version 1.0.0
 *
 */
public class CmsIndexShowEducation extends DataEntity<CmsIndexShowEducation>{


	private static final long serialVersionUID = 1L;
	private String title;//标题
	private String xAxis;//横坐标
	private String legend;//图例
	private Integer series;//数据
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
