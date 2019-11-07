package com.dsup.dbmanagement.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.UserVO;
import com.dsup.dbmanagement.messge.Coolsms;
import com.dsup.dbmanagement.service.StorageService;
import com.dsup.dbmanagement.service.UserService;





@Controller
public class UserController {

	@Autowired UserService userService;
	@Autowired StorageService storageService;
	
	//목록 페이지로 이동
	@RequestMapping("userList")
	public String userList(UserVO vo, Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		model.addAttribute("tableSpaceList",storageService.getStorageList(userId));
		return "dbmanagement/user/userList";
	}
	
	//목록조회
	@RequestMapping(value="/users", method=RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> userList(HttpSession session, Model model, UserVO vo){
		vo.setUser((String)session.getAttribute("userId")); //나중에 주석풀어야함  
		return userService.userList(vo);
	}
	
	//등록페이지 
	@RequestMapping("/userCreateForm")
	public String userCreateForm(Model model, HttpSession session) {
		String userId = (String)session.getAttribute("userId"); //임시로 test 쓰고있음 나중에 주석 풀어야함
		model.addAttribute("tableSpaceList",storageService.getStorageList(userId));
		return "dbmanagement/user/userCreate";
	}

	//등록처리 
	@RequestMapping(value="/users"
			,method=RequestMethod.POST
			,consumes="application/json" )
	@ResponseBody
	public Map userCreate(@RequestBody UserVO vo, Model model, HttpSession session) {
		
		vo.setUser((String)session.getAttribute("userId")); //나중에 주석풀어야함
		if(vo.getDefaultTableSpace() == null) {
		   vo.setDefaultTableSpace("USERS");
		}
		System.out.println(vo.getDefaultTableSpace());
		userService.insertUser(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("user", vo);
		return map;
	}
	
	//id 중복체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(UserVO vo) {
		return userService.idCheck(vo);
	}
	
	
	
	

	
	//삭제
	@RequestMapping(value="/users/{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map deleteUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setId(id);
		userService.deleteUser(vo);
		return Collections.singletonMap("result", true);
		
	}
	
	//단건조회
	@RequestMapping(value="/user/{id}", method=RequestMethod.GET)
	@ResponseBody
	public UserVO getUser(@PathVariable String id, UserVO vo, Model model) {
		vo.setId(id);
		return userService.getUser(vo);
	}

	//업데이트
	@RequestMapping(value="/users", method=RequestMethod.PUT, consumes="application/json" )
	@ResponseBody
	public UserVO updateUser(@RequestBody UserVO vo, Model model) {
		/*
		 * if(vo.getDefaultTableSpace() == null || vo.getTemporaryTableSpace() == null)
		 * { vo.setDefaultTableSpace("USERS"); vo.setTemporaryTableSpace("TEMP"); }
		 */
		userService.updateUser(vo);
		return vo;
	}
	
	//문자 보내기
	  @RequestMapping(value = "/sendSms.do")
	  public String sendSms(HttpServletRequest request) throws Exception {

	    String api_key = "NCSRHIGOPYJ8YEVI";
	    String api_secret = "U8YXG0EIPTCYDU4FUFX6RMRYGDNAYDS1";
	    Coolsms coolsms = new Coolsms(api_key, api_secret);

	    HashMap<String, String> set = new HashMap<String, String>();
	    set.put("to", "01088559500, 01034568594"); // 수신번호

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