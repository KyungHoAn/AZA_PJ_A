<%@ page language="java" contentType="text/html;" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--  ///////////////////////// JSTL  ////////////////////////// -->


<!DOCTYPE html>

<meta charset="UTF-8">
<title>개인정보수정</title>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<script defer src="https://kit.fontawesome.com/57ea3feb1d.js" crossorigin="anonymous"></script>
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<script defer src="/resources/javascript/common/indexUI.js"></script>

	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   <!-- Load Favicon-->
<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
	
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


.form-horizontal {
    padding-left: 10px;
    margin-top: 20px;
    margin-bottom: 0px;
    margin-left: 300px;
    line-height: 33px;
}


</style>
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/index_UI.css" rel="stylesheet">
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "수정"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateUser();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				history.go(-1);
			});
		});	
		
		
		///////////////////////////////////////////////////////////////////////
		function fncUpdateUser() {

				
			$("form").attr("method" , "POST").attr("action" ,"/user/getUserView").submit();
		}
	
	</script>
		
	
</head>

<body>
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class="text-info">회원정보수정</h3>
	       <h5 class="text-muted">회원정보를<strong class="text-danger"> 변경</strong>해주세요.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${user.userId }" placeholder="중복확인하세요"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">아이디는 수정불가</strong>
		      </span>
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" value="${user.password}" placeholder="변경비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="변경비밀번호 확인">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="변경회원이름" readonly>
		      <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">이름 수정불가</strong>
		      	</span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		  
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}"  placeholder="변경번호">
		    </div>
	
		    <input type="hidden" name="phone"  />
		  </div>
		  
		  <c:if test="${user.role eq 'student'}">
			
			<div class="form-group">
		    <label for="school" class="col-sm-offset-1 col-sm-3 control-label">학교</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="school" name="school" value="${user.school}" >
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="grade" class="col-sm-offset-1 col-sm-3 control-label">학년</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="grade" name="grade" value="${user.grade}" >
		    </div>
		  </div>
		</c:if>

		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	
<!-- Footer-->


	  <script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>

	<script src="/resources/javascript/students/studentsUI.js"></script>
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