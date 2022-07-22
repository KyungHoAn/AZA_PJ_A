<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AzA : 과제 등록</title>
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

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.css" />

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
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">

<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">

<script type="text/javascript"></script>
<style>
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}
</style>


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
								<h2 class="display-6 mb-0">과제 등록</h2>
								<div class="card-text">Creating an Assignment</div>
							</div>
						</div>
					</div>
					<div class="card-body p-4">
						<form>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2"
									id="inputGroup-sizing-default">수업명</span>
								<select class="form-select" aria-label="Default select example"
									id="lessonName" name="lessonCode">
									<c:set var="i" value="0" />
									<c:forEach var="lesson" items="${list }">
										<c:set var="i" value="${i+1 }" />
										<option align="left" value="${lesson.lessonCode }">${lesson.lessonName }
									</c:forEach>
								</select>
							</div>
							<div class="input-group mb-3  align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2">과제 제목</span>
								<input class="form-control" type="text"
									placeholder="과제 제목을 입력하세요"
									aria-label="Example text with button addon" id="homeworkTitle"
									name="homeworkTitle" value="${paper.homeworkTitle}"
									aria-describedby="button-addon1">
							</div>
							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2" type="button">학생 이름</span>
								<select class="form-select" aria-label="Default select example"
									id="studentName" name="studentId">
								</select>
							</div>

							<div class="input-group mb-3 align-middle text-center align-items-center">
								<span class="text-primary p-1 mr-2" type="button">과제 마감 날짜</span>
								<input class="form-control" type="date"
									placeholder="과제 마감 날짜를 입력하세요"
									aria-label="Example text with button addon"
									id="homeworkDueDate" name="homeworkDueDate"
									value="${paper.homeworkDueDate}"
									aria-describedby="button-addon1">
							</div>
							<div class="mb-0">
								<textarea class="form-control" id="homeworkContent"
									name="homeworkContent" placeholder="과제 내용을 입력하세요"
									value="${paper.homeworkContent}" rows="12"></textarea>
							</div>
						</form>
					</div>
					<div align="center" style="margin: 0px 10px 20px 10px;">
						<button id="addBtn" onclick="addBtn();"
							class="btn btn-outline-primary"
							style="margin: 0px 10px 0px 10px;">등록</button>
						<button id="cancelBtn" onclick="cancelBtn();"
							class="btn btn-outline-gray"
							style="margin: 0px 10px 0px 10px;">취소</button>
					</div>
				</div>
			</div>
	</div>
	</main>
	<!-- Footer-->
	<footer>
		<%-- <button type="button" id="open-messagePopup" class="btn float btn-lg btn-icon"><i class="material-icons">mail_outline</i></button>
		<jsp:include page="/WEB-INF/views/common/home.jsp" /> --%>
	</footer>
	</div>

	<script
		src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.0-beta.10/chart.min.js"
		crossorigin="anonymous"></script>
	<script src="/resources/javascript/paper/paperUI.js"></script>
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
	<script
		src="/resources/javascript/common/datatables/datatables-simple-demo2.js"></script>
</body>
</html>