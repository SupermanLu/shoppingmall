package com.shoppingmall.model;

public class Menu {
    private String menuid;

    private String menuname;

    private String menubs;

    private String description;

    private Integer ordernum;

    private String parentmenuid;

    public String getMenuid() {
        return menuid;
    }

    public void setMenuid(String menuid) {
        this.menuid = menuid == null ? null : menuid.trim();
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname == null ? null : menuname.trim();
    }

    public String getMenubs() {
        return menubs;
    }

    public void setMenubs(String menubs) {
        this.menubs = menubs == null ? null : menubs.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }

    public String getParentmenuid() {
        return parentmenuid;
    }

    public void setParentmenuid(String parentmenuid) {
        this.parentmenuid = parentmenuid == null ? null : parentmenuid.trim();
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
 	
 	
 	private String parentmenuname;

	public String getParentmenuname() {
		return parentmenuname;
	}

	public void setParentmenuname(String parentmenuname) {
		this.parentmenuname = parentmenuname;
	}
}