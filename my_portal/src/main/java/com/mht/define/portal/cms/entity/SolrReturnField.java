package com.mht.define.portal.cms.entity;
/**
 * 表示solr索引库和需要返回的字段的映射关系的类
 * @author admin
 *
 */
public class SolrReturnField {
	private Integer id;
	/**
	 * 索引库名称
	 */
	private String coreName;
	/**
	 * 需要返回的fieldName
	 */
	private String fieldName;
	
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
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
}
