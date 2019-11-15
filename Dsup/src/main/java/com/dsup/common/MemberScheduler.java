package com.dsup.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dsup.member.service.MemberService;

@Component
public class MemberScheduler {
	@Autowired MemberService memberService;

	// 윤정 del_date가 오늘 + 오늘이전 인 유저 삭제
	@Scheduled(cron = "0 0 0 * * *")
	public void deleteWithdrawalUsers() {
		memberService.deleteWithdrawalUsers();
	}
}
