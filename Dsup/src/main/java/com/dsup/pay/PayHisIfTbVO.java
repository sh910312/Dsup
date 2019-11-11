package com.dsup.pay;

import lombok.Data;

@Data
public class PayHisIfTbVO {
	private int paySeq;
	private String userId;
	private String payDate;
	private String payItem;
	private String payType;
	private int payPrice;
}
