<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h2>판매 글 쓰기</h2>
  <form action="/board/register" method="post">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>  
    <div class="form-group">
      <label for="title">상품명</label>
      <input type="text" class="form-control" id="title"
       placeholder="제목 입력(4-100)" name="title"
       maxlength="100" required="required"
       pattern=".{4,100}">
    </div>
    <div class="form-group">
   <label for="content">상품 정보</label>
   <textarea class="form-control" rows="5" id="content"
    name="pinfo" placeholder="내용 작성"></textarea>
 </div>
    <div class="form-group">
      <label for="writer">판매자</label>
      <input class="form-control" name='celler' value='<sec:authentication property="principal.username"/>' readonly="readonly" >
    </div>
    <div class="form-group">
      <label for="writer">가격</label>
      <input type="text" class="form-control" id="writer"
       placeholder="가격" name="price">
    </div>
    <input type="file"  id ="fileItem" name='uploadFile' style="height: 30px;">
  <div id="uploadResult">
</div>
<hr>
    <button type="submit" class="btn btn-default">등록</button>
</div>
</form>



















<script type="text/javascript">

var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";


$("input[type='file']").on("change", function(e){
	
	if($(".imgDeleteBtn").length > 0){
		deleteFile();
	}
	
	let formData = new FormData();
	let fileInput = $('input[name="uploadFile"]');
	let fileList = fileInput[0].files;
	let fileObj = fileList[0];
	
	
	 if(!fileCheck(fileObj.name, fileObj.size)){
		return false;
	} 
	//파일하나일때
	//formData.append("uploadFile", fileObj);
	//파일여러개일때
	// for(let i = 0; i < fileList.length; i++){
		formData.append("uploadFile", fileObj);
	//} 
	$.ajax({
		url: '/uploadAjaxAction',
    	processData : false,
    	contentType : false,
    	data : formData,
    	
    	 beforeSend: function(xhr) {
    			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    		},
    	
    	type : 'POST',
    	dataType : 'json',
    	success : function(result){
	    		console.log(result);
	    		//$("#uploadResult").css("display" ,"block");
	    		showUploadImage(result);
	    	},
			error : function(result){
				alert("이미지 파일이 아닙니다.");
	    	}
	});
});

$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
	
	deleteFile();
	
});


let regex = new RegExp("(.*?)\.(jpg|png)$");
let maxSize = 5048576; //1MB	

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
		  
	if(!regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	
	return true;		
	
	
}
function showUploadImage(uploadResultArr){
	
	
	if(!uploadResultArr || uploadResultArr.length == 0){return}
	
	let uploadResult = $("#uploadResult");
	
	let obj = uploadResultArr[0];
	
	let str = "";
	
	let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
	
	str += "<div id='result_card'>";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='"+fileCallPath+"'>x</div>";
	str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
	str += "</div>";		
	
		uploadResult.append(str);     
    
}
function deleteFile(){

	let targetFile = $(".imgDeleteBtn").data("file");
	
	
	let targetDiv = $("#result_card");
	$.ajax({
		url: '/deleteFile',
		data : {fileName : targetFile},
		dataType : 'text',
		type : 'POST',
		success : function(result){
			console.log(result);
			$('#result_card').remove();
		},
		error : function(result){
			console.log(result);
			
			alert("파일을 삭제하지 못하였습니다.")
		}
   });
}


</script>
                    			 
</body>
</html>