const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;


const pool = require('../database');
const helpers = require('./helpers');

passport.use('local.signin', new LocalStrategy({
  usernameField: 'username',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, username, password, done) => {
  const rows = await pool.query('SELECT * FROM secretaria WHERE usuario = ?', [username]);
  if (rows.length > 0) {
    const user = rows[0];
    const validPassword = await helpers.matchPassword(password, user.password)
    if (password === user.password) {
      done(null, [user], req.flash('success', 'Welcome ' + user.username));
    } else {
      done(null, false, req.flash('message', 'Incorrect Password'));
    }
  } else {
    return done(null, false, req.flash('message', 'The Username does not exists.'));
  }
}));

passport.use('local.signup', new LocalStrategy({
  usernameField: 'usuario',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, usuario, password, done) => {


  const newUser = {
    usuario,
    password
  };
  newUser.password = await helpers.encryptPassword(password);

  const result = await pool.query('INSERT INTO secretaria SET ?', [newUser]);
  console.log(result);
  newUser.id = result.insertId;
  return done(null, newUser);
}));

passport.serializeUser(function(user, done) {
  done(null, user);
});

passport.deserializeUser(function(user, done) {
  done(null, user);
});


/*passport.serializeUser((user, done) => {
  done.apply(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  const rows = await pool.query('SELECT * FROM secretaria WHERE usuario = ?', [id]);
  done(null, rows[0]);
});*/