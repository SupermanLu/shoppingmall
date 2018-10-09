package com.shoppingmall.model;

public class Swip {
    private String swipid;

    private String swiplink;

    private String swipimgurl;

    private Integer ordernum;

    private String addtime;

    public String getSwipid() {
        return swipid;
    }

    public void setSwipid(String swipid) {
        this.swipid = swipid == null ? null : swipid.trim();
    }

    public String getSwiplink() {
        return swiplink;
    }

    public void setSwiplink(String swiplink) {
        this.swiplink = swiplink == null ? null : swiplink.trim();
    }

    public String getSwipimgurl() {
        return swipimgurl;
    }

    public void setSwipimgurl(String swipimgurl) {
        this.swipimgurl = swipimgurl == null ? null : swipimgurl.trim();
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime == null ? null : addtime.trim();
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