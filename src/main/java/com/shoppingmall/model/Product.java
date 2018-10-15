package com.shoppingmall.model;

import java.math.BigDecimal;

public class Product {
    private String productid;

    private Integer pno;

    private String pname;

    private String cid;

    private String issj;

    private String istj;

    private String isjptj;

    private String isrxjp;

    private String isrm;

    private String isxp;

    private String isqg;

    private String isdlsy;

    private String istg;

    private String qgstarttime;

    private String qgendtime;

    private String tgstarttime;

    private String tgendtime;

    private BigDecimal originalprice;

    private BigDecimal discountedprice;

    private BigDecimal postage;

    private Integer stock;

    private String logourl;

    private Integer sales;

    private Integer ordernum;

    private String updatetime;

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid == null ? null : productid.trim();
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname == null ? null : pname.trim();
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid == null ? null : cid.trim();
    }

    public String getIssj() {
        return issj;
    }

    public void setIssj(String issj) {
        this.issj = issj == null ? null : issj.trim();
    }

    public String getIstj() {
        return istj;
    }

    public void setIstj(String istj) {
        this.istj = istj == null ? null : istj.trim();
    }

    public String getIsjptj() {
        return isjptj;
    }

    public void setIsjptj(String isjptj) {
        this.isjptj = isjptj == null ? null : isjptj.trim();
    }

    public String getIsrxjp() {
        return isrxjp;
    }

    public void setIsrxjp(String isrxjp) {
        this.isrxjp = isrxjp == null ? null : isrxjp.trim();
    }

    public String getIsrm() {
        return isrm;
    }

    public void setIsrm(String isrm) {
        this.isrm = isrm == null ? null : isrm.trim();
    }

    public String getIsxp() {
        return isxp;
    }

    public void setIsxp(String isxp) {
        this.isxp = isxp == null ? null : isxp.trim();
    }

    public String getIsqg() {
        return isqg;
    }

    public void setIsqg(String isqg) {
        this.isqg = isqg == null ? null : isqg.trim();
    }

    public String getIsdlsy() {
        return isdlsy;
    }

    public void setIsdlsy(String isdlsy) {
        this.isdlsy = isdlsy == null ? null : isdlsy.trim();
    }

    public String getIstg() {
        return istg;
    }

    public void setIstg(String istg) {
        this.istg = istg == null ? null : istg.trim();
    }

    public String getQgstarttime() {
        return qgstarttime;
    }

    public void setQgstarttime(String qgstarttime) {
        this.qgstarttime = qgstarttime == null ? null : qgstarttime.trim();
    }

    public String getQgendtime() {
        return qgendtime;
    }

    public void setQgendtime(String qgendtime) {
        this.qgendtime = qgendtime == null ? null : qgendtime.trim();
    }

    public String getTgstarttime() {
        return tgstarttime;
    }

    public void setTgstarttime(String tgstarttime) {
        this.tgstarttime = tgstarttime == null ? null : tgstarttime.trim();
    }

    public String getTgendtime() {
        return tgendtime;
    }

    public void setTgendtime(String tgendtime) {
        this.tgendtime = tgendtime == null ? null : tgendtime.trim();
    }

    public BigDecimal getOriginalprice() {
        return originalprice;
    }

    public void setOriginalprice(BigDecimal originalprice) {
        this.originalprice = originalprice;
    }

    public BigDecimal getDiscountedprice() {
        return discountedprice;
    }

    public void setDiscountedprice(BigDecimal discountedprice) {
        this.discountedprice = discountedprice;
    }

    public BigDecimal getPostage() {
        return postage;
    }

    public void setPostage(BigDecimal postage) {
        this.postage = postage;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getLogourl() {
        return logourl;
    }

    public void setLogourl(String logourl) {
        this.logourl = logourl == null ? null : logourl.trim();
    }

    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime == null ? null : updatetime.trim();
    }
    
    private String pimgurl;

    private String desc;

    public String getPimgurl() {
        return pimgurl;
    }

    public void setPimgurl(String pimgurl) {
        this.pimgurl = pimgurl == null ? null : pimgurl.trim();
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
   	
   	
   	private String parentcatename;

	public String getParentcatename() {
		return parentcatename;
	}

	public void setParentcatename(String parentcatename) {
		this.parentcatename = parentcatename;
	}
	
	
	private String begintime;
	
	private String endtime;
	
	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
	private String searchno;

	public String getSearchno() {
		return searchno;
	}

	public void setSearchno(String searchno) {
		this.searchno = searchno;
	}

	
}