/**
 * Copyright &copy; 2015-2020 <a href="http://www.mht.org/">mht</a> All rights reserved.
 */
package com.mht.define.portal.cms.entity;

import org.hibernate.validator.constraints.Length;

import com.mht.common.persistence.DataEntity;
import com.mht.common.utils.excel.annotation.ExcelField;
import com.mht.define.portal.cms.utils.ConstantConfig;

/**
 * 视频Entity
 * @author 王杰
 * @version 2017-07-25
 */
public class CmsVideo extends DataEntity<CmsVideo> {
	
	private static final long serialVersionUID = 1L;
	private Integer sort;//排序 
	private String videoUrl;		// 视频路径
	private String videoPriority;	// 视频优先级
	private String videoName;		// 视频名称
	private String videoImage;		// 视频封面图
	private String videoSource;     // 视频来源
	private String disable;         // 是否禁用（1：启用；2：禁用）
	private CmsVideoType videoType; // 视频类型
	private String videoDetail;     // 视频详情
	private String videoUrlTemp;    // 视频外部链接
	private String videoUrlCache;   // 视频本地上传
	private Integer hits;	// 点击数
	
	public CmsVideo() {
		super();
		this.hits = 0;
	}

	public CmsVideo(String id){
		super(id);
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getVideoUrlCache() {
		return videoUrlCache;
	}

	public void setVideoUrlCache(String videoUrlCache) {
		this.videoUrlCache = videoUrlCache;
	}

	public String getVideoUrlTemp() {
		return videoUrlTemp;
	}

	public void setVideoUrlTemp(String videoUrlTemp) {
		this.videoUrlTemp = videoUrlTemp;
	}

	public String getVideoSource() {
		return videoSource;
	}

	public void setVideoSource(String videoSource) {
		this.videoSource = videoSource;
	}

	@ExcelField(title="视频路径", align=2, sort=7)
	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	
	@ExcelField(title="视频优先级", align=2, sort=8)
	public String getVideoPriority() {
		return videoPriority;
	}

	public void setVideoPriority(String videoPriority) {
		this.videoPriority = videoPriority;
	}
	
	@Length(min=0, max=64, message="视频名称长度必须介于 0 和 64 之间")
	@ExcelField(title="视频名称", align=2, sort=9)
	public String getVideoName() {
		return videoName;
	}

	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}
	
	@ExcelField(title="视频封面图", align=2, sort=10)
	public String getVideoImage() {
		return videoImage;
	}

	public void setVideoImage(String videoImage) {
		this.videoImage = videoImage;
	}

	public String getDisable() {
		return disable;
	}

	public void setDisable(String disable) {
		this.disable = disable;
	}

	public CmsVideoType getVideoType() {
		return videoType;
	}

	public void setVideoType(CmsVideoType videoType) {
		this.videoType = videoType;
	}

	public String getVideoDetail() {
		return videoDetail;
	}

	public void setVideoDetail(String videoDetail) {
		this.videoDetail = videoDetail;
	}

	public Integer getHits() {
		return hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}
	
	
}