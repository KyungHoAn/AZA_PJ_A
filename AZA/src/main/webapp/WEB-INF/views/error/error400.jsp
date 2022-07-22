<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ERROR : 400</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/main.css" rel="stylesheet">
</head>
<style>
	body { margin: 0; padding-bottom: 3rem; font-family: Pretendard, 'Noto Sans KR'; }
</style>
<body>
 <!-- Layout wrapper-->
<div id="layoutError">
            <!-- Layout content-->
            <div id="layoutError_content">
                <!-- Main page content-->
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <!-- Error message content-->
                                <div class="text-center my-5 mt-sm-10">
                                    <img class="img-fluid mb-4" src="assets/img/illustrations/error-400.svg" alt="400 Error Image by Freepik Storyset" style="max-width: 30rem">
                                    <p class="lead">잘못된 주소입니다...</p>                                   
                                    <a class="btn btn-primary" href="/">
                                        <i class="material-icons leading-icon">arrow_back</i>
                                       	메인 페이지로
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <!-- Layout footer-->
            <div id="layoutError_footer">
                <!-- Footer-->
                <!-- Min-height is set inline to match the height of the drawer footer-->
                <footer class="py-4 mt-auto border-top" style="min-height: 74px">
                    <div class="container-xl px-5">
                        <div class="d-flex flex-column flex-sm-row align-items-center justify-content-sm-between small">
                            <div class="me-sm-2">Copyright &copy; CANLC 2022</div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <!-- Load Bootstrap JS bundle-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <!-- Load global scripts-->
        <script type="module" src="/resources/javascript/common/material.js"></script>
        <script src="/resources/javascript/common/scripts.js"></script>
</body>
</html>
</html>