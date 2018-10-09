package com.shoppingmall.model;

import java.math.BigDecimal;

public class Order {
    private String orderid;

    private Integer orderno;

    private String customid;

    private String proid;

    private BigDecimal preprice;

    private Integer num;

    private BigDecimal postage;

    private String status;

    private String ordertime;

    private String paytime;

    private String receiver;

    private String location;

    private String detaillocation;

    private String phone;

    private String deliverytime;

    private String iscomment;

    private String isread;
    
    private String pname;

    public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid == null ? null : orderid.trim();
    }

    public Integer getOrderno() {
        return orderno;
    }

    public void setOrderno(Integer orderno) {
        this.orderno = orderno;
    }

    public String getCustomid() {
        return customid;
    }

    public void setCustomid(String customid) {
        this.customid = customid == null ? null : customid.trim();
    }

    public String getProid() {
        return proid;
    }

    public void setProid(String proid) {
        this.proid = proid == null ? null : proid.trim();
    }

    public BigDecimal getPreprice() {
        return preprice;
    }

    public void setPreprice(BigDecimal preprice) {
        this.preprice = preprice;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public BigDecimal getPostage() {
        return postage;
    }

    public void setPostage(BigDecimal postage) {
        this.postage = postage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime == null ? null : ordertime.trim();
    }

    public String getPaytime() {
        return paytime;
    }

    public void setPaytime(String paytime) {
        this.paytime = paytime == null ? null : paytime.trim();
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver == null ? null : receiver.trim();
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public String getDetaillocation() {
        return detaillocation;
    }

    public void setDetaillocation(String detaillocation) {
        this.detaillocation = detaillocation == null ? null : detaillocation.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getDeliverytime() {
        return deliverytime;
    }

    public void setDeliverytime(String deliverytime) {
        this.deliverytime = deliverytime == null ? null : deliverytime.trim();
    }

    public String getIscomment() {
        return iscomment;
    }

    public void setIscomment(String iscomment) {
        this.iscomment = iscomment == null ? null : iscomment.trim();
    }

    public String getIsread() {
        return isread;
    }

    public void setIsread(String isread) {
        this.isread = isread == null ? null : isread.trim();
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