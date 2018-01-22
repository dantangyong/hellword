package com.mht.define.portal.cms.entity;
/**
 * SolrDir 用于封装与Solr索引库有关的数据
 * @author admin
 *
 */
public class SolrDir {
	/**
	 * @coreName 索引库名称
	 */
	private String coreName;
	/**
	 * @tableName 创建索引库依据的表
	 */
	private String tableName;

	public String getCoreName() {
		return coreName;
	}

	public void setCoreName(String coreName) {
		this.coreName = coreName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	
}
