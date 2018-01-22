/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.mht.common.persistence.CrudDao;
import com.mht.common.persistence.annotation.MyBatisDao;
import com.mht.define.portal.cms.entity.ArticleData;

/**
 * 文章DAO接口
 * @author ThinkGem
 * @version 2013-8-23 (2017.12.14 dty)
 */
@MyBatisDao
public interface ArticleDataDao extends CrudDao<ArticleData> {
	
	List<ArticleData> selectHotNews(ArticleData ArticleData);

	ArticleData selectClickNews(String name);

	List<ArticleData> selectIf(@Param("name")String name,@Param("start")int start,@Param("pageSize")int defaultPagesize);

	Number selectcount(String name);
	
}
