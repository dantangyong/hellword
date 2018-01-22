package com.mht.define.portal.cms.dao;

import java.util.List;

import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.SolrHistory;

@MyBatisDao
public interface SolrHistoryDao {
	public List<SolrHistory> getServiceHotName(SolrHistory his);
	
	public List<SolrHistory> getHotName();

	public void addHotName(SolrHistory his);
	
	public void updateHotName(SolrHistory his);
	
	public SolrHistory getSearcheName(SolrHistory his);
	
	public List<SolrHistory> getHome();
	
	public List<Article> getHotNews();
}