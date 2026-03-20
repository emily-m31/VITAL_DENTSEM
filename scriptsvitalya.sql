-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VITALEM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VITALEM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VITALEM` DEFAULT CHARACTER SET utf8 ;
USE `VITALEM` ;

-- -----------------------------------------------------
-- Table `VITALEM`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Rol` (
  `id_Rol` INT NOT NULL AUTO_INCREMENT,
  `descripcion_rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Tipo_documento` (
  `id_Tipodocumento` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipodoc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Tipodocumento`),
  UNIQUE INDEX `descripcion_tipodoc_UNIQUE` (`descripcion_tipodoc` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Usuario` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `nombreus` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `documento` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `Rol_id_Rol` INT NOT NULL,
  `Tipo_documento_id_Tipodocumento` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `contrasena_UNIQUE` (`contrasena` ASC),
  INDEX `fk_Usuario_Rol1_idx` (`Rol_id_Rol` ASC),
  UNIQUE INDEX `correousuario_UNIQUE` (`correo` ASC),
  INDEX `fk_Usuario_Tipo_documento1_idx` (`Tipo_documento_id_Tipodocumento` ASC),
  CONSTRAINT `fk_Usuario_Rol1`
    FOREIGN KEY (`Rol_id_Rol`)
    REFERENCES `VITALEM`.`Rol` (`id_Rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Tipo_documento1`
    FOREIGN KEY (`Tipo_documento_id_Tipodocumento`)
    REFERENCES `VITALEM`.`Tipo_documento` (`id_Tipodocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Estado_cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Estado_cita` (
  `idEstado_cita` INT NOT NULL AUTO_INCREMENT,
  `descripcion_estadoci` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstado_cita`),
  UNIQUE INDEX `descripcion_estadoci_UNIQUE` (`descripcion_estadoci` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Tipo_tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Tipo_tratamiento` (
  `id_Tipotratam` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipotratam` VARCHAR(45) NOT NULL,
  `costo` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_Tipotratam`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Cita` (
  `id_Cita` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `descripcion_cita` VARCHAR(45) NOT NULL,
  `Paciente_id_Paciente` INT NOT NULL,
  `Usuario_id_Usuario` INT NOT NULL,
  `Estado_cita_idEstado_cita` INT NOT NULL,
  `Tratamiento_id_Tratamiento` INT NOT NULL,
  PRIMARY KEY (`id_Cita`),
  INDEX `fk_Cita_Usuario1_idx` (`Usuario_id_Usuario` ASC),
  INDEX `fk_Cita_Estado_cita1_idx` (`Estado_cita_idEstado_cita` ASC),
  INDEX `fk_Cita_Tratamiento1_idx` (`Tratamiento_id_Tratamiento` ASC),
  UNIQUE INDEX `fecha_hora_UNIQUE` (`fecha_hora` ASC),
  CONSTRAINT `fk_Cita_Usuario1`
    FOREIGN KEY (`Usuario_id_Usuario`)
    REFERENCES `VITALEM`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cita_Estado_cita1`
    FOREIGN KEY (`Estado_cita_idEstado_cita`)
    REFERENCES `VITALEM`.`Estado_cita` (`idEstado_cita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cita_Tratamiento1`
    FOREIGN KEY (`Tratamiento_id_Tratamiento`)
    REFERENCES `VITALEM`.`Tipo_tratamiento` (`id_Tipotratam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Medio_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Medio_pago` (
  `id_Mediopago` INT NOT NULL AUTO_INCREMENT,
  `descripcion_mediopa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Mediopago`),
  UNIQUE INDEX `descripcion_mediopa_UNIQUE` (`descripcion_mediopa` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Estado_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Estado_pago` (
  `id_Estadopago` INT NOT NULL AUTO_INCREMENT,
  `descripcion_estadop` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Estadopago`),
  UNIQUE INDEX `descripcion_estadop_UNIQUE` (`descripcion_estadop` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Pago` (
  `id_Pago` INT NOT NULL AUTO_INCREMENT,
  ` monto` DECIMAL(10,2) NOT NULL,
  `Medio_pago_idMedio_pago` INT NOT NULL,
  `Estado_pago_idEstado_pago` INT NOT NULL,
  `Cita_id_Cita` INT NOT NULL,
  PRIMARY KEY (`id_Pago`),
  INDEX `fk_Pago_Medio_pago1_idx` (`Medio_pago_idMedio_pago` ASC),
  INDEX `fk_Pago_Estado_pago1_idx` (`Estado_pago_idEstado_pago` ASC),
  INDEX `fk_Pago_Cita1_idx` (`Cita_id_Cita` ASC),
  CONSTRAINT `fk_Pago_Medio_pago1`
    FOREIGN KEY (`Medio_pago_idMedio_pago`)
    REFERENCES `VITALEM`.`Medio_pago` (`id_Mediopago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pago_Estado_pago1`
    FOREIGN KEY (`Estado_pago_idEstado_pago`)
    REFERENCES `VITALEM`.`Estado_pago` (`id_Estadopago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pago_Cita1`
    FOREIGN KEY (`Cita_id_Cita`)
    REFERENCES `VITALEM`.`Cita` (`id_Cita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Abono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Abono` (
  `id_Abono` INT NOT NULL AUTO_INCREMENT,
  `monto_abono` DECIMAL(10,2) NOT NULL,
  `fecha_abono` DATE NOT NULL,
  `Pago_id_Pago` INT NOT NULL,
  PRIMARY KEY (`id_Abono`),
  INDEX `fk_Abono_Pago1_idx` (`Pago_id_Pago` ASC),
  CONSTRAINT `fk_Abono_Pago1`
    FOREIGN KEY (`Pago_id_Pago`)
    REFERENCES `VITALEM`.`Pago` (`id_Pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VITALEM`.`Historial_tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VITALEM`.`Historial_tratamiento` (
  `id_Historial` INT NOT NULL AUTO_INCREMENT,
  `anio` INT NOT NULL,
  `costo` DECIMAL(10,2) NOT NULL,
  `Tipo_tratamiento_id_Tipotratam` INT NOT NULL,
  PRIMARY KEY (`id_Historial`),
  UNIQUE INDEX `anio_UNIQUE` (`anio` ASC),
  INDEX `fk_Historial_tratamiento_Tipo_tratamiento1_idx` (`Tipo_tratamiento_id_Tipotratam` ASC),
  CONSTRAINT `fk_Historial_tratamiento_Tipo_tratamiento1`
    FOREIGN KEY (`Tipo_tratamiento_id_Tipotratam`)
    REFERENCES `VITALEM`.`Tipo_tratamiento` (`id_Tipotratam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;