package com.shoppingmall.model;

public class ProductWithBLOBs extends Product {
    private String pimgurl;

    private String descption;

    public String getPimgurl() {
        return pimgurl;
    }

    public void setPimgurl(String pimgurl) {
        this.pimgurl = pimgurl == null ? null : pimgurl.trim();
    }

    public String getDescption() {
        return descption;
    }

    public void setDescption(String descption) {
        this.descption = descption == null ? null : descption.trim();
    }
}