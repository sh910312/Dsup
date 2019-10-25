//package com.dsup.chat.controller;
//
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.http.server.ServerHttpRequest;
//import org.springframework.http.server.ServerHttpResponse;
//import org.springframework.http.server.ServletServerHttpRequest;
//import org.springframework.web.socket.WebSocketHandler;
//import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
//
//import com.dsup.chat.UserVO;
//
//public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {
//
//	@Override
//	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
//			Map<String, Object> attributes) throws Exception {
//		
//		// 위의 파라미터 중, attributes 에 값을 저장하면 웹소켓 핸들러 클래스의 WebSocketSession에 전달된다
//		System.out.println("before Handshake");
//		
//		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
//		System.out.println("URI : "+request.getURI());
//		
//		HttpServletRequest req = ssreq.getServletRequest();
//
//		// HttpSession에 저장된 이용자의 닉네임을 추출하는경우
//		UserVO nickname = (UserVO) req.getSession().getAttribute("nickname");
//		System.out.println("555555555555");
//		attributes.put("nickname", nickname); // 담아준다
//		System.out.println("httpSession에 저장된 닉네임: "+ nickname);
//
//		return super.beforeHandshake(request, response, wsHandler, attributes);
//	}
//
//	@Override
//	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler socketHandler,
//			Exception ex) {
//		System.out.println("After Handshake");
//		super.afterHandshake(request, response, socketHandler, ex);
//	}
//
//}
