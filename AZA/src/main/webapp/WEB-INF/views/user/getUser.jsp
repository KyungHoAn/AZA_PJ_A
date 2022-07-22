<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>개인정보조회</title>

        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blank Page - Material Admin Pro</title>
        <!-- Load Favicon-->
        <link href="assets/img/favicon.ico" rel="shortcut icon" type="image/x-icon" />
        <!-- Load Material Icons from Google Fonts-->
        <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet" />
        <!-- Roboto and Roboto Mono fonts from Google Fonts-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500" rel="stylesheet" />
        <!-- Load main stylesheet-->
<link href="/resources/css/template.css" rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet" />
<link href="/resources/css/main.css" rel="stylesheet" />   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script defer src="/resources/javascript/common/indexUI.js"></script>
<link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">









<style>
header{
display: flex;
}
*, body { 
font-family: Pretendard, 'Noto Sans KR';
}
.form-horizontal{
 padding-left: 20px;
 margin-top: 20px;
 margin-bottom: 30px;
 margin-left : 300px;
 line-height : 50px;
}
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
.btn-outline-danger {
    color: #d32f2f;
    border-color: #d32f2f;
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
.btn-primary {
    color: #fff;
    background-color: #6200ea;
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
    border: none;
    padding: calc(0.40625rem + 1px) calc(1rem + 1px);
}
.text-center {
    text-align: center !important;
}
th {
    text-align: center;
}
.form-control {
    display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.p-5 {
    
    padding-top: 4rem !important;
    padding-right: 20rem !important;
    padding-bottom: 10rem !important;
    padding-left: 20rem !important;
}
#aa{
font-size: 30px;
margin-top: 0px;
}
</style>

<script
		src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<script type="text/javascript">
		
	// 수업추가 참고하기
		//============= 회원정보수정 Event  처리 =============	
		 $( function() {
				$("button:contains('회원정보수정')").on("click" , function() {
					self.location="/user/updateUser?userId=${user.userId}"
				});
			});
	
	//학생 아이디 유효성 검사
			const checkStudent = _.debounce(async (id) => {
		    	
		    	var id = $("#firstStudentId").val();
		    	
		    	$.ajax({
		    		url:'/user/rest/checkStudent',
		    		type : "post",
		    		data:{id},
		    		success : function(cnt) {
		    			if(cnt == 1) {
		    				$('#certCheck2').text("확인이 완료되었습니다.");
		    				$('#certCheck2').css('color','blue');	
		    				
		    			}
		    			else {
		    				$('#certCheck2').text("확인되지 않은 정보입니다.");
		    				$('#certCheck2').css('color','red');
		    				
		    			}
		    		}
		    	});
		    },2000);
			
		// 자녀 추가 이벤트
		$(function(){
			$("input[name=addStudentBtn]").click(function(){
				if ($(this).val()=="자녀추가"){
					$("#addStudentInput").show();
				}
			});
	});
		
// 탈퇴
		
		function quit(){
			location.href = "/user/quit";
		}
		
	</script>




        
</head>
<body>



<main>
                    <!-- Page header-->
                    <header class="bg-gray">
                    <span class="material-icons">
face_2
</span>  
<i class="material-icons icon-xxl">face</i>  
                        <div class="container-xl px-5 text-center">
                        <h1 class="text-white py-3 mb-0 display-6" id="aa">개인정보수정</h1></div>
                    </header>
                    <div class="container-l p-5 text-center" >
                        <div class="card card-raised">
                            <div class="card-body text-center p-5">
                     
                     <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label" style="margin-bottom: 0px;
    margin-top: 10px;">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" value="${user.userId }" readonly>
		    </div>
		  </div>
                             
   
		
		<br></br>

		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label" style="margin-bottom: 0px;
    margin-top: 10px;">이 름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" value="${user.userName }" readonly>
		    </div>
		  </div>
		
		<br></br>		

		  <div class="form-group">
		    <label class="col-sm-offset-1 col-sm-3 control-label" style="margin-bottom: 0px;
    margin-top: 10px;">휴대전화번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" value="${ !empty user.phone ? user.phone : ''}" readonly>
		    </div>
		  </div>    
		
		<br></br>    
                                
   <!-- 학생 -->
		
		
		<c:if test="${user.role eq 'student'}">
			
			<div class="form-group">
		    <label for="school" class="col-sm-offset-1 col-sm-3 control-label">학교</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="school" name="school" value="${user.school}" readonly>
		    </div>
		  </div>
		
		<div class="form-group">
		    <label for="grade" class="col-sm-offset-1 col-sm-3 control-label">학년</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="grade" name="grade" value="${user.grade}" readonly>
		    </div>
		  </div>
		<br></br>
		</c:if>
		
		
		<!-- 부모 -->                             
                                
		<c:if test="${user.role eq 'parent'}">


			<input type="button" name="addStudentBtn" class="btn btn-outline-primary" value="자녀추가" onclick='addStudentBtn()' />
			
			
			<div></div>
			<form action="/user/addRelation" method="POST" enctype="multipart/form-data">		
			<div id="addStudentInput" style="display :none">
			
			<input type="hidden" name="userId" value="${user.userId}">
	<br></br>
		
<div class="form-floating mb-3">
  <input type="text" class="form-control" id="firstStudentId" name="firstStudentId" placeholder="자녀 아이디" oninput="checkStudent()">
  <label for="floatingInput">자녀 아이디</label>
  <div class="form-group" id="certCheck2"></div>
</div>

<br></br>


<div class="form-floating">
  <input type="text" class="form-control" id="relationName" name="relationName" placeholder="학생과의 관계">
  <label for="floatingInput">자녀와의 관계</label>
</div>
			
<br></br>
			<input class="btn btn-outline-primary" type="submit" value="등록">
			<input class="btn btn-outline-primary" type="reset" value="취소" />
			</div>
			</form>

<br></br>			
			
			<c:forEach var="studentsInfo" items="${studentsInfo}" varStatus="status">
<table class="table">
  <thead>
    <tr>
      <th scope="col">자녀 아이디</th>
      <th scope="col">자녀 이름</th>
      <th scope="col">자녀 학교</th>
      <th scope="col">자녀 학년</th>
      <th scope="col">학생과의 관계</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <td>${studentsInfo.userId}</td>
      <td>${studentsInfo.userName}</td>
      <td>${studentsInfo.school}</td>
      <td>${studentsInfo.grade}</td>
<!--  <c:forEach var="user" items="${list}"> -->    
      <td>${user.relationName}</td>
<!-- </c:forEach>      --> 
    </tr>

  </tbody>
</table>

		<br></br>
	
		 </c:forEach>
		</c:if>       
		                        
      	<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">회원정보수정</button>
	  			<button type="button" class="btn btn-outline-danger btn-sm" onclick="quit()">탈퇴</button>
	  			
	  		</div>
		</div>   
		                       
                                
                                
                              </div>  
                                
                                
                                
                                
                                
                                
                            </div>
                        </div>
           
                </main>






</body>

</html>