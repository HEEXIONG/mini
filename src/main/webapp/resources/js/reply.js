// Page399 : reply.js는 아무 기능 없이 간단히 동작하는 코드만을
// 넣어서 확인하는 용도로 사용합니다.
// reply.js 파일은 게시물의 조회 페이지에서 사용하기 위해서
// 작성된 것이므로, views/board/get.jsp 파일에 추가해 줍니다.
console.log("Reply Module....... 동작 확인!");

// Page401 : 모듈 구성하기 : 모듈 패턴은 Java의 클래스처럼 JavaScript를 이용해서
// 메서드를 가지는 객체를 구성합니다. 모듈 패턴은 JavaScript의 즉시 실행함수와 '{}'를 이용해서
// 객체를 구성합니다.
// JavaScript의 즉시 실행함수는 () 안에 함수를 선언하고 바깥쪽에서 실행해 줍니다.
// 즉시 실행함수는 함수의 실행 결과가 바깥쪽에 선언된 변수에 할당됩니다. 다음은
// replyService라는 변수에 name이라는 속성에 'AAAA'라는 속성값을 가진 객체가 할당됩니다.
var replyService = (function() {

	// Page402 연습할 때 아래 구문은 주석 처리 합니다.
	//	return {name : "AAAA"};
	// Page 403 : replyService 객체의 내부에 add라는 메서드 작성해 줌.
	// add() 메서드는 외부에서는 replyService.add(객체, 콜백)를 전달하는 형태로
	// 호출할 수 있습니다.
	
	function add(reply, callback) {
		console.log("reply..... 처리 확인!");
	// Page 403 : reply.js 내에 add 함수는 Ajax를 이용해서 POST 방식으로 호출하도록 합니다.
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			// add() 메서드의 데이터 전송 타입은 application/json; charset=utf-8
			// 방식으로 전송합니다. 그리고, 파라미터로 callback과 error를 함수로
			// 받게 하며, 만일 Ajax 호출이 성공하고, callback 값으로 적절할 함수가
			// 존재한다면 해당 함수를 호출해서 결과를 반영하는 방식입니다.			
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		})
	
	}
	
	// Page406 : jQuery의 getJSON() 사용해서, 댓글의 목록 처리 확인
	// getList() 메서드는 param이라는 객체를 통해서 필요한 파라미터를 전달 받아서
	// JSON 목록을 호출합니다. JSON 형태가 필요하므로 URL 호출 시 확장자를
	// '.json'으로 요구합니다. 이제 get.jsp에서 해당 게시물의 모든 댓글을 가져오는지 확인하는
	// get.jsp 소스 수정 코드를 진행해 줍니다.
	
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if(callback){
						// callback(data); // 댓글 목록만 가져오게 함

			// Page437 댓글 숫자와 목록을 가져오는 경우, 위에 소스는 주석 처리하고,
			// 아래 소스를 추가 코딩해 줍니다.
						callback(data.replyCnt, data.list);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
			}
	
	// Page 408 댓글 삭제는 DELETE 방식을 통해서 해당 URL을 호출해서 처리해 줍니다.
	// 댓글 삭제를 처리하는 remove() 메서드를 정의해 줍니다.
	
	//page731
	function remove(rno, replyer, callback, error) {
	      $.ajax({
	         type : 'delete',
	         url : '/replies/delete/' + rno,
	         data : JSON.stringify({rno:rno,replyer:replyer}),
	         contentType : "application/json; charset=utf-8",
	         success : function(deleteResult, status, xhr) {
	            if(callback){
	               callback(deleteResult);
	            }
	         },
	         error : function(xhr, status, er) {
	            if(error){
	               error(er);
	            }
	         }
	      });
	   }
	
	// Page 410 : 댓글 수정은 수정하는 내용과 함께 댓글의 번호를 전송합니다.
	// 댓글의 내용은 JSON 형태로 전송하기 때문에 댓글 등록과 비슷한 부분이 많습니다.
	// 이제, get.jsp 소스 코딩을 해야합니다. 이때, replyService를 이용하는
	// get.jsp에서는 댓글 번호는 데이터베이스에 존재하는 댓글의 번호를 이용해야 합니다.
	// 댓글은 수정하는 내용이 댓글의 내용 밖에 없지만 JavaScript 객체로 처리하는 방식을
	// 활용합니다.
	function update(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/request/' + reply.rno,
			data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					if(callback){
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if(error){
						error(er);
					}
				}
		});
	}
	
	// Page 413 댓글 조회 처리 : 특정 번호의 댓글 조회는 GET 방식으로 동작하므로
	//                      reply.js에서 처리해 줍니다.
	// 그리고, get.jsp에서는 댓글의 번호만을 전달 처리 합니다.
	function get(rno, callback, error) {
		$.get("/replies/" + rno + ".json", function(result) {
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	
	// Page417~Page418 : 댓글에 대한 시간 처리 소스 코딩 시작
	// XML이나 JSON 형태로 데이터를 받을 때는 순수하게 숫자로 표현되는 시간 값이 나오게 되어
	// 있으므로, 화면에서는 이를 변환해서 사용하는 것이 좋습니다. 날짜 포맷의 경우, 문화권마다
	// 표기 순서 등이 다르기 때문에 화면에서 포맷을 처리하는 방식을 권장합니다.
	// 최근 웹페이지들을 보면 해당일에 해당하는 데이터는 '시/분/초'를 보여주고, 전날에 등록된
	// 데이터들은 '년/월/일' 등을 보여주는 경우가 많습니다. 현재 시간을 기준으로 해서
	// 화면에 내용이 달라지도록 하는 부분을 다음과 같이 displayTime() 메서드로 구현해 봅니다.
	// JSON 형태로 Date 형식의 날짜를 받아올 경우 날짜 처리가 안된 순수하게 숫자로 표현되는 시간 값이 나오게 됩니다. 그래서 아래와 같이 displayTime() 메서드로 변환 처리를 해줍니다.
	// 해당일 시간, 날짜 처리 함수 displayTime() 메서드 정의
	// displayTime() 메서드는 Ajax에서 데이터를 가져와서 HTML을 만들어 주는
	// get.jsp 부분에 'replyService.displayTime(list[i].replyDate)'의
	// 형태로 적용합니다.
	function displayTime(timeValue) {
		var today = new Date();
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		// 24시간이 지나지 않은 댓글(시간 표시 예시 : 14:20:22)
		if(gap < (1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ":", (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
		  // 24시간이 지난 댓글(날짜 표시 예시 : 2022/03/22)
		} else {
			var yy = dateObj.getFullYear();
			// getMonth() is zero-based 이기 때문에 +1을 처리해 줌.
			var mm = dateObj.getMonth() +1;
			var dd = dateObj.getDate();
			
			return[yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
		}
	};	
	
	return {
		add:add,
		getList : getList, // 옆에 소스는 Page 407 하단 소스 내용 추가 내용입니다.
		remove : remove, // 옆에 소스는 Page 409 상단 소스 내용 추가 내용입니다.
		update : update, // 옆에 소스는 Page 411 상단 소스 내용 추가 내용입니다.
		get : get, // 옆에 소스는 Page 413 상단 소스 내용 추가 내용입니다.
		displayTime : displayTime // 옆에 소스는 Page 418 소스 추가 내용입니다.
	};
	
})();

