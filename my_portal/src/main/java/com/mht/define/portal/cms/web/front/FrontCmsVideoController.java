package com.mht.define.portal.cms.web.front;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mht.common.config.Global;
import com.mht.common.persistence.Page;
import com.mht.common.utils.StringUtils;
import com.mht.common.web.BaseController;
import com.mht.define.portal.cms.entity.Article;
import com.mht.define.portal.cms.entity.Category;
import com.mht.define.portal.cms.entity.CmsBanner;
import com.mht.define.portal.cms.entity.CmsVideo;
import com.mht.define.portal.cms.entity.CmsVideoType;
import com.mht.define.portal.cms.entity.NewNotice;
import com.mht.define.portal.cms.entity.PageBean;
import com.mht.define.portal.cms.entity.Site;
import com.mht.define.portal.cms.service.CmsBannerService;
import com.mht.define.portal.cms.service.CmsVideoService;
import com.mht.define.portal.cms.service.CmsVideoTypeService;
import com.mht.define.portal.cms.utils.CmsUtils;
import com.mht.define.portal.cms.utils.ConstantConfig;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.LogUtils;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * 
 * @ClassName: CmsVideoController
 * @Description: 前台视频中心
 * @author wangjie
 * @date 2017年7月31日 下午4:08:58 
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${frontPath}/cms/video")
public class FrontCmsVideoController extends BaseController{

	@Autowired
	private CmsVideoService videoservice;
	@Autowired
	private CmsVideoTypeService videoTypeService;
	@Autowired
	private CmsBannerService bannerService;
	
