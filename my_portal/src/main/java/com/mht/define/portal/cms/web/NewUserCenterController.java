package com.mht.define.portal.cms.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mht.common.json.AjaxJson;
import com.mht.common.utils.StringUtils;
import com.mht.define.portal.cms.entity.SysUser;
import com.mht.define.portal.cms.entity.UserContent;
import com.mht.define.portal.cms.entity.UserContentDate;
import com.mht.define.portal.cms.service.NewUserCenterService;
import com.mht.modules.account.service.CommonService;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.service.SystemService;
import com.mht.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/cms/usercenter")
public class NewUserCenterController {
    @Autowired
    private NewUserCenterService nucService;
    SysUser user = new SysUser();

    @Autowired
    private SystemService systemService;

    @RequestMapping(value = "")
    public ModelAndView clazz(ModelAndView mav, String name, HttpServletRequest req) {
        // user = nucService.selectByPrimaryKey(UserUtils.getUser().getId());
        // mav.addObject("user", user);
        // mav.addObject("date", new SimpleDateFormat("yyyy-MM-dd").format(new
        // Date()));
        User currentUser = UserUtils.getUser();
        mav.addObject("loginName", currentUser.getLoginName());
        mav.setViewName("/define/portal/cms/user/userCenter");
        return mav;
    }

    @ResponseBody()
    @RequestMapping(value = "modifyPwd")
    public AjaxJson modifyPwd(String oldPwd, String newPwd) {
        AjaxJson aj = new AjaxJson();
        User user = UserUtils.getUser();
        if (StringUtils.isNotBlank(oldPwd) && StringUtils.isNotBlank(newPwd)) {

            String old = CommonService.encryption(oldPwd);
            if (old.equals(user.getPassword())) {
                systemService.updatePasswordById(user.getId(), user.getLoginName(), newPwd);
                aj.setCode("0");
                aj.setMsg("修改密码成功");
            } else {
                aj.setCode("1");
                aj.setMsg("修改密码失败，旧密码错误");
            }
        } else {
            aj.setCode("2");
            aj.setMsg("密码为空");
        }
        return aj;
    }

    @RequestMapping(value = "UserCenterSeleteAllCalendar")
    public ModelAndView Calendar(ModelAndView mav) {
        mav.setViewName("/define/portal/cms/infoUsercenter");
        List<UserContent> list = nucService.selectContentByPrimeryKey(UserUtils.getUser().getId());
        List<UserContentDate> list01 = nucService.changeDate(list);
        mav.addObject("content", list01);
        mav.addObject("user", user);
        mav.addObject("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        return mav;
    }

    @RequestMapping(value = "UserCenterInsertCalendarByPrimeryEntity")
    public ModelAndView InsertContent(ModelAndView mav, UserContent content) {
        content.setId(UUID.randomUUID().toString().replace("-", ""));
        content.setUserId(UserUtils.getUser().getId());
        System.out.println(content);
        mav.setViewName("/define/portal/cms/infoUsercenter");
        mav.addObject("user", user);
        mav.addObject("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        nucService.InsertContent(content);
        List<UserContent> list = nucService.selectContentByPrimeryKey(UserUtils.getUser().getId());
        mav.addObject("content", list);
        return mav;

    }

    @RequestMapping(value = "UserCenterDeleteCalendarByPrimeryKey")
    public ModelAndView DeleteContent(ModelAndView mav, String id) {
        mav.setViewName("/define/portal/cms/infoUsercenter");
        mav.addObject("user", user);
        mav.addObject("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        nucService.DeleteByPrimeryKey(id);
        List<UserContent> list = nucService.selectContentByPrimeryKey(UserUtils.getUser().getId());
        mav.addObject("content", list);
        return mav;
    }

}
