package com.mht.plugin.host.entity;

import com.mht.common.persistence.DataEntity;
import com.mht.plugin.common.license.PluginLicense;

public class LicenseInfo extends DataEntity<LicenseInfo> {
    private static final long serialVersionUID = 1L;
    public final static String INVALID = "证书无效";
    public final static String INVALID2 = "证书失效";
    public final static String OVERDUE = "证书过期";
    public final static String VALID = "证书有效";

    private String pluginCode;
    private String license;
    private String enable;
    private PluginLicense pluginLicense;
    private String licenseMsg;// 证书无效、证书过期、证书有效
    private String pluginName;

    public String getPluginCode() {
        return pluginCode;
    }

    public void setPluginCode(String pluginCode) {
        this.pluginCode = pluginCode;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable;
    }

    public PluginLicense getPluginLicense() {
        return pluginLicense;
    }

    public void setPluginLicense(PluginLicense pluginLicense) {
        this.pluginLicense = pluginLicense;
    }

    public String getLicenseMsg() {
        return licenseMsg;
    }

    public void setLicenseMsg(String licenseMsg) {
        this.licenseMsg = licenseMsg;
    }

    public String getPluginName() {
        return pluginName;
    }

    public void setPluginName(String pluginName) {
        this.pluginName = pluginName;
    }

}
