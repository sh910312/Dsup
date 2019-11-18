package com.dsup.common;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dsup.dbmanagement.BackupVO;
import com.dsup.dbmanagement.service.BackupService;
import com.dsup.member.service.MemberService;

@Component
public class AdminScheduler {
	@Autowired MemberService memberService;
	@Autowired BackupService backupService;
	
	// 윤정 del_date가 오늘 + 오늘이전 인 유저 삭제
	@Scheduled(cron = "0 0 0 * * *")
	public void deleteWithdrawalUsers() {
		memberService.deleteWithdrawalUsers();
	}
	
	// 윤정 백업파일 보관기간 지난 항목 삭제
	@Scheduled(cron = "0 9 16 * * *")
	public void deleteTimeoverBackup() {
		List<BackupVO> bulist = new ArrayList<BackupVO>();
		bulist = backupService.getOverBackup();
		int len = bulist.size();
		String buarr[] = new String[len];
		int i = 0;
		for(BackupVO bu : bulist) 
			buarr[i++] = bu.getBackupFileNm();
		backupService.backupDelete(buarr);
	}
}
