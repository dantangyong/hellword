package com.mht.define.portal.cms.entity;

import java.util.List;

/**
 * @ClassName: AppUserRecordList
 * @Description: 统计显示数据
 * @author com.mhout.dty
 * @date 2017年12月18日 下午5:10:53
 * @version 1.0.0
 */
public class AppBlocksUserRecordList {

	private List<Integer> count;
	private List<String> value;
	private List<AppBlocksUserRecordData> list;

	public List<Integer> getCount() {
		return count;
	}

	public void setCount(List<Integer> count) {
		this.count = count;
	}

	public List<String> getValue() {
		return value;
	}

	public void setValue(List<String> value) {
		this.value = value;
	}

	public List<AppBlocksUserRecordData> getList() {
		return list;
	}

	public void setList(List<AppBlocksUserRecordData> list) {
		this.list = list;
	}
	

}
