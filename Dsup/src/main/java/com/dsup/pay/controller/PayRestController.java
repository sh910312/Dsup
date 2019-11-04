package com.dsup.pay.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dsup.pay.PayVO;
import com.dsup.pay.service.PayService;

@RestController
public class PayRestController {

	@Autowired
	PayService payService;

	// 등록
	@ResponseBody
	@RequestMapping(value = "/pays", method = RequestMethod.POST, consumes = "application/json")
	public Map insertPay(PayVO vo, Model model) {
		System.out.println("start");
		System.out.println(vo);
		payService.insertPay(vo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("pay", true);
		return map;
	}
}
