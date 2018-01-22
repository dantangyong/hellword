/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.mht.define.portal.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.google.common.collect.Lists;
import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.service.CrudService;
import com.mht.common.utils.CacheUtils;
import com.mht.common.utils.StringUtils;
import com.mht.define.portal.cms.dao.ArticleDao;
import com.mht.define.portal.cms.dao.ArticleDataDao;
import com.mht.define.portal.cms.dao.CategoryDao;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.ArticleData;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.utils.ConstantConfig;
import com.mht.modules.sys.utils.UserUtils;

/**
 * 文章Service
 * @author ThinkGem
 * @version 2013-05-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleService extends CrudService<ArticleDao, Article> {
 
	@Autowired
	private ArticleDataDao articleDataDao;
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ArticleDao articleDao;
	
	@Transactional(readOnly = false)
	public Page<Article> findPage(Page<Article> page, Article article, boolean isDataScopeFilter) {
		// 更新过期的权重，间隔为“6”个小时
		Date updateExpiredWeightDate =  (Date)CacheUtils.get("updateExpiredWeightDateByArticle");
		if (updateExpiredWeightDate == null || (updateExpiredWeightDate != null 
				&& updateExpiredWeightDate.getTime() < new Date().getTime())){
			dao.updateExpiredWeight(article);
			CacheUtils.put("updateExpiredWeightDateByArticle", DateUtils.addHours(new Date(), 6));
		}
//		DetachedCriteria dc = dao.createDetachedCriteria();
//		dc.createAlias("category", "category");
//		dc.createAlias("category.site", "category.site");
		if (article.getCategory()!=null && StringUtils.isNotBlank(article.getCategory().getId()) && !Category.isRoot(article.getCategory().getId())){
			Category category = categoryDao.get(article.getCategory().getId());
			if (category==null){
				category = new Category();
			}
			category.setParentIds(category.getId());
			category.setSite(category.getSite());
			article.setCategory(category);
		}
		else{
			article.setCategory(new Category());
		}
//		if (StringUtils.isBlank(page.getOrderBy())){
//			page.setOrderBy("a.weight,a.update_date desc");
//		}
//		return dao.find(page, dc);
	//	article.getSqlMap().put("dsf", dataScopeFilter(article.getCurrentUser(), "o", "u"));
		return super.findPage(page, article);
		
	}

	@Transactional(readOnly = false)
	public void save(Article article) {
		if (article.getArticleData().getContent()!=null){
			article.getArticleData().setContent(StringEscapeUtils.unescapeHtml4(
					article.getArticleData().getContent()));
		}
		// 如果没有审核权限，则将当前内容改为待审核状态
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
			article.setDelFlag(Article.DEL_FLAG_AUDIT);
		}
		// 如果栏目不需要审核，则将该内容设为发布状态
		if (article.getCategory()!=null&&StringUtils.isNotBlank(article.getCategory().getId())){
			Category category = categoryDao.get(article.getCategory().getId());
			if (!Global.YES.equals(category.getIsAudit())){
				article.setDelFlag(Article.DEL_FLAG_NORMAL);
			}
		}
		//article.setUpdateBy(UserUtils.getUser());
		article.setUpdateDate(new Date());
        if (StringUtils.isNotBlank(article.getViewConfig())){
            article.setViewConfig(StringEscapeUtils.unescapeHtml4(article.getViewConfig()));
        }
        
        ArticleData articleData = new ArticleData();
       
        
		if (StringUtils.isBlank(article.getId())){
			article.preInsert();
			articleData = article.getArticleData();
			articleData.setId(article.getId());
			if(StringUtils.isNotBlank(article.getArticleData().getCopyfrom())){
				articleData.setCopyfrom(article.getArticleData().getCopyfrom());
			}else{
				copyFrom(articleData);
			}
			dao.insert(article);
			articleDataDao.insert(articleData);
		}else{
			article.preUpdate();
			articleData = article.getArticleData();
			articleData.setId(article.getId());
			if(StringUtils.isNotBlank(article.getArticleData().getCopyfrom())){
				articleData.setCopyfrom(article.getArticleData().getCopyfrom());
			}else{
				copyFrom(articleData);
			}
			dao.update(article);
			articleDataDao.update(article.getArticleData());
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Article article, Boolean isRe) {
//		dao.updateDelFlag(id, isRe!=null&&isRe?Article.DEL_FLAG_NORMAL:Article.DEL_FLAG_DELETE);
		// 使用下面方法，以便更新索引。
		//Article article = dao.get(id);
		//article.setDelFlag(isRe!=null&&isRe?Article.DEL_FLAG_NORMAL:Article.DEL_FLAG_DELETE);
		//dao.insert(article);
		if (isRe!=null&&isRe) {
			Article a = dao.get(article.getId());
			a.setDelFlag(Article.DEL_FLAG_NORMAL);
			a.setUpdateDate(new Date());
			dao.update(a);
		} else {
			super.delete(article);
		}
		
	}
	
	/**
	 * 通过编号获取内容标题
	 * @return new Object[]{栏目Id,文章Id,文章标题}
	 */
	public List<Object[]> findByIds(String ids) {
		if(ids == null){
			return new ArrayList<Object[]>();
		}
		List<Object[]> list = Lists.newArrayList();
		String[] idss = StringUtils.split(ids,",");
		Article e = null;
		for(int i=0;(idss.length-i)>0;i++){
			e = dao.get(idss[i]);
			list.add(new Object[]{e.getCategory().getId(),e.getId(),StringUtils.abbr(e.getTitle(),50)});
		}
		return list;
	}
	
	/**
	 * 点击数加一
	 */
	@Transactional(readOnly = false)
	public void updateHitsAddOne(String id) {
		dao.updateHitsAddOne(id);
	}
	
	/**
	 * 更新索引
	 */
	public void createIndex(){
		//dao.createIndex();
	}
	
	/**
	 * 全文检索
	 */
	//FIXME 暂不提供检索功能
	public Page<Article> search(Page<Article> page, String q, String categoryId, String beginDate, String endDate){
		
		// 设置查询条件
//		BooleanQuery query = dao.getFullTextQuery(q, "title","keywords","description","articleData.content");
//		
//		// 设置过滤条件
//		List<BooleanClause> bcList = Lists.newArrayList();
//
//		bcList.add(new BooleanClause(new TermQuery(new Term(Article.FIELD_DEL_FLAG, Article.DEL_FLAG_NORMAL)), Occur.MUST));
//		if (StringUtils.isNotBlank(categoryId)){
//			bcList.add(new BooleanClause(new TermQuery(new Term("category.ids", categoryId)), Occur.MUST));
//		}
//		
//		if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {   
//			bcList.add(new BooleanClause(new TermRangeQuery("updateDate", beginDate.replaceAll("-", ""),
//					endDate.replaceAll("-", ""), true, true), Occur.MUST));
//		}   
		
		//BooleanQuery queryFilter = dao.getFullTextQuery((BooleanClause[])bcList.toArray(new BooleanClause[bcList.size()]));

//		System.out.println(queryFilter);
		
		// 设置排序（默认相识度排序）
		//FIXME 暂时不提供lucene检索
		//Sort sort = null;//new Sort(new SortField("updateDate", SortField.DOC, true));
		// 全文检索
		//dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		//dao.keywordsHighlight(query, page.getList(), 30, "title");
		//dao.keywordsHighlight(query, page.getList(), 130, "description","articleData.content");
		
		return page;
	}

	public List<Article> findMainNews(Article article) {
		return articleDao.findMainNews(article);
	}

	public List<Article> findPics(Article article) {
		return articleDao.findPics();
	}
	
	/**
	 * 设置新闻文章出处
	 */
	public void copyFrom(ArticleData articleData){
		String officeName = UserUtils.getUser().getOffice().getName();
		 if (StringUtils.isBlank(officeName)) {
        	 articleData.setCopyfrom("教务处");
        } else{
        	articleData.setCopyfrom(officeName);
        }
        logger.info("========================"+articleData.getCopyfrom());
	}
	
	@Transactional(readOnly = false)
	public String disable(String id) {
		Article article = get(id);
		String info = "";
		if(Global.ENABLE.equals(article.getDisable())){
			article.setDisable(Global.DISABLE);
			info = "新闻禁用成功";
		} else {
			article.setDisable(Global.ENABLE);
			info = "新闻启用成功";
		}
		save(article);
		return info;
	}
    
	@Transactional(readOnly = false)
	public void sort(String sourceId, String destinationId) {
		Article articleSource = dao.get(sourceId);
		Article articleDestination = dao.get(destinationId);
		int temp = articleSource.getWeight();
		articleSource.setWeight(articleDestination.getWeight());
		articleDestination.setWeight(temp);
		dao.update(articleDestination);
		dao.update(articleSource);
		
	}
    
	@Transactional(readOnly = false)
	public String recommend(String id) {
		String info = "";
		Article article = get(id);
		if(ConstantConfig.RECOMMEND.equals(article.getPosid())){
			article.setPosid(ConstantConfig.DISRECOMMEND);
			info = "文章取消推荐成功";
		} else {
			article.setPosid(ConstantConfig.RECOMMEND);
			info = "文章推荐成功";
		}
		save(article);
		return info;
	}
	
	/*
	 * 前台service
	 * 
	 */
	
	public List<ArticleData> selecthotnews(ArticleData articleData) {
		return articleDataDao.selectHotNews(articleData);
	}
	
	public ArticleData selectclicknews(String name) {
		return articleDataDao.selectClickNews(name);
	}
	
	public List<ArticleData> selectnews(String name,PageBean pb) {
		Number count = articleDataDao.selectcount(name);
		pb.setTotalRecods(count.intValue());
		pb.setStart((pb.getPageCode()-1)*PageBean.DEFAULT_PAGESIZE);
		List<ArticleData> list= articleDataDao.selectIf(name,pb.getStart(),PageBean.DEFAULT_PAGESIZE);
		return list;
	}
	
	public List<Category> selectChannel (String name) {
		return categoryDao.selectChannel(name);
	}
	
	public List<Category> selectAllChannel() {
		// TODO Auto-generated method stub
		return categoryDao.selectAllChannel();
	}

	public List<Category> selectHotChannel(int index) {
		// TODO Auto-generated method stub
		return categoryDao.selectHotChannel(index);
	}
}
