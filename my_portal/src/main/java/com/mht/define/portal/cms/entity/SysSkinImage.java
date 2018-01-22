package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

public class SysSkinImage extends DataEntity<SysSkinImage>{

	private static final long serialVersionUID = 1L;

	private String url;//图片路径

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
