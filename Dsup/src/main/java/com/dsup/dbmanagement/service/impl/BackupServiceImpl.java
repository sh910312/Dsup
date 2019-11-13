package com.dsup.dbmanagement.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dsup.dbmanagement.BackupVO;
import com.dsup.dbmanagement.DatafileVO;
import com.dsup.dbmanagement.service.BackupService;

@Service
public class BackupServiceImpl implements BackupService {

	@Autowired BackupDAOMybatis dao;
	
	@Override
	public void BackupCreate(BackupVO vo, String tablespaceName, String backupPath) {
		try {
			// 테이블스페이스 begin backup
			dao.beginBackup(tablespaceName);
			// 데이터파일 목록 가져오기
			List<DatafileVO> datafile = new ArrayList<DatafileVO>();
			datafile = dao.datafileList(tablespaceName);
			// 압축파일 만들기
			vo = makeZip(vo, tablespaceName, datafile, backupPath);
			// DB에 자료 입력
			dao.insertBackupList(vo);
		} catch (Exception e) {
			
		} finally {
			// 테이블스페이스 end backup
			dao.endBackup(tablespaceName);
		}
	}

	// [윤정1028] 백업파일 목록
	@Override
	public List<BackupVO> getBackupList(String userId) {
		return dao.getBackupList(userId);
	}
	
	// [윤정 1029] 백업파일 삭제
	@Override
	public void backupDelete(String[] deleteFiles) {
		for(String fileName : deleteFiles) {
			File file = new File(fileName);
			if(file.exists()) {
				if(file.delete()) {
					dao.BackupDelete(fileName);
					// 파일이 삭제되면 테이블의 데이터도 삭제
				} 
			}
		}
	}

	// [윤정 1028] 파일 압축하기
	public BackupVO makeZip(BackupVO vo, String tablespaceName, List<DatafileVO> datafile, String backupPath) {
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd HHmmss");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyyMMdd");
		Date time = new Date();
		String time1 = format1.format(time);
		vo.setBackupDate(format2.format(time));
		
		File directory = new File(backupPath);
		if(!directory.exists()) directory.mkdirs();
		// 경로 없으면 생성
		
		String zipFileName = directory + "\\" + vo.getUserId() + "_" + tablespaceName + "_" + time1 + ".zip"; // 경로, 압축파일명, 확장자
		// 압축파일명 : userId_tablespaceName_yyyyMMdd HHmmss
		vo.setBackupFileNm(zipFileName);
		
		byte[] buf = new byte[4096];
		 
		try {
		    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
		 
		    for(DatafileVO file : datafile) {
		    	FileInputStream in = new FileInputStream(file.getFileName());
		    	Path path = Paths.get(file.getFileName());
		    	String fileName = path.getFileName().toString();
		    	System.out.println("파일이름 : " + fileName);
		    	
		    	ZipEntry ze = new ZipEntry(fileName);
		    	out.putNextEntry(ze);

		        int len;
		        while ((len = in.read(buf)) > 0) {
		            out.write(buf, 0, len);
		        }
		          
		        out.closeEntry();
		        in.close();
		    }
		    out.close();
		} catch(FileNotFoundException e) {
			System.out.println("파일 없음!");
			e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return vo;
	}


}
