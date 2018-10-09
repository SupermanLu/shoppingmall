package com.shoppingmall.model;

public class Comment {
    private String commentid;

    private String pid;

    private String customid;

    private String oid;

    private Integer level;

    private String notetype;

    private String replytype;

    private String useremail;

    private String subject;

    private String comment;

    private String status;

    private String commentdate;

    public String getCommentid() {
        return commentid;
    }

    public void setCommentid(String commentid) {
        this.commentid = commentid == null ? null : commentid.trim();
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public String getCustomid() {
        return customid;
    }

    public void setCustomid(String customid) {
        this.customid = customid == null ? null : customid.trim();
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid == null ? null : oid.trim();
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getNotetype() {
        return notetype;
    }

    public void setNotetype(String notetype) {
        this.notetype = notetype == null ? null : notetype.trim();
    }

    public String getReplytype() {
        return replytype;
    }

    public void setReplytype(String replytype) {
        this.replytype = replytype == null ? null : replytype.trim();
    }

    public String getUseremail() {
        return useremail;
    }

    public void setUseremail(String useremail) {
        this.useremail = useremail == null ? null : useremail.trim();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getCommentdate() {
        return commentdate;
    }

    public void setCommentdate(String commentdate) {
        this.commentdate = commentdate == null ? null : commentdate.trim();
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
}