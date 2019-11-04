package com.dsup.chat.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.dsup.member.MemberVO;

public class SoketHandler extends TextWebSocketHandler implements WebSocketHandler {

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
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println(session.getAttributes());
		
		Map<String, Object> map = session.getAttributes();
		MemberVO vo = (MemberVO) map.get("member");
		
		System.out.println(vo.getNickname() + "으로부터 " + message.getPayload() + "받음");
		
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(vo.getNickname()+ " : " + message.getPayload()));
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		Map<String, Object> map = session.getAttributes();
		MemberVO vo = (MemberVO) map.get("member");
		
		sessionList.remove(session);
		System.out.println(vo.getNickname() +"님이 퇴장함");
	}

}
