/**
 * path: api/login
 */


const { Router } = require('express');
const { createUser, login, renewToken } = require('../controllers/auth');
const { check } = require('express-validator');
const { validateFields } = require('../middlewares/validate-fiels');
const { validate } = require('../models/user');
const { validateJWT } = require('../middlewares/validate-jwt');

const router = Router();

router.post('/new', [
    check('name', 'Name is mandatory').not().isEmpty(),
    check('email', 'Email is mandatory').not().isEmpty(),
    check('email', 'Email with wrong format').isEmail(),
    check('password', 'Password is mandatory').not().isEmpty(),
    validateFields
],  createUser );


router.post('/', [
    check('email', 'Email is mandatory').not().isEmpty(),
    check('email', 'Email with wrong format').isEmail(),
    check('password', 'Password is mandatory').not().isEmpty(),
    validateFields
], login)


router.get('/renew', validateJWT, renewToken )



module.exports = router;