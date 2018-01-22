package com.mht.define.portal.cms.entity;

import java.util.Date;

public class UserContentDate {
	private String id;

    private String userId;

    private String eventTimeY;
    
    private String eventTimeM;

    private String eventContent;

    private String createBy;

    private Date createDate;

    private String remarks;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getEventTimeY() {
		return eventTimeY;
	}

	public void setEventTimeY(String eventTimeY) {
		this.eventTimeY = eventTimeY;
	}

	public String getEventTimeM() {
		return eventTimeM;
	}

	public void setEventTimeM(String eventTimeM) {
		this.eventTimeM = eventTimeM;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
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
		this.remarks = remarks;
	}
    
    
    
}
