<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지시험 등록</title>
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
<!-- <script defer src="/resources/javascript/alert/alertUI.js"></script> -->
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">


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
		/* $("#scoreDiv").hide(); */
	}
	
	function addBtn() {
		alert("눌렸다!!");
		var lessonName = $('option:selected').text().trim();
		var quizTitle = $("input[name='quizTitle']").val();
		var studentName = $("input[name='studentName']").val();
		
		if(lessonName == null || lessonName.length<1){
			alert("수업명을 반드시 입력해야합니다.");
			return;
		}
		if(quizTitle == null || quizTitle.length<1){
			alert("제목은 반드시 입력해야 합니다.");
			return;
		}
		if(studentName == null || studentName.length<1){
			alert("학생이름은 반드시 입력해야 합니다.");
			return;
		}

		$("form").attr("method","POST").attr("action" , "/paper/addPaperQuiz").submit();
	}
	
/* 	function addNonSubjective() {
		alert("눌렸다!!");
	} */
	
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
				$(wrapper).append('<div><table class="table table-bordered" name="subjectiveQuestion" id="subjectiveQuestion"><tr><td colspan="4"><input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" id="questionNo" name="questionNo"aria-label=".form-control-sm example"></td><td colspan="1"><div class="form-check" align="right"><input class="form-check-input" id="answerCheck" type="checkbox" value="" checked=""><label class="form-check-label" for="flexCheckChecked">정답</label></div></td></tr><tr><td colspan="5"><textarea type="text" name="questionContent" id="questionContent" class="form-control" placeholder="문제내용을 입력하세요"></textarea></td></tr><tr><td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" class="form-control" placeholder="문제 정답을 입력하세요"></input></td></tr></table><button id="deleteQuestionBtn" class="btn btn-text-primary" type="button">삭제</button></div>')
			}
		});
		
		$(wrapper).on("click","#deleteQuestionBtn", function(e){
			e.preventDefault();
			$(this).parent('div').remove();
			x--;
		})
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
	        <div class="input-group mb-3" style="margin: 20px 0px 20px 0px" >
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">수업명</button>
	            <select class="form-select" aria-label="Default select example" id="lessonName" name="lessonName">
	            	<c:set var="i" value="0"/>
	            	<c:forEach var="lesson" items="${list }">
	            	<c:set var="i" value="${i+1 }"/>
	            		<option align="center" value="${lesson.lessonName }">${lesson.lessonName }
	            	</c:forEach>
                </select>
	        </div>
	        <div class="input-group mb-3">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">시험명</button>
	            <input class="form-control" type="text" placeholder="시험명을 입력하세요" aria-label="Example text with button addon" 
	             id="quizTitle" name="quizTitle" value="${paper.quizTitle}" aria-describedby="button-addon1">
	        </div>
	        <div class="input-group mb-3">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">학생 이름</button>
	            <input class="form-control" type="text" placeholder="학생 이름을 입력하세요" aria-label="Example text with button addon" 
	            id="studentName" name="studentName" value="${paper.studentName}" aria-describedby="button-addon1">
	        </div>
