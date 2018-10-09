package com.shoppingmall.model;

public class Help {
    private String helpid;

    private String helptype;

    private String helpcontent;

    public String getHelpid() {
        return helpid;
    }

    public void setHelpid(String helpid) {
        this.helpid = helpid == null ? null : helpid.trim();
    }

    public String getHelptype() {
        return helptype;
    }

    public void setHelptype(String helptype) {
        this.helptype = helptype == null ? null : helptype.trim();
    }

    public String getHelpcontent() {
        return helpcontent;
    }

    public void setHelpcontent(String helpcontent) {
        this.helpcontent = helpcontent == null ? null : helpcontent.trim();
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