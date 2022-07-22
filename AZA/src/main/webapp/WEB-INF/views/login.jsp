<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html>
<head>
<!-- Load Favicon-->
<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon" />
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet" />
<!-- Roboto and Roboto Mono fonts from Google F	onts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet" />
<!-- Load main stylesheet-->
<link href="/resources/css/styles.css" rel="stylesheet" />


<link href="assets/img/favicon.ico" rel="shortcut icon"
	type="image/x-icon">
<!-- Load Material Icons from Google Fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
	rel="stylesheet">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<meta charset="EUC-KR">
<title>AZA : LOGIN</title>
<link rel="shortcut icon" href="/resources/img/favicon.ico" />
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<script src="/resources/javascript/user/login.js"></script>
<script type="text/javascript">
	
</script>
<style>
* {
	margin: 0px;
}
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}
</style>
</head>
<body class="bg-login">

	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content"
			class="justify-content-center text-center align-items-center">

			<main>
				<div class="container">
					<div
						class="row justify-content-center text-center align-items-center">
						<div class="col-xxl-4 col-xl-5 col-lg-6 col-md-8">
							<div>

								<div class="card-body p-5 mt-6">

									<!-- Auth header with logo image-->
									<div class="text-center">



										<img id="logoImg" class="mb-3" src="/resources/img/logo2.png" alt="..."
											style="height: 150px">

										<!-- <div class="subheading-1 mb-5">AZA에 오신걸 환영합니다!</div> -->
									</div>

									<form id="loginForm" name="loginForm">
										<div class="mb-4" align="center" id="id_text">
											<!-- <mwc-textfield class="w-100" label="ID" outlined> -->
											<!-- <input type="text" name="userId" id="userId"></input> -->
											<input type="text" name="userId" id="userId"
												class="form-control rounded-pill"
												style="border: 1px solid #978BC0; background-color: transparent;"
												value="" placeholder="아이디"></input>
											<!-- </mwc-textfield> -->
										</div>
										<div class="mb-4" align="center">
											<!-- <mwc-textfield class="w-100" label="password" outlined
												icontrailing="visibility_off" type="password"> -->

											<input type="password" name="password" id="password"
												class="form-control rounded-pill"
												style="border: 1px solid #978BC0; background-color: transparent;"
												value="" placeholder="비밀번호"></input>
											<!-- </mwc-textfield> -->
										</div>
										<hr class="nav nav-tabs" role="tablist" />


										<div class="mt-4 mb-4" align="center">
											<div class="d-grid text-center">
												<button
													class="btn btn-outline-white justify-content-center fw-bold rounded-pill"
													type="button">로그인</button>
											</div>
										</div>

										<div class="mb-1">
											<div class="btn-group" role="group">
												<button class="btn btn-text-primary" type="button">아이디 찾기</button>
												<button class="btn btn-text-primary" type="button">비밀번호 재설정</button>
												<button class="btn btn-text-primary" type="button">회원가입</button>
											</div>
										</div>
										

									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"></script> -->
	<!-- Load global scripts-->

	<!--   <script type="module" src="/resources/common/material.js"></script>
   <script src="/resources/common/scripts.js"></script>
   
    -->

	<!-- 	<script type="module" src="/resources/javascript/common/material.js"></script>
	<script type="module" src="/resources/javascript/common/scripts.js"></script> -->
</body>
</html>