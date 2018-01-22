package com.mht.define.portal.cms.dao;

import java.util.List;
import java.util.Map;

/**
 * Solr索引库创建使用的Dao，使用JDBC获取元数据
 * @author admin
 *
 */
public interface SolrDirDao {
	/**
	 * 根据tableName获取字段列表
	 * @param tabName
	 * @return
	 */
	public List<Map<String,String>> getFieldList(String tabName);
}
