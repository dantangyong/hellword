package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

/**
 * 底部标签管理
 * @ClassName: TagManage
 * @Description: 
 * @author wangjie
 * @date 2017年8月4日 下午4:13:46 
 * @version 1.0.0
 */
public class TagManage extends DataEntity<TagManage>{

	private static final long serialVersionUID = 1L;

	private String logoUrl; // logo路径
	private String logoAble; // logo禁用状态
	private String edition; // 版本内容
	private String contactWays; // 联系方式
	private String editionAble; // 版本禁用状态
	private String cooperator; // 合作单位
	private String cooperatorAble; // 合作单位禁用状态
	private String link; // 常用链接
	private String linkAble; // 常用链接禁用状态
	public String getLogoUrl() {
		return logoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
	public String getLogoAble() {
		return logoAble;
	}
	public void setLogoAble(String logoAble) {
		this.logoAble = logoAble;
	}
	public String getEdition() {
		return edition;
	}
	public void setEdition(String edition) {
		this.edition = edition;
	}
	public String getEditionAble() {
		return editionAble;
	}
	public void setEditionAble(String editionAble) {
		this.editionAble = editionAble;
	}
	public String getCooperator() {
		return cooperator;
	}
	public void setCooperator(String cooperator) {
		this.cooperator = cooperator;
	}
	public String getCooperatorAble() {
		return cooperatorAble;
	}
	public void setCooperatorAble(String cooperatorAble) {
		this.cooperatorAble = cooperatorAble;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getLinkAble() {
		return linkAble;
	}
	public void setLinkAble(String linkAble) {
		this.linkAble = linkAble;
	}
	public String getContactWays() {
		return contactWays;
	}
	public void setContactWays(String contactWays) {
		this.contactWays = contactWays;
	}
	
	
}
