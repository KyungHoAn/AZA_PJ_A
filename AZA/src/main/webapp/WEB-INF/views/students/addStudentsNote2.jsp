<%@ page language="java" contentType="text/html;" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>강의노트</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script src="/resources/javascript/students/noteUI.js"></script>	
	<script src="/webjars/stomp-websocket/stomp.min.js"></script>
	<script src="/webjars/sockjs-client/sockjs.min.js"></script>
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<!-- <script src="https://kit.fontawesome.com/79647d7f04.js" crossorigin="anonymous"></script> -->
	<!-- <script defer src="/resources/javascript/message/asserts/ui.js"></script> -->
	<!-- <script defer src="/resources/javascript/alert/alertUI.js"></script> -->
	<link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
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
	<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" rel="stylesheet">
	<!-- Load main stylesheet-->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
		crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" type="text/css">
	
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.css"/>
	 
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.12.1/b-2.2.3/b-colvis-2.2.3/b-html5-2.2.3/b-print-2.2.3/sl-1.4.0/datatables.min.js"></script>
	<script src="/resources/javascript/students/noteUI.js"></script>
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
	<!-- //////////////////////////////////////////////////// -->
	<script>
	$(document).ready(function() {
		
		var toolbar = [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture','link','video']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview','fullscreen', 'help']]
			  ];
	
		var setting = {
	            height : 300,
	            minHeight : null,
	            maxHeight : null,
	            focus : true,
	            lang : 'ko-KR',
	            toolbar : toolbar,
	            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            onImageUpload : function(files, editor,
	            welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            uploadSummernoteImageFile(files[i],
	            this);
	            		}
	            	}
	            }
	         };
	
	        $('#summernote').summernote(setting);
	        });
	</script>
	
	
	

</head>
<body>
	<div class="container p-5">
		<form name="noteForm" action="addStudentsNote" method="post">
			<div class="border border-top-0 p-3 p-sm-5 bg-white">
			<div class="col flex-shrink-0 mb-5 mb-md-0" style="margin: 20px 20px 20px 20px">
		        <h1 class="display-4 mb-0">새 노트 작성</h1>
		        <div class="text-muted">Create a New Note</div>
		   	</div>
		      <div id="noteDiv" style="margin: 30px 30px 30px 30px">
	    	 	<div class="input-group mb-3">
		            <button class="btn btn-outline-primary" type="button" style="width:120px;" disabled>제 목</button>
		            <input class="form-control" type="text" placeholder="" aria-label="Example text with button addon" 
		             name="noteTitle" id="noteTitle" value="${students.noteTitle}" aria-describedby="button-addon1">
	        	</div>
	            <input type="hidden" class="form-control" type="text" placeholder="" aria-label="Example text with button addon" 
	            	name="studentId" id="studentId" value="${user.userId}" <%-- value="${students.studentId}" --%> aria-describedby="button-addon1"/>
				
		        <textarea name="noteContent" id="summernote" value="${students.noteContent}" class="bt-white"></textarea>
		      </div>
		      
		      <div align="center">			
	 	      	  <input type="button" onclick="submitPost();" value="작성" class="btn btn-outline-primary"/>
				  <button id="calcelBtn" type="button" class="btn btn-outline-primary">취소</button>
			  </div>
		  </div>
	    </form>
   	</div>
   	
	

</body>
</html>