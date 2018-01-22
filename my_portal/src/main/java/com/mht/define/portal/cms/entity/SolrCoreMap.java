package com.mht.define.portal.cms.entity;
/**
 * 表示solr索引库映射关系的类
 * @author admin
 *
 */
public class SolrCoreMap {
	private Integer id;
	/**
	 * 索引库名称
	 */
	private String coreName;
	/**
	 * 索引库对应code
	 */
	private String mapCode;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCoreName() {
		return coreName;
	}
	public void setCoreName(String coreName) {
		this.coreName = coreName;
	}
	public String getMapCode() {
		return mapCode;
	}
	public void setMapCode(String mapCode) {
		this.mapCode = mapCode;
	}
	
}
