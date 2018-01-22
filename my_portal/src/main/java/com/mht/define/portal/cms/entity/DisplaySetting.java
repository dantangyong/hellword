package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;

/**
 * 显示设置
 * 
 * @author 王杰
 * @version 2017-5-12
 *
 */
public class DisplaySetting extends DataEntity<DisplaySetting> {

	private static final long serialVersionUID = 1L;
	private String systemName; // 系统名称
	private String logo; // 系统logo
	private String carousel; // 轮播图
	private int frequency; // 轮播频率
	private String theme; // 系统主题，多个主题以‘，’区分

	public String getSystemName() {
		return systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getCarousel() {
		return carousel;
	}

	public void setCarousel(String carousel) {
		this.carousel = carousel;
	}

	public int getFrequency() {
		return frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

}
