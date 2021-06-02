-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema administracion_colegio1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema administracion_colegio1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `administracion_colegio1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `administracion_colegio1` ;

-- -----------------------------------------------------
-- Table `administracion_colegio1`.`colegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`colegio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(45) NOT NULL,
  `ApellidoP` VARCHAR(45) NOT NULL,
  `ApellidoM` VARCHAR(45) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `CI` VARCHAR(45) NOT NULL,
  `Lugar_de_Nacimiento` VARCHAR(45) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPersona`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`apoderado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`apoderado` (
  `idapoderado` INT NOT NULL AUTO_INCREMENT,
  `idpersona` INT NOT NULL,
  PRIMARY KEY (`idapoderado`),
  INDEX `fk_personaApoderado_idx` (`idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_personaApoderado`
    FOREIGN KEY (`idpersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`madre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`madre` (
  `idmadre` INT NOT NULL AUTO_INCREMENT,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idmadre`),
  INDEX `fk_madreP_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_madreP`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`padre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`padre` (
  `idpadre` INT NOT NULL AUTO_INCREMENT,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idpadre`),
  INDEX `fk_PadreP_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_PadreP`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`estudiante` (
  `idestudiante` INT NOT NULL AUTO_INCREMENT,
  `idPersona` INT NOT NULL,
  `idPadre` INT NULL DEFAULT NULL,
  `idMadre` INT NULL DEFAULT NULL,
  `idApoderado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idestudiante`),
  INDEX `fk_estudianteP_idx` (`idPersona` ASC) VISIBLE,
  INDEX `fk_estudiantePadre_idx` (`idPadre` ASC) VISIBLE,
  INDEX `fk_estudianteMadre_idx` (`idMadre` ASC) VISIBLE,
  INDEX `fk_estudianteApoderado_idx` (`idApoderado` ASC) VISIBLE,
  CONSTRAINT `fk_estudianteApoderado`
    FOREIGN KEY (`idApoderado`)
    REFERENCES `administracion_colegio1`.`apoderado` (`idapoderado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_estudianteMadre`
    FOREIGN KEY (`idMadre`)
    REFERENCES `administracion_colegio1`.`madre` (`idmadre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_estudiantePadre`
    FOREIGN KEY (`idPadre`)
    REFERENCES `administracion_colegio1`.`padre` (`idpadre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_estudiantePersona`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`secretaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`secretaria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idColegio` INT NOT NULL,
  `idPersona` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_SecC_idx` (`idColegio` ASC) VISIBLE,
  INDEX `fk_PerS_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_PerS`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SecC`
    FOREIGN KEY (`idColegio`)
    REFERENCES `administracion_colegio1`.`colegio` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`inscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`inscripcion` (
  `idinscripcion` INT NOT NULL AUTO_INCREMENT,
  `NumeroBoleta` INT NOT NULL,
  `fecha_inscripcion` DATE NOT NULL,
  `CostoTotal` FLOAT NOT NULL,
  `idSecretaria` INT NOT NULL,
  `idColegio` INT NOT NULL,
  `idEstudiante` INT NOT NULL,
  PRIMARY KEY (`idinscripcion`),
  INDEX `fk_inscripcionSecretaria_idx` (`idSecretaria` ASC) VISIBLE,
  INDEX `fk_inscipcionColegio_idx` (`idColegio` ASC) VISIBLE,
  INDEX `fk_inscripcionEstudiante_idx` (`idEstudiante` ASC) VISIBLE,
  CONSTRAINT `fk_inscipcionColegio`
    FOREIGN KEY (`idColegio`)
    REFERENCES `administracion_colegio1`.`colegio` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inscripcionEstudiante`
    FOREIGN KEY (`idEstudiante`)
    REFERENCES `administracion_colegio1`.`estudiante` (`idestudiante`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inscripcionSecretaria`
    FOREIGN KEY (`idSecretaria`)
    REFERENCES `administracion_colegio1`.`secretaria` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `nivel` VARCHAR(45) NULL DEFAULT NULL,
  `curso` INT NOT NULL,
  `idinscripcion` INT NOT NULL,
  PRIMARY KEY (`idalumno`),
  INDEX `fk_alumnoInsripcion_idx` (`idinscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_alumnoInsripcion`
    FOREIGN KEY (`idinscripcion`)
    REFERENCES `administracion_colegio1`.`inscripcion` (`idinscripcion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`materia` (
  `idmateria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`comunicadospadres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`comunicadospadres` (
  `idcomunicadosPadres` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` TEXT NOT NULL,
  `idSecretaria` INT NOT NULL,
  `idAlumno` INT NOT NULL,
  `idMateria` INT NOT NULL,
  `Trimestre` INT NOT NULL,
  `Gestion` YEAR NOT NULL,
  PRIMARY KEY (`idcomunicadosPadres`),
  INDEX `fk_alumnoComunicados_idx` (`idAlumno` ASC) VISIBLE,
  INDEX `fk_secretariaComunicados_idx` (`idSecretaria` ASC) VISIBLE,
  INDEX `fk_materiacomunicados_idx` (`idMateria` ASC) VISIBLE,
  CONSTRAINT `fk_alumnoComunicados`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `administracion_colegio1`.`alumno` (`idalumno`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_materiacomunicados`
    FOREIGN KEY (`idMateria`)
    REFERENCES `administracion_colegio1`.`materia` (`idmateria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_secretariaComunicados`
    FOREIGN KEY (`idSecretaria`)
    REFERENCES `administracion_colegio1`.`secretaria` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`director` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idColegio` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ColD_idx` (`idColegio` ASC) VISIBLE,
  INDEX `fk_PerD_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_ColD`
    FOREIGN KEY (`idColegio`)
    REFERENCES `administracion_colegio1`.`colegio` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PerD`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`libreta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`libreta` (
  `idlibreta` INT NOT NULL AUTO_INCREMENT,
  `idAlumno` INT NOT NULL,
  `idMateria` INT NOT NULL,
  `trimestre` INT NOT NULL,
  `gestion` YEAR NOT NULL,
  `califHacer` INT NULL DEFAULT '0',
  `califSaber` INT NULL DEFAULT '0',
  `califSemifinal` FLOAT GENERATED ALWAYS AS ((`califHacer` + `califSaber`)) STORED,
  `califSerDecidir` INT NULL DEFAULT '0',
  `califFinal` INT GENERATED ALWAYS AS ((`califSemifinal` + `califSerDecidir`)) STORED,
  `idcomunicadosPadres` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idlibreta`),
  INDEX `fk_alumnoLibreta_idx` (`idAlumno` ASC) VISIBLE,
  INDEX `fk_materiaLibreta_idx` (`idMateria` ASC) VISIBLE,
  INDEX `fk_comunicadosLibreta_idx` (`idcomunicadosPadres` ASC) VISIBLE,
  CONSTRAINT `fk_alumnoLibreta`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `administracion_colegio1`.`alumno` (`idalumno`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comunicadosLibreta`
    FOREIGN KEY (`idcomunicadosPadres`)
    REFERENCES `administracion_colegio1`.`comunicadospadres` (`idcomunicadosPadres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_materiaLibreta`
    FOREIGN KEY (`idMateria`)
    REFERENCES `administracion_colegio1`.`materia` (`idmateria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`pago_pensiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`pago_pensiones` (
  `idpago_pensiones` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `mes` VARCHAR(45) NOT NULL,
  `total` FLOAT NOT NULL,
  `idalumno` INT NOT NULL,
  `idsecretaria` INT NOT NULL,
  PRIMARY KEY (`idpago_pensiones`),
  INDEX `idalumno_idx` (`idalumno` ASC) VISIBLE,
  INDEX `idsecretaria_idx` (`idsecretaria` ASC) VISIBLE,
  CONSTRAINT `idalumno`
    FOREIGN KEY (`idalumno`)
    REFERENCES `administracion_colegio1`.`alumno` (`idalumno`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idsecretaria`
    FOREIGN KEY (`idsecretaria`)
    REFERENCES `administracion_colegio1`.`secretaria` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `administracion_colegio1`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `administracion_colegio1`.`profesor` (
  `idprofesor` INT NOT NULL AUTO_INCREMENT,
  `especialidad` VARCHAR(45) NOT NULL,
  `idPersona` INT NOT NULL,
  `idMateria` INT NOT NULL,
  `idColegio` INT NOT NULL,
  PRIMARY KEY (`idprofesor`),
  INDEX `fk_personaProfesor_idx` (`idPersona` ASC) VISIBLE,
  INDEX `fk_materiaProfesor_idx` (`idMateria` ASC) VISIBLE,
  INDEX `fk_colegioProfesor_idx` (`idColegio` ASC) VISIBLE,
  CONSTRAINT `fk_colegioProfesor`
    FOREIGN KEY (`idColegio`)
    REFERENCES `administracion_colegio1`.`colegio` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_materiaProfesor`
    FOREIGN KEY (`idMateria`)
    REFERENCES `administracion_colegio1`.`materia` (`idmateria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_personaProfesor`
    FOREIGN KEY (`idPersona`)
    REFERENCES `administracion_colegio1`.`persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `administracion_colegio1`;

DELIMITER $$
USE `administracion_colegio1`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `administracion_colegio1`.`comunicadospadres_AFTER_INSERT`
AFTER INSERT ON `administracion_colegio1`.`comunicadospadres`
FOR EACH ROW
BEGIN
	update libreta set idcomunicadosPadres = new.idcomunicadosPadres where idAlumno = new.idAlumno and idMateria = new.idMateria and gestion = new.Gestion 
    and trimestre = new.Trimestre;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