<%-- 	        <div class="input-group mb-3" id="scoreDiv">
	            <button class="btn btn-outline-primary" type="button" style="width:120px;">점수</button>
	            <input class="form-control" type="number" placeholder="" aria-label="Example text with button addon" 
	            id="quizScore" name="quizScore" value="${paper.quizScore}" aria-describedby="button-addon1">
	        </div> --%>
		</div>
		
		<div class="input_fields_wrap">
			<button id="addSubjectiveBtn" class="btn btn-text-primary" type="button"><i class="bi bi-plus-square"></i>주관식 문제 추가</button>	
			<button id="addNonSubjectiveBtn" class="btn btn-text-primary" type="button"><i class="bi bi-plus-square"></i>객관식 문제 추가</button>	
				<%-- <div>
					<table class="table table-bordered" name="nonSubjectiveQuestion" id="nonSubjectiveQuestion">
		     			<tr>
		     				<td colspan="4">
		     						<input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" 
		                                	id="questionNo" name="questionNo"aria-label=".form-control-sm example">
		     				</td>
		     				<td colspan="1">
		     					<div class="form-check" align="right">
		                             <input class="form-check-input" id="answerCheck" type="checkbox" value="" checked="">
		                             <label class="form-check-label" for="flexCheckChecked">정답</label>
		                        </div>
		                   </td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea type="text" name="questionContent" id="questionContent" class="form-control" placeholder="문제내용을 입력하세요"></textarea></td>
		     			</tr>
		     			<tr>
		     				<td>
		     					<div class="form-check">
		                                <input class="form-check-input" id="choiceNo1" type="radio" name="choiceNo">
		                                <input class="form-control form-control-sm" style="width:100px" type="text" placeholder="1번보기 입력" 
		                                	id="choiceContent1" name="choiceContent"aria-label=".form-control-sm example">
		                            </div>
		     				</td>
		     				<td>
		     					<div class="form-check">
		                                <input class="form-check-input" id="choiceNo2" type="radio" name="choiceNo">
		                                <input class="form-control form-control-sm" style="width:100px" type="text" placeholder="2번보기 입력" 
		                                	id="choiceContent2" name="choiceContent"aria-label=".form-control-sm example">
		                            </div>
		     				</td>
		     				<td>
		     					<div class="form-check">
		                                <input class="form-check-input" id="choiceNo3" type="radio" name="choiceNo">
		                                <input class="form-control form-control-sm" style="width:100px" type="text" placeholder="3번보기 입력" 
		                                	id="choiceContent3" name="choiceContent"aria-label=".form-control-sm example">
		                            </div>
		     				</td>
		     				<td>
		     					<div class="form-check">
		                                <input class="form-check-input" id="choiceNo4" type="radio" name="choiceNo">
		                                <input class="form-control form-control-sm" style="width:100px" type="text" placeholder="4번보기 입력" 
		                                	id="choiceContent4" name="choiceContent"aria-label=".form-control-sm example">
		                            </div>
		     				</td>
		     				<td>
		     					<div class="form-check">
		                                <input class="form-check-input" id="choiceNo5" type="radio" name="choiceNo">
		                                <input class="form-control form-control-sm" style="width:100px" type="text" placeholder="5번보기 입력" 
		                                	id="choiceContent5" name="choiceContent"aria-label=".form-control-sm example">
		                            </div>
		     				</td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" class="form-control" placeholder="문제 정답을 입력하세요"></input></td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea name="studentAnswer" id="studentAnswer" class="form-control" placeholder="학생정답입력란"></textarea></td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea name="feedBackContent" id="feedBackContent" class="form-control" placeholder="피드백 입력란"></textarea></td>
		     			</tr>
		    		</table>
		    		
		    		<table class="table table-bordered" name="subjectiveQuestion" id="subjectiveQuestion">
		     			<tr>
		     				<td colspan="4">
		     						<input class="form-control form-control-sm" style="width:60px" type="text" placeholder="문제번호" 
		                                	id="questionNo" name="questionNo"aria-label=".form-control-sm example">
		     				</td>
		     				<td colspan="1">
		     					<div class="form-check" align="right">
		                             <input class="form-check-input" id="answerCheck" type="checkbox" value="" checked="">
		                             <label class="form-check-label" for="flexCheckChecked">정답</label>
		                        </div>
		                   </td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea type="text" name="questionContent" id="questionContent" class="form-control" placeholder="문제내용을 입력하세요"></textarea></td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><input type="text" name="teacherAnswer" id="teacherAnswer" class="form-control" placeholder="문제 정답을 입력하세요"></input></td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea name="studentAnswer" id="studentAnswer" class="form-control" placeholder="학생정답입력란"></textarea></td>
		     			</tr>
		     			<tr>
		     				<td colspan="5"><textarea name="feedBackContent" id="feedBackContent" class="form-control" placeholder="피드백 입력란"></textarea></td>
		     			</tr>
		    		</table>
				<button id="deleteQuestionBtn" class="btn btn-text-primary" type="button">삭제</button>
				</div> --%>
		</div>
		
</form>			
	    <div align="center">			
		 	 <button id="addBtn" onclick="addBtn();" class="btn btn-outline-primary">등록</button>
		 	 <button id="cancelBtn" onclick="cancelBtn();" class="btn btn-outline-primary">취소</button>
		</div>
 
		        

<!-- 		<button id="addSubjective" class="btn btn-text-primary" onclick="addSubjective();" type="button"><i class="bi bi-plus-square"></i>주관식 문제 추가</button>
	    <button id="addNonSubjective" class="btn btn-text-primary" onclick="addNonSubjective();" type="button"><i class="bi bi-plus-square"></i>객관식 문제 추가</button>	 -->

	        <!-- <button id="deleteSubjective" class="btn btn-text-primary" type="button">주관식 문제 삭제</button>
	        <button id="deleteNonSubjective" class="btn btn-text-primary" type="button">객관식 문제 삭제</button> -->


</body>
</html>