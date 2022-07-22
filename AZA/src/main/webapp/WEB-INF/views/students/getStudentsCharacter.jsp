<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Students Character </title>
<!--  -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/b209e29beb.js" crossorigin="anonymous"></script>
    <link href="/resources/css/message.css" rel="stylesheet">
    <!-- Load Favicon-->
    <link href="assets/img/favicon.ico" rel="shortcut icon" type="image/x-icon">
    <!-- Load Material Icons from Google Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
    <!-- Load Simple DataTables Stylesheet-->
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet">
    <!-- Roboto and Roboto Mono fonts from Google Fonts-->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500" rel="stylesheet">
    <!-- Load main stylesheet-->
    <link href="/resources/css/styles.css" rel="stylesheet">
    
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">   

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="/resources/css/common.css"/>
        <link rel="stylesheet" href="/resources/css/style.css"/>
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

<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/attendance.css" rel="stylesheet">	    
<!--  -->


<style>

</style>

<script type="text/javascript">

$(function () {
	$('#characterCode').on('change', function() {
		var characterCode = $('option:selected').val().trim();
/* 		alert("선택된 characterCode => "+characterCode); */
		
		$.ajax(
				{url : "/students/rest/getStudentsCharacter/"+characterCode ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},success : function(JSONData , status) {

						//text값 변경
						$('#studentName').text(JSONData.studentName+"의 특징");											
						$('#characterContent').text(JSONData.characterContent);

						
						// value값 변경
						$('input[name=characterCode]').val(JSONData.characterCode);
						$('input[name=studentId]]').val(JSONData.studentId);
						$('input[name=studentName]').val(JSONData.studentName);
						$('input[name=characterContent]').val(JSONData.characterCode);
						
						
					}
	
				}		
		
		)
		
		
		
	})
	
	
});


$(function() {
	$( "#deleteBtn" ).on("click" , function() {
		deleteStudentsCharacter();
	});
});

$(function() {
	$( "#updateBtn" ).on("click" , function() {
		updateStudentsCharacter();
	});
});

function deleteStudentsCharacter() {

	$("form").attr("method" , "POST").attr("action" , "/students/deleteStudentsCharacter").submit();

}

function updateStudentsCharacter() {

	$("form").attr("method" , "POST").attr("action" , "/students/updateStudentsCharacterView").submit();

}



</script>
<style>
*, body { 
font-family: Pretendard, 'Noto Sans KR';
}
</style>
</head>
<body class="nav-fixed bg-light">
<form>
<br/>
<div align="center" class="character">
	<header class="main-header">
<div class="text-primary fs-5"><i class="bi bi-twitch"></i>학생 특징 등록</div>
 <div class="text-gray caption fs-6 mb-3">Add Character</div>
	</header>
<input type="hidden" name="characterCode" value="${students.characterCode }">
<input type="hidden" name="studentId" value="${students.studentId }">
<input type="hidden" name="studentName" value="${students.studentName }">
<input type="hidden" name="characterContent"  value="${students.characterContent }">


			<select id="studentName" name="studentId" class="form-select form-select-sm" aria-label="Large select example" style="width: 200px;">
						<option align="center" selected="" disabled="" > 학생 선택 </option>
				<c:forEach var="students" items="${list}">  
						<option align="center" value="${students.characterCode }">${students.studentName}	
				 </c:forEach>
			</select>
			
<br/>
<br/>

			<div class="card card-raised border-top border-4 border-primary h-100"  style="width:600px;">
                                    <div class="card-body p-5">
                                        <div class="overline text-muted mb-4"></div>
                                        <h1 id="studentName"> ${students.studentName}의 특징 </h1>
                                        <%-- <p class="card-text mb-4" id="characterCode2">character Code : ${students.characterCode }</p>
                                        <p class="card-text mb-4" id="studentId">studentId : ${students.studentId }</p> --%>
                                        <table class="table table-sm mb-0">
                                            <tbody>
                                                <tr>
                                                    <td><div class="text-muted fst-italic"></div></td>
                                                     <td id="characterContent">${students.characterContent}</td>
                                                   <!-- <td class="text-end"><div class="text-muted">-$5,400.00</div></td> -->
                                                </tr>
                                        </table>
                                    </div>
                                    <div class="card-footer bg-transparent position-relative ripple-gray">
                                      		<button id="updateBtn" class="btn btn-outline-primary" type="button">수정</button>
											<button id="deleteBtn" class="btn btn-outline-danger" type="button">삭제</button>
											
                                    </div>  
              </div>


<!--  --> 
</div>
</form>
<script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.0-beta.10/chart.min.js"
		crossorigin="anonymous"></script>
	<!-- <script src="/resources/javascript/common/charts/chart-defaults.js"></script> -->
	<script src="/resources/javascript/common/prism.js"></script>
	<script src="/resources/javascript/common/material.js"></script>
	<script src="/resources/javascript/common/scripts.js"></script>
</body>
</html>