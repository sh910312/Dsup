package com.dsup.pay;

import lombok.Data;

@Data
public class ServiceStateTbVO {
	private String userId;
	private String payDate;
	private String payItem;
	private String payType;
	private String cancelYn;
}
