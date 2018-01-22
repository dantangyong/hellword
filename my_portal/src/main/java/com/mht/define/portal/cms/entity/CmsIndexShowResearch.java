package com.mht.define.portal.cms.entity;

import java.util.Map;

import com.mht.common.persistence.DataEntity;
/**
 * @ClassName: CmsIndesShowResearch
 * @Description:科研获奖级别表 
 * @author wxw
 * @date 2017年9月30日
 * @version 1.0.0
 *
 */
public class CmsIndexShowResearch extends DataEntity<CmsIndexShowResearch>{


	private static final long serialVersionUID = 1L;
	private String title;//标题
	private String legend;//图例
	private Integer series;//饼图
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
