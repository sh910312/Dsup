package com.dsup.chat;

import java.util.Date;

import lombok.Data;

@Data
public class ChatVO {

	int chat_id;
	String user_id;
	String nickname;
	String contents;
	Date write_date;
	
}
