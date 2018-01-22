package com.mht.plugin.host.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.google.gson.Gson;
import com.mht.common.json.AjaxJson;
import com.mht.common.utils.StringUtils;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;
import com.mht.plugin.common.license.LicenseUtil;
import com.mht.plugin.common.pluginfo.PluginInfo;
import com.mht.plugin.common.pluginfo.PluginManager;
import com.mht.plugin.host.dao.AuthorityDao;

/**
 * @ClassName: LicenseInterceptor
 * @Description: 证书验证拦截器
 * @author com.mhout.sx
 * @date 2017年10月11日 下午2:11:20
 * @version 1.0.0
 */
public class LicenseInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private AuthorityDao authorityDao;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            Object handler) throws Exception {
        User currentUser = UserUtils.getUser();
        String code = httpServletRequest.getParameter("code_license");

        if (StringUtils.isNotBlank(code)) {
            PluginInfo pi = PluginManager.getPluginInfoByCode(code);
            AjaxJson aj = new AjaxJson();
            if (pi.isLicense()) {// 是否需要证书
                String license = authorityDao.getLicenseByCode(code);
                if (StringUtils.isNotBlank(license)) {
                    aj = LicenseUtil.verifyLicense(license, code);
                } else {
                    aj.setCode("5");
                    aj.setMsg("该插件缺少有效证书！");
                }
            } else {
                aj.setCode("0");
                aj.setMsg("该插件不需要证书！");
            }
            if ("0".equals(aj.getCode())) {
                return true;
            } else {
                aj.setCode("0303");
                String contentType = "application/json;charset=UTF-8";
                httpServletResponse.reset();
                httpServletResponse.setContentType(contentType);
                httpServletResponse.setCharacterEncoding("UTF-8");
                httpServletResponse.getWriter().write(new Gson().toJson(aj));// 返回json对象
                httpServletResponse.getWriter().flush();
                httpServletResponse.getWriter().close();
                // httpServletResponse.sendRedirect("/");
                return false;
            }
        } else {
            return true;
        }

    }

}