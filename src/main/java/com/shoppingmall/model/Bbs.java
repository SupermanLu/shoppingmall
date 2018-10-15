package com.shoppingmall.model;

public class Bbs {
    private String bbsid;

    private String cid;

    private String email;

    private String bbstype;

    private String subject;

    private String bbscontent;

    private String bbstime;

    private String status;

    public String getBbsid() {
        return bbsid;
    }

    public void setBbsid(String bbsid) {
        this.bbsid = bbsid == null ? null : bbsid.trim();
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid == null ? null : cid.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getBbstype() {
        return bbstype;
    }

    public void setBbstype(String bbstype) {
        this.bbstype = bbstype == null ? null : bbstype.trim();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public String getBbscontent() {
        return bbscontent;
    }

    public void setBbscontent(String bbscontent) {
        this.bbscontent = bbscontent == null ? null : bbscontent.trim();
    }

    public String getBbstime() {
        return bbstime;
    }

    public void setBbstime(String bbstime) {
        this.bbstime = bbstime == null ? null : bbstime.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
    
    // Õ®”√
 	private int limit;

 	private int offset;

 	private String search;

 	public int getLimit() {
 		return limit;
 	}

 	public void setLimit(int limit) {
 		this.limit = limit;
 	}

 	public int getOffset() {
 		return offset;
 	}

 	public void setOffset(int offset) {
 		this.offset = offset;
 	}

 	public String getSearch() {
 		return search;
 	}

 	public void setSearch(String search) {
 		this.search = search;
 	}
 	
    private String customname;

	public String getCustomname() {
		return customname;
	}

	public void setCustomname(String customname) {
		this.customname = customname;
	}
}