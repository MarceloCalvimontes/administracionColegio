const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const mysqlStore = require('express-mysql-session');
const passport = require('passport');
const bodyParser = require('body-parser');
const {database} = require('./keys');
const cookieParser = require('cookie-parser');
const passportLocal = require ('passport-local').Strategy;

const jwt = require('jsonwebtoken');


const { encode } = require('querystring');

//inicializaciones
const app = express();
require('./lib/passport');

//ajustes
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'),'layouts'),
    partialsDir: path.join(app.get('views'),'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}))
app.set('view engine','.hbs');

//middlewares
app.use(session({
    secret:'mysqlnodesession',
    resave: true,
    saveUninitialized: true,
    //store: new mysqlStore(database)
}));
app.use(flash());
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());
app.use(cookieParser('llave secreta'));



//variables globales
app.use((req, res, next)=>{
    app.locals.exito = req.flash('exito');
    app.locals.exito = req.flash('message');
    app.locals.user = req.user;
    next();
});

//rutas
app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use('/links',require('./routes/links'));


//public
app.use(express.static(path.join(__dirname, 'public')));

//empezar el servidor
app.listen(app.get('port'),()=>{
    console.log('Servidor en puerto',app.get('port'));
});
/*
app.get('/', (req, res) => {
    res.json({
        text:'ffff',
    });
});

app.post('/api/login', (req, res) => {
    const user = {id:3};
    const token = jwt.sign({user}, 'my_secret_key');
     res.json({
         token
     });
});
app.get('/api/protected', ensureToken, (req, res) => {
     jwt.verify(req.token, 'my_secret_key'),(err,data)=>{
         if(err){
            res.sendStatus(403)
         }else{
             text:'protected',
             data
         }
     }
});

function ensureToken(req, res, next){
    const bearerHeader = req.headers['autorization'];
    console.log(bearerHeader);
    if(typeof bearerHeader !== 'undefined'){
        const bearer = bearerHeader.split(" ");
        const bearerToken = bearer[1];
        req.token = bearerToken;
        next();
    }else{
        res.sendStatus(403);
    }
}*/
