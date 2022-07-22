<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Aza : main</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<script defer src="https://kit.fontawesome.com/57ea3feb1d.js" crossorigin="anonymous"></script>
<script defer src="/resources/javascript/message/asserts/ui.js"></script>
<script defer src="/resources/javascript/alert/alertUI.js"></script>
<script defer src="/resources/javascript/students/studentsUI.js"></script>

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
</style>
<link href="/resources/css/styles.css" rel="stylesheet">
<link href="/resources/css/common.css" rel="stylesheet">
<link href="/resources/css/attendance.css" rel="stylesheet">
<script type="text/javascript">

function resetForm() {
	document.addStudentsRecordForm.reset();
	$('.lessonCheck').removeClass('show');
	$('.valCheck').removeClass('show');	
}

$(function() {
	// addStudentsRecord
	$('#addStudentsRecordBtn').on("click", function() {

		var valFlag = false;
		const lessonCode = document.addStudentsRecordForm.lessonCode.value;
		const lessonStartDate = document.addStudentsRecordForm.lessonStartDate.value;
		const fees = document.addStudentsRecordForm.fees.value;
		const payDueDate = document.addStudentsRecordForm.payDueDate.value;
		
		// 유효성 check
		if(lessonCode.length < 8 || lessonCode == null || lessonStartDate.length < 1 || lessonStartDate.length == null || fees.length < 1 || fees == null || payDueDate < 1 || payDueDate == null) {
			$('.valCheck').addClass('show');
		} else {
			$.ajax({
				 url: "http://localhost:8080/lesson/rest/checkLessonCode/"+lessonCode,
		            type: "GET",
		            headers : {
		                    "Accept" : "application/json",
		                    "Content-Type" : "application/json",                                    
		                },
		            success: function(result) {
		                if(result) {
		                	console.log(result);
		                	
		                	if(result == true) {
		                		valFlag = true;
		                	}
		                	
		                	if(!valFlag) {
		                		$('.lessonCheck').addClass('show');
		                		return;
		                	}
		                	
		                	console.log(valFlag);
		                	
		                	if(valFlag) {
		            			document.addStudentsRecordForm.action = "/students/addStudentsRecord";
		            			document.addStudentsRecordForm.method = "POST";
		            			document.addStudentsRecordForm.submit();		
		            		}
		                } else {
		                	console.log("lesson/rest/checkLessonCode :: error || null");			                	
		                	$('.lessonCheck').addClass('show');
		                }
		            }
			})
		}
		
    	

	})
})



function deleteAlert(alertCode) {
	$.ajax({
		url:"http://localhost:8080/alert/rest/deleteAlert/"+alertCode,
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	console.log("deleteAlert");
            	
        	var listAlertView = "";
            var list = result.list
            	
            	list.map(alert => {
            		
            		let alertCode = alert.alertCode;
            		let alertContent = alert.alertContent;
            		let alertCreateAt = alert.alertCreateAt;
            		let alertReadAt = alert.alertReadAt;
            		
            		if(!alertReadAt) {
            			listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3" onclick="return readAlert(`+alertCode+`)">
            			<div>
            			<span class="material-icons text-primary">done</span>
            			<p class="text-primary">읽음</p>
            			</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;
            			
            		} else {
						listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3">
						<div>
						<span class="material-icons text-danger" onclick="return deleteAlert(`+alertCode+`)">delete</span>
						<p class="text-danger">삭제</p>
						</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;               		
            		}              		
            	})
            	
            	$('.alertLi').remove();
	        	$("#alertDropDown").html("");
	        	$("#alertDropDown").append(`<li><h6 class="dropdown-header bg-primary text-white fw-500 py-3">알림</h6></li>
						<li><hr class="dropdown-divider my-0" /></li>`);
	        	$("#alertDropDown").append(listAlertView);
	        	$("#alertDropDown").addClass("show").attr("data-bs-popper", "static");

            } else {
            	console.log("faile");
            }
       }
	})
	
	
	
	
}



function listAlert() {
	$.ajax({
		url:"http://localhost:8080/alert/rest/listAlert",
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	console.log("listAlert");
            	
        	var listAlertView = "";
            var list = result.list
            	
            	list.map(alert => {
            		
            		let alertCode = alert.alertCode;
            		let alertContent = alert.alertContent;
            		let alertCreateAt = alert.alertCreateAt;
            		let alertReadAt = alert.alertReadAt;
            		
            		if(!alertReadAt) {
            			listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3" onclick="return readAlert(`+alertCode+`)">
            			<div>
            			<span class="material-icons text-primary">done</span>
            			<p class="text-primary">읽음</p>
            			</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;
            			
            		} else {
						listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3">
						<div>
						<span class="material-icons text-danger" onclick="return deleteAlert(`+alertCode+`)">delete</span>
						<p class="text-danger">삭제</p>
						</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;               		
            		}              		
            	})
            	
            	$('.alertLi').remove();
            	$("#alertDropDown").html("");
            	$("#alertDropDown").append(`<li><h6 class="dropdown-header bg-primary text-white fw-500 py-3">알림</h6></li>
    					<li><hr class="dropdown-divider my-0" /></li>`);
            	$("#alertDropDown").append(listAlertView);

            } else {
            	console.log("faile");
            }
       }
	})
	
}

function readAlert(alertCode) {
	$.ajax({
		url:"http://localhost:8080/alert/rest/readAlert/"+alertCode,
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	console.log("readAlert");
            	
        	var listAlertView = "";
            var list = result.list
            	
            	list.map(alert => {
            		
            		let alertCode = alert.alertCode;
            		let alertContent = alert.alertContent;
            		let alertCreateAt = alert.alertCreateAt;
            		let alertReadAt = alert.alertReadAt;
            		
            		if(alertReadAt == "") {
            			listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3" onclick="return readAlert(`+alertCode+`)">
            			<div>
            			<span class="material-icons text-primary">done</span>
            			<p class="text-primary">읽음</p>
            			</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;
            			
            		} else {
						listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3">
						<div>
						<span class="material-icons text-danger">delete</span>
						<p class="text-danger">삭제</p>
						</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext">`+alertCreateAt+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;               		
            		}
            		
            		
            		
            	})
            	
            	$('.alertLi').remove();
            	$("#alertDropDown").html("");
            	$("#alertDropDown").append(`<li><h6 class="dropdown-header bg-primary text-white fw-500 py-3">알림</h6></li>
    					<li><hr class="dropdown-divider my-0" /></li>`);
            	$("#alertDropDown").append(listAlertView);
            	$("#alertDropDown").addClass("show").attr("data-bs-popper", "static");
            	
            } else {
            	console.log("faile");
            }
       }
	})
}



$(function() {

	// Alert
	 $('#dropdownMenuNotifications').on('click', function() {
		console.log("알림 버튼 눌림");
		listAlert();

	})

	// Message
	$("#open-messagePopup").on("click", function() {
		console.log("메시지 버튼 눌림");
		
        $.ajax({
            url: "http://localhost:8080/message/rest/listMessage",
            type: "GET",
            headers : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json",                                    
                },
            success: function(result) {
                if(result) {
                	console.log(result);
                	
                	sessionStorage.setItem('userId', result[0].userId);
                	
                	result.shift();
                	
                	console.log(result);
                	
                	var listOtherView = "";
                	
                	result.map((other,i) => {
               			
                		let studentId = other.studentId ? other.studentId : other.firstStudentId;
                		let studentName = other.studentId ? other.studentName : "학생이룸";
                		let relationName = other.relationName ? other.relationName : "";
                		let userId = other.userId ? other.userId : studentId;
                		let userName = studentName + " " + relationName;
                		//console.log(i, studentId);
                		
                		listOtherView += `<ul id='getOtherMessage' class='list-unstyled mb-0' onclick="getOtherMessage('`+userId+`','`+userName+`')">
                		<li class='p-2 border-bottom' data-id=`+userId+`>
                            	<a class="d-flex justify-content-between">
                                    <div class="d-flex flex-row">
                                        <div class="pt-1">
                                            <p class="fw-bold mb-0">`+studentName+" "+relationName+`</p>
                                            <p class="small text-muted">최근메시지</p>
                                        </div>
                                    </div>
                            	</a>
                        	</li>
                    	</ul>`;
                	});
                	
                	$('#getOtherMessage').remove();
                	$('#listOther').append(listOtherView);

                } else {
                    console.log("실패");
                }
            } 
        })
	})
	


})
	





</script>



</head>

<body class="nav-fixed bg-light">

	<div id="layoutDrawer_content">
	
		<!-- Main page content-->
		<main class="mt-12">
			<header class="main-header">
				<!-- page header -->
				<div class="row justify-content-center gx-5">
                      <div class="row justify-content-end col-md-8 col-lg-6">
                          <div class="pt-0 pb-2 mt-3 col-6 col-sm-3">
                              <div class="nav-item dropdown pt-3 col" id="myDropdown">
						      <a class="nav-link dropdown-toggle pb-0" href="#" data-bs-toggle="dropdown">  자녀 선택  </a>
						      <ul class="dropdown-menu">
							  		<c:forEach var="student" items="${studentInfo}">
							  			<li><a class="dropdown-item" href="#">${student.userName}  &raquo;</a>
							  				<ul class="submenu dropdown-menu">
							  					<c:forEach var="lesson" items="${lessons}">
							  					<li><a class="dropdown-item" href="/students/listStudentsAttendance?studentId=${student.userId}&lessonCode=${lesson.lessonCode}">${lesson.lessonName}</a></li>
							  					</c:forEach>
						            		</ul>
							  			</li>	
							  	</c:forEach>
						      </ul>
                          </div>

							
						    </div>

                      </div>
                  </div>
			</header>
			<div class="container-xl px-5 mt-2"> 


								  <div class="hbContainer">
					                <div class="calendarYearMonth center">
					                    <p class="left calBtn" onclick="prevMonth()"> Prev </p>
					                    <p id="yearMonth"></p>
					                    <p class="right calBtn" onclick="nextMonth()"> Next </p>
					                </div>
					                <div>
					                    <ol class="calendarList1">
					                        <li class="day-name">Sat</li>
					                        <li class="day-name">Sun</li>
					                        <li class="day-name">Mon</li>
					                        <li class="day-name">Tue</li>
					                        <li class="day-name">Wed</li>
					                        <li class="day-name">Thu</li>
					                        <li class="day-name">Fri</li>
					                    </ol>
					                    <ol class="calendarList2" id="calendarList">
					
					                    </ol>
					               </div>
            					</div>
							  
							 </div>
							

		       <%--  <div class="messagePopup hidden" id="messagePopup">
            <section style="background-color: #eee;">
                
                <!-- list -->
                <div id="otherListContainer" class="container py-5">          
                <div class="row d-flex justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-6">         
                        <div class="card" id="chat2">
                            <div class="card-header d-flex justify-content-between align-items-center p-3">
                                <div>
                                    <h5 class="mb-0">상대목록</h5>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                      <span class="input-group-text" id="basic-addon1">@</span>
                                    </div>
                                    <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                  </div>
                                <button id="getMessageBtn" type="button" class="btn btn-primary btn-sm" data-mdb-ripple-color="dark">임시 getMessageContainer</button>
                            </div>

                            <div id="listOther" class="card-body scroll" style="height: 500px;">

                                 
                            </div>
                        </div>
                    </div>
                </div>
                </div>

               <!--  message -->
                <div id="getMessageContainer" class="container py-5 hidden">          
                <div class="row d-flex justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-6">         
                        <div class="card py-10" id="chat2">
                            <div class="card-header d-flex justify-content-between align-items-center p-3">
                                <div id="otherInfo">
                                    <h5 class="mb-0">otherName</h5>
                                    <h6 class="mb-0">otherDetail</h6>
                                </div>
                                <button id="otherListBtn" type="button" class="btn btn-primary btn-sm" data-mdb-ripple-color="dark">목록</button>
                            </div>
                            
                            <div id="messages" class="card-body scroll" style="position: relative; height: 400px">
                                
                            </div>
                        </div>
                        <div class="card-footer text-muted">
                        
                            <form id="msgForm">
                                <div class="d-flex justify-content-around">
                                <input type="text" id="messageContent"  class="form-control form-control-lg" placeholder="메시지 입력">
                                <button id="sendBtn" class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>   
                            </div>     
                            </form>
                        </div>
                    </div>
                </div>
                </div>
            </section>
        </div> --%>
		</main>
	<!-- Footer-->
	<footer>
		<%-- <button type="button" id="open-messagePopup" class="btn float btn-lg btn-icon"><i class="material-icons">mail_outline</i></button>
		<jsp:include page="/WEB-INF/views/common/home.jsp" /> --%>
	</footer>
	</div>
	  <script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>
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
 	// <![CDATA[  <-- For SVG support
/*   	if ('WebSocket' in window) {
		(function () {
			function refreshCSS() {
				var sheets = [].slice.call(document.getElementsByTagName("link"));
				var head = document.getElementsByTagName("head")[0];
				for (var i = 0; i < sheets.length; ++i) {
					var elem = sheets[i];
					var parent = elem.parentElement || head;
					parent.removeChild(elem);
					var rel = elem.rel;
					if (elem.href && typeof rel != "string" || rel.length == 0 || rel.toLowerCase() == "stylesheet") {
						var url = elem.href.replace(/(&|\?)_cacheOverride=\d+/, '');
						elem.href = url + (url.indexOf('?') >= 0 ? '&' : '?') + '_cacheOverride=' + (new Date().valueOf());
					}
					parent.appendChild(elem);
				}
			}
			var protocol = window.location.protocol === 'http:' ? 'ws://' : 'wss://';
			var address = protocol + window.location.host + window.location.pathname + '/ws';
			var socket = new WebSocket(address);
			socket.onmessage = function (msg) {
				if (msg.data == 'reload') window.location.reload();
				else if (msg.data == 'refreshcss') refreshCSS();
			};
			if (sessionStorage && !sessionStorage.getItem('IsThisFirstTime_Log_From_LiveServer')) {
				console.log('Live reload enabled.');
				sessionStorage.setItem('IsThisFirstTime_Log_From_LiveServer', true);
			}
		})();
	}
	else {
		console.error('Upgrade your browser. This Browser is NOT supported WebSocket for Live-Reloading.');
	}   */
	// ]]>
</script>
</body>
</html>