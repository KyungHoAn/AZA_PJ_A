<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<title>AZA : 수업 상세 조회</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>

<link
	href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" type="text/css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" type="text/javascript"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">	
	
	
<script type="text/javascript">


function fncdeleteLesson(){
   var lessonCode = $("input[name='lessonCode']").val();
   console.log(lessonCode);
   
   if(lessonCode != "${lesson.lessonCode}"){
      alert("수업코드가 일치하지 않습니다..");
      return;
   } else {
   $("form").attr("method","GET").attr("action","/lesson/deleteLesson").submit();
	   
   }
}

$(function(){
   $("#goDelete").on("click",function(){
      fncdeleteLesson();
   });
   
   $("#ct_btn03").on("click",function(){
      self.location="/lesson/listLesson"
   });
});
</script>

<style>
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}

</style>

</head>
<body class="nav-fixed bg-light">
	<div id="layoutDrawer_content"> 
		<main>
			<header class="mb-5"> </header>
			<div class="container-xl px-5">
				<div class="card card-raised mb-5">
					<div class="card-header bg-transparent px-4">
						<div class="d-flex justify-content-between align-items-center">
							<div class="me-4">
								<h2 class="display-6 mb-0">수업 상세 조회</h2>
								<div class="card-text">LESSON</div>
							</div>
						</div>
					</div>
					<div class="card-body p-4">
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업코드</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonCode"
									name="lessonCode" value="${lesson.lessonCode}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업명</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonName"
									name="lessonName" value="${lesson.lessonName}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 요일</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonDay"
									name="lessonDay" value="${lesson.lessonDay}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 시간</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonName"
									value="${lesson.lessonStartTime} ~ ${lesson.lessonEndTime}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 시작일</span>
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonCreateAt"
									name="lessonCreateAt" value="${lesson.lessonCreateAt}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 장소</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonPlace"
									name="lessonPlace" value="${lesson.lessonPlace}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">과목명</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="subject"
									name="subject" value="${lesson.subject}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업료</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="fees"
									name="fees" value="${lesson.fees}"
									aria-describedby="button-addon1" readOnly="true">
						</div>
						<div class="mb-0">
								<textarea class="form-control" id="lessonContent"
									name="lessonContent" placeholder="과제 내용을 입력하세요"
									value="${lesson.lessonContent}" rows="12" readonly>${lesson.lessonContent}</textarea>
						</div>
					</div>
					<c:choose>
						<c:when test="${user.role eq 'teacher'}">
							<div align="center" style="margin: 0px 0px 20px 0px">
								<button id="updateBtn" class="btn btn-outline-primary">수정</button>
								<button id="deleteBtn"  data-bs-toggle="modal" data-bs-target="#myModal" class="btn btn-outline-danger">삭제</button>
							</div>
							<form>
								 <div class="modal fade" id="myModal" role="dialog"> 
								 <div class="modal-dialog">
								
								 <!-- Modal content-->
								<div class="modal-content">
								 <div class="modal-header">
								 <h4 class="modal-title" align="center">수업코드를 입력해주세요</h4> 
								 </div>
								 <div class="modal-body" align="center">
											<div class="form-group">
									         <label for="lessonCode" class="col-sm-2 control-label">수업코드</label>
									         <div class="col-sm-10">
									           <input type="text" class="form-control mt-2" id="lessonCode" name="lessonCode" placeholder="수업코드">
									         </div>
									       </div>
								</div>
								<div class="modal-footer">
								 	<button type="button" class="btn btn-outline-danger btn-sm align-items-center justify-center" id="goDelete">삭제</button>
								</div>
								</div>
								</div>
								</div>
							</form>
						</c:when>
					</c:choose>
				</div>
				<hr class="my-5" />
			</div>
		</main>
		<!-- Modal -->
		
	       
						
						
	        		</div>


<!-- Load Bootstrap JS bundle-->

    <script
		src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
	<script src="/resources/javascript/lesson/LessonUI.js"></script>
</body>
</html>