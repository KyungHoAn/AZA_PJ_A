const mongoose = require('mongoose');

const msgSchema = new mongoose.Schema({

    senderId: {
        type: String,
        required: true,
    },
    receiverId: {
        type: String,
        required: true,
    },
    messageContent: {
        type: String,
        required: true,
    },
    messageCreateAt: {
        type: String,
        required: true,
    },
    messageReadAt: {
        type: String
    }    
})

const Msg = mongoose.model('msg', msgSchema);
module.exports = Msg;

