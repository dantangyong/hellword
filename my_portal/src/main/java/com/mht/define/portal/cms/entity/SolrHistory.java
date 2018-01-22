package com.mht.define.portal.cms.entity;


import java.util.Date;

import com.mht.common.persistence.DataEntity;


public class SolrHistory extends DataEntity<SolrHistory>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String  id;
	
	private String name;
	
	private Integer count;
	
	private String service;
	
	private Date create_date;
	
	private Date update;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public Date getUpdate() {
		return update;
	}

	public void setUpdate(Date update) {
		this.update = update;
	}
	

}
