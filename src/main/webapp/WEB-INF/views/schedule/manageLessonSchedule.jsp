<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@page import="java.util.List" %>
<%@page import="com.aza.service.domain.Schedule" %> --%>

<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8' />
<link type="text/css" href="/resources/css/schedule.css" rel="stylesheet" />
<script type="text/javascript"   src="/resources/javascript/schedule/main.js"></script>
<!-- <script src='../lib/main.min.js'></script> -->
<script type="text/javascript"   src="/resources/javascript/schedule/ko.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->

 <!-- bootstrap 4 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- getLesson.jsp -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Roboto and Roboto Mono fonts from Google Fonts-->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Mono:400,500" rel="stylesheet" />
<link href="/resources/css/common.css" rel="stylesheet">
<script>
  var calendar = null;
  
  $(document).ready(function(){
  var calendarEl = document.getElementById('calendar');
  aspectRatio: 1.35,
  calendar = new FullCalendar.Calendar(calendarEl, {
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridDay'
    },
    initialView: 'dayGridMonth',
    locale: 'ko',   		//한글설정 나머지 영어빼고 지움
    buttonIcons: false, 	//이전달 다음달로 보임 <> == true
    navLinks: true, 		//날짜 누르면 상세 조회.
    businessHours: true, 	//상세 시간 표시
    editable: true,   		//수정가능여부
    selectable: true, 		//날짜 선택시 표시
    dayMaxEvents: true, 	//이벤트가 많을 시 +표시로 보여줌
    selectMirror: true,
    events: function(info, successCallback, failureCallback) {
       // ajax 처리로 데이터를 로딩 시킨다.
       $.ajax({
         type:"post",
         url: '/schedule/rest/listLessonSchedule',
         dataType: "json",
           success: function(list) {
        	   var events = [];
                $.each(list, function (index, data){
                	for(var i=0; i<data.length; i++){
                		events.push({
                         title:data[i].title,
                         start:data[i].start,
                         end:data[i].end
                      });
                   }
                })
               successCallback(events);
              }
       });
    },//json형태의 값
    eventAdd: function(){//이벤트가 추가되면 발생하는 이벤트
       console.log()
    },
    /* 모달추가로 인한 추석 처리 */ 
    select: function(arg){
       $("#calendarModal").modal("show");   //modal 나타내기
      
      $("#addCalendar").on("click",function(){ //modal의 추가 버튼 클릭
         var content = $("#calendar_content").val();
         var start_date = $("#calendar_start_date").val();
         var end_date = $("#calendar_end_date").val();
         
         //내용 입력 여부 확인
         if(content == null || content == ""){
            alert("내용을 입력하세요.");
         }else if(start_date==""|| end_date==""){
            alert("날짜를 입력하세요");
         }else if(new Date(end_date)- new Date(start_date)<0){   //date타입으로 변경 후 확인
            alert("종료일이 시작일보다 먼저입니다.");
         }else { //정상적인 입력 시
            var obj = {
               "title":content,
               "start":start_date,
               "end":end_date
            }//전송할 객체 생성
            calendar.addEvent({
               title: obj.title,
               start: obj.start,
               end: obj.end,
               backgroundColor:"primary",
               textColor:"black"
            })
            }
         });
        calendar.unselect()
       },
       eventClick: function(arg){
        if(confirm('이벤트를 지우겠습니까?')){
            arg.event.remove()
            var allEvent = calendar.getEvents();
            console.log(allEvent[0])
            let title = allEvent[0]._def.title;
            let start = allEvent[0]._instance.range.start;
            let end = allEvent[0]._instance.range.end;
            let scheduleData = {"title": title, "start": start, "end": end};
            $.ajax
            ({
               type:'POST',
               url: '/schedule/rest/deleteSchedule',
               data: scheduleData,
               success: function(data) {
               	alert('삭제완료')	
               },
               error:function(e) {
             	  alert('error: ', e)
               }  
             });
            }
        },      
      aditable: true,   //false로 변경시 draggable 작동 x
      displayEventTime: false // 시간 표시 x modal 표시로 작성한 부분
    
  });
  calendar.render();       
  //선택한 옵션이 변경되면 동적으로 일정관리 옵션 변경
/*         localeSelectorEl.addEventListener('change', function() {
      if (this.value) {
        calendar.setOption('locale', this.value);
      }
    });*/
});
      
      function allSave()
      {
         var allEvent = calendar.getEvents();         
         var events = new Array();
         
         for(var i=0; i< allEvent.length; i++)
         {
           var obj = new Object();
           obj.title = allEvent[i]._def.title;   //이벤트 명칭
           obj.start = allEvent[i]._instance.range.start; //시작 날짜 및 시간
           obj.end = allEvent[i]._instance.range.end;
           
           events.push(obj);
         }
         var jsondata = JSON.stringify(events);
         
        $.ajax
        ({
           type:'POST',
           url: '/schedule/rest/addLessonSchedule',
           data: {"alldata": jsondata},
           /* data: {"scheduleTitle":jsondata.scheduleTitle,
              "scheduleStartTime":"scheduleStartTime",
              "scheduleEndTime":"scheduleEndTime"}, */
           dataType: 'text',
           async: false, //==>동기
           success: function(data) {
           	alert('일정 등록완료')	
           },
           error:function(e) {
         	  alert('error: ', e)
           }  
         });
      }
      
      function fncSelectTeacher(e){
         const p = [];
         p.push('hi')
         const select = $(".schedule");
         for(let i=0; i<select.length; i++){
            p.push($(select[i]).data('value'))
         }         
         var a = $(e).parent().find(".form-select").val();
         var teacherId = p[a];
            
         $("#selectTeacher").attr("method","POST").attr("action","/schedule/manageLessonSchedule?teacherID="+teacherId).submit();
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

.success{
font-family: "Open Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", Helvetica, Arial, sans-serif;
}


#calendar {
   max-width: 1100px;
   margin: 0 auto;
   padding: 0 10px;
}

.fc-header-toolbar {
   /*달련 상단 툴바 위치 조정*/
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
      <form id = "selectTeacher" class="d-flex"   > 
      <div class="form-group">
         <label for="lessonCode" class="col-sm-2 control-label">선생님이름</label>
         <select class="form-select" aria-label="Disabled select example">
               <c:set var="i" value="0"/>
                     <c:forEach var="schedule" items="${list}">
                         <c:set var="i" value ="${i+1}"/>
                        <option class="schedule" value="${i}" data-value="${schedule.teacherId}">${schedule.teacherName.userName}</option>
                     </c:forEach>
                  </select>
            <!-- <div class="col-sm-10">
         <input type="text" class="form-control" id="lessonCode" name="lessonCode" placeholder="수업코드">
       </div> -->
       </div>
       <button type="button" class="btn01" id="btn01">검색</button>
    </form>
    </c:if>
   <!-- book -->
   <c:if test="${user.role eq 'parent'}">
         <form id = "selectTeacher" class="d-flex"   > 
      <div class="form-group">
         <label for="studentName" class="col-sm-2 control-label">학생이름</label>
         <select class="form-select" aria-label="Disabled select example">
         <option class="schedule" value="${i}">선택</option>
               <c:set var="i" value="0"/>
                     <c:forEach var="schedule" items="${list}">
                         <c:set var="i" value ="${i+1}"/>
                        <option class="schedule" value="${i}" data-value="${schedule.studentId.studentId}">${schedule.studentId.studentName}</option>
                     </c:forEach>
                  </select>
            <!-- <div class="col-sm-10">
         <input type="text" class="form-control" id="lessonCode" name="lessonCode" placeholder="수업코드">
       </div> -->
       </div>
       <button type="button" class="btn01" id="btn01">검색</button>
    </form>
   </c:if>
   
   
   <div id='calendar' style="width:1020px; height:620px;"></div>
   <!-- modal 추가 -->
   <c:if test="${user.role eq 'teacher'}">
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="datetime-local" class="form-control" id="calendar_start_date" name="calendar_start_date">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="datetime-local" class="form-control" id="calendar_end_date" name="calendar_end_date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar" style="background-color: #6c757d">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
                        <button style="width:120px; height:40px; background-color:black; color:white; vertical-align:middle; font-size:17px;
                     cursor:poointer" onclick="javascript:allSave();">일정 저장</button>
                </div>    
            </div>
        </div>
    </div>
    </c:if>
</body>
</html>