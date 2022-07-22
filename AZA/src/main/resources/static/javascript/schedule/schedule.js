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
          locale: 'ko',   //한글설정 나머지 영어빼고 지움
          buttonIcons: {
				prev: 'bi bi-arrow-left',
				next: 'bi bi-arrow-right',
			}, //이전달 다음달로 보임 <> == true
          navLinks: true,  //날짜 누르면 상세 조회.
          businessHours: true, //상세 시간 표시
          editable: true,   //수정가능여부
          selectable: true, //날짜 선택시 표시
          dayMaxEvents: true, //이벤트가 많을 시 +표시로 보여줌 ㅎㅎ
          selectMirror: true,
          events: function(info, successCallback, failureCallback){
             // ajax 처리로 데이터를 로딩 시킨다.
             /* var datalist = []; */
             $.ajax({
               type:"post",
               url: '/schedule/rest/listLessonSchedule',
               dataType: "json",
                 success: function(list) {
                     var events = [];
                      console.log("^^ 될거지?");
                      console.log(list);
                      $.each(list, function (index,data){
                         /* for(var i=0; i<data.length; i++){
                            console.log(data[i].title);  
                         } */
                          var datalist = data.list;
                         
                          /* for(var i=0; i<data.length; i++){ */
                             if(data.pValue !=null && data.pValue === 'private'){
                                for(var i=0; i<data.length; i++){
                                events.push({
                                      title:data[i].title
                                      ,start:data[i].start
                                      ,end:data[i].end
                                }); 
                                }
                             }else if(data.pValue!=null&&data.pValue ==='public'){
                                for(var i=0; i<data.length; i++){
                                events.push({
                                      title:data[i].title
                                      ,start:data[i].start
                                      ,end:data[i].end
                                   }); 
                                }
                             }else{
                                for(var i=0; i<data.length; i++){
                                   events.push({
                                         title:data[i].title
                                         ,start:data[i].start
                                         ,end:data[i].end
                                      }); 
                                   }                           
                             }
                           /*} */
                      })                      
                      /* datalist.push({
                          title:result.title,
                          start:result.start,
                          end:result.end */
                          /* title: "오후 회의",
                          start: "2022-06-06T19:00:00",
                          end: "2022-06-07T09:30:00" */
                      /* }); */
                     successCallback(events);
                    }
             });
          },//json형태의 값
          eventAdd: function(){//이벤트가 추가되면 발생하는 이벤트
             console.log()
          },
          /* 모달추가로 인한 추석 처리 */ 
          select: function(arg){
        	  $("#calendarModal").modal("show");	//modal 나타내기
  			
  			$("#addCalendar").on("click",function(){ //modal의 추가 버튼 클릭
  				var content = $("#calendar_content").val();
  				var start_date = $("#calendar_start_date").val();
  				var end_date = $("#calendar_end_date").val();
  				
  				//내용 입력 여부 확인
  				if(content == null || content == ""){
  					alert("내용을 입력하세요.");
  				}else if(start_date==""|| end_date==""){
  					alert("날짜를 입력하세요");
  				}else if(new Date(end_date)- new Date(start_date)<0){	//date타입으로 변경 후 확인
  					alert("종료일이 시작일보다 먼저입니다.");
  				}else { //정상적인 입력 시
  					var obj = {
  						"title":content,
  						"start":start_date,
  						"end":end_date
  					}//전송할 객체 생성
  					console.log(obj); //서버로 해당 객체를 전달해서 DB연동 가능
  					calendar.addEvent({
  						title: obj.title,
  						start: obj.start,
  						end: obj.end,
  						backgroundColor:"primary",
  						textColor:"black"
  					})
	  				}
	  			});
           /* var title = prompt('일정 등록: ');  //title값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
               if(title){
                 calendar.addEvent({
                  title: title,
                   start: arg.start,
                   end: arg.end,  // allDay: arg.allDay,
                   backgroundColor:"skyblue",
                   textColor:"blue"
                 })
               } */
              calendar.unselect()
             },
             eventClick: function(arg){
              if(confirm('이벤트를 지우겠습니까?')){
                arg.event.remove()
              }
            },
            
            aditable: true,	//false로 변경시 draggable 작동 x
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
         
         /* console.log(allEvent); */
         for(var i=0; i< allEvent.length; i++)
         {
           var obj = new Object();
            /* alert(allEvent[i]._def.title);//이벤트 명칭 */
           obj.title = allEvent[i]._def.title;   //이벤트 명칭
           /* obj.allday = allEvent[i]._def.allDay; //하루종일의 이벤트인지 알려주는 boolean */
           obj.start = allEvent[i]._instance.range.start; //시작 날짜 및 시간
           obj.end = allEvent[i]._instance.range.end;
           
           events.push(obj);
         }
         var jsondata = JSON.stringify(events);
         /* console.log(jsondata); */
         
         savedata(jsondata)
      }
      
      function loadingEvents()   //전체 json data 담김
      {
         $.ajax
         ({
            type:'POST',
            url: '/schedule/rest/listLessonSchedule',
            data: {},
            dataType: 'JSON',   //가지고 올때의 데이터 타입
            async: false //==>동기
          })
          .done(function(result){
             /* console.log(result); */
             /* alert(JSON.stringify(result));*/
             
             /* var list = result.list;
             list.map(schedule => {
                console.log(schedule.start);
                console.log(schedule.end);
                console.log(schedule.title);
             }) */
             
             return_value = JSON.stringify(result);
             /* alert(JSON.stringify(result)); */
             alert(return_value);
             return return_value;
          })          
          .fail(function(request, status, error){
             alert("에러 발생:"+error)   
          });
         /* 
          return return_value; */
      }
      
      function savedata(jsondata)
      {
         $.ajax
         ({
            type:'POST',
            url: '/schedule/addLessonSchedule',
            data: {"alldata": jsondata},
            /* data: {"scheduleTitle":jsondata.scheduleTitle,
               "scheduleStartTime":"scheduleStartTime",
               "scheduleEndTime":"scheduleEndTime"}, */
            dataType: 'text',
            async: false //==>동기
            /* success: function(data){
               alert("OK");
            } */
          })
          .done(function(result){
             alert("저장완료");
          })
          
          .fail(function(request, status, error){
             alert("에러 발생:"+error)   
          });
      }