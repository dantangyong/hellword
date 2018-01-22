package com.mht.plugin.host.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.mht.common.json.AjaxJson;
import com.mht.common.json.ZTreeDto;
import com.mht.common.utils.StringUtils;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;
import com.mht.plugin.common.license.LicenseUtil;
import com.mht.plugin.common.pluginfo.PluginAuthority;
import com.mht.plugin.common.pluginfo.PluginBase;
import com.mht.plugin.common.pluginfo.PluginInfo;
import com.mht.plugin.common.pluginfo.PluginManager;
import com.mht.plugin.host.dao.AuthorityDao;
import com.mht.plugin.host.service.AuthorityService;

/**
 * @ClassName: PluginsController
 * @Description: 插件管理控制器
 * @author com.mhout.sx
 * @date 2017年8月31日 下午2:31:25
 * @version 1.0.0
 */
@RestController
@RequestMapping("${adminPath}/plugin/host/plugins/api")
public class PluginsApiController {

    @Autowired
    private AuthorityService authorityService;

    @Autowired
    private AuthorityDao authorityDao;

    public static final String INTO_ICON = "/static/user/images/redo.png";

    /**
     * @Title: testDataSource
     * @Description: TODO插件数据源测试
     * @param jdbcUrl
     * @param driverClassName
     * @param username
     * @param password
     * @return
     * @author com.mhout.sx
     * @throws SQLException
     */
    @RequestMapping(value = "/testDataSource")
    public AjaxJson testDataSource(@RequestParam(required = true) String jdbcUrl,
            @RequestParam(required = true) String driverClassName, @RequestParam(required = true) String username,
            @RequestParam(required = true) String password) {
        AjaxJson aj = new AjaxJson();
        Connection conn = null;
        username = HtmlUtils.htmlUnescape(username);
        password = HtmlUtils.htmlUnescape(password);
        try {
            Class.forName(driverClassName);
            conn = (Connection) DriverManager.getConnection(jdbcUrl, username, password);

            aj.setCode("0");
            aj.setMsg("连接测试成功！");
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setMsg("-1");
            aj.setMsg("驱动类错误：" + e.getMessage());
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setMsg("-2");
            aj.setMsg("连接错误：" + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
        return aj;
    }

    /**
     * @Title: validateLicense 验证证书
     * @Description: TODO
     * @param code
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/validateLicense")
    public AjaxJson validateLicense(@RequestParam(required = true) String code) {
        AjaxJson aj = new AjaxJson();
        PluginInfo pi = PluginManager.getPluginInfoByCode(code);
        if (pi.isLicense()) {
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
        return aj;
    }

    /**
     * @Title: getPlugins
     * @Description: TODO 获取插件列表
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/getPlugins")
    public List<PluginInfo> getPlugins() {
        return PluginManager.getPluginInfos();
    }

    /**
     * @Title: getUserPlugins
     * @Description: TODO 获取用户拥有的插件
     * @return
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/getUserPlugins")
    public List<PluginInfo> getUserPlugins() throws InstantiationException, IllegalAccessException {
        User currentUser = UserUtils.getUser();
        List<PluginAuthority> ownPlugin = authorityService.getUserPlugins(currentUser.getId());
        List<PluginInfo> list = new ArrayList<PluginInfo>();
        for (PluginAuthority pa : ownPlugin) {
            PluginInfo pi = PluginManager.providers.get(pa.getName());
            if (pi != null) {
                list.add(pi);
            }
        }
        return list;
    }

    /**
     * @Title: getUserAuthByPlugin
     * @Description: TODO 用户拥有的某个插件的权限
     * @param code
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/getUserAuthByPlugin")
    public List<PluginAuthority> getUserAuthByPlugin(@RequestParam(required = true) String code) {
        User currentUser = UserUtils.getUser();
        return authorityService.getUserAuthByPlugin(currentUser.getId(), code);
    }

    /**
     * @Title: getPluginAuthority
     * @Description: TODO 获取插件所有的权限
     * @param name
     * @return
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/getPluginAuthority")
    public AjaxJson getPluginAuthority(@RequestParam(required = true) String name) {
        AjaxJson aj = new AjaxJson();
        try {
            PluginBase plugin = PluginManager.getPlugin(name);
            aj.setCode("0");
            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("auth", plugin.getPluginAuthority());
            aj.setBody(map);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setCode("-1");
            aj.setMsg("获取权限失败");
            aj.setSub_msg(e.getMessage());
        }
        return aj;

    }

    /**
     * @Title: createSQL
     * @Description: TODO 创建数据库
     * @param name
     * @return
     * @author com.mhout.sx
     */
    @RequiresPermissions("plugin:host:plugins:createSQL")
    @RequestMapping(value = "/createSQL")
    public AjaxJson createSQL(@RequestParam(required = true) String name) {
        AjaxJson aj = new AjaxJson();
        try {
            PluginBase plugin = PluginManager.getPlugin(name);
            // plugin.setDataSourcePlugin(dataSourcePlugin);
            plugin.createSQL();
            aj.setCode("0");
            aj.setMsg("执行创建sql成功");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setCode("-1");
            aj.setMsg("执行sql失败");
            aj.setSub_msg(e.getMessage());
        }
        return aj;
    }

    /**
     * @Title: dropSQL
     * @Description: TODO 删除数据库
     * @param name
     * @return
     * @author com.mhout.sx
     */
    @RequiresPermissions("plugin:host:plugins:dropSQL")
    @RequestMapping(value = "/dropSQL")
    public AjaxJson dropSQL(@RequestParam(required = true) String name) {
        AjaxJson aj = new AjaxJson();
        try {
            PluginBase plugin = PluginManager.getPlugin(name);
            // plugin.setDataSourcePlugin(dataSourcePlugin);
            plugin.dropSQL();
            aj.setCode("0");
            aj.setMsg("执行删除sql成功");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            aj.setCode("-1");
            aj.setMsg("执行sql失败");
            aj.setSub_msg(e.getMessage());
        }
        return aj;
    }

    /**
     * @Title: authorityTreeData
     * @Description: TODO 获取所有插件的所有权限，并选中角色已拥有的权限
     * @param id
     * @return
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/authorityTreeData")
    public List<ZTreeDto> authorityTreeData(@RequestParam(required = true) String id, HttpServletRequest request)
            throws InstantiationException, IllegalAccessException {
        // 获取角色拥有的权限
        // User currentUser = UserUtils.getUser();
        List<PluginAuthority> ownList = authorityService.getRoleAuth(id);
        String path = request.getContextPath();
        List<PluginInfo> list = PluginManager.getPluginInfos();
        List<ZTreeDto> tree = new ArrayList<ZTreeDto>();
        for (PluginInfo pi : list) {// 获取插件权限
            PluginBase plugin = PluginManager.getPlugin(pi.getName());
            PluginAuthority pa = plugin.getPluginAuthority();
            tree.add(pluginAuthorityToZTreeDto(pa, ownList, path));
        }
        // tree.add(new ZTreeDto());
        return tree;
    }

    /**
     * @Title: saveAuth
     * @Description: TODO 保存角色与插件权限的对应关系
     * @param id：角色id
     * @param authStr：权限json字符串
     * @return
     * @throws JsonParseException
     * @throws JsonMappingException
     * @throws IOException
     * @author com.mhout.sx
     */
    @RequestMapping(value = "/saveAuth")
    public AjaxJson saveAuth(@RequestParam(required = true) String id, @RequestParam(required = true) String authStr)
            throws JsonParseException, JsonMappingException, IOException {
        authorityService.saveAuth(id, authStr);
        AjaxJson aj = new AjaxJson();
        aj.setCode("0");
        aj.setMsg("保存权限成功");
        return aj;
    }

    /**
     * @Title: pluginAuthorityToZTreeDto
     * @Description: TODO 将PluginAuthority对象转换为ZTreeDto对象供前台显示
     * @param pa：插件的权限
     * @param ownList：角色已拥有的权限
     * @return
     * @author com.mhout.sx
     */
    private ZTreeDto pluginAuthorityToZTreeDto(PluginAuthority pa, List<PluginAuthority> ownList, String path) {
        ZTreeDto zt = new ZTreeDto();
        zt.setName(pa.getName());
        zt.setObj(clearPluginAuthority(pa));
        zt.setOpen(false);
        zt.setNocheck(false);
        zt.setChkDisabled(false);
        zt.setChecked(checkRoleAuth(pa, ownList));
        List<PluginAuthority> pageList = pa.getChildren();
        if (pageList != null && pageList.size() != 0) {
            List<ZTreeDto> pageTree = new ArrayList<ZTreeDto>();
            for (PluginAuthority pageAuthority : pageList) {
                ZTreeDto pageZT = new ZTreeDto();
                pageZT.setName(pageAuthority.getName());
                pageZT.setObj(clearPluginAuthority(pageAuthority));
                pageZT.setOpen(true);
                pageZT.setNocheck(false);
                pageZT.setChkDisabled(false);
                pageZT.setChecked(checkRoleAuth(pageAuthority, ownList));
                if (pageAuthority.isHome()) {
                    pageZT.setIcon(path + INTO_ICON);
                }
                List<PluginAuthority> buttonList = pageAuthority.getChildren();
                if (buttonList != null && buttonList.size() != 0) {
                    List<ZTreeDto> buttonTree = new ArrayList<ZTreeDto>();
                    for (PluginAuthority buttonAuthority : buttonList) {
                        ZTreeDto buttonZT = new ZTreeDto();
                        buttonZT.setName(buttonAuthority.getName());
                        buttonZT.setObj(clearPluginAuthority(buttonAuthority));
                        buttonZT.setIsParent(false);
                        buttonZT.setNocheck(false);
                        buttonZT.setChkDisabled(false);
                        buttonZT.setChecked(checkRoleAuth(buttonAuthority, ownList));
                        buttonTree.add(buttonZT);
                    }
                    pageZT.setChildren(buttonTree);
                } else {
                    pageZT.setIsParent(false);
                }
                pageTree.add(pageZT);
            }
            zt.setChildren(pageTree);
        }
        return zt;
    }

    /**
     * @Title: checkRoleAuth
     * @Description: TODO 检查是否拥有该权限
     * @param pa
     * @param ownList
     * @return
     * @author com.mhout.sx
     */
    private boolean checkRoleAuth(PluginAuthority pa, List<PluginAuthority> ownList) {
        // TODO Auto-generated method stub
        for (PluginAuthority ownpa : ownList) {
            if (ownpa.getCode().equals(pa.getCode())) {
                return true;
            }
        }
        return false;
    }

    /**
     * @Title: clearPluginAuthority
     * @Description: TODO 清除ztree节点不需要的数据
     * @param pa
     * @return
     * @author com.mhout.sx
     */
    private PluginAuthority clearPluginAuthority(PluginAuthority pa) {
        PluginAuthority obj = new PluginAuthority();
        obj.setCode(pa.getCode());
        obj.setName(pa.getName());
        obj.setPage(pa.getPage());
        obj.setPlugin(pa.getPlugin());
        obj.setType(pa.getType());
        obj.setHome(pa.isHome());
        return obj;
    }

}
