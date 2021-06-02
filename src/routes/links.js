const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/add', (req, res)=>{
    pool.query("SELECT * FROM personas",function(err,datos){
        console.log(datos);
        });
    res.render('links/add');
});

router.post('/add',async (req, res)=>{
    const {Nombres, ApellidoP, ApellidoM, Sexo, CI, Lugar_de_Nacimiento, FechaNacimiento, Direccion, Telefono, email} = req.body;
    const newLink = {
        Nombres,
        ApellidoP,
        ApellidoM, 
        Sexo,
        CI,
        Lugar_de_Nacimiento,
        FechaNacimiento,
        Direccion,
        Telefono,
        email
    };
    await pool.query('INSERT INTO persona set?',[newLink]);
    req.flash('exito','Persona agregada correctamente');
     res.redirect('/links');
});

router.get('/', async (req, res) => {
    const links= await pool.query('SELECT * FROM persona');
    //const links= await pool.query('select a.idalumno, pe.Nombres, pe.ApellidoP, pe.ApellidoM, c.Mensaje, m.nombre as Materia, l.califHacer as Hacer, l.califSaber as Saber from materia m inner join libreta l on m.idMateria = l.idMateria inner join comunicadospadres c on l.idcomunicadosPadres = c.idcomunicadosPadres inner join alumno a on c.idalumno = a.idalumno inner join inscripcion i on a.idinscripcion = i.idinscripcion inner join estudiante e on i.idestudiante = e.idestudiante inner join persona pe on e.idPersona = pe.idPersona where a.idalumno = 19;');
    //const links= await pool.query('select a.idalumno, i.NumeroBoleta,i.fecha_inscripcion, i.CostoTotal, pe.Nombres, pe.ApellidoP, pe.ApellidoM,pe.Sexo,pe.CI,pe.Lugar_de_Nacimiento, pe.FechaNacimiento , pe.Direccion, pe.Telefono, pe.email, a.curso, a.nivel from alumno a inner join inscripcion i on a.idinscripcion = i.idinscripcion inner join estudiante e on i.idestudiante = e.idestudiante inner join persona pe on e.idPersona = pe.idPersona order by a.curso;');
    //const links= await pool.query('select pe.Nombres, pe.ApellidoP, pe.ApellidoM,pe.Sexo,pe.CI,pe.Lugar_de_Nacimiento, pe.Direccion, pe.Telefono, pe.email from alumno a inner join inscripcion i on a.idinscripcion = i.idinscripcion inner join estudiante e on i.idestudiante = e.idestudiante inner join padre p on e.idPadre = p.idPadre inner join persona pe on p.idPersona = pe.idPersona;');
    res.render('links/list', {links});
});

router.get('/delete/:idPersona',async (req, res) => {
    const {idPersona} = req.params;
    await pool.query('DELETE FROM persona WHERE idPersona = ?',[idPersona]);
    req.flash('exito','Persona eliminada correctamente');
    res.redirect('/links');
});

router.get('/edit/:idPersona',async (req, res) => {
    const {idPersona} = req.params;
    const links = await pool.query('SELECT * FROM persona WHERE idPersona = ?',[idPersona]);
    console.log(links[0]);
    res.render('links/edit', {persona: links[0]});
    //console.log(idPersona);
    //res.send('recibido');

});

router.post('/edit/:idPersona', async (req, res) => {
    const{idPersona} = req.params;
    const {Nombres, ApellidoP, ApellidoM, Sexo, CI, Lugar_de_Nacimiento, FechaNacimiento, Direccion, Telefono, email} = req.body;
    const newLink={
        Nombres,
        ApellidoP,
        ApellidoM, 
        Sexo,
        CI,
        Lugar_de_Nacimiento,
        FechaNacimiento,
        Direccion,
        Telefono,
        email
    };
    console.log(newLink);
    req.flash('exito','Actualizado correctamente');
    await pool.query('UPDATE persona set ? WHERE idPersona = ?',[newLink,idPersona]);
    res.redirect('/links');
});


module.exports = router;