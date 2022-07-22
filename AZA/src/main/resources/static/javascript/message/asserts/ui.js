const messagePopupBtn = $("#open-messagePopup");
const messagePopup =  $("#messagePopup");
const otherListBtn = $("#otherListBtn");
const getMessageBtn = $("#getMessageBtn");
const otherListContainer = $("#otherListContainer");
const getMessageContainer = $("#getMessageContainer");
const messages = document.getElementById('messages');
var msgHtml = "";

messagePopupBtn.on("click", popupHandler);
otherListBtn.on("click", getMessageHandler);
getMessageBtn.on("click", otherListHandler);

function popupHandler() {
	
	if(messagePopupBtn.hasClass("opened")) {
		messagePopup.removeClass("show");
		messagePopup.addClass("hidden");
		messagePopupBtn.removeClass("opened");
		disconnect();
	} else{
		
		messagePopup.removeClass("hidden");
		messagePopup.addClass("show");
		messagePopupBtn.addClass("opened")
		connect();
	}
}

function getMessageHandler() {
	otherListContainer.removeClass("hidden");
	getMessageContainer.addClass("hidden");
	$("#messages").empty();
}

function otherListHandler(otherId) {	
	getMessageContainer.removeClass("hidden");
	otherListContainer.addClass("hidden");
}

function getOtherMessage(otherId, otherName) {	
	console.log(otherId);
	otherListHandler(otherId);
	getMessage(sessionStorage.userId , otherId);
	let otherInfo = `<input type="hidden" id="otherId" value="${otherId}"></input>
	<h5 id="otherName" class="mb-0">${otherName}</h5>
	<h6 class="caption small text-gray m-0">@${otherId}</h6>`;
	$("#otherInfo").html("");	
	$("#otherInfo").html(otherInfo);
}

/*$(document).mouseup(function (e){
	if(messagePopup.has(e.target).length === 0){
		messagePopup.removeClass("show");
		messagePopup.addClass("hidden");
		disconnect();
	}
});*/

var stompClient =""

function connect() {
    var socket = new SockJS('/gs-guide-websocket');
    console.log(socket);
    stompClient = Stomp.over(socket);
    console.log("connect");
    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        
        // getMessage : 메시지 상세조회
        stompClient.subscribe('/topic/getMessage', function (messages) {
			msgHtml = "";
			console.log(messages + "getMessagezzz")
            var list = JSON.parse(messages.body);
            let userId = sessionStorage.userId;          
            $('.messageList').remove();
            list.map(message => {
				showMessages(userId,message);
			});
			
		// addMessage : 메시지 보내기	
		stompClient.subscribe('/topic/showAddMessage', function(data) {
			console.log(data);
			var message = JSON.parse(data.body);
			let userId = message.senderId;
			let otherId = message.receiverId;
			getMessage(userId, otherId);
			});
        });
        
    });
}

function showAddMessage() {
	stompClient.subscribe('/topic/showAddMessage', function(message) {
		console.log(message);		
	})
}

function disconnect() {
    if (stompClient !== null) {
       // stompClient.disconnect();
    }
    console.log("연결 끝 : Disconnected");
}

// getMessage
function getMessage(userId,otherId) {
	console.log(stompClient);
	console.log("/app/getMessage/userId/otherId");
	stompClient.send(`/app/getMessage/${userId}/${otherId}`,{}, JSON.stringify({'userId':userId, 'otherId': otherId }));
}

function addMessage() {
	console.log(stompClient);
	console.log("/app/addMessage");
	
	var now = getLocalDateTime();
	
	stompClient.send("/app/addMessage", {}, JSON.stringify({'senderId': sessionStorage.userId,
															'receiverId': $("#otherId").val(),
															'messageContent': $("#messageContent").val(),
															'messageCreateAt': now,		
	}));
	$("#messageContent").val("");
}

function deleteBtnHandler(ele) {
	console.log("deleteBtnHandler :"+ele.dataset.id);
	console.log("deleteBtnHandler :"+ sessionStorage.userId);
	console.log("deleteBtnHandler :"+ $("#otherId").val());
	stompClient.send("/app/deleteMessage/"+ele.dataset.id),{}, JSON.stringify({
															'senderId': sessionStorage.userId,
															'receiverId': $("#otherId").val(),
															'_id' : ele.dataset.id
															})
}


function showMessages(userId, message) {
	
	var createAt = message.messageCreateAt.split("년");
	if(createAt[0] == new Date().getFullYear()) {
		var timeForm = createAt[1];
	} else {
		var timeForm = createAt.join("년 ");
	}
	

	if (userId == message.senderId) {
		
		console.log(message);
		msgHtml += `<ul class='messageList pl-3'>
		<div class="pt-1 pb-1 d-flex flex-row justify-content-end">
        <div class="messageContent" name="${message._id}">
            <div class="d-flex justify-content-end align-items-end">
	            <i class="deleteBtn bi bi-x m-0 pb-0 mr-1 fs-6 text-primary" onclick="return deleteBtnHandler(this)" data-id="${message._id}"></i>
	            <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-primary">${message.messageContent}</p>
            </div>
                <p class="small caption me-3 mb-1 rounded-3 text-muted d-flex justify-content-end">${timeForm}</p>
        </div>
        </div></ul>`;
	} else {
		msgHtml += `<ul class='messageList pl-3'>
		<div class="pt-1 pb-1 d-flex flex-row justify-content-start">
        <span class="messageContent" name="${message._id}">
        <div class="d-flex justify-content-start align-items-end">
        <p class="small p-2 mb-1 rounded-3" style="background-color: #f5f6f7;">${message.messageContent}</p>
        </div>
        <p class="small caption text-muted mb-1 text-start">${timeForm}</p>
        </span>
        </div></ul>`;	
	}	
	//console.log(msgHtml);
	console.log("내려감");
    $("#messages").html(msgHtml);
    scrollToBottom("messageScroll");
    
}

function getLocalDateTime() {
	var now = new Date().toLocaleString();
	var x = now.replaceAll(".", "");
	var temp = x.split(" ");

	var nowForm = temp[0] + "년" + temp[1] +"월 "+temp[2]+"일 "+temp[3]+" "+temp[4].substring(0, temp[4].length-3); 

	return nowForm;
}


// 자동 스크롤
function scrollToBottom (id) {
   var div = document.getElementById(id);
   div.scrollTop = div.scrollHeight - div.clientHeight;
}



$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $( "#connect" ).click(function() { connect(); });
    $( "#disconnect" ).click(function() { disconnect(); });
    $( "#send" ).click(function() { sendName(); });
    $("#sendBtn").click(function() { addMessage(); });
    $("#messageContent").keydown(function(e) {
	    if (e.keyCode == 13) {
	        $('#messageContent').submit();
	    }}
	  );
});
