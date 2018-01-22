package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

/**
 * 敏感词Entity
 * @author dty
 * @version 2017-12-18
 */
public class SensitiveWord extends DataEntity<SensitiveWord> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String sensitiveName;//敏感词

	public String getSensitiveName() {
		return sensitiveName;
	}

	public void setSensitiveName(String sensitiveName) {
		this.sensitiveName = sensitiveName;
	}
	

}
