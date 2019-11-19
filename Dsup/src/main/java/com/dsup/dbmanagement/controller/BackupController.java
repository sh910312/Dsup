package com.dsup.dbmanagement.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dsup.dbmanagement.BackupVO;
import com.dsup.dbmanagement.service.BackupService;

@Controller
public class BackupController {

	@Autowired BackupService backupService;
	
	// [윤정1023] 백업 리스트 페이지로 이동 ----- 리스트 출력은 아직
	@RequestMapping("/backupList")
	public String BackupList() {
		return "dbmanagement/backup/backupList";
	}
	
	// [윤정1023] 백업 생성하기 페이지로 이동
	@RequestMapping("/backupCreateForm")
	public String backupCreateForm() {
		return "dbmanagement/backup/backupCreateForm";
	}
	
	// [윤정1027] 백업하기
	@RequestMapping("/backupCreate")
	public String backupCreate(@RequestParam String tablespaceName, BackupVO vo, HttpServletRequest request) {
		String backupPath = request.getSession().getServletContext().getRealPath("/resources/dsupBackup");
		backupService.BackupCreate(vo, tablespaceName, backupPath);
		return "redirect:backupList";
	}
	
	// [윤정1028] 백업 목록 출력 json
	@ResponseBody
	@RequestMapping(value="/backup", method=RequestMethod.GET)
	public List<BackupVO> getBackupList(HttpSession session){
		String userId = (String) session.getAttribute("userId");
		return backupService.getBackupList(userId);
	}
	
	// [윤정1028] 백업파일 다운로드
	@RequestMapping("/download/{backupFileNm:.+}")
	public void downloadBackupResource(HttpServletRequest request,
            						   HttpServletResponse response,
            						   @PathVariable("backupFileNm") String fileName) {
		String backupPath = request.getSession().getServletContext().getRealPath("/resources/dsupBackup");
		Path path = Paths.get(backupPath,fileName);
		if(Files.exists(path)) {
            response.setContentType("application/octet-stream;charset=UTF-8"); // 파일의 타입
            response.addHeader("Content-Disposition", "attachment; filename="+fileName);
			try
            {
                Files.copy(path, response.getOutputStream());
                response.getOutputStream().flush();
            }
            catch (IOException ex) {
                ex.printStackTrace();
            }
		}
	}
	
	// [윤정1029] 백업파일 삭제
	@RequestMapping("/backupDelete")
	public String backupDelete(@RequestParam(value="deleteFiles") String[] deleteFiles) {
		backupService.backupDelete(deleteFiles);
		return "redirect:backupList";
	}
	
	// 윤정 1118 보관기간 지난 백업파일
	@ResponseBody
	@RequestMapping("overBackup")
	public List<BackupVO> overBackup(){
		return backupService.getOverBackup();
	}
}
