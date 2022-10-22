window.addEventListener('DOMContentLoaded', event => {

    const datatablesSimple = document.getElementById('datatablesSimple');

    if (datatablesSimple) {
	    	$.ajax({
		url:"/students/rest/listTotalStudentsRecord",
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
	
				console.log("js : rest/listStudentsRecord");
				var records = result.list;
				var recordData = [];
				
				records.map((record, i) => {
					console.log(record);
					
					var temp = [];
					temp.push(i+1);
					temp.push(record.studentName);
					temp.push(record.studentId);
					temp.push(record.lessonName);
					temp.push(record.lessonStartDate);
					temp.push(record.fees);
					temp.push(record.payDueDate);
					temp.push(record.proposal);
					temp.push(record.recordCode);

					console.log(temp);
					
					recordData.push(temp);
				})
				console.log(recordData);
				
				var data = {
					"headings" : [
						"NO",
						"이름",
						"ID",
						"수업명",
						"수업 시작일",
						"수업료",
						"수업료 납입일",
						"Status",
						"recordCode",
					],					
					"data" : recordData,

				}
				
		var proposalIcon = function(data, type, row) {
			if(data == "0") {
				return `<a href="/students/proposalStudents/${row.lastElementChild.textContent}/1"><span class="badge bg-success pl-3 pr-3 mr-3">승인</span></a><a href="/students/proposalStudents/${row.lastElementChild.textContent}/2"><span class="badge bg-gray">승인 거절</span></a>`				
			} 
			else if(data == "1") {
				return `<span class="badge bg-primary mr-3">승인 완료</span>`+
				`<a href="/students/deleteStudentsRecord/${row.lastElementChild.textContent}"><span class="badge bg-light text-secondary">삭제</span></a>`;
				}
			else if(data == "2") {
				return `<span class="badge bg-warn">승인 거절</span>`
			}
			return data;
		}
		
		var deleteIcon = function(data, type, row) {
			if(data == "1") {
				return row.classList.add("delete"), `<button>delete</button>`;
			}
		}		
				
				
         new simpleDatatables.DataTable(datatablesSimple, {
			data,
			columns:[
				{
					select: 7,
					render: proposalIcon
				},
				{
					select: 8,
					hidden: true,
					render: deleteIcon
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
            ],	
		});
			}}
		})
    }
});

function deleteStudentsRecord(recordCode) {
	
}


				