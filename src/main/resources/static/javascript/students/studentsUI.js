window.addEventListener('DOMContentLoaded', event => {
	
	// 자녀 선택 드롭다운
	if (window.innerWidth < 992) {
	  // close all inner dropdowns when parent is closed
	  document.querySelectorAll('.navbar .dropdown').forEach(function(everydropdown){
	    everydropdown.addEventListener('hidden.bs.dropdown', function () {
	      // after dropdown is hidden, then find all submenus
	        this.querySelectorAll('.submenu').forEach(function(everysubmenu){
	          // hide every submenu as well
	          everysubmenu.style.display = 'none';
	        });
	    })
	  });
	
	  document.querySelectorAll('.dropdown-menu a').forEach(function(element){
	    element.addEventListener('click', function (e) {
	        let nextEl = this.nextElementSibling;
	        if(nextEl && nextEl.classList.contains('submenu')) {	
	          // prevent opening link if link needs to open dropdown
	          e.preventDefault();
	          if(nextEl.style.display == 'block'){
	            nextEl.style.display = 'none';
	          } else {
	            nextEl.style.display = 'block';
	          }
	
	        }
	    });
	  })
	}
	
	// 달력
	var currentMonth = new Date().getMonth() + 1;	
	loadEvent(currentMonth);
	
})

// AJAX : restCtrl
function loadEvent(month) {
	var url = new URL(window.location.href);
	var urlParam = url.searchParams;
	var studentId = urlParam.has("studentId") ? urlParam.get("studentId") : "";
	var lessonCode = urlParam.has("lessonCode") ? urlParam.get("lessonCode") : "";
	
	console.log(month, urlParam, studentId,lessonCode);

	$.ajax({
		url:"/students/rest/listStudentsAttendance/"+month+"/"+currentYear+"?studentId="+studentId+"&lessonCode="+lessonCode,
		type:"POST",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
				
				var list = result.list;
				
				console.log(list);
	
				var attendanceArr = [];
				
				list.map(x=> {
					var date = x.attendanceDate.substr(-2);
					var status = x.attendanceState;
					
					date = date[0] == "0" ? date.substr(-1) : date
					
					var temp = {date, status};
					
					attendanceArr.push(temp);
				})

				console.log(attendanceArr);
	
				makeCalendar(currentYear, currentMonth);
			
				attendanceArr.map(x => {
					colored(x);
				})

			}else {
				console.log("실패");
			}
		}
	})	
}	


// 달력
function colored(data) {
	
	var badge = "";
	
	switch (data.status) {
		case "결석":
			badge = `<div class="m-0"><span class="badge bg-danger">결석</span></div>`;
			break;
		case "출석":
			badge = `<div class="m-0"><span class="badge bg-success">출석</span></div>`;
			break;
		case "도망":
			badge =	`<div class="m-0"><span class="badge bg-warning text-dark">도망</span></div>`;
			break;
		default:
			badge = `<div class="m-0"><span class="badge bg-secondary">${data.status}</span></div>`;
			break;
	}

	$(`#${data.date}`).append(badge);
	
}

const months = [
    { 'id': 1, 'name': 'Jan' },
    { 'id': 2, 'name': 'Feb' },
    { 'id': 3, 'name': 'Mar' },
    { 'id': 4, 'name': 'Apr' },
    { 'id': 5, 'name': 'May' },
    { 'id': 6, 'name': 'Jun' },
    { 'id': 7, 'name': 'Jul' },
    { 'id': 8, 'name': 'Aug' },
    { 'id': 9, 'name': 'Sep' },
    { 'id': 10, 'name': 'Oct' },
    { 'id': 11, 'name': 'Nov' },
    { 'id': 12, 'name': 'Dec' },
];
var currentYear = new Date().getFullYear();
var currentMonth = new Date().getMonth() + 1;


function letsCheck(year, month) {
    var daysInMonth = new Date(year, month, 0).getDate();
    var firstDay = new Date(year, month, 01).getUTCDay();
    var array = {
        daysInMonth: daysInMonth,
        firstDay: firstDay
    };
    return array;
}

function makeCalendar(year, month) {
    var getChek = letsCheck(year, month);
    getChek.firstDay === 0 ? getChek.firstDay = 7 : getChek.firstDay;
    $('#calendarList').empty();
    for (let i = 1; i <= getChek.daysInMonth; i++) {
        if (i === 1) {
            var div = '<li id="' + i + '" style="grid-column-start: ' + getChek.firstDay + ';"><div>1</div></li>';
        } else {
            var div = '<li id="' + i + '" ><div>' + i + '</div></li>'
        }
        $('#calendarList').append(div);
    }
    monthName = months.find(x => x.id === month).name;
    $('#yearMonth').text(year + ' ' + monthName);
    
    month = month < 10 ? "0"+ month : month;
    var yearInput = `<input type='hidden' value=${year} name='year'/>`;
    var monthInput = `<input type='hidden' value=${month} name='month'/>`;
    
    $('#yearMonth').append(monthInput);
}

function nextMonth() {
	
    currentMonth = currentMonth + 1;
    if (currentMonth > 12) {
        currentYear = currentYear + 1;
        currentMonth = 1;
    }
    $('#calendarList').empty();
    $('#yearMonth').text(currentYear + ' ' + currentMonth);
    loadEvent(currentMonth);
    
}


function prevMonth() {
	
    currentMonth = currentMonth - 1;
    if (currentMonth < 1) {
        currentYear = currentYear - 1;
        currentMonth = 12;
    }
    $('#calendarList').empty();
    $('#yearMonth').text(currentYear + ' ' + currentMonth);

    loadEvent(currentMonth);
}

///////////////////////////////////////////////////////////////