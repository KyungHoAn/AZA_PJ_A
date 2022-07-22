<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>addCharacter</title>


<!--  -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/b209e29beb.js" crossorigin="anonymous"></script>
    <link href="/resources/css/message.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
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

        
<!--  -->


<style>
*, body { 
font-family: Pretendard, 'Noto Sans KR';
}
</style>
<script type="text/javascript" charset="euc-kr">
$(function() {
	$( "#addBtn" ).on("click" , function() {
		addStudentsCharacter();
	});
});

$(function() {
	   $( "#cancleBtn" ).on("click" , function() {
	      history.go(-1);
	   });
	});
	
$(function () {
	$('#studentName').on('change', function() {
				
		$("form").attr("method" , "POST").attr("action" , "/students/getCheckStudentsCharacter").submit();
		
	})
	
	
});   
   
   
function addStudentsCharacter() {
	
	var characterContent = $("textarea[name='characterContent']").val();
	var studentName = $('option:selected').text().trim()
	var studentId =$('option:selected').val().trim();
		
	if(characterContent == null || characterContent.length < 1){
		
		alert("특징은 필수 입력 항목입니다.");
		return;
	}
			
	$("form").attr("method" , "POST").attr("action" , "/students/addStudentsCharacter").submit();

}

</script>

</head>
<body class="nav-fixed bg-light mt-5">

<form>

<!-- 학생 list -->
 <div align="center">
<header class="main-header">
<div class="text-primary fs-5"><i class="bi bi-twitch"></i>학생 특징 등록</div>
 <div class="text-gray caption fs-6 mb-3">Add Character</div>
	</header>
			<select id="studentName" name="studentId" class="form-select form-select-sm" aria-label="Large select example" style="width: 200px;">
						<option selected="" disabled="" > 학생 선택 </option>
				<c:forEach var="students" items="${list}">
						
						<option value="${students.studentId }">${students.studentName}</option>
	
				 </c:forEach>
				</select>


	
<br/>
<br/>
<c:if test="${!empty userStudent.userName}">
			<div class="card card-raised border-top border-4 border-primary h-100"  style="width:600px;">
                                    <div class="card-body p-5">
                                        <div class="overline text-muted mb-4"></div>
                                        		<input type="hidden" name="userId" value="${userStudent.userId}">
                                               <h2 name="studentName" value="${userStudent.userName}">${userStudent.userName}의 특징 등록 페이지</h2>
        									   <p class="card-text mb-4 fs-6 text-muted">학생 특징은 1개만 등록 가능합니다. :)</p>
                                   
                                        <table class="table table-sm mb-0">
                                            <tbody>
                                                <tr>
                                                    <td><div class="text-muted fst-italic"></div></td>
                                                     <td>
                                                     
                                                     <textarea class="dataTable-input" placeholder="특징을 입력해주세요 :)" 
														type="text" style="width:500px;height:400px;"
														name="characterContent"></textarea>
                                                     
                                                     </td>
                                                </tr>
                                        </table>
                                    </div>
                                    
                                    <div class="card-footer bg-transparent position-relative ripple-gray">
											<button id="addBtn" class="btn btn-outline-primary" type="button">등록</button>
											<button id="cancleBtn" class="btn btn-outline-gray" type="button">취소</button>
                                    </div>  
              </div>
</c:if>
<!-- ==================================================== -->		
</div>
<br/>

</form>

</body>
</html>