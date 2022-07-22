<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AzA : 과제 조회</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<!-- <script src="https://kit.fontawesome.com/79647d7f04.js" crossorigin="anonymous"></script> -->
<!-- <script defer src="/resources/javascript/message/asserts/ui.js"></script> -->
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<link
	href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css"
	rel="stylesheet">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
<link
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
	rel="stylesheet">
<!-- Load main stylesheet-->



<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.css" />
<script src="sweetalert2.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.js"></script>
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
	//$("#lessonNameList").hide();
	$("#cancelBtn").hide();
	//$("#studentNameList").hide();
	
	
	if(${paper.homeworkCheck} == 1){
		$("#homeworkCheck").prop("disabled",true);
	}
	
	if(${user.role eq 'teacher'}){
		$("#checkDiv").hide();
	}else if(${user.role eq 'student'}){
		$("#checkDiv").show();
		$("#goUpdateBtn").hide();
		$("#deleteBtn").hide();
	}else{
		$("#checkDiv").hide();
		$("#goUpdateBtn").hide();
		$("#deleteBtn").hide();
	}
	
}

$(document).ready(function(){
    $("#homeworkCheck").change(function(){
        if($("#homeworkCheck").is(":checked")){
            $("#homeworkCheck").prop("disabled",true);
            $("form").attr("method", "POST").attr("action","/paper/updatePaperHomeworkCheck").submit();
        }
    });
});


</script>

</head>

<body class="nav-fixed bg-light">

	<div id="layoutDrawer_content">
		<!-- Main page content-->
		<main>
			<header class="mb-5"> </header>
			<div class="container-xl px-5">
				<div class="card card-raised mb-5">
					<div class="card-header bg-transparent px-4">
						<div class="d-flex justify-content-between align-items-center">
							<div class="me-4">
								<h2 class="display-6 mb-0">과제 상세 조회</h2>
								<div class="card-text">ASSIGNMENT</div>
							</div>
						</div>
					</div>
					<form>
						<div class="card-body p-4">
							<input type="hidden" name="homeworkCode" id="homeworkCode"
								value="${paper.homeworkCode }" />
							<div class="input-group mb-3 align-middle text-center align-items-center"
								id="lessonNameListInput">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업명</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="lessonName"
									name="lessonName" value="${paper.lessonName}"
									aria-describedby="button-addon1" readOnly="true">
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2">과제 제목</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="homeworkTitle"
									name="homeworkTitle" value="${paper.homeworkTitle}"
									aria-describedby="button-addon1" readOnly="true">
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center" id="studentNameInput">
								<span class="text-primary p-1 mr-2">학생 이름</span> 
									<input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon" id="studentName"
									name="studentName" value="${paper.studentName}"
									aria-describedby="button-addon1" readOnly="true">
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2">과제 마감 날짜</span> <input
									class="form-control" type="text" placeholder=""
									aria-label="Example text with button addon"
									id="homeworkDueDate" name="homeworkDueDate"
									value="${paper.homeworkDueDate}"
									aria-describedby="button-addon1" readOnly="true">
							</div>
							<div class="mb-0">
								<textarea class="form-control" id="homeworkContent"
									name="homeworkContent" placeholder="과제 내용을 입력하세요"
									value="${paper.homeworkContent}" rows="12" readonly>${paper.homeworkContent}</textarea>
							</div>
							<div id="checkDiv" class="form-check" align="center"
								style="margin: 20px 0px 0px 0px; font-size: 20px;">
								<input class="form-check-input" id="homeworkCheck"
									name="homeworkCheck" type="checkbox" value=""> <label
									class="form-check-label" for="flexCheckDefault">과제 완료
									체크</label>
							</div>
						</div>
					</form>
					<div align="center" style="margin: 0px 0px 20px 0px">
						<button id="goUpdateBtn" class="btn btn-outline-primary">수정</button>
						<button id="updateBtn" class="btn btn-outline-primary">확인</button>
						<button id="deleteBtn" onclick="deleteBtn();"
							class="btn btn-outline-primary">삭제</button>
						<button id="goBackBtn" onclick="goBackBtn();"
							class="btn btn-outline-primary">이전</button>
						<button id="cancelBtn" onclick="cancelBtn();"
							class="btn btn-outline-primary">취소</button>
					</div>
				</div>
				<hr class="my-5" />
			</div>
		</main>
	</div>

	<script
		src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
	<script src="/resources/javascript/paper/paperUI.js"></script>
	<script
		src="/resources/javascript/common/datatables/datatables-simple-demo2.js"></script>
</body>

</html>