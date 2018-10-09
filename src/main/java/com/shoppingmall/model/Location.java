package com.shoppingmall.model;

public class Location {
    private String locationid;

    private String locationno;

    private String locationname;

    public String getLocationid() {
        return locationid;
    }

    public void setLocationid(String locationid) {
        this.locationid = locationid == null ? null : locationid.trim();
    }

    public String getLocationno() {
        return locationno;
    }

    public void setLocationno(String locationno) {
        this.locationno = locationno == null ? null : locationno.trim();
    }

    public String getLocationname() {
        return locationname;
    }

    public void setLocationname(String locationname) {
        this.locationname = locationname == null ? null : locationname.trim();
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