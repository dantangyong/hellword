package com.mht.define.portal.cms.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mht.common.utils.IdGen;
import com.mht.define.portal.cms.dao.SolrHistoryDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.SolrHistory;
@Service
public class SolrHistoryLogService {
	@Autowired
	SolrHistoryDao solrHistoryDao;
	
	public  List<SolrHistory> hotName(){
		return	solrHistoryDao.getHotName();
	}
	
	public  List<SolrHistory> hotName01(){
		return	solrHistoryDao.getHome();
	}
	public  List<SolrHistory> hotServiceName(SolrHistory his){
		return	solrHistoryDao.getServiceHotName(his);
	}
	public boolean getName(SolrHistory solrRecord){
		SolrHistory result = solrHistoryDao.getSearcheName(solrRecord);
		if(result ==null){
			return false;
		}
		return true;
		
	}
	
	public void addData(SolrHistory solrRecord){
		solrRecord.setId(IdGen.uuid());
		solrRecord.setCount(1);
		
		solrRecord.setCreate_date(new java.sql.Date(new java.util.Date().getTime()));
		solrRecord.setUpdate(new Date());
		solrHistoryDao.addHotName(solrRecord);
	}
	public void update(SolrHistory solrRecord,boolean exist){
		SolrHistory result = solrHistoryDao.getSearcheName(solrRecord);
		if(result !=null){
		Integer num =result.getCount();
		result.setCount(num+1);
		result.setUpdate(new Date());
		solrHistoryDao.updateHotName(result);
		}
	}
	
	public  List<Article> getHotNews(){
		return	solrHistoryDao.getHotNews();
	}

}