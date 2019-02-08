package com.zhi.entity;

import java.util.Date;

public class CusDevPlan {
	private Integer id;
	private Integer saleChanceId;
	private Date planDate;
	private String planItem;
	private String executeAffect;
	private SaleChance saleChance;
	public CusDevPlan() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSaleChanceId() {
		return saleChanceId;
	}
	public void setSaleChanceId(Integer saleChanceId) {
		this.saleChanceId = saleChanceId;
	}
	public Date getPlanDate() {
		return planDate;
	}
	public void setPlanDate(Date planDate) {
		this.planDate = planDate;
	}
	public String getPlanItem() {
		return planItem;
	}
	public void setPlanItem(String planItem) {
		this.planItem = planItem;
	}
	public String getExecuteAffect() {
		return executeAffect;
	}
	public void setExecuteAffect(String executeAffect) {
		this.executeAffect = executeAffect;
	}
	public SaleChance getSaleChance() {
		return saleChance;
	}
	public void setSaleChance(SaleChance saleChance) {
		this.saleChance = saleChance;
	}
	
}
