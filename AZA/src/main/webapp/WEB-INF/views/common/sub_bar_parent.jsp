<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Aza : main</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<script defer src="https://kit.fontawesome.com/57ea3feb1d.js" crossorigin="anonymous"></script>
<script defer src="/resources/javascript/message/asserts/ui.js"></script>
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<script defer src="/resources/javascript/students/studentsUI.js"></script>
<script defer src="/resources/javascript/common/indexUI.js"></script>

<link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
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
<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
	
<style>
*, body { 
font-family: Pretendard, 'Noto Sans KR';
}

*-ms-overflow-style: {none;
	
}

*::-webkit-scrollbar {
	display: none;
}
</style>
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/attendance.css" rel="stylesheet">
<script type="text/javascript">
</script>



</head>

<body class="nav-fixed bg-light">

	<div id="layoutDrawer_content">
	
		<!-- Main page content-->
		<main class="mt-12">
			<header class="main-header">
				<!-- page header -->
				<div class="row justify-content-center gx-5">
                      <div class="row justify-content-end col-md-8 col-lg-6">
                         
						   
                      <nav>
							  <div class="nav justify-content-center nav-tabs mt-3" id="nav-tab" role="tablist">			  	
							    <button class="subframe_nav nav-link active" data-url="/lesson/listLesson" id="nav-lessonList-tab" data-bs-toggle="tab" data-bs-target="#nav-parent-kids-tab" type="button" role="tab" aria-controls="nav-home" aria-selected="true">수업목록</button>
							    <button class="subframe_nav nav-link" data-url="/students/listStudentsAttendance" id="nav-studentsAttendance-tab" data-bs-target="#nav-parent-kids-tab" data-bs-toggle="tab"type="button" role="tab" aria-controls="nav-profile" aria-selected="false">출석</button>
							    <button class="subframe_nav nav-link" data-url="/students/manageStudentsExam"  id="nav-studentsExam-tab" data-bs-toggle="tab"type="button" role="tab" data-bs-target="#nav-parent-kids-tab" aria-controls="nav-contact" aria-selected="false">성적</button>
							    <button class="subframe_nav nav-link" data-url="/paper/listPaperHomework"  id="nav-paperHomework-tab" data-bs-toggle="tab"type="button" role="tab" data-bs-target="#nav-parent-kids-tab" aria-controls="nav-contact" aria-selected="false">과제</button>
							    <!-- <button class="subframe_nav nav-link" id="nav-paperQuiz-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#nav-parent-kids-tab" aria-controls="nav-contact" aria-selected="false">쪽지시험</button> -->
							    <button class="subframe_nav nav-link" data-url="/lesson/manageLessonBook" id="nav-lessonBook-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#nav-parent-kids-tab" aria-controls="nav-contact" aria-selected="false">교재</button>
							  </div>
							</nav>
                      </div>
                  </div>
			</header>
			<div class="container-xl p-0 mx-0"> 
			                            
							<div class="tab-content" id="nav-tabContent">
							  <div class="tab-pane fade show active" id="nav-lessonList" role="tabpanel" aria-labelledby="nav-parent-kids-tab">
							  
							  
							  
							  
							  <iframe id="subFrame" class="none-scroll" src="/lesson/listLesson" style="display:block; width:100vw; height: 100vh; z-index:9990; opacity: 100%" allowfullscreen></iframe>
							  
							  
							  </div>
							</div>
			</div>
		     
		</main>
	<!-- Footer-->
	<footer>
	</footer>
	</div>
	  <script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.0-beta.10/chart.min.js"
		crossorigin="anonymous"></script>
	<!-- <script src="/resources/javascript/common/charts/chart-defaults.js"></script> -->
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
	<script src="https://kit.fontawesome.com/57ea3feb1d.js" crossorigin="anonymous"></script>
<!-- 	<script src="/resources/javascript/common/charts/demos/dashboard-chart-area-light-demo.js"></script> -->
	<script type="text/javascript">

</script>
</body>
</html>