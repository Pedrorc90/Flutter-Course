const { userConnected, userDisconnected, saveMessage } = require('../controllers/socket');
const { checkJWT } = require('../helpers/jwt');
const { io } = require('../index');


// Socket messages
io.on('connection', client => {

    console.log('Cient connected')

    const [ isValid, uid ] = checkJWT( client.handshake.headers['x-token'] ); 
 
    if ( !isValid ) return client.disconnect();

    console.log('Client authenticated');
    userConnected( uid )

    // Introduce the user in a particular room
    // Global room ( All devices connected - message to everyone )

    client.join( uid );

    client.on('message-personal', async ( payload ) => {
      
      await saveMessage( payload );

      io.to( payload.to ).emit('message-personal', payload );
    })




    client.on('disconnect', () => {
      console.log("Client disconnected") 
      userDisconnected( uid );
    }
    );

    // client.on('message', ( payload ) => {
    //     console.log("message!!", payload);
    //     io.emit('message', { admin: 'New message' }); // Emit to all clients connected
    // });

  });