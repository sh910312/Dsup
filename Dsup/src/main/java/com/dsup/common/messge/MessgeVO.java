package com.dsup.common.messge;

import lombok.Data;

@Data
public class MessgeVO {
	private String msgId;
	private String msgContents;
	private String msgSendDate;
	private String receiverId;
	
}
