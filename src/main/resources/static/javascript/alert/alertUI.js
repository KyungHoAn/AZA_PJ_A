window.addEventListener('DOMContentLoaded', event => {
	countAlert();
})

let target = document.querySelector('#alertDropDown');

let observer = new MutationObserver((mutations) => {
   	countAlert();
})

let option = {
    attributes: true,
    childList: true,
    characterData: true,
    subtree: true,
};

observer.observe(target, option);

function countAlert() {
	
	$.ajax({
		url:"/alert/rest/countAlert",
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
        },
        success: function(result) {
			if(result) {
				console.log("안읽은 알림 : "+result);
				
				if(result > 0) {
					$("#alertCntBadge").removeClass("hidden");
					$("#alertCntBadge").html(result);
				} else {
					$("#alertCntBadge").addClass("hidden");
				}
				
			} else {
				console.log("fail");
				$("#alertCntBadge").addClass("hidden");
			}
		}
		
	})
}


function deleteAlert(alertCode) {
	$.ajax({
		url:"/alert/rest/deleteAlert/"+alertCode,
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	makeAlert(result);

            } else {
            	console.log("fail");
            	
            }
       }
	})
}

function listAlert() {
	$.ajax({
		url:"/alert/rest/listAlert",
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	console.log("listAlert");
            	
				makeAlert(result);

            } else {
            	console.log("fail");
            }
       }
	})
	
}

function readAlert(alertCode) {
	$.ajax({
		url:"/alert/rest/readAlert/"+alertCode,
		type:"GET",
		headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {         	
            if(result) {
            	
            	makeAlert(result);
            	
            } else {
            	console.log("fail");
            }
       }
	})
}


function makeAlert(result) {
	
	   	console.log("makeAlert");
            	
        	var listAlertView = "";
            var list = result.list
            	
            	list.map(alert => {
            		
            		let alertCode = alert.alertCode;
            		let alertContent = alert.alertContent;
            		let alertCreateAt = alert.alertCreateAt;
            		let alertReadAt = alert.alertReadAt;
	           		let time = "";
            		let tempTotal = alertCreateAt.split(" ");
            		let tempDate = tempTotal[0].split("/");
            		time += tempDate[0]+"년 "+tempDate[1]+"월 "+tempDate[2]+"일 "+tempTotal[1];
            		
            		if(!alertReadAt) {
            			listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3" onclick="return readAlert(`+alertCode+`)">
            			<div class="row">
            			<span class="material-icons text-primary">done</span>
            			<p class="text-primary">읽음</p>
            			</div>
						<div class="dropdown-item-content me-2">
							<div class="dropdown-item-content-text small">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext text-muted caption p-0">`+time+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;
            			
            		} else {
						listAlertView += `<li class="alertLi d-flex justify-content-between pt-3 px-3" onclick="return deleteAlert(`+alertCode+`)"">
						<div class="row">
						<span class="material-icons text-danger" onclick="return deleteAlert(`+alertCode+`)">delete</span>
						<p class="text-danger">삭제</p>
						</div>
						<div class="dropdown-item-content me-2" onclick="return deleteAlert(`+alertCode+`)">
							<div class="dropdown-item-content-text small">`+alertContent+`</div>
							<div class="dropdown-item-content-subtext text-muted caption p-0">`+time+`</div>
						</div>
						</li><li><hr class="dropdown-divider my-0" /></li>`;               		
            		}              		
            	})
            	
            	$('.alertLi').remove();
            	$("#alertDropDown").html("");
            	$("#alertDropDown").append(`<li><h6 class="dropdown-header bg-primary text-white fw-500 py-3">알림</h6></li>
    					<li><hr class="dropdown-divider my-0" /></li>`);
            	$("#alertDropDown").append(listAlertView);
}
