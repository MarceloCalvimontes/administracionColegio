const express = require('express');
const router = express.Router();
const passport = require('passport');
//renderiza
router.get('/signup', (req, res) => {
    res.render('auth/signup');
});

//recibe los datos
/*router.post('/signup', (req, res) => {
    passport.authenticate('local/signup',{
        successRedirect:'/profile',
        failureRedirect: '/signup',
        failureFlash: true
    });
    
    res.send('recibido');
});*/

router.post('/signup',passport.authenticate('local/signup',{
    successRedirect:'/profile',
    failureRedirect: '/signup',
    failureFlash: true
}));

router.get('/signin', (req, res) => {
    res.render('auth/signin');
  });

router.post('/signin', (req, res, next) => {
  
  passport.authenticate('local.signin', {
    successRedirect: '/profile',
    failureRedirect: '/signin',
    failureFlash: true
  })(req, res, next);
});

router.get('/profile', (req, res) => {
    res.render('profile');
});

router.get('/login', (req, res) => {
  res.render('auth/login');
});
module.exports = router;