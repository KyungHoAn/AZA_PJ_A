window.addEventListener('DOMContentLoaded', event => {
	const lessonDataSimple = document.getElementById('lessonDataSimple');

	if (lessonDataSimple) {

		if (sessionStorage.getItem("role") == 'teacher') {
			$.ajax({
				url: "/lesson/rest/listLesson",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json",
				},
				success: function(result) {
					if (result) {
						console.log("js : rest/listLesson");

						console.log(result);



						var lesson = result.list;
						console.log(lesson)
						var lessonData = [];
						var role = sessionStorage.getItem('role');

						lesson.map((lesson, i) => {
							var temp = [];
							temp.push(i + 1);
							temp.push(lesson.lessonName);
							temp.push(lesson.teacherName.userName);
							temp.push(lesson.lessonDay);
							temp.push(lesson.lessonStartTime);
							temp.push(lesson.lessonEndTime);
							temp.push(lesson.lessonPlace);
							temp.push(lesson.subject);
							temp.push(lesson.lessonCode);

							lessonData.push(temp);
						})

						var data = {
							"headings": [
								"No",
								"수업명",
								"선생님 이름",
								"수업 요일",
								"수업시작시간",
								"수업종료시간",
								"수업장소",
								"과목명",
								"수업코드"
							],
							"data": lessonData,
						}

						var getLesson = function(data, type, row) {
							var lessonCode = row.childNodes[8].textContent
							return `<a href="/lesson/getLesson/` + lessonCode + `">` + data + `</a>`;
						}

						if (sessionStorage.getItem("role") == 'teacher') {

							new simpleDatatables.DataTable(lessonDataSimple, {
								data,
								columns: [
									{
										select: 8,
										render: getLesson,
									},
								],
								columnDefs: [
									{
										targets: [0],
										orderData: [0, 1],
									},
									{
										targets: [1],
										orderData: [0, 1],
									},
									{
										targets: [2],
										orderData: [0, 1],
									},
									{
										targets: [3],
										orderData: [0, 1],
									},
									{
										targets: [4],
										orderData: [0, 1],
									},
									{
										targets: [5],
										orderData: [0, 1],
									},
									{
										targets: [6],
										orderData: [0, 1],
									},
									{
										targets: [7],
										orderData: [0, 1],
									},
									{
										targets: [8],
										orderData: [0, 1],
									},
								],
							});
						}
					}
				}
			}) // ajax 끝
		} else {
			$.ajax({
				url: "/lesson/rest/listLesson",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json",
				},
				success: function(result) {
					if (result) {
						console.log("js : rest/listLesson");

						console.log(result);



						var lesson = result.list;
						console.log(lesson)
						var lessonData = [];
						var role = sessionStorage.getItem('role');

						lesson.map((lesson, i) => {
							var temp = [];
							temp.push(i + 1);
							temp.push(lesson.lessonName);
							temp.push(lesson.teacherName.userName);
							temp.push(lesson.lessonDay);
							temp.push(lesson.lessonStartTime);
							temp.push(lesson.lessonEndTime);
							temp.push(lesson.lessonPlace);
							temp.push(lesson.subject);
							temp.push(lesson.lessonCode);
							temp.push(lesson.studentId.proposal);
							temp.push(lesson.studentId.studentName);

							lessonData.push(temp);
						})

						var data = {
							"headings": [
								"No",
								"수업명",
								"선생님 이름",
								"수업 요일",
								"수업시작시간",
								"수업종료시간",
								"수업장소",
								"과목명",
								"수업코드",
								"proposal",
								"학생이름",
							],
							"data": lessonData,
						}

						var getproposal = function(data, type, row) {

							//var proposal =  row.lastElementChild.textContent
							var proposal = row.childNodes[9].textContent

							return `<a href="/lesson/getLesson/` + proposal + `">
                        <button class="btn btn-raised-warning type="button"> 상세보기 </button>
                           </a>`;
						}

						var getLesson = function(data, type, row) {
							var lessonCode = row.childNodes[8].textContent
							return `<a href="/lesson/getLesson/` + lessonCode + `">` + data + `</a>`;
						}

						if (sessionStorage.getItem("role") == 'teacher') {
							var columns = [{
								select: 9,
								render: getproposal,
							}];

							new simpleDatatables.DataTable(lessonDataSimple, {
								data,
								columns: [
									{
										select: 8,
										render: getLesson,
									},
									{
										select: 9,
										hidden: true,
									},
									{
										select: 10,
										hidden: true,
									},
								],
								columnDefs: [
									{
										targets: [0],
										orderData: [0, 1],
									},
									{
										targets: [1],
										orderData: [0, 1],
									},
									{
										targets: [2],
										orderData: [0, 1],
									},
									{
										targets: [3],
										orderData: [0, 1],
									},
									{
										targets: [4],
										orderData: [0, 1],
									},
									{
										targets: [5],
										orderData: [0, 1],
									},
									{
										targets: [6],
										orderData: [0, 1],
									},
									{
										targets: [7],
										orderData: [0, 1],
									},
									{
										targets: [8],
										orderData: [0, 1],
									},
									{
										targets: [9],
										orderData: [0, 1],
									},
									{
										targets: [10],
										orderData: [0, 1],
									},
								],
							});
						} else if (sessionStorage.getItem("role") == 'student') {
							new simpleDatatables.DataTable(lessonDataSimple, {
								data,
								columns: [
									{
										select: 8,
										render: getLesson,
									},
									{
										select: 10,
										hidden: true,
									},
								],
								columnDefs: [
									{
										targets: [0],
										orderData: [0, 1],
									},
									{
										targets: [1],
										orderData: [0, 1],
									},
									{
										targets: [3],
										orderData: [0, 1],
									},
									{
										targets: [4],
										orderData: [0, 1],
									},
									{
										targets: [5],
										orderData: [0, 1],
									},
									{
										targets: [6],
										orderData: [0, 1],
									},
									{
										targets: [7],
										orderData: [0, 1],
									},
									{
										targets: [8],
										orderData: [0, 1],
									},
									{
										targets: [9],
										orderData: [0, 1],
									},
									{
										targets: [10],
										orderData: [0, 1],
									},
								],
							});
						} else if (sessionStorage.getItem("role") == 'parent') {
							new simpleDatatables.DataTable(lessonDataSimple, {
								data,
								columns: [
									{
										select: 8,
										render: getLesson,
									},
								],
								columnDefs: [
									{
										targets: [0],
										orderData: [0, 1],
									},
									{
										targets: [1],
										orderData: [0, 1],
									},
									{
										targets: [3],
										orderData: [0, 1],
									},
									{
										targets: [4],
										orderData: [0, 1],
									},
									{
										targets: [5],
										orderData: [0, 1],
									},
									{
										targets: [6],
										orderData: [0, 1],
									},
									{
										targets: [7],
										orderData: [0, 1],
									},
									{
										targets: [8],
										orderData: [0, 1],
									},
									{
										targets: [9],
										orderData: [0, 1],
									},
									{
										targets: [10],
										orderData: [0, 1],
									},
								],
							})
						}

					}
				}
			})
		}
	}
});