package com.mht.define.portal.cms.web.front;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mht.common.web.BaseController;
import com.mht.common.web.Servlets;
import com.mht.modules.sys.entity.Log;
import com.mht.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.mht.modules.sys.utils.LogUtils;
import com.mht.modules.sys.utils.UserUtils;

/**
 * 门户退出
 * @author wj
 *
 */
@Controller
@RequestMapping(value = "${frontPath}/logout")
public class FrontLogoutController extends BaseController{

    /**
     * 管理登出
     * 
     * @throws IOException
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        Principal principal = UserUtils.getPrincipal();
        // 如果已经登录，则跳转到管理首页
        if (principal != null) {
            LogUtils.saveLog(Servlets.getRequest(), Log.TYPE_LOGOUT, "系统登出");
            UserUtils.clearCache(); 
            UserUtils.getSubject().logout();
        }
        request.getSession().invalidate();
        return "redirect:" + adminPath + "/backHomePage";
    }
}
