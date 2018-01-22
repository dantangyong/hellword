package com.mht.define.portal.cms.entity;

import java.util.List;


public class PageBean<T> {
	/*
	 * 默认页码
	 */
	public static final int DEFAULT_PAGECODE = 1;
	/*
	 * 默认展示页码量
	 */
	public static final int DEFAULT_SHOWPAGE = 8;
	/*
	 * 默认每页展示信息量
	 */
	public static final int DEFAULT_PAGESIZE = 10;
	/*
	 * 默认每页展示信息量
	 */
	public static final int VIDEO_DEFAULT_PAGESIZE = 15;
	/*
	 *显式零
	 */
	public static final int DEFAULT_ZERO = 0;
	/*
	 *默认通知公告显示数量
	 */
	public static final int DEFAULT_NOTISE_PAGESIZE = 8;
	private int pageCode;
	private int pageSize;
	private List<T> beanlist;
	private int totalRecods;
	private int totalPage;
	private String url;
	private String name;
	private int Start;
	private int begin;
	private int end;
	
	public int getBegin() {
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getStart() {
		return Start;
	}
	public void setStart(int start) {
		Start = start;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<T> getBeanlist() {
		return beanlist;
	}
	public void setBeanlist(List<T> beanlist) {
		this.beanlist = beanlist;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalPage() {
		int totalPage = this.totalRecods/pageSize;
		if(totalRecods%pageSize!=0){
			totalPage++;
		}
		return totalPage;
	}
	public int getPageCode() {
		return pageCode;
	}
	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalRecods() {
		return totalRecods;
	}
	public void setTotalRecods(int totalRecods) {
		this.totalRecods = totalRecods;
	}
	
	//传入当前pageCode，设置便利页码(page(当前页码)，size(显示页码数量))
	public void setBeginAndEnd(int page,int size){
		int total = getTotalPage();
		if(size>total){size=total;}
		if(size<1){size=1; }
		if((page-size/2-1)<=0){
			setBegin(1);
			setEnd(size);
		}else if((page+(size-size/2))>=total){
			setEnd(total);
			setBegin(total-size+1);
		}else{
			setBegin(page-size/2);
			setEnd(page+(size-size/2));
		}
	}
}

