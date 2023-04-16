const { response } = require('express');
const Message = require('../models/message');



const getChat = async( req, res = response ) => {

    const myId = req.uid;
    const messagesTo = req.params.to;

    const last30 = await Message.find({
        $or: [ { from: myId, to: messagesTo }, { from: messagesTo, to: myId } ]
    })
    .sort({ createdAt: 'desc' })
    .limit(30);

    res.json({
        ok: true,
        messages: last30
    })

}


module.exports = { getChat }