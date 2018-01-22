/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsVideoType;


/**
 * 文章DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface ArticleDao extends CrudDao<Article> {
	
	public List<Article> findByIdIn(String[] ids);
//	{
//		return find("from Article where id in (:p1)", new Parameter(new Object[]{ids}));
//	}
	
	public int updateHitsAddOne(String id);
//	{
//		return update("update Article set hits=hits+1 where id = :p1", new Parameter(id));
//	}
	
	public int updateExpiredWeight(Article article);
	
	public List<Category> findStats(Category category);
//	{
//		return update("update Article set weight=0 where weight > 0 and weightDate < current_timestamp()");
//	}
	/**
	 * 获取权重前三的三条新闻
	 * @return
	 */
	public List<Article> findMainNews(Article article);

	/**
	 * 获取新闻的三张图片
	 * @return
	 */
	public List<Article> findPics();
	
	void disableArticle(@Param("article")Article article);
}
