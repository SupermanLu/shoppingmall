package com.shoppingmall.model;

public class Param {
    private String paramid;

    private String paramname;

    private String paramvalue;

    private String desc;

    public String getParamid() {
        return paramid;
    }

    public void setParamid(String paramid) {
        this.paramid = paramid == null ? null : paramid.trim();
    }

    public String getParamname() {
        return paramname;
    }

    public void setParamname(String paramname) {
        this.paramname = paramname == null ? null : paramname.trim();
    }

    public String getParamvalue() {
        return paramvalue;
    }

    public void setParamvalue(String paramvalue) {
        this.paramvalue = paramvalue == null ? null : paramvalue.trim();
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc == null ? null : desc.trim();
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