<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쪽지 시험</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<!-- <script src="https://kit.fontawesome.com/79647d7f04.js" crossorigin="anonymous"></script> -->
<!-- <script defer src="/resources/javascript/message/asserts/ui.js"></script> -->
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
<!-- Load Favicon-->
<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon">
<!-- Load Material Icons from Google Fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">
<!-- Load Simple DataTables Stylesheet-->

<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
<!-- Load main stylesheet-->



<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" type="text/css">

<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.css"/>
 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
<style>
*, body { 
font-family: Pretendard, 'Noto Sans KR';
}
</style>
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">

	<script type="text/javascript">
			
			window.onload = function () { 
				$("#updateBtn").hide();
				$("#lessonNameSelect").hide();
				$("#submitBtn").hide();
				$("#addSubjectiveBtn").hide();
				$("#addNonSubjectiveBtn").hide();
				//$("#answerCheckDiv").hide();
				$("div[name='answerCheckDiv']").hide();
				$("td[name='questionBtn']").hide();
				
				
				if(${user.role eq 'teacher'}){
					//$("#checkDiv").hide();
					$("#answerCheckDiv").show();
				}else if(${user.role eq 'student'}){
					//$("#checkDiv").show();
					$("#goUpdateBtn").hide();
					$("#deleteBtn").hide();
					$("#submitBtn").show();
					document.getElementById("studentAnswer").readOnly=false;
				}else{
					//$("#checkDiv").hide();
					$("#goUpdateBtn").hide();
					$("#deleteeBtn").hide();
				}
				
				//if(${paper.homeworkCheck} == 1){
				//	$("#homeworkCheck").prop("disabled",true);
				//}
			}
			
	 		$(function() {
				
				$( "button.btn.btn-outline-primary:contains('수정')").on("click" , function() {
					
					document.getElementById("quizTitle").readOnly=false;
					document.getElementById("studentName").readOnly=false;
					document.getElementById("quizScore").readOnly=false;
					/* document.getElementById("questionContent").readOnly=false;
					document.getElementById("teacherAnswer").readOnly=false;
					document.getElementById("feedBackContent").readOnly=false; */
					
					$("textarea[name='questionContent']").attr('readOnly', false);
					$("input[name='teacherAnswer']").attr('readOnly', false);
					$("textarea[name='feedBackContent']").attr('readOnly', false);
					
					$("#goUpdateBtn").hide();
					$("#updateBtn").show();
					$("#lessonNameSelect").show();
					$("#lessonNameView").hide();
					
					$("#addSubjectiveBtn").show();
					$("#addNonSubjectiveBtn").show();
					$("td[name='questionBtn']").show();

				    /* const homeworkDueDate = document.getElementById('homeworkDueDate');
				    homeworkDueDate.type = "date"; */
				});
			});
	 		
	 		$(function() {
	 			
				$( "button.btn.btn-outline-primary:contains('확인')").on("click" , function() {
					$("form").attr("method", "POST").attr("action","/paper/updatePaperQuiz").submit();
					$("#lessonNameSelect").hide();
					$("#lessonNameView").show();
					
					$("#goUpdateBtn").show();
					$("#updateBtn").hide();
					
					$("#addSubjectiveBtn").hide();
					$("#addNonSubjectiveBtn").hide();
					$("td[name='questionBtn']").hide();
					
				});
	 		});
	 		
			function deleteBtn() {
				if(window.confirm("정말 삭제하시겠습니까?")){
					if(true){
						$("form").attr("method", "POST").attr("action","/paper/deletePaperQuiz").submit();
					}else{
						alert('삭제가 취소되었습니다.');
					}
				}	
			}
			
			function cancelBtn() {
				history.go(-1);
			}
			
			/* $(document).ready(function(){
			    $("#answerCheck").change(function(){
			        if($("#answerCheck").is(":checked")){
			            $("#answerCheck").prop("disabled",true);
			            $("form").attr("method", "POST").attr("action","/paper/updatePaperAnswerCheck").submit();
			        }
			    });
			}); */
			
			$(document).ready(function() {
				var maxFields = 6;
				var wrapper = $(".input_fields_wrap");
				var addNonSubjectiveButton = $("#addNonSubjectiveBtn");
				var addSubjectiveButton = $("#addSubjectiveBtn");
					
				var x=1;
				$(addNonSubjectiveButton).click(function(e){
					e.preventDefault();
					if(x < maxFields){
						x++;
						/* $(wrapper).append('<div><input type="text" name="questionNo"><button id="deleteSubQuestionBtn" class="btn btn-text-primary" type="button">삭제</button></div>') */
						$(wrapper).append('<div><table class="table table-bordered" name="nonSubjectiveQuestion" id="nonSubjectiveQuestion"><tr><td colspan="4"><input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" id="questionNo" name="questionNo"aria-label=".form-control-sm example"></td><td colspan="1"><div class="form-check" align="right"><input class="form-check-input" id="answerCheck" type="checkbox" value="" checked=""><label class="form-check-label" for="flexCheckChecked">정답</label></div></td></tr><tr><td colspan="5"><textarea type="text" name="questionContent" id="questionContent" class="form-control" placeholder="문제내용을 입력하세요"></textarea></td></tr><tr><td><div class="form-check"><input class="form-check-input" id="choiceNo1" type="radio" name="choiceNo"><input class="form-control form-control-sm" style="width:100px" type="text" placeholder="1번보기 입력" id="choiceContent1" name="choiceContent"aria-label=".form-control-sm example"></div></td><td><div class="form-check"><input class="form-check-input" id="choiceNo2" type="radio" name="choiceNo"><input class="form-control form-control-sm" style="width:100px" type="text" placeholder="2번보기 입력" id="choiceContent2" name="choiceContent"aria-label=".form-control-sm example"></div></td><td><div class="form-check"><input class="form-check-input" id="choiceNo3" type="radio" name="choiceNo"><input class="form-control form-control-sm" style="width:100px" type="text" placeholder="3번보기 입력" id="choiceContent3" name="choiceContent"aria-label=".form-control-sm example"></div></td><td><div class="form-check"><input class="form-check-input" id="choiceNo4" type="radio" name="choiceNo"><input class="form-control form-control-sm" style="width:100px" type="text" placeholder="4번보기 입력" id="choiceContent4" name="choiceContent"aria-label=".form-control-sm example"></div></td><td><div class="form-check"><input class="form-check-input" id="choiceNo5" type="radio" name="choiceNo"><input class="form-control form-control-sm" style="width:100px" type="text" placeholder="5번보기 입력" id="choiceContent5" name="choiceContent"aria-label=".form-control-sm example"></div></td></tr><tr><td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" class="form-control" placeholder="문제 정답을 입력하세요"></input></td></tr></table><button id="deleteQuestionBtn" class="btn btn-text-primary" type="button">삭제</button></div>')
					}
				});
				
				$(addSubjectiveButton).click(function(e){
					e.preventDefault();
					if(x < maxFields){
						x++;
						$(wrapper).append('<div><table class="table table-bordered" name="subjectiveQuestion" id="subjectiveQuestion"><tr><td colspan="4"><input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" id="questionNo" name="questionNo"aria-label=".form-control-sm example"></td><td colspan="1"><div class="form-check" align="right"><input class="form-check-input" id="answerCheck" type="checkbox" value="" checked=""><label class="form-check-label" for="flexCheckChecked">정답</label></div></td></tr><tr><td colspan="5"><textarea type="text" name="questionContent" id="questionContent" class="form-control" placeholder="문제내용을 입력하세요"></textarea></td></tr><tr><td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" class="form-control" placeholder="문제 정답을 입력하세요"></input></td></tr></table><button id="updateQuestionBtn" class="btn btn-text-primary" type="button">수정</button><button id="deleteQuestionBtn" class="btn btn-text-primary" type="button">삭제</button></div>')
					}
				});
				
				$(wrapper).on("click","#deleteQuestionBtn", function(e){
					e.preventDefault();
					$(this).parent('div').remove();
					x--;
				})
				
/* 				$(wrapper).on("click","#updateQuestionBtn", function(e){
					e.preventDefault();
					
				}) */
			});
	
	</script>
</head>
<body>
	<form method="post" id="quizForm">
		
		<div class="border border-top-0 p-3 p-sm-5 bg-light">
			<div class="col flex-shrink-0 mb-5 mb-md-0" style="margin: 10px 0px 10px 0px">
		        <h1 class="display-4 mb-0">시 험 등 록</h1>
		        <div class="text-muted">Add Quiz</div>
	    	</div>
	    	
	    	<input type="hidden" id="quizCode" name="quizCode" value="${paper.quizCode }">
	    	
	        <div class="input-group mb-3" style="margin: 20px 0px 20px 0px" id="lessonNameSelect">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">수업명</button>
	            <select class="form-select" aria-label="Default select example" id="lessonName" name="lessonName">
	            	<c:set var="i" value="0"/>
	            	<c:forEach var="lesson" items="${list }">
	            	<c:set var="i" value="${i+1 }"/>
	            		<option align="center" >${lesson.lessonName }
	            	</c:forEach>
                </select>
	        </div>
	        <div id="lessonNameView">
	        	<button class="btn btn-outline-primary" type="button" style="width:120px;">수업명</button>
	            <input class="form-control" type="text"  aria-label="Example text with button addon" 
	             id="lessonNameInput" name="lessonName" value="${paper.lessonName}" aria-describedby="button-addon1" readOnly="true">
	        </div>
	        <div class="input-group mb-3">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">시험명</button>
	            <input class="form-control" type="text" aria-label="Example text with button addon" 
	             id="quizTitle" name="quizTitle" value="${paper.quizTitle}" aria-describedby="button-addon1" readOnly="true">
	        </div>
	        <div class="input-group mb-3">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">학생 이름</button>
	            <input class="form-control" type="text" aria-label="Example text with button addon" 
	            id="studentName" name="studentName" value="${paper.studentName}" aria-describedby="button-addon1" readOnly="true">
	        </div>
 	        <div class="input-group mb-3" id="scoreDiv">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">점수</button>
	            <input class="form-control" type="number" aria-label="Example text with button addon" 
	            id="quizScore" name="quizScore" value="${paper.quizScore}" aria-describedby="button-addon1" readOnly="true">
	        </div>
		</div>
		
		<div class="input_fields_wrap">
			<button id="addSubjectiveBtn" class="btn btn-text-primary" type="button"><i class="bi bi-plus-square"></i>주관식 문제 추가</button>	
			<button id="addNonSubjectiveBtn" class="btn btn-text-primary" type="button"><i class="bi bi-plus-square"></i>객관식 문제 추가</button>	
				<div>
		    		<table class="table table-bordered" name="subjectiveQuestion" id="subjectiveQuestion">
		    			<c:set var="i" value="0"/>
		    			<c:forEach var="paper" items="${listQuestion }">
		    				<c:set var="i" value="${i+1 }"/>
				     			<tr>
				     				<td colspan="4">
				     						<input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" 
				                                	id="questionNo" name="questionNo" value="${i }" aria-label=".form-control-sm example" readOnly="true">
		                                	<input type="hidden" id="questionCode" name="questionCode" value="${paper.questionCode }">
				     				</td>
				     				<td colspan="1">
				     					<div class="form-check" align="right" id="answerCheckDiv" name="answerCheckDiv">
				                             <input class="form-check-input" id="answerCheck" type="checkbox" value="${paper.answerCheck }" checked="">
				                             <label class="form-check-label" for="flexCheckChecked">정답</label>
				                        </div>
				                   </td>
				     			</tr>
				     			<tr>
				     				<td colspan="5"><textarea type="text" name="questionContent" id="questionContent" value="${paper.questionContent}" class="form-control" readOnly="true">${paper.questionContent}</textarea></td>
				     			</tr>
				     			<tr>
				     				<td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" value="${paper.teacherAnswer}" class="form-control" readOnly="true"></input></td>
				     			</tr>
				     			<tr>
				     				<td colspan="5"><textarea name="studentAnswer" id="studentAnswer" value="${paper.studentAnswer}" class="form-control" placeholder="학생정답입력란" readOnly="true">${paper.studentAnswer}</textarea></td>
				     			</tr>
				     			<tr>
				     				<td colspan="5"><textarea name="feedBackContent" id="feedBackContent" value="${paper.feedBackContent}" class="form-control" placeholder="피드백 입력란" readOnly="true">${paper.feedBackContent}</textarea></td>
				     			</tr>	
				     			<tr>
				     				<td colspan="5" id="questionBtn" name="questionBtn">
					     				<button id="updateQuestionBtn" class="btn btn-text-primary" type="button">수정</button>
					     				<button id="deleteQuestionBtn" class="btn btn-text-primary" type="button">삭제</button>
				     				</td>
				     			</tr>	    				
		    			</c:forEach>		     			
		    		</table>
				
				</div>
		</div>
		
</form>			
	    <div align="center">		
	    		 <button id="submitBtn" onclick="submitBtn();" class="btn btn-outline-primary">제출</button>	
			 	 <button id="goUpdateBtn"  class="btn btn-outline-primary">수정</button>
			 	 <button id="updateBtn" class="btn btn-outline-primary">확인</button>
			 	 <button id="deleteBtn" onclick="deleteBtn();" class="btn btn-outline-primary">삭제</button>
			 	 <button id="cancelBtn" onclick="cancelBtn();" class="btn btn-outline-primary">취소</button>

		</div>
</body>
</html>