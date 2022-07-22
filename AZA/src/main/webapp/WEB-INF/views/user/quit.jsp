<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>



<head>
   
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>탈퇴</title>
        <!-- Load Favicon-->
        <link href="assets/img/favicon.ico" rel="shortcut icon" type="image/x-icon">
        <!-- Load Material Icons from Google Fonts-->
        <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
        <!-- Roboto and Roboto Mono fonts from Google Fonts-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500" rel="stylesheet">
        <!-- Load main stylesheet-->
<link href="/resources/css/template.css" rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet" />
<link href="/resources/css/main.css" rel="stylesheet" />    
 
 <link href="assets/img/favicon.ico" rel="shortcut icon" type="image/x-icon" />

<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet" />


<meta charset="EUC-KR">
<title>Insert title here</title>

<style>

.btn-outline-primary, div.code-toolbar > .toolbar a, div.code-toolbar > .toolbar button, div.code-toolbar > .toolbar span {
    color: #6200ea;
    border-color: #6200ea;
    --mdc-ripple-fg-size: 0;
    --mdc-ripple-left: 0;
    --mdc-ripple-top: 0;
    --mdc-ripple-fg-scale: 1;
    --mdc-ripple-fg-translate-end: 0;
    --mdc-ripple-fg-translate-start: 0;
    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
    will-change: transform, opacity;
    overflow: hidden;
    position: relative;
}

</style>
</head>
<body>
<form>







<div class="card-body p-5">
                                    
                                            <div class="text-center">
		<h1 class="display-5 mb-0">정말 탈퇴하시겠습니까?</h1>
		<div class="subheading-1 mb-5">아이디/비밀번호를 입력해주세요</div>
	</div>

	<div class="mb-4 text-center">
		아이디 : <input type="text" name="userId" id="userId" value="${userId}"></input>

	</div>
	<div class="mb-4 text-center">

		비밀번호 : <input type="password" name="password" id="password" value="${password}"></input>

	</div>
	<div class="mb-1 text-center">
		<div class="btn-group" role="group">
			<button class="btn btn-outline-primary" type="button" onclick='deleteUser()'>탈퇴</button>
			<button class="btn btn-outline-primary" type="button">취소</button>
		</div>
	</div>
           </div>



	</form>
	
	

	
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">


function deleteUser() {
	
		if($("#password").val()=="" || $("#password").val().length < 1){
			Swal.fire(
					  '탈퇴할 수 없어요',
					  '비밀번호를 확인해주세요🙄',
					  'warning'
			).then((result) => {
				$("#password").focus();
				return false;
			})			
		} else {
			Swal.fire(
					  '탈퇴 완료!!!',
					  '잘가요 안녕🥺',
					  'success'
			).then((result) => {
				$("form").attr("method" , "POST").attr("action" , "/user/quit").submit();
				
			})			
			
			
			
		}	

};


$( function() {
	$("button:contains('취소')").on("click" , function() {
		history.go(-1);
	});
});


</script>
</body>
</html>