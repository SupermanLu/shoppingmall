package com.shoppingmall.model;

public class Help {
    private String helpid;

    private String helpname;

    private String helppid;

    private String helpcontent;

    public String getHelpid() {
        return helpid;
    }

    public void setHelpid(String helpid) {
        this.helpid = helpid == null ? null : helpid.trim();
    }

    public String getHelpname() {
        return helpname;
    }

    public void setHelpname(String helpname) {
        this.helpname = helpname == null ? null : helpname.trim();
    }

    public String getHelppid() {
        return helppid;
    }

    public void setHelppid(String helppid) {
        this.helppid = helppid == null ? null : helppid.trim();
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

	private String parenthelpname;
   	
   	public String getParenthelpname() {
		return parenthelpname;
	}

	public void setParenthelpname(String parenthelpname) {
		this.parenthelpname = parenthelpname;
	}


	
}