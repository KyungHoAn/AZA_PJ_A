const socket = io('http://localhost:3000', {
    withCredentials: true,
});
const messages = document.getElementById('messages');
const msgForm = document.getElementById('msgForm');



socket.on("getUserId", () => {
	socket.emit("emitMessage", sessionStorage.getItem('userId'));
});

socket.on('message', (data, userId, otherId) => {
    console.log(data);
    send(data);
});

socket.on('output-messages', (data, userId, otherId) => {
    console.log(data);

    if(data.length) {
        data.forEach(message => {
            send(message);
        })
    }

    // send(data);
});

socket.on('deleteHandler', (messageId, userId, otherId) => {
    console.log("deleteHandler"+messageId);

    const deletedEle = document.querySelector(`.messageContent[name='${messageId}']`);

    deletedEle.remove();
})

msgForm.addEventListener('submit', e => {
    e.preventDefault();
    socket.emit('chatmessage', msgForm.messageContent.value);
    msgForm.messageContent.value = '';
});

function send(message, userId, otherId) {

    if(message.senderId == userId) {
        const msgHtml = 
        `<div class="pt-1 pb-1 d-flex flex-row justify-content-end">
        <div class="messageContent" name="${message._id}">
            <div>
            <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-primary">${message.messageContent}</p>
            <button class="deleteBtn" class="btn btn-outline-danger" onclick="return deleteBtnHandler(this)" data-id="${message._id}"><i class="fa-solid fa-trash"></i></button>
            </div>
                <p class="small me-3 mb-1 rounded-3 text-muted d-flex justify-content-end">${message.messageCreateAt}</p>
                </div>
        </div>`;
        messages.innerHTML += msgHtml;
        
    } else {
        const msgHtml = `<div class="pt-1 pb-1 d-flex flex-row justify-content-start">
        <div class="messageContent" name="${message._id}">
        <p class="small p-2 ms-3 mb-1 rounded-3" style="background-color: #f5f6f7;">${message.messageContent}</p>
        </div>
        </div>`;
        messages.innerHTML += msgHtml;       
    }
}

function deleteBtnHandler(ele)  {
    console.log("deleteBtnHandler"+ele.dataset.id);
    socket.emit('deleteMessage', ele.dataset.id);
} 
