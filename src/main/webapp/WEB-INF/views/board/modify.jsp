<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h2>판매 글 수정</h2>
  <form role="form" action="/board/modify" method="post">
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
      <input class="form-control" name='celler' readonly="readonly" >
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
	<sec:authentication property="principal" var="pinfo"/>
    <sec:authorize access="isAuthenticated()">
    <c:if test="${pinfo.username eq board.celler}">
    <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
    <button type="submit" data-oper='remove' class="btn btn-default">제거</button>
    </c:if>
	</sec:authorize>
</div>
</form>







<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		// form 태그의 모든 버튼은 기본적으로 submit으로 처리하기 때문에
		// e.preventDefault()로 기본 동작을 막고 마지막에 직접 submit()을 수행합니다.
		e.preventDefault();
		// 자바스크립트에서는 button 태그의 'data-oper' 속성을 이용해서
		// 원하는 기능을 동작하도록 처리합니다.
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "/board/remove");
		} else if(operation === 'list'){
			// move to list
			// 수정된 내용은 클릭한 버튼이 List인 경우 action 속성과 method 속성을
			// 변경합니다. '/board/list'로의 이동은 아무런 파라미터가 없기 때문에
			// form 태그의 모든 내용은 삭제한 상태에서 submit()을 진행합니다.			
		   formObj.attr("action", "/board/list").attr("method", "get");
		    
		// Page 321 수정/삭제 페이지에서 목록 페이지로 이동 처리
		// 페이지 이동의 마지막은 수정/삭제를 취소하고 다시 목록 페이지로 이동하는 것입니다.
		// 목록 페이지는 오직 pageNum과 amount만을 사용하므로 form 태그의
		// 다른 내용들은 삭제하고 필요한 내용만을 다시 추가하는 형태가 편리합니다.
		// 만일 사용자가 'List' 버튼을 클릭한다면 form 태그에서 필요한 부분만 잠시
		// 복사(clone)해서 보관해 두고, form 태그 내의 모든 내용은 지워버립니다(empty)
		// 이후에 다시 필요한 태그들만 추가해서 '/board/list'를 호출하는 형태를 이용합니다.
			// Page 321 자바스크립트 소스 추가 시작
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();			
		    // Page 321 자바스크립트 소스 추가 끝
		    
		    // Page 347 자바스크립트 소스 추가 시작
		    var keywordTag = $("input[name='keyword']").clone();
		    var typeTag = $("input[name='type']").clone();
		    // Page 347 자바스크립트 소스 추가 끝
		    
		    formObj.empty();	
		    
		    // Page 321 자바스크립트 소스 추가 시작
		    formObj.append(pageNumTag);
		    formObj.append(amountTag);
		    // Page 321 자바스크립트 소스 추가 끝
		    
		    // Page 347 자바스크립트 소스 추가 시작
		    formObj.append(keywordTag);
		    formObj.append(typeTag);
		    // Page 347 자바스크립트 소스 추가 끝
		    
		}
		// page 590 아래 소스 코딩 시작
		else if (operation === 'modify') {
			console.log("submit clicked");
			var str = "";
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
			   	console.dir(jobj);
			    // console.log("-------------------------");
			    // console.log(jobj.data("filename"));
			    str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
			});
			// console.log(str);
		    formObj.append(str).submit();
		}
		// page 590 아래 소스 코딩 끝
		formObj.submit();		
	});
});
</script>










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