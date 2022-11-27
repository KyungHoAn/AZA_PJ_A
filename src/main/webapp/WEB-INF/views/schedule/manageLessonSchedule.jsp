<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@page import="java.util.List" %>
<%@page import="com.aza.service.domain.Schedule" %> --%>

<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8' />
<link type="text/css" href="/resources/css/schedule.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="/resources/javascript/schedule/main.js"></script>
<!-- <script src='../lib/main.min.js'></script> -->
<script type="text/javascript"
	src="/resources/javascript/schedule/ko.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->

<!-- bootstrap 4 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- getLesson.jsp -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500"
	rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet">
<script>
	var calendar = null;

	$(document).ready(function() {
		var calendarEl = document.getElementById('calendar');
		aspectRatio: 1.35, calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,timeGridDay'
			},
			initialView : 'dayGridMonth',
			locale : 'ko', //�ѱۼ��� ������ ����� ����
			buttonIcons : false, //������ �����޷� ���� <> == true
			navLinks : true, //��¥ ������ �� ��ȸ.
			businessHours : true, //�� �ð� ǥ��
			editable : true, //�������ɿ���
			selectable : true, //��¥ ���ý� ǥ��
			dayMaxEvents : true, //�̺�Ʈ�� ���� �� +ǥ�÷� ������
			selectMirror : true,
			events : function(info, successCallback, failureCallback) {
				// ajax ó���� �����͸� �ε� ��Ų��.
				$.ajax({
					type : "post",
					url : '/schedule/rest/listLessonSchedule',
					dataType : "json",
					success : function(list) {
						var events = [];
						$.each(list, function(index, data) {
							for (var i = 0; i < data.length; i++) {
								events.push({
									title : data[i].title,
									start : data[i].start,
									end : data[i].end
								});
							}
						})
						successCallback(events);
					}
				});
			},//json������ ��
			eventAdd : function() {//�̺�Ʈ�� �߰��Ǹ� �߻��ϴ� �̺�Ʈ
				console.log()
			},
			/* ����߰��� ���� �߼� ó�� */
			select : function(arg) {
				$("#calendarModal").modal("show"); //modal ��Ÿ����
				
				$("#addCalendar").on("click", function() { //modal�� �߰� ��ư Ŭ��
					var content = $("#calendar_content").val();
					var start_date = $("#calendar_start_date").val();
					var end_date = $("#calendar_end_date").val();

					//���� �Է� ���� Ȯ��
					if (content == null || content == "") {
						alert("������ �Է��ϼ���.");
					} else if (start_date == "" || end_date == "") {
						alert("��¥�� �Է��ϼ���");
					} else if (new Date(end_date) - new Date(start_date) < 0) { //dateŸ������ ���� �� Ȯ��
						alert("�������� �����Ϻ��� �����Դϴ�.");
					} else { //�������� �Է� ��
						var obj = {
							"title" : content,
							"start" : start_date,
							"end" : end_date
						}//������ ��ü ����
						calendar.addEvent({
							title : obj.title,
							start : obj.start,
							end : obj.end,
							backgroundColor : "primary",
							textColor : "black"
						})
					}
					/* console.log('content: '+content)
					console.log('start_date: '+start_date)
					console.log('end_date: '+end_date) */
					var allEvent = calendar.getEvents();
					var events = new Array();
					for (let i = 0; i < allEvent.length; i++) {
						//defId ���� ����
						// 2022-11-20T00:25
						// Sun Nov 20 2022 09:25:00 GMT+0900 (�ѱ� ǥ�ؽ�)
						let startTime = allEvent[i]._instance.range.start.toString()
						let sMonth = startTime.substr(3,4)	// month
						let yearT = startTime.substr(10,11)
						let [startTime1, startYear] = yearT.split(' ')		//year
						let dayY = startTime.substr(7,8)
						let [startYear2, startDay] = dayY.split(' ')		// day
						/* console.log('----')
						console.log(startDay)		//??? +1 error
						console.log('----') */
						
						let endTime = allEvent[i]._instance.range.end.toString()
						let eMonth = endTime.substr(3,4)		//month
						let endT = endTime.substr(10,11)
						let [endTime1, endYear] = endT.split(' ')	// endYear
						let dayY2 = endTime.substr(7,8)
						let [endYear2, endDay] = dayY2.split(' ')		//endDay
						
						let inputStartDate = start_date.substr(0,10)	// year-month-day
						let inputEndDate = end_date.substr(0,10)		// year-month-day
						
						// month ġȯ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
						let startMonth;
						if(sMonth == ' Jan'){
							startMonth = '01';
						}else if(sMonth == ' Feb'){
							startMonth = '02';
						}else if(sMonth == ' Mar'){
							startMonth = '03';
						}else if(sMonth == ' Apr'){
							startMonth = '04';
						}else if(sMonth == ' May'){
							startMonth = '05';
						}else if(sMonth == ' Jun'){
							startMonth = '06';
						}else if(sMonth == ' Jul'){
							startMonth = '07';
						}else if(sMonth == ' Aug'){
							startMonth = '08';
						}else if(sMonth == ' Sep'){
							startMonth = '09';
						}else if(sMonth == ' Oct'){
							startMonth = '10';
						}else if(sMonth == ' Nov'){
							startMonth = '11';
						}else if(sMonth == ' Dec'){
							startMonth = '12';
						}
						
						let endMonth;
						if(sMonth == ' Jan'){
							endMonth = '01';
						}else if(sMonth == ' Feb'){
							endMonth = '02';
						}else if(sMonth == ' Mar'){
							endMonth = '03';
						}else if(sMonth == ' Apr'){
							endMonth = '04';
						}else if(sMonth == ' May'){
							endMonth = '05';
						}else if(sMonth == ' Jun'){
							endMonth = '06';
						}else if(sMonth == ' Jul'){
							endMonth = '07';
						}else if(sMonth == ' Aug'){
							endMonth = '08';
						}else if(sMonth == ' Sep'){
							endMonth = '09';
						}else if(sMonth == ' Oct'){
							endMonth = '10';
						}else if(sMonth == ' Nov'){
							endMonth = '11';
						}else if(sMonth == ' Dec'){
							endMonth = '12';
						}
						
						let selectStartDate = startYear+'-'+startMonth+'-'+(startDay-1)
						/* console.log(inputStartDate==selectStartDate) ok*/
						
						let selectEndDate = endYear+'-'+endMonth+'-'+(endDay-1)
						/* console.log(inputEndDate == selectEndDate) ok */
						
						let defId = allEvent[i]._def.defId
						if(allEvent[i]._def.title == content && inputStartDate==selectStartDate && inputEndDate == selectEndDate) {
							$.ajax({
								type : 'POST',
								url : '/schedule/rest/addLessonSchedule',
								data : {
									"defId" : defId,
									"startTime" : start_date,
									"endTime" : end_date,
									"content" : content
								},
								success : function(data) {
									alert('���� ��ϿϷ�')
								},
								error : function(e) {
									alert('error: ', e)
								}
							});
						}
					}
				});
				calendar.unselect()
			},
			eventClick : function(arg) {
				if (confirm('�̺�Ʈ�� ����ڽ��ϱ�?')) {
					arg.event.remove()
					console.log(JSON.stringify(arg, null, "\t"))
					console.log('-----')
					/* console.log(Object.values(arg)); */
					let obj = Object.values(arg)
					console.log(obj[1]._def.title)
					console.log(obj[1]._instance.range.start)
					console.log(obj[1]._instance.range.end)
					var allEvent = calendar.getEvents();
					/* let title = allEvent[0]._def.title;
					let start = allEvent[0]._instance.range.start;
					let end = allEvent[0]._instance.range.end; */	
					
					
					
					// �ؿ� delete ���� ing..
					
					let startTime = allEvent[i]._instance.range.start.toString()
					let sMonth = startTime.substr(3,4)	// month
					let yearT = startTime.substr(10,11)
					let [startTime1, startYear] = yearT.split(' ')		//year
					let dayY = startTime.substr(7,8)
					let [startYear2, startDay] = dayY.split(' ')		// day
					/* console.log('----')
					console.log(startDay)		//??? +1 error
					console.log('----') */
					
					let endTime = allEvent[i]._instance.range.end.toString()
					let eMonth = endTime.substr(3,4)		//month
					let endT = endTime.substr(10,11)
					let [endTime1, endYear] = endT.split(' ')	// endYear
					let dayY2 = endTime.substr(7,8)
					let [endYear2, endDay] = dayY2.split(' ')		//endDay
					
					let inputStartDate = start_date.substr(0,10)	// year-month-day
					let inputEndDate = end_date.substr(0,10)		// year-month-day
					
					// month ġȯ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
					let startMonth;
					if(sMonth == ' Jan'){
						startMonth = '01';
					}else if(sMonth == ' Feb'){
						startMonth = '02';
					}else if(sMonth == ' Mar'){
						startMonth = '03';
					}else if(sMonth == ' Apr'){
						startMonth = '04';
					}else if(sMonth == ' May'){
						startMonth = '05';
					}else if(sMonth == ' Jun'){
						startMonth = '06';
					}else if(sMonth == ' Jul'){
						startMonth = '07';
					}else if(sMonth == ' Aug'){
						startMonth = '08';
					}else if(sMonth == ' Sep'){
						startMonth = '09';
					}else if(sMonth == ' Oct'){
						startMonth = '10';
					}else if(sMonth == ' Nov'){
						startMonth = '11';
					}else if(sMonth == ' Dec'){
						startMonth = '12';
					}
					
					let endMonth;
					if(sMonth == ' Jan'){
						endMonth = '01';
					}else if(sMonth == ' Feb'){
						endMonth = '02';
					}else if(sMonth == ' Mar'){
						endMonth = '03';
					}else if(sMonth == ' Apr'){
						endMonth = '04';
					}else if(sMonth == ' May'){
						endMonth = '05';
					}else if(sMonth == ' Jun'){
						endMonth = '06';
					}else if(sMonth == ' Jul'){
						endMonth = '07';
					}else if(sMonth == ' Aug'){
						endMonth = '08';
					}else if(sMonth == ' Sep'){
						endMonth = '09';
					}else if(sMonth == ' Oct'){
						endMonth = '10';
					}else if(sMonth == ' Nov'){
						endMonth = '11';
					}else if(sMonth == ' Dec'){
						endMonth = '12';
					}
					
					let selectStartDate = startYear+'-'+startMonth+'-'+(startDay-1)
					/* console.log(inputStartDate==selectStartDate) ok*/
					
					let selectEndDate = endYear+'-'+endMonth+'-'+(endDay-1)
					/* console.log(inputEndDate == selectEndDate) ok */
					
					
					
					
					/* let scheduleData = {
						"title" : title,
						"start" : start,
						"end" : end
					}; */
					/* $.ajax({
						type : 'POST',
						url : '/schedule/rest/deleteSchedule',
						data : scheduleData,
						success : function(data) {
							alert('�����Ϸ�')
						},
						error : function(e) {
							alert('error: ', e)
						}
					}); */
				}
			},
			aditable : true, //false�� ����� draggable �۵� x
			displayEventTime : false
		});
		calendar.render();
	});

	function fncSelectTeacher(e) {
		const p = [];
		p.push('hi')
		const select = $(".schedule");
		for (let i = 0; i < select.length; i++) {
			p.push($(select[i]).data('value'))
		}
		var a = $(e).parent().find(".form-select").val();
		var teacherId = p[a];

		$("#selectTeacher").attr("method", "POST").attr("action",
				"/schedule/manageLessonSchedule?teacherID=" + teacherId)
				.submit();
	}
</script>

<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
	background-color: #f5f5f5;
}

.success {
	font-family: "Open Sans", -apple-system, BlinkMacSystemFont, "Segoe UI",
		Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", Helvetica,
		Arial, sans-serif;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
	padding: 0 10px;
}

.fc-header-toolbar {
	/*�޷� ��� ���� ��ġ ����*/
	padding-top: 1em;
	padding-left: 1em;
	padding-right: 1em;
}

#loading {
	display: none;
	position: absolute;
	top: 10px;
	right: 10px;
}
</style>

<style>
</style>
</head>
<body class="mt-0">
	<div id='loading'>loading...</div>
	<c:if test="${user.role eq 'student' }">
		<form id="selectTeacher" class="d-flex">
			<div class="form-group">
				<label for="lessonCode" class="col-sm-2 control-label">�������̸�</label>
				<select class="form-select" aria-label="Disabled select example">
					<c:set var="i" value="0" />
					<c:forEach var="schedule" items="${list}">
						<c:set var="i" value="${i+1}" />
						<option class="schedule" value="${i}"
							data-value="${schedule.teacherId}">${schedule.teacherName.userName}</option>
					</c:forEach>
				</select>
				<!-- <div class="col-sm-10">
         <input type="text" class="form-control" id="lessonCode" name="lessonCode" placeholder="�����ڵ�">
       </div> -->
			</div>
			<button type="button" class="btn01" id="btn01">�˻�</button>
		</form>
	</c:if>
	<!-- book -->
	<c:if test="${user.role eq 'parent'}">
		<form id="selectTeacher" class="d-flex">
			<div class="form-group">
				<label for="studentName" class="col-sm-2 control-label">�л��̸�</label>
				<select class="form-select" aria-label="Disabled select example">
					<option class="schedule" value="${i}">����</option>
					<c:set var="i" value="0" />
					<c:forEach var="schedule" items="${list}">
						<c:set var="i" value="${i+1}" />
						<option class="schedule" value="${i}"
							data-value="${schedule.studentId.studentId}">${schedule.studentId.studentName}</option>
					</c:forEach>
				</select>
				<!-- <div class="col-sm-10">
         <input type="text" class="form-control" id="lessonCode" name="lessonCode" placeholder="�����ڵ�">
       </div> -->
			</div>
			<button type="button" class="btn01" id="btn01">�˻�</button>
		</form>
	</c:if>


	<div id='calendar' style="width: 1020px; height: 620px;"></div>
	<!-- modal �߰� -->
	<c:if test="${user.role eq 'teacher'}">
		<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">������ �Է��ϼ���.</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="taskId" class="col-form-label">���� ����</label> <input
								type="text" class="form-control" id="calendar_content"
								name="calendar_content"> <label for="taskId"
								class="col-form-label">���� ��¥</label> <input
								type="datetime-local" class="form-control"
								id="calendar_start_date" name="calendar_start_date"> <label
								for="taskId" class="col-form-label">���� ��¥</label> <input
								type="datetime-local" class="form-control"
								id="calendar_end_date" name="calendar_end_date">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id="addCalendar"
							style="background-color: #6c757d">�߰�</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" id="sprintSettingModalClose">���</button>
						<button
							style="width: 120px; height: 40px; background-color: black; color: white; vertical-align: middle; font-size: 17px; cursor: poointer"
							onclick="javascript:allSave();">���� ����</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</body>
</html>