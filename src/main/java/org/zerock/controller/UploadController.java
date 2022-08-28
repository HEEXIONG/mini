package org.zerock.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachImageVO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequiredArgsConstructor

@Log4j
public class UploadController {

	private final BoardService service;
	
	@GetMapping("/display")
	// ResponseEntity 객체를 통해 body에 byte [] 데이터를 보내야 하기 때문
	public ResponseEntity<byte[]> getImage(String fileName){
		File file = new File("c:\\upload\\" + fileName);
		
ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		return result;
		
	}
	@PreAuthorize("isAuthenticated()")
	 @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	 public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile){
		
		String uploadFolder = "C:\\upload";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		Date date = new Date();
	
		String str = sdf.format(date);
		
		
		String datePath = str.replace("-", File.separator);
		
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		List<AttachImageVO> list = new ArrayList();
		
	   for(MultipartFile multipartFile : uploadFile) {
		   
		   AttachImageVO vo = new AttachImageVO();
		   
		   
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			
			String uuid = UUID.randomUUID().toString();
			
			vo.setUuid(uuid);
			uploadFileName = uuid + "_" + uploadFileName;
			
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			
			try {
				multipartFile.transferTo(saveFile);
				
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
				
				BufferedImage bo_image = ImageIO.read(saveFile);

					 
					double ratio = 3;
					
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio);					
				
				
				Thumbnails.of(saveFile)
		        .size(width, height)
		        .toFile(thumbnailFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			list.add(vo);
		    } //for
	   ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		
		return result;
	   }
	
	
	
		/*
		 * public void uploadAjaxActionsPost(MultipartFile uploadFile) {
		 * log.info("uploadAjaxActionPost 실행"); String uploadFolder = "C:\\";
		 * 
		 * // SimpleDateForamt은 Date 클래스를 통해 얻은 오늘의 날짜를 지정된 형식의 문자열 데이터로 생성하기 위해서 사용
		 * SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 * 
		 * //Date 클래스를 오늘의 날짜를 얻기 위해서 사용 Date date = new Date(); // String str =
		 * sdf.format(date);
		 * 
		 * // '-'을 경로 구분자인 '/'(리눅스) 혹은 '\'(윈도)로 변경 String datePath = str.replace("-",
		 * File.separator);
		 * 
		 * //폴더 생성 File uploadPath = new File(uploadFolder, datePath); //폴더가 이미 존재하는
		 * 상황에도 사용자가 업로드를 할 때마다 폴더를 생성하는 코드가 무조건 실행을 막기위해 if(uploadPath.exists() ==
		 * false) { uploadPath.mkdirs(); }
		 * 
		 * }
		 */

//	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	
//	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPost(MultipartFile uploadFile) {
//		log.info("uploadAjaxActionPost 실행");
//		
//		File checkfile = new File(uploadFile.getOriginalFilename());
//		String type = null;
//		try {
//			type = Files.probeContentType(checkfile.toPath());
//			log.info("MIME TYPE : " + type);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		if(!type.startsWith("image")) {
//			
//			List<AttachImageVO> list = null;
//			return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
//			
//		}
//		
//		String uploadFolder = "C:\\upload";
//
//		// SimpleDateForamt은 Date 클래스를 통해 얻은 오늘의 날짜를 지정된 형식의 문자열 데이터로 생성하기 위해서 사용
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//		// Date 클래스를 오늘의 날짜를 얻기 위해서 사용
//		Date date = new Date();
//		//
//		String str = sdf.format(date);
//
//		// '-'을 경로 구분자인 '/'(리눅스) 혹은 '\'(윈도)로 변경
//		String datePath = str.replace("-", File.separator);
//
//		// 폴더 생성
//		File uploadPath = new File(uploadFolder, datePath);
//		// 폴더가 이미 존재하는 상황에도 사용자가 업로드를 할 때마다 폴더를 생성하는 코드가 무조건 실행을 막기위해
//		if (uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}
//		
//		List<AttachImageVO> list = new ArrayList();
//		
//		// for (MultipartFile multipartFile : uploadFile) {
//
//		AttachImageVO vo = new AttachImageVO();
//		/* 파일 이름 */
//		String uploadFileName = uploadFile.getOriginalFilename();
//		vo.setFileName(uploadFileName);
//		vo.setUploadPath(datePath);
//		
//
//		// uuid 파일이름 중복을 피하기 위해서
//		String uuid = UUID.randomUUID().toString();
//		vo.setUuid(uuid);
//		uploadFileName = uuid + "_" + uploadFileName;
//
//		/* 파일 위치, 파일 이름을 합친 File 객체 */
//		File saveFile = new File(uploadPath, uploadFileName);
//
//		/* 파일 저장 */
//		try {
//				
//			  uploadFile.transferTo(saveFile); //썸네일 이미지파일이름 = s_" + "uuid_" + "원본파일 이름"
//			  /* 1번 방법
//			 * File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
//			 * BufferedImage bo_image = ImageIO.read(saveFile);
//			 * 
//			 * 비율 double ratio = 3; 넓이 높이 int width = (int) (bo_image.getWidth() / ratio);
//			 * int height = (int) (bo_image.getHeight() / ratio);
//			 * 
//			 * BufferedImage bt_image = new BufferedImage(width, height,
//			 * BufferedImage.TYPE_3BYTE_BGR); Graphics2D graphic =
//			 * bt_image.createGraphics(); graphic.drawImage(bo_image, 0, 0,width,height,
//			 * null); ImageIO.write(bt_image, "jpg", thumbnailFile);
//			 */
//			  File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
//			  BufferedImage bo_image = ImageIO.read(saveFile);
//			   
//				double ratio = 3;
//				//넓이 높이
//				int width = (int) (bo_image.getWidth() / ratio);
//				int height = (int) (bo_image.getHeight() / ratio);
//			  
//			  Thumbnails.of(saveFile)
//		        .size(width, height)
//		        .toFile(thumbnailFile);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		list.add(vo);
//		// }
//		/* 파일 이름 */
//
//		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
//		
//		return result;
//	}
	
	
	
	
	
	
	
	
	
	
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		log.info("deleteFile........" + fileName);
		
		File file = null;
		
		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
		
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			log.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}

}
