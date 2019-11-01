package com.dsup.pay;

import lombok.Data;

@Data
public class PayVO {
	private int paySeq;
	private String userId;
	private String payDate;
	private String item;
	private String type;
	private String price;
	private String cancelYn;
}
