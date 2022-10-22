var stompClient = null;

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    $("#send").prop("disabled", !connected);
    if (connected) {
        $("#gold_sleep").addClass("hidden");
        $("#gold_basic").removeClass("hidden");       
    }
    else {
        $("#gold_basic").addClass("hidden");
        $("#gold_sleep").removeClass("hidden");
       
    }
    $("#msg").html("");
}

function connect() {
	$("#msg").attr("disabled", false);
	$("#send").attr("disabled", false);
	
    var socket = new SockJS('/ws');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/public', function (message) {
	
			var div = `<div class="message">
		            		<p class="text">${message.body}</p>
		          		</div>`;
            showMessage(div); //서버에 메시지 전달 후 리턴받는 메시지
        });
    });
}

function disconnect() {
    if (stompClient !== null) {
        stompClient.disconnect();
    }
    setConnected(false);
     $("#msg").attr("disabled", true);
     $("#send").attr("disabled", true);
    console.log("Disconnected");
}

function sendMessage() {
    let message = $("#msg").val();
    var div = `<div class="message text-only">
					<div class="response">
	  					<p class="text">${message}</p>
		            </div>
				</div>`;
    showMessage(div);

    stompClient.send("/app/sendMessage", {}, JSON.stringify(message)); //서버에 보낼 메시지
	$("#msg").val("");
}

function showMessage(messageContent) {
    $("#messages-chat").append(messageContent);
}

$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $( "#connect" ).click(function() { 
		connect();
		$("#msg").val("");
	  });
    $( "#disconnect" ).click(function() { 
		disconnect();
		$("#msg").val("");
	});
    $( "#send" ).click(function() { 
		if($("#msg").val() !== "" || $("#msg").val().length > 0) {
			sendMessage(); 
			$("#msg").val("");			
		}
	
	
	});
	$("#msg").on("keyup", function(e) {
		if($("#msg").val() !== "" || $("#msg").val().length > 0) {
		
			
			if(e.keyCode == '13') {
				sendMessage(); 
				$("#msg").val("");
			}
		}
	});
});


