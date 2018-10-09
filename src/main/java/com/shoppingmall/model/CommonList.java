package com.shoppingmall.model;

import java.util.List;

public class CommonList {
	private List<? extends Object> rows;

	private int total;
	

	public List<? extends Object> getRows() {
		return rows;
	}
	public void setRows(List<? extends Object> rows) {
		this.rows = rows;
	}
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
}
