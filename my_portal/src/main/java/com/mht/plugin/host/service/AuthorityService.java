package com.mht.plugin.host.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mht.common.json.AjaxJson;
import com.mht.common.persistence.Page;
import com.mht.common.utils.IdGen;
import com.mht.modules.sys.entity.User;
import com.mht.modules.sys.utils.UserUtils;
import com.mht.plugin.common.license.LicenseUtil;
import com.mht.plugin.common.pluginfo.PluginAuthority;
import com.mht.plugin.common.pluginfo.PluginInfo;
import com.mht.plugin.common.pluginfo.PluginManager;
import com.mht.plugin.host.dao.AuthorityDao;
import com.mht.plugin.host.entity.LicenseInfo;

@Repository
@Transactional(readOnly = true)
public class AuthorityService {

    @Autowired
    private AuthorityDao authorityDao;

    /**
     * @Title: saveAuth
     * @Description: TODO 保存角色与权限的对应
     * @param id
     * @param authStr
     * @throws JsonParseException
     * @throws JsonMappingException
     * @throws IOException
     * @author com.mhout.sx
     */
    @Transactional(readOnly = false)
    public void saveAuth(String id, String authStr) throws JsonParseException, JsonMappingException, IOException {
        // TODO Auto-generated method stub
        // json转对象
        ObjectMapper jacksonMapper = new ObjectMapper();
        JavaType javaType = null;
        javaType = jacksonMapper.getTypeFactory().constructParametricType(List.class, PluginAuthority.class);
        List<PluginAuthority> pas = jacksonMapper.readValue(authStr, javaType);

        // 删除原有权限
        authorityDao.deleteByRole(id);

        // 插入新的权限
        for (PluginAuthority pa : pas) {
            authorityDao.save(id, pa.getCode(), pa.getName(), pa.getPage(), pa.getPlugin(), pa.getType());
        }

    }

    /**
     * @Title: getUserAuth
     * @Description: TODO 获取用户拥有的权限
     * @param id
     * @return
     * @author com.mhout.sx
     */
    public List<PluginAuthority> getUserAuth(String id) {
        // TODO Auto-generated method stub
        return authorityDao.getUserAuth(id);
    }

    /**
     * @Title: getRoleAuth
     * @Description: TODO 获取角色拥有的权限
     * @param id
     * @return
     * @author com.mhout.sx
     */
    public List<PluginAuthority> getRoleAuth(String id) {
        // TODO Auto-generated method stub
        return authorityDao.getRoleAuth(id);
    }

    /**
     * @Title: getUserPlugins
     * @Description: TODO 获取用户可以访问的插件
     * @param id
     * @return
     * @author com.mhout.sx
     */
    public List<PluginAuthority> getUserPlugins(String id) {
        // TODO Auto-generated method stub
        return authorityDao.getUserPlugins(id);
    }

    /**
     * @Title: getUserAuthByPlugin
     * @Description: TODO 获取用户拥有的某个插件权限
     * @param id
     * @param code
     * @return
     * @author com.mhout.sx
     */
    public List<PluginAuthority> getUserAuthByPlugin(String id, String code) {
        // TODO Auto-generated method stub
        return authorityDao.getUserAuthByPlugin(id, code);
    }

    /**
     * @Title: saveLicense
     * @Description: TODO 保存证书
     * @param code
     * @param license
     * @author com.mhout.sx
     */
    @Transactional(readOnly = false)
    public void saveLicense(String code, String license) {
        User currentUser = UserUtils.getUser();
        authorityDao.disableLicense(code);
        authorityDao.saveLicense(IdGen.uuid(), code, license, currentUser.getId(), new Date());
    }

    /**
     * @Title: findLicense
     * @Description: TODO 分页查询证书
     * @param page
     * @param licenseInfo
     * @return
     * @author com.mhout.sx
     * @throws Exception
     */
    public Page<LicenseInfo> findLicense(Page<LicenseInfo> page, LicenseInfo licenseInfo) throws Exception {
        // TODO Auto-generated method stub
        licenseInfo.setPage(page);
        List<LicenseInfo> list = authorityDao.findList(licenseInfo);
        for (LicenseInfo li : list) {
            PluginInfo pi = PluginManager.getPluginInfoByCode(li.getPluginCode());
            if (pi != null) {
                li.setPluginName(pi.getName());
            }
            AjaxJson aj = LicenseUtil.verifyLicense(li.getLicense(), li.getPluginCode());
            if ("0".equals(aj.getCode())) {
                if ("1".equals(li.getEnable())) {
                    li.setLicenseMsg(LicenseInfo.VALID);
                } else {
                    li.setLicenseMsg(LicenseInfo.INVALID2);
                }

                li.setPluginLicense(LicenseUtil.parserLicense(li.getLicense()));
            } else if ("2".equals(aj.getCode())) {
                li.setLicenseMsg(LicenseInfo.OVERDUE);
                li.setPluginLicense(LicenseUtil.parserLicense(li.getLicense()));
            } else {
                li.setLicenseMsg(LicenseInfo.INVALID);
            }
        }
        page.setList(list);
        return page;
    }

    /**
     * @Title: getLicenseNum
     * @Description: TODO 获取证书是否存在
     * @param license
     * @param code
     * @return
     * @author com.mhout.sx
     */
    public int getLicenseNum(String license, String code) {
        // TODO Auto-generated method stub
        return authorityDao.getLicenseNum(license, code);
    }

}
