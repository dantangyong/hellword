package com.mht.define.portal.cms.entity;

import java.util.Date;

public class UserContent {
    private String id;

    private String userId;

    private Date eventTime;

    private String eventContent;

    private String createBy;

    private Date createDate;

    private String remarks;
    
    

    @Override
	public String toString() {
		return "UserContent [id=" + id + ", userId=" + userId + ", eventTime=" + eventTime + ", eventContent="
				+ eventContent + ", createBy=" + createBy + ", createDate=" + createDate + ", remarks=" + remarks + "]";
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Date getEventTime() {
        return eventTime;
    }

    public void setEventTime(Date eventTime) {
        this.eventTime = eventTime;
    }

    public String getEventContent() {
        return eventContent;
    }

    public void setEventContent(String eventContent) {
        this.eventContent = eventContent == null ? null : eventContent.trim();
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }
}