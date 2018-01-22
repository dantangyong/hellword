package com.mht.define.portal.cms.entity;

import java.util.Date;

public class OaNotifyRecord {
    private String id;

    private String oaNotifyId;

    private String userId;

    private String readFlag;

    private Date readDate;
    
    

    @Override
	public String toString() {
		return "OaNotifyRecord [id=" + id + ", oaNotifyId=" + oaNotifyId + ", userId=" + userId + ", readFlag="
				+ readFlag + ", readDate=" + readDate + "]";
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOaNotifyId() {
        return oaNotifyId;
    }

    public void setOaNotifyId(String oaNotifyId) {
        this.oaNotifyId = oaNotifyId == null ? null : oaNotifyId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getReadFlag() {
        return readFlag;
    }

    public void setReadFlag(String readFlag) {
        this.readFlag = readFlag == null ? null : readFlag.trim();
    }

    public Date getReadDate() {
        return readDate;
    }

    public void setReadDate(Date readDate) {
        this.readDate = readDate;
    }
}