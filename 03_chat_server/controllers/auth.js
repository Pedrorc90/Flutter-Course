const { response } = require('express');
const bcrypt = require('bcryptjs')
const User = require('../models/user');
const { generateJWT } = require('../helpers/jwt');

const createUser = async( req, res = response ) => {

    const { email, password } = req.body;

    try {

        const emailExists = await User.findOne({ email })

        if ( emailExists ) {
            return res.status(400).json({
                ok: false,
                msg: 'Email is already registered'
            });
        } 

        const user = new User( req.body );

        // Encrypt password
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync( password, salt )

        await user.save();

        // Generate JWT
        const token = await generateJWT( user.id );

        res.json({ 
            ok: true, 
            user,
            token
        })

    } catch ( error ) {
        console.log( error )
        res.status(500).json({
            ok: false,
            msg: 'Contact with administrator'
        })
    }

}

const login = async( req, res = response ) => {

    const { email, password } = req.body;

    try {
        
        const userDB = await User.findOne({ email });
        if ( !userDB ) return res.status(404).json({ ok: false, msg: 'Email not found' })

        // Password validation
        const validPwd = bcrypt.compareSync( password, userDB.password )
        if ( !validPwd ) return res.status(400).json({ ok: false, msg: 'Pwd not valid' })

        // Generate JWT
        const token = await generateJWT( userDB.id )
        
        res.json({ 
            ok: true, 
            user: userDB,
            token
        })


    } catch (error) {
        res.status(500).json({
            ok: false,
            msg: 'Contact with administrator'
        })
    }
    
}

const renewToken = async( req, res = response ) => {

    try {
        const { uid } = req;
        const token = await generateJWT( uid )

        const userDB = await User.findById( uid );

        res.json({ 
            ok: true, 
            userDB,
            token
        })
    } catch (error) {
        res.status(500).json({ 
            ok: false, 
            msg: 'Contact with admin'
        })
    }

    
}

module.exports = { createUser, login, renewToken }