	@ModelAttribute
	public CmsVideo get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return videoservice.get(id);
		}else{
			return new CmsVideo();
		}
	}
	
	/**
	 * 
	 * @Title: index 
	 * @Description: 视频中心
	 * @param model
	 * @param video
	 * @return String
	 * @author wangjie
	 */
	@RequestMapping(value = "")
	public String index(Model model, CmsVideo video) {
		if(video.getVideoType()==null){
			video.setVideoType(new CmsVideoType());
		}
		List<CmsVideo> videos = videoservice.selectList(video ,new PageBean<>());
		model.addAttribute("videos", videos);
		CmsVideoType videoType = new CmsVideoType();
		videoType.setDisable(Global.ENABLE);
		List<CmsVideoType> videoTypeList = videoTypeService.findList(videoType);
		  // 视频轮播的图片
        CmsBanner banner = new CmsBanner();
        banner.setDisable(Global.ENABLE);
        List<CmsBanner> banners = bannerService.getShowBanners(banner);
		model.addAttribute("videoTypeList", videoTypeList);
		model.addAttribute("pageTotal", Math.ceil((double)videoTypeList.size()/9));
		model.addAttribute("banners", banners);
		return "/define/portal/cms/videoCenter";
	}
	/**
	 * 
	 * @Title: selectAllVideo 
	 * @Description: 查询相关视频
	 * @param model
	 * @param video
	 * @return
	 * @author com.mhout.wzw
	 */
	@RequestMapping(value = "selectVideo")
	public String selectVideo(Model model, CmsVideo video,HttpServletRequest request, HttpServletResponse response) {
		String pageCode=PageBean.DEFAULT_PAGECODE+"";
		if("".equals(video.getVideoType())||video.getVideoType()==null){
			video.setVideoType(new CmsVideoType());
		}
		if("".equals(video.getCreateBy())||video.getCreateBy()==null){
			video.setCreateBy(new User());
		}
		CmsVideoType videoType = video.getVideoType();
		video.setDisable(Global.ENABLE);
		PageBean<CmsVideo> pb = new PageBean<>();
		pb.setPageCode(Integer.parseInt(pageCode));
		
		/**
		 * 热门搜索索引开始
		 */
		
		if(video.getVideoType().getTypeName()!=null&&"热门推荐".equals(video.getVideoType().getTypeName())){
			video.getVideoType().setTypeName("");
			List<CmsVideo> hotVideos = Lists.newArrayList();
			//sort=1按sort排序,sort=2按更新时间排序，sort=3按点击量排序
			/**
			 * 热门视频
			 */
			pb.setPageSize(-1);//no limit
			video.setSort(ConstantConfig.HITS);
			List<CmsVideo> list = videoservice.selectList(video,pb);
			/**
			 * 推荐视频
			 */
			pb.setPageSize(0);
			video.setSort(ConstantConfig.SORT);
			video.setVideoPriority(ConstantConfig.RECOMMEND);
			List<CmsVideo> recommendVideos = videoservice.selectList(video,pb);
            //解决重复的
			for(CmsVideo v:list){
				if (!recommendVideos.contains(v)){
					hotVideos.add(v);
				}
			}
			model.addAttribute("hotVideos", hotVideos);
			model.addAttribute("recommendVideos", recommendVideos);
			return "/define/portal/cms/hotContent";
		}
		if(video.getVideoType().getTypeName()==null||"".equals(video.getVideoType().getTypeName())){
			videoType.setTypeName("");
		}else{
			videoType.setTypeName(video.getVideoType().getTypeName());
			videoType =  videoTypeService.selectByName(videoType);
			video.getVideoType().setId(videoType.getId());
		}
		pb.setPageSize(PageBean.VIDEO_DEFAULT_PAGESIZE);
		video.setSort(ConstantConfig.SORT);
		List<CmsVideo> videos = videoservice.selectList(video,pb);
		model.addAttribute("videos", videos);
		model.addAttribute("page", pb);
		return "/define/portal/cms/videoContent";
	}
	
	
	/**
	 * 
	 * @Title: showVideo 
	 * @Description: 视频详情
	 * @param model
	 * @param video
	 * @return String
	 * @author wangjie
	 */
	@RequestMapping(value = "detail")
	public String detail(Model model, CmsVideo video) {
//		video.setVideoType(new CmsVideoType());
		List<CmsVideo> list = Lists.newArrayList();
		List<CmsVideo> hotList = Lists.newArrayList();
		
		PageBean<CmsVideo> pb = new PageBean<>();
		pb.setPageSize(0);
		video = videoservice.get(video.getId());
//		更新点击量
		videoservice.updateHitsAddOne(video.getId());
		
		CmsVideo hotVideo = new CmsVideo();
		hotVideo.setVideoType(video.getVideoType());
		hotVideo.setSort(1);
	    list = videoservice.selectList(hotVideo,pb);
	    List<CmsVideo> videoList = new ArrayList<>(list);
	    //去掉重复
	    if(videoList.contains(video)){
			videoList.remove(video);
		}
		if(list.size()<12){
			hotVideo.setVideoType(new CmsVideoType());
			hotList = videoservice.selectList(hotVideo,pb);
			for(CmsVideo v:hotList){
				if (!list.contains(v)){
					videoList.add(v);
				}
				if(videoList.size() >= 12){
					  break;
				  }
		   }
		}
		
		model.addAttribute("videoList", videoList);
		model.addAttribute("video", video);
		return "/define/portal/cms/playVideo";
	}
	@RequestMapping(value = "addVideo")
	public String addVideo(Model model, CmsVideo video,HttpServletRequest request, HttpServletResponse response) {
		String pageCode = request.getParameter("pageCode");
		if(pageCode==null||"".equals(pageCode)){
			pageCode=PageBean.DEFAULT_PAGECODE+"";
		}
		if("".equals(video.getVideoType())||video.getVideoType()==null){
			video.setVideoType(new CmsVideoType());
		}
		if("".equals(video.getCreateBy())||video.getCreateBy()==null){
			video.setCreateBy(new User());
		}
		CmsVideoType videoType = video.getVideoType();
//		video.setVideoType(videoType);
		if(video.getVideoType().getTypeName()==null||"".equals(video.getVideoType().getTypeName())){
			videoType.setTypeName("");
		}else{
			videoType.setTypeName(video.getVideoType().getTypeName());
			videoType =  videoTypeService.selectByName(videoType);
			if(videoType!=null){
				video.getVideoType().setId(videoType.getId());
			}
		}
		video.setDisable(String.valueOf( PageBean.DEFAULT_PAGECODE));
		PageBean<CmsVideo> pb = new PageBean<>();
		pb.setPageCode(Integer.parseInt(pageCode)+1);
		pb.setPageSize(PageBean.VIDEO_DEFAULT_PAGESIZE);
		List<CmsVideo> videos = videoservice.selectList(video,pb);
		model.addAttribute("page", pb);
		model.addAttribute("videos", videos);
		return "/define/portal/cms/addVideoList";
	}

}
