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
<title>AzA : �л����� �ý���</title>
<link rel="shortcut icon" href="/resources/img/favicon.ico"/>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<script defer src="https://kit.fontawesome.com/57ea3feb1d.js"
	crossorigin="anonymous"></script>
<script defer src="/resources/javascript/common/indexUI.js"></script>
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
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
   integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
   crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<style>
*, body {
	font-family: Pretendard, 'Noto Sans KR';
}

 *-ms-overflow-style: {
	none;
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
	<div class="nav-fixed bg-light">
		<!-- Top app bar navigation menu-->

		<nav class="top-app-bar navbar navbar-expand navbar-dark bg-white">
			<div class="container-fluid px-4">
				<!-- Drawer toggle button-->
				<button class="btn btn-lg btn-icon order-1 order-lg-0"
					id="drawerToggle" href="javascript:void(0);">
					<i class="material-icons text-primary">menu</i>
				</button>
				<!-- Navbar brand-->
				<a class="navbar-brand me-auto" href="/index" data-url=''> <img
					class="px-0 mx-0" alt="" src="/resources/img/logo.png"
					style="height: 45px;">
				</a>
				<!-- Navbar items-->
				<div class="d-flex align-items-center mx-3 me-lg-0">
					<!-- Navbar buttons-->
					<div class="d-flex align-items-center">
						<!-- Notifications and alerts dropdown-->
						<div class="greetingMsg subFont text-primary fw-bold pr-3"></div>
						<div class="dropdown dropdown-notifications d-none d-sm-block">
							<button class="btn btn-lg btn-icon dropdown-toggle me-3"
								id="dropdownMenuNotifications" type="button"
								data-bs-toggle="dropdown" aria-expanded="false">
								<i class="material-icons text-primary position-relative">notifications</i>
								<span id="alertCntBadge"
									class="position-absolute translate-middle badge rounded-pill bg-danger align-middle text-center"
									style="top: 30%; left: 63%; font-size: 0.5rem;"></span>
							</button>
							<ul id="alertDropDown"
								class="dropdown-menu dropdown-menu-end me-3 mt-3 py-0 overflow-hidden"
								aria-labelledby="dropdownMenuNotifications">
							</ul>
						</div>



						<!-- User profile dropdown-->
						<div class="dropdown">
							<button class="btn btn-lg btn-icon dropdown-toggle"
								id="dropdownMenuProfile" type="button" data-bs-toggle="dropdown"
								aria-expanded="false">
								<i class="material-icons text-primary">person</i>
							</button>
							<ul class="dropdown-menu dropdown-menu-end mt-3"
								aria-labelledby="dropdownMenuProfile">
								<li class="top_nav" data-url='/user/getUser'><a
									class="dropdown-item" href="#" data-url='/user/getUser'> <i
										class="material-icons leading-icon text-primary">person</i>
										<div class="me-3">����������</div>
								</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item" href="/user/logout"> <i
										class="material-icons leading-icon text-primary">logout</i> <!-- class="material-icons leading-icon" >logout</i> -->
										<!-- 2022/06/18 MJ��Ʈ �浹 �ּ�ó������ -->

										<div class="me-3">�α׾ƿ�</div>
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>
		<!-- Layout wrapper-->
		<div id="layoutDrawer">
			<!-- Layout navigation-->
			<div id="layoutDrawer_nav">
				<!-- Drawer navigation-->
				<nav class="drawer accordion drawer-light bg-white"
					id="drawerAccordion">
					<div class="drawer-menu">
						<div class="nav">
							<!-- Drawer section heading (Account)-->
							<div
								class="drawer-menu-heading d-sm-none titleFont text-primary fs-4">Account</div>
							<!-- Drawer link (Notifications)-->
							<a class="nav-link d-sm-none" href="#!">
								<div class="nav-link-icon">
									<i class="material-icons text-primary text-primary">notifications</i>
								</div> Notifications
							</a>
							<!-- Drawer link (Messages)-->
							<a class="nav-link d-sm-none" href="#!">
								<div class="nav-link-icon">
									<i class="material-icons text-primary text-primary">mail</i>
								</div> Messages
							</a>
							<!-- Divider-->
							<div class="drawer-menu-divider d-sm-none"></div>
							<!-- Drawer section heading (Interface)-->
							<div
								class="drawer-menu-heading text-primary fw-bold titleFont fs-4">MENU</div>
							<!-- Drawer link (Overview)-->
							<a class="nav-link left_nav" href="#" data-url='/student/lesson'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-easel2 text-primary"></i>
								</div> ��������
							</a> <a class="nav-link left_nav" href="#"
								data-url='/paper/listPaperHomework'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-journals text-primary"></i>
								</div> ����
							</a> <a class="nav-link left_nav" href="#"
								data-url='/students/manageStudentsExam'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-clipboard-pulse text-primary"></i>
								</div> ����
							</a> <a class="nav-link left_nav" href="#"
								data-url='/students/listStudentsNote'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-journal-arrow-down text-primary"></i>
								</div> ���ǳ�Ʈ
							</a> <a class="nav-link left_nav" href="#"
								data-url='/payment/listPayment'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-piggy-bank text-primary"></i>
								</div> ����
							</a> <a class="nav-link left_nav" href="#" data-url='/lesson/1'>
								<div class="nav-link-icon fs-5">
									<i class="bi bi-emoji-smile-upside-down text-primary"></i>
								</div> ������
							</a>
							<!-- Divider-->
							<div class="drawer-menu-divider"></div>
							<!-- Drawer footer        -->
							<div class="drawer-footer border-top">
								<div class="d-flex justify-content-center">
									<!-- ���� �߰� ��ư -->
									<button class="btn btn-primary" type="button"
										data-bs-toggle="modal" data-bs-target="#addStudentsRecord">
										���� �߰�<i class="trailing-icon material-icons">launch</i>
									</button>
								</div>
							</div>
						</div>
				</nav>
			</div>
		</div>
	</div>
	<!-- Layout content-->
	<div id="layoutDrawer_content">
		<header class="main-header" style="height: 0px;">
			<!-- page header -->
			<div class="row justify-content-center gx-5"></div>
			<!-- ���� �߰� Modal-->
			<div class="modal fade" id="addStudentsRecord" tabindex="-1"
				aria-labelledby="addStudentsRecordLabel" aria-hidden="true"
				data-bs-backdrop="static" data-bs-keyboard="false">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="addStudentsRecordLabel">���� �ڵ� ���</h5>
							<button class="btn-close" type="button" data-bs-dismiss="modal"
								aria-label="Close" onclick="resetForm()"></button>
						</div>
						<div class="modal-body">
							<c:url var="add_record" value="/students/listStudentsRecord" />
							<form name="addStudentsRecordForm" action="${add_record}">
								<div class="form-group row">
									<div class="col-8">
										<label for="lessonCode" class="col-form-label">���� �ڵ�:</label>
										<input type="text" class="form-control" id="recipient-name"
											name="lessonCode" required />
									</div>
									<div class="col-4">
										<label for="lessonStartDate" class="col-form-label">����
											������:</label> <input type="date" class="form-control"
											id="lessonStartDate" name="lessonStartDate" required>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-8">
										<label for="fees" class="col-form-label">������:</label> <input
											type="text" class="form-control" id="fees" name="fees"
											placeholder="���ڸ� �Է��ϼ���:D" required />
									</div>
									<div class="col-4">
										<label for="payDueDate" class="col-form-label">������
											������:</label> <select class="form-select" id="payDueDate"
											name="payDueDate" required>
											<option selected disabled value="">�ſ�</option>
											<option value="1">1��</option>
											<option value="2">2��</option>
											<option value="3">3��</option>
											<option value="4">4��</option>
											<option value="5">5��</option>
											<option value="6">6��</option>
											<option value="7">7��</option>
											<option value="8">8��</option>
											<option value="9">9��</option>
											<option value="10">10��</option>
											<option value="11">11��</option>
											<option value="12">12��</option>
											<option value="13">13��</option>
											<option value="14">14��</option>
											<option value="15">15��</option>
											<option value="16">16��</option>
											<option value="17">17��</option>
											<option value="18">18��</option>
											<option value="19">19��</option>
											<option value="20">20��</option>
											<option value="21">21��</option>
											<option value="22">22��</option>
											<option value="23">23��</option>
											<option value="24">24��</option>
											<option value="25">25��</option>
											<option value="26">26��</option>
											<option value="27">27��</option>
											<option value="28">28��</option>
											<option value="29">29��</option>
											<option value="30">30��</option>
											<option value="31">31��</option>
										</select>
									</div>
								</div>

								<p
									class="valCount text-primary hidden justify-content-end align-items-center">
									<i class="bi bi-emoji-expressionless p-1"></i>���ڸ� �Է��ϼ���<i
										class="bi bi-emoji-expressionless p-1"></i>
								</p>
								<p
									class="lessonCheck text-primary hidden justify-content-end align-items-center">
									<i class="bi bi-emoji-neutral p-1"></i>�߸��� �����ڵ��Դϴ�<i
										class="bi bi-emoji-neutral p-1"></i>
								</p>
								<div class="d-flex justify-content-end">
									<button class="btn btn-text-primary " type="submit"
										id="addStudentsRecordBtn">���</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</header>
		<!-- Main page content-->
		<main class="mt-12">
			<header class="main-header">
				<!-- page header -->
				<div class="row justify-content-center gx-5">
					<div class="row justify-content-end col-md-8 col-lg-6">
						<div class="pt-6 pb-2 mt-3 col-6 col-sm-3"></div>

					</div>
				</div>
			</header>
			<!-- /////////////////////////////////////////////////////////////////////////////// -->
			<iframe id="mainFrame" class="none-scroll" src="/home"
				style="display: block; width: 100vw; height: 100vh; z-index: 2000;"
				allowfullscreen></iframe>
			<!-- /////////////////////////////////////////////////////////////////////////////// -->



			<div
				class="messagePopup hidden position-absolute end-0 mr-3 none-scroll"
				id="messagePopup" style="z-index: 9999; top: 5px;">
				<!-- list -->
				<div id="otherListContainer" class="container p-0"
					style="width: 25rem; height: 30rem;">
					<div class="row mr-0">

						<div class="card p-0" id="chat2"
							style="wwidth: 25rem; height: 30rem;">
							<div
								class="card-header d-flex justify-content-between align-items-center p-3">
								<div>
									<h6 class="mb-0 fs-6 titleFont text-primary">ä�ø��</h6>
								</div>
								<div
									class="input-group col-6 mb-0  justify-content-between align-items-center">
									<i class="bi bi-search pr-2 text-primary fs-5"></i> <input
										id="messageSearchKeyword" type="text" class="form-control"
										placeholder="�л� �̸� �˻�" aria-label="Username" />
								</div>
							</div>


							<div id="listOther" class="card-body overflow-auto"
								style="height: 500px;"></div>
						</div>

					</div>
				</div>

				<!--  message -->
				<div id="getMessageContainer" class="container p-0 hidden"
					style="width: 25rem; height: 30rem;">
					<div class="row mr-0">

						<div class="card p-0" id="chat2"
							style="wwidth: 25rem; height: 30rem;">
							<div
								class="card-header d-flex justify-content-between align-items-center p-3">
								<div id="otherInfo">
									<h5 class="mb-0">otherName</h5>
									<h6 class="mb-0">otherDetail</h6>
								</div>
								<button id="otherListBtn" type="button"
									class="btn btn-outline-primary btn-sm"
									data-mdb-ripple-color="dark">���</button>
							</div>
							<div class="card-body overflow-auto position-relative p-1" id="messageScroll">
								<div id="messages" class="m-0 p-0 pb-5" style=""></div>
							</div>
							<form id="msgForm"
								class="position-absolute fixed-bottom bg-white p-2 m-0">
								<hr class="m-0 mb-1" />
								<div class="d-flex justify-content-around">
									<input type="text" id="messageContent" class="form-control"
										placeholder="�޽��� �Է�">
									<button id="sendBtn" class="btn btn-primary">
										<i class="fas fa-paper-plane"></i>
									</button>
								</div>
							</form>

							<!-- <div class="card-footer text-muted" style=""> -->

						</div>
					</div>
				</div>
			</div>
		</main>
		<!-- Footer-->
		<footer>
			<button type="button" id="open-messagePopup"
				class="btn btn-md btn-primary btn-icon position-absolute mr-2"
				style="bottom: 20px; right: 10px; z-index: 9999;">
				<i class="material-icons">mail_outline</i>
			</button>
		</footer>
	</div>
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