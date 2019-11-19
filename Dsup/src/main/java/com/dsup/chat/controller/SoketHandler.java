package com.dsup.chat.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.dsup.chat.ChatVO;
import com.dsup.chat.service.ChatService;
import com.dsup.chat.service.SearchService;
import com.dsup.member.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;

public class SoketHandler extends TextWebSocketHandler implements WebSocketHandler {
	
	@Autowired
	SearchService searchservice;
	
	@Autowired
	ChatService chatService;

//	private static Logger logger = LoggerFactory.getLogger(SoketHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		super.afterConnectionEstablished(session);
		System.out.println("클라이언트 접속됨");
		
		Map<String, Object> map = session.getAttributes();
		MemberVO vo = (MemberVO) map.get("member");

		sessionList.add(session);
		System.out.println(vo.getNickname()+"님이 접속됨");

	
		String msg = vo.getNickname()+"님이 입장하였습니다.";
		String nickname = "";
		int chatid = 0;
		
		sendMaseege("login", msg,  nickname,  chatid, "");
	
	
	}
	
	
	
	public void sendMaseege(String cmd, String msg, String nickname, int chatid, String userId) throws IOException {
		
		SimpleDateFormat date =  new SimpleDateFormat("MM월dd일 HH:mm");
//		SimpleDateFormat date =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		Map<String, String> map = new HashMap<String, String>();
		String temp = 
				"<div class='pull-right'>" + date.format(new Date())	+ "</div>"
				+ "<h4>" + nickname + "</h4>"
				+ "<span> " + msg
				+ "<input type='hidden' value='" + chatid+ "'>" 
				+ "</span>";
		
		map.put("cmd", cmd);
		map.put("msg", temp);
		map.put("userId", userId);
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(map);
		
		System.out.println(jsonString);
		
		for (WebSocketSession sess : sessionList) {
			System.out.println("채팅 세션 리스트 작동중?");
			sess.sendMessage(new TextMessage(jsonString));
			 
		}
		
	}
	

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println(session.getAttributes());
		
		
		Map<String, Object> map = session.getAttributes();
		MemberVO vo = (MemberVO) map.get("member");

		ChatVO cvo = new ChatVO();
		
		cvo.setUserId(vo.getUserId());
		cvo.setNickname(vo.getNickname());
		cvo.setContents(message.getPayload());
	
		
		
		
		
		int a = chatService.insertChat(cvo); // DB에 저장된다.
		
		
		
		
		
		System.out.println(cvo+",,,,"+a);
		
		
		//System.out.println(vo.getUserId() + "으로부터 " + message.getPayload() + "받음" + date.format(new Date()));
		String msg = message.getPayload();
		String nickname = cvo.getNickname();
		
		int chatid = cvo.getChatId();
		
		sendMaseege("msge", msg,  nickname,  chatid, cvo.getUserId());
	
		
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		Map<String, Object> map = session.getAttributes();
		MemberVO vo = (MemberVO) map.get("member");
		
		sessionList.remove(session);
		System.out.println(vo.getNickname() +"님이 퇴장함");
	
		
		String msg = vo.getNickname() +"님이 퇴장함";
		String nickname = "";
		int chatid = 0;
		
		sendMaseege("logout", msg,  nickname,  chatid, "");
	
	}

}
