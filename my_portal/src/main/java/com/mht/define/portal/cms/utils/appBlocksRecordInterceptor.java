package com.mht.define.portal.cms.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mht.define.portal.cms.entity.FrontApp;
import com.mht.define.portal.cms.entity.SysOffice;
import com.mht.define.portal.cms.service.AppBlocksUserRecordService;
import com.mht.define.portal.cms.service.FrontAppService;

public class appBlocksRecordInterceptor extends HandlerInterceptorAdapter {
    
	@Autowired
	private AppBlocksUserRecordService appBlocksUserRecordService;
	
	@Autowired
	private FrontAppService frontAppService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String path = request.getRequestURI() ;
		//根据app_url查出id
		FrontApp frontApp = frontAppService.getByAPPUrl(path);
		if(frontApp != null){
			appBlocksUserRecordService.record(frontApp);
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
    
}
