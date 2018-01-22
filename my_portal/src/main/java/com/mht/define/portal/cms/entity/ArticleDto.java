package com.mht.define.portal.cms.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ArticleDto {

	private String categoryName;// 分类编号
	private String title;	// 标题
	private String image;	// 文章图片
	private String keywords;// 关键字
	private String description;// 描述、摘要
	private String content;// 新闻内容
	private Integer weight;	// 权重，越大越靠前
	private Date weightDate;// 权重期限，超过期限，将weight设置为0
	private Integer hits;	// 点击数
	
	private String updateDate;	// 开始时间

	/**
	 * 详情页构造方法
	 * @param categoryName
	 * @param title
	 * @param image
	 * @param description
	 * @param beginDate
	 */
	public ArticleDto(Article article) {
		this.categoryName = article.getCategory().getName();
		this.title = article.getTitle();
		this.image = article.getImageSrc();
		this.description = article.getDescription();
		this.content = article.getArticleData().getContent();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		this.updateDate = format.format(article.getUpdateDate());
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	public Date getWeightDate() {
		return weightDate;
	}
	public void setWeightDate(Date weightDate) {
		this.weightDate = weightDate;
	}
	public Integer getHits() {
		return hits;
	}
	public void setHits(Integer hits) {
		this.hits = hits;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}
