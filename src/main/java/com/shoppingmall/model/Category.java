package com.shoppingmall.model;

public class Category {
    private String cateid;

    private String catename;

    private String parentcateid;

    private String issy;

    private String bannerurl;

    private Integer ordernum;

    public String getCateid() {
        return cateid;
    }

    public void setCateid(String cateid) {
        this.cateid = cateid == null ? null : cateid.trim();
    }

    public String getCatename() {
        return catename;
    }

    public void setCatename(String catename) {
        this.catename = catename == null ? null : catename.trim();
    }

    public String getParentcateid() {
        return parentcateid;
    }

    public void setParentcateid(String parentcateid) {
        this.parentcateid = parentcateid == null ? null : parentcateid.trim();
    }

    public String getIssy() {
        return issy;
    }

    public void setIssy(String issy) {
        this.issy = issy == null ? null : issy.trim();
    }

    public String getBannerurl() {
        return bannerurl;
    }

    public void setBannerurl(String bannerurl) {
        this.bannerurl = bannerurl == null ? null : bannerurl.trim();
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }
    
    // Í¨ÓÃ
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
   	
   	
   	private String parentcatename;

	public String getParentcatename() {
		return parentcatename;
	}

	public void setParentcatename(String parentcatename) {
		this.parentcatename = parentcatename;
	}
   	
   	
}