package com.shoppingmall.model;

public class Rule {
    private String ruleid;

    private String rulecontent;

    public String getRuleid() {
        return ruleid;
    }

    public void setRuleid(String ruleid) {
        this.ruleid = ruleid == null ? null : ruleid.trim();
    }

    public String getRulecontent() {
        return rulecontent;
    }

    public void setRulecontent(String rulecontent) {
        this.rulecontent = rulecontent == null ? null : rulecontent.trim();
    }
}