package com.mht.plugin.host.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.google.gson.Gson;
import com.mht.common.json.AjaxJson;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;

public class SessionInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            Object handler) throws Exception {
        User currentUser = UserUtils.getUser();
        // 判断session是否存在
        if (currentUser == null || currentUser.getId() == null || "".equals(currentUser.getId())) {
            // 判断请求是否为ajax
            String requestType = httpServletRequest.getHeader("X-Requested-With");
            String accept = httpServletRequest.getHeader("Accept");
            if (requestType != null && requestType.toLowerCase().equals("xmlhttprequest") && accept != null
                    && accept.contains("application/json")) {
                String contentType = "application/json;charset=UTF-8";
                AjaxJson aj = new AjaxJson();
                aj.setCode("0302");
                aj.setMsg("未登录或会话失效");
                httpServletResponse.reset();
                httpServletResponse.setContentType(contentType);
                httpServletResponse.setCharacterEncoding("UTF-8");
                httpServletResponse.getWriter().write(new Gson().toJson(aj));// 返回json对象
                httpServletResponse.getWriter().flush();
                httpServletResponse.getWriter().close();
                // httpServletResponse.sendRedirect("/");
                return false;
            } else {
                return true;
            }

        } else {
            return true;
        }
    }

}