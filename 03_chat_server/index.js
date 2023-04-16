
const express = require('express');
const path = require('path'); // Coming from node
require('dotenv').config();

// DB Config
const { dbConnection } = require('./database/config');
dbConnection()

// Express app
const app = express(); // Init express and ready to listen

// Body read and parse
app.use( express.json() );

// Node server
const server = require('http').createServer(app); // Create server
module.exports.io = require('socket.io')(server);
require('./sockets/socket');


// Public path
const publicPah = path.resolve( __dirname, 'public' )
app.use( express.static(publicPah));

// Routes
app.use( '/api/login', require('./routes/auth') )
app.use( '/api/users', require('./routes/users') )
app.use( '/api/messages', require('./routes/messages') )

// We can listen whatever request to port 3000
server.listen( process.env.PORT, ( err ) => {
    if ( err ) throw new Error(err);
    console.log('Server running in port', process.env.PORT);
})