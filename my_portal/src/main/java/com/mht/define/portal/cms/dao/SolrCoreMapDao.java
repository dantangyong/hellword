package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.SolrCoreMap;
import com.mht.define.portal.cms.entity.SolrReturnField;

@MyBatisDao
public interface SolrCoreMapDao {
	/**
	 * 获取Solr索引库和索引库编码的映射关系
	 * @return
	 */
	public List<SolrCoreMap> getCoreMap();
	/**
	 * 获取Solr索引库和需要返回的字段之间的映射关系
	 * @return
	 */
	public List<SolrReturnField> getReturnFields();
	
	
	public String selectService(String aid);
}
