<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>AZA : 수업 수정</title>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"></script>
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
								<h2 class="display-6 mb-0">수업 수정</h2>
								<div class="card-text">Update the Class</div>
							</div>
						</div>
					</div>
					<div class="card-body p-4">
						<form class="form-horizontal">
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">강의명</span>
								<input class="form-control" value="${lesson.lessonName}" type="text" placeholder="강의명을 입력하세요" aria-label="Example text with button addon" id="lessonName" name="lessonName" aria-describedby="button-addon1" style="height:36.5px;" readonly="readonly">
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center" >
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 코드</span>
								<input class="form-control" type="text" aria-label="Example text with button addon"
	            					id="lessonCode" name="lessonCode" value="${lesson.lessonCode}" aria-describedby="button-addon1" readonly="readonly"/>
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 요일</span>
								<div class="form-check form-check-inline align-middle text-center align-items-center">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="월" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">월</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="화" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">화</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="수" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">수</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="목" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">목</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="금" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">금</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="토" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">토</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input mt-2" type="checkbox" id="lessonDay" value="일" name="lessonDay" >
								  <label class="form-check-label pt-1" for="lessonDay">일</label>
								</div>
								<input type="hidden" id="hiddenValue" name="hiddenValue" value=""/>
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 시작 시간</span>
								<input class="form-control" type="time" value="${lesson.lessonStartTime}" aria-label="Example text with button addon" id="lessonStartTime" name="lessonStartTime"/></div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 종료 시간</span>
								 <input class="form-control" type="time" value="${lesson.lessonEndTime}" aria-label="Example text with button addon" id="lessonEndTime" name="lessonEndTime" aria-describedby="button-addon1"/>
								
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 장소</span>
							 <input class="form-control" value="${lesson.lessonPlace }" type="text" aria-label="Example text with button addon"  id="lessonPlace" name="lessonPlace" aria-describedby="button-addon1" placeholder="수업장소를 입력하세요"/>		
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업료</span>
								<input class="form-control" type="text" aria-label="Example text with button addon" placeholder="수업료를 입력하세요"
	            					id="fees" name="fees" value="${lesson.fees }" aria-describedby="button-addon1"/>
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업 시작일</span>
								<input class="form-control" type="text" aria-label="Example text with button addon" placeholder="수업시작일을 입력하세요"
	            					id="fees" name="fees" value="${lesson.lessonCreateAt}" aria-describedby="button-addon1"/>
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">과목명</span>
								<input class="form-control" type="text" value="${lesson.subject}" placeholder="과목명을 입력하세요" aria-label="Example text with button addon" 
	            				id="subject" name="subject" aria-describedby="button-addon1"/>
							</div>
							<div class="mb-0">
								<textarea class="form-control"  id="lessonContent" name="lessonContent" placeholder="수업 커리큘럼을 입력하세요" rows="12">${lesson.lessonContent}</textarea>
							</div>
						</form>
					</div>
					<div align="center" style="margin: 0px 10px 20px 10px;">
						<button id="updateButton"
							class="btn btn-outline-primary"
							style="margin: 0px 10px 0px 10px;">등록</button>
						<button id="cancelBtn"
							class="btn btn-outline-gray"
							style="margin: 0px 10px 0px 10px;">취소</button>
					</div>
				</div>
				</div>
				
		</main>	
</div>
<script src="/resources/javascript/lesson/lessonUI.js"></script>
</body>

</html>