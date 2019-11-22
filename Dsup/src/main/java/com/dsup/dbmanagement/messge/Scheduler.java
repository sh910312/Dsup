package com.dsup.dbmanagement.messge;

import java.util.HashMap;
import java.util.List;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dsup.dbmanagement.service.MessgeService;
import com.dsup.dbmanagement.service.MessgeVO;

@Component
public class Scheduler {

	@Autowired
	MessgeService messgeService;
	//DB 80% 사용시 월~금 9시, 18시에 자동 문자 보내기 
	@Scheduled(cron = "0 0 18 ? * MON-FRI")
	
		 public void sendSms() throws Exception {

			    String api_key = "NCSRHIGOPYJ8YEVI";
			    String api_secret = "U8YXG0EIPTCYDU4FUFX6RMRYGDNAYDS1";
			    Coolsms coolsms = new Coolsms(api_key, api_secret);

			    //서비스 호출
			    List<MessgeVO> messgeList = messgeService.messgeList(null);
			    System.out.println(messgeList);
			    for(int i=0; i<messgeList.size(); i++) {
				    HashMap<String, String> set = new HashMap<String, String>();
				    set.put("to",  messgeList.get(i).getPhonenumber()); // 수신번호
				    
				    set.put("from", "01088559500"); // 발신번호
				    set.put("text",String.format("모모에서 알려드립니다. %s님의 DB용량 %sMB 소진했습니다. %sMB남았습니다.", 
				    							 messgeList.get(i).getUserId(),
				    							 messgeList.get(i).getUsed(),
				    						     messgeList.get(i).getFree())); 
				    set.put("type", "sms"); // 문자 타입				
				    
	
				    System.out.println(set);
	
				    JSONObject result = coolsms.send(set); // 보내기&전송결과받기
				    System.out.println(result.get("status"));
			    }
			    
			    HashMap<String, String> set = new HashMap<String, String>();
			    JSONObject result = coolsms.send(set); // 보내기&전송결과받기
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

			  }
	

}
