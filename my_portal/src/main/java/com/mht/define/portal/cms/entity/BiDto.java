package com.mht.define.portal.cms.entity;

import java.util.List;

public class BiDto {

	private String name; // 类别名称
	private List<DashboardBoard> boards; // 看板集合
	
	public BiDto(String name, List<DashboardBoard> boards) {
		super();
		this.name = name;
		this.boards = boards;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<DashboardBoard> getBoards() {
		return boards;
	}
	public void setBoards(List<DashboardBoard> boards) {
		this.boards = boards;
	}
	
	
}
