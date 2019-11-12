package com.dsup.dbmanagement.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dsup.dbmanagement.messge.Coolsms;

@Controller
public class MessgeController {

	//문자 보내기
	  @RequestMapping(value = "/sendSms.do")
	  public String sendSms(HttpServletRequest request) throws Exception {

	    String api_key = "NCSRHIGOPYJ8YEVI";
	    String api_secret = "U8YXG0EIPTCYDU4FUFX6RMRYGDNAYDS1";
	    Coolsms coolsms = new Coolsms(api_key, api_secret);

	    HashMap<String, String> set = new HashMap<String, String>();
	    set.put("to", ""); // 수신번호

	    set.put("from", (String)request.getParameter("from")); // 발신번호
	    set.put("text", (String)request.getParameter("text")); // 문자내용
	    set.put("type", "sms"); // 문자 타입

	    System.out.println(set);

	    JSONObject result = coolsms.send(set); // 보내기&전송결과받기
	    System.out.println(result.get("status"));
	    
	    if ( (Boolean) result.get("status") == true) {
	      // 메시지 보내기 성공 및 전송결과 출력
	      System.out.println("성공");
	      System.out.println(result.get("group_id")); // 그룹아이디
	      System.out.println(result.get("result_code")); // 결과코드
	      System.out.println(result.get("result_message")); // 결과 메시지
	      System.out.println(result.get("success_count")); // 메시지아이디
	      System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
	    } else {
	      // 메시지 보내기 실패
	      System.out.println("실패");
	      System.out.println(result.get("code")); // REST API 에러코드
	      System.out.println(result.get("message")); // 에러메시지
	    }

	    return "redirect:main.do";
	  }
	
}

