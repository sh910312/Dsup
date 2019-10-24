package com.dsup.dbmanagement;

import lombok.Data;

/*
 * 윤정
 * 1022 17:19
 * 테이블스페이스 vo
 */
@Data 
public class TablespaceVO {
	private String tablespaceName;
	private String status; // online, offline, read only
	private String contents; // pernament, temporary, undo
	
	private int total; // 전체 용량
	private int used; // 사용량
	private int free; // 빈 용량
	private float usedPer; // 사용 퍼센트
	public String getTablespaceName() {
		return tablespaceName;
	}
	public void setTablespaceName(String tablespaceName) {
		this.tablespaceName = tablespaceName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getUsed() {
		return used;
	}
	public void setUsed(int used) {
		this.used = used;
	}
	public int getFree() {
		return free;
	}
	public void setFree(int free) {
		this.free = free;
	}
	public float getUsedPer() {
		return usedPer;
	}
	public void setUsedPer(float usedPer) {
		this.usedPer = usedPer;
	}
	
	
}
