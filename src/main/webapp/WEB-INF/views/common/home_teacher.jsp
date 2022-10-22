<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Aza : home - teacher</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<script defer src="https://kit.fontawesome.com/57ea3feb1d.js"
	crossorigin="anonymous"></script>
<script defer src="/resources/javascript/message/asserts/ui.js"></script>
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<script defer src="/resources/javascript/students/teacherHome.js"></script>

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
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet">
<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">


<!-- schedule -->
<link type="text/css" href="/resources/css/schedule.css"	rel="stylesheet" />
<script defer type="text/javascript"	src="/resources/javascript/schedule/main.js"></script>
<!-- <script src='../lib/main.min.js'></script> -->
<script defer type="text/javascript"	src="/resources/javascript/schedule/ko.js"></script>
<script defer type="text/javascript"	src="/resources/javascript/schedule/schedule.js"></script>
<script defer src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- bootstrap 4 -->
<link rel="stylesheet"	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />


<style>
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}

</style>
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/attendance.css" rel="stylesheet">
<link href="/resources/css/main.css" rel="stylesheet">
<script type="text/javascript">
	
</script>



</head>

<body class="nav-fixed bg-light mt-5">

	<!-- Layout content-->
	<div id="layoutDrawer_content">


		<div class="container-xl px-5">

			<div class="row" style="">
				<div class="col-6">
					<div id="calendar" class="m-0"></div>
				</div>



				<div class="col-6">
					<div class="">
						<div id="lessonTimeTable" class="col-12 mb-5 mt-2">
							<div class="card card-raised overflow-hidden h-100">
								<div class="card-header bg-primary text-white">
									<div id="curDate"
										class="d-flex justify-content-between align-items-center"></div>
								</div>
								<div class="card-body bg-transparent p-0">
									<div class="list-group list-group-flush">
										<div
											class="list-group-item d-flex justify-content-between align-items-center">
											<div class="col-6 caption font-monospace text-muted">Time</div>
											<div class="col-6 caption text-muted ms-2">수업명</div>
										</div>
										<div id="curLessonList"></div>
									</div>
								</div>
							</div>
						</div>


						<div id="addStudentsAttendance" class="col mb-5">
							<div class="card card-raised h-100 overflow-hidden">
								<div id="curLessonName" class="card-header bg-white d-flex justify-content-between">
									<div class="fw-bold text-primary">출석 체크</div>
								</div>
								<div id="curAttendanceList" class="card-body bg-transparent p-0">

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
	
	<!-- Footer-->
	<footer>
	</footer>

	<script
		src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.0-beta.10/chart.min.js"
		crossorigin="anonymous"></script>
	<!-- <script src="/resources/javascript/common/charts/chart-defaults.js"></script> -->
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
	<script src="https://kit.fontawesome.com/57ea3feb1d.js"
		crossorigin="anonymous"></script>
	<!-- 	<script src="/resources/javascript/common/charts/demos/dashboard-chart-area-light-demo.js"></script> -->
	<script type="text/javascript">
		
	</script>
</body>
</html>