<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>



<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Reset Password - Material Admin Pro</title>
<!-- Load Favicon-->
<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon">
<!-- Load Material Icons from Google Fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">
<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet">
<!-- Load main stylesheet-->
<link href="/resources/css/template.css" rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet" />
<link href="/resources/css/main.css" rel="stylesheet" />

<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon" />

<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet" />



<meta charset="UTF-8">
<title>Find ID</title>
<style>


*, body {
	font-family: Pretendard, 'Noto Sans KR';
}


</style>
<!-- Load Favicon-->


</head>

<body class="bg-primary">
	<!-- Layout wrapper-->
	<div id="layoutAuthentication">
		<!-- Layout content-->
		<div id="layoutAuthentication_content">
			<!-- Main page content-->
			<main>
				<!-- Main content container-->
				<div class="container" >
					<div class="row justify-content-center">
						<div class="col-xxl-4 col-xl-5 col-lg-6 col-md-8">
							<div class="card mt-5 mt-xl-10 mb-4 " style="border:none; background-color: transparent;">
								<div class="card-body pb-1">
									<!-- Auth header with logo image-->
									<div class="text-center">
										<!-- <img class="mb-3" src="/resources/img/logo2.png" alt="..."
											style="height: 100px"> -->
										<h3 class="display-5 mb-2 text-primary subFont">아이디 찾기</h3>
									</div>
									<!-- Reset password submission form-->
									<form class="rounded-3 p-5 form-signin" method="post"action="find_id"
										name="findform" style="background: rgba(51, 170, 51, .1)">
										<div class="mb-4" align="center">
											<input type="text"class="form-control rounded-pill text-white"
												style="border: 0.8px solid #978BC0; background-color: transparent;"
												value="" placeholder="이름" id="userName"
													name="userName" >
										</div>


										<div class="mb-4">
												<input type="text" class="form-control rounded-pill text-white"
												style="border: 0.8px solid #978BC0; background-color: transparent;"
												value="" placeholder="핸드폰번호" id="phone"
													name="phone">

										</div>


										<div
											class="form-label-group d-flex align-items-end justify-content-end pb-2">
											<button
												class="btn btn-outline-light btn-block text-uppercase m-1 mb-0 btn-sm"
												type="button">취소</button>
											<input
												class="btn btn-outline-primary btn-block text-uppercase m-1 mb-0 btn-sm"
												type="submit" value="check">
										</div>


										<!-- 이름과 전화번호가 일치하지 않을 때-->
										<c:if test="${check == 1}">
											<script>
            opener.document.findform.userName.value = "";
            opener.document.findform.phone.value = "";
         </script>
											<label class="text-white mt-1 text-end">일치하는 정보가 존재하지 않습니다.</label>
										</c:if>

										<!-- 이름과 비밀번호가 일치하지 않을 때 -->
										<c:if test="${check == 0 }">
											<label class="text-white mt-1 text-end">찾으시는 아이디는 '<span class="text-primary">${id}</span>' 입니다.</label>
											<div
												class="form-label-group d-flex align-items-center justify-content-between my-8">
												<button
													class="btn btn-outline-light btn-block text-uppercase m-1 mb-0 btn-sm"
													type="button">비밀번호 재설정</button>
												<button
													class="btn btn-outline-primary btn-block text-uppercase m-1 mb-0 btn-sm"
													type="button">로그인 화면으로</button>
											</div>
										</c:if>


									</form>
								</div>
							</div>
							<!-- Auth card message-->
							<div class="text-center">
								<a class="small fw-500 text-decoration-none link-white"
									href="/user/addUser">가입된 정보가 없으신가용? 회원가입하세요!</a>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<!-- Layout footer-->
		<div id="layoutAuthentication_footer">
			<!-- Auth footer-->

		</div>
	</div>
	<!-- Load Bootstrap JS bundle-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<!-- Load global scripts-->


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
   
   $( function() {
      $("button:contains('비밀번호 재설정')").on("click" , function() {
         self.location = "/user/findPassword"
      });
   });
   
   $( function() {
      $("button:contains('로그인 화면으로')").on("click" , function() {
         self.location = "http://127.0.0.1:8080/"
      });
   });
   
   $( function() {
      $("button:contains('취소')").on("click" , function() {
         self.location = "http://127.0.0.1:8080/"
      });
   });

      
   </script>
</body>
</html>