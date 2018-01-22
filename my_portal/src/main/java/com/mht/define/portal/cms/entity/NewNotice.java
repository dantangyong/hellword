package com.mht.define.portal.cms.entity;

import com.mht.common.persistence.DataEntity;
import com.mht.modules.sys.entity.Office;

public class NewNotice extends DataEntity<NewNotice> {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
    private String type;
    private String title;
    private String content;
    private String files;
    private String status;
    private Office office;  //部门id
    
    private boolean isSelf;		
    @Override
	public String toString() {
		return "OaNotify [id=" + id + ", type=" + type + ", title=" + title + ", content=" + content + ", files="
				+ files + ", status=" + status + ", createBy=" + createBy + ", createDate=" + createDate + ", updateBy="
				+ updateBy + ", updateDate=" + updateDate + ", remarks=" + remarks + ", delFlag=" + delFlag
				+ ", officeId=" + office.getId() + "]";
	}

     
	public boolean isSelf() {
		return isSelf;
	}


	public void setSelf(boolean isSelf) {
		this.isSelf = isSelf;
	}


	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getFiles() {
        return files;
    }

    public void setFiles(String files) {
        this.files = files == null ? null : files.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }


	public Office getOffice() {
		return office;
	}


	public void setOffice(Office office) {
		this.office = office;
	}


	

  
}