-- MySQL Script generated by MySQL Workbench
-- Sat Apr 25 01:26:32 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema WDS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema WDS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WDS` DEFAULT CHARACTER SET utf8 ;
USE `WDS` ;

-- -----------------------------------------------------
-- Table `WDS`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDS`.`user` (
  `user_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `user_username` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`user_id`));


-- -----------------------------------------------------
-- Table `WDS`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDS`.`customer` (
  `cid` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `cfirstname` VARCHAR(30) NOT NULL,
  `clastname` VARCHAR(30) NOT NULL,
  `cgender` CHAR(1) NULL,
  `cmaritality` CHAR(1) NOT NULL,
  `cinstype` CHAR(1) NOT NULL,
  `chouse` INT(4) NOT NULL,
  `cstreet` VARCHAR(30) NOT NULL,
  `ccity` VARCHAR(30) NOT NULL,
  `cstate` VARCHAR(2) NOT NULL,
  `czipcode` INT(5) NOT NULL,
  `user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`cid`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_customer`
    FOREIGN KEY (`user_id`)
    REFERENCES `WDS`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WDS`.`insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDS`.`insurance` (
  `insid` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `insstartdate` DATETIME NOT NULL,
  `insenddate` DATETIME NOT NULL,
  `inspremium` DECIMAL(10,2) NOT NULL,
  `insstatus` CHAR(1) NOT NULL,
  `instype` VARCHAR(9) NOT NULL,
  `cid` BIGINT(20) NOT NULL,
  PRIMARY KEY (`insid`),
  INDEX `cid_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `fk_customer_ins`
    FOREIGN KEY (`cid`)
    REFERENCES `WDS`.`customer` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WDS`.`home_ins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDS`.`home_ins` (
  `insid` BIGINT(20) NOT NULL,
  `home_ins_type` CHAR(1) NOT NULL,
  `homeid` INT(10) NOT NULL,
  `hpurchasedate` DATETIME NOT NULL,
  `hvalue` DECIMAL(10,2) NOT NULL,
  `harea` DECIMAL(8,2) NOT NULL,
  `htype` CHAR(1) NOT NULL,
  `hfire` INT(1) NOT NULL,
  `hsecurity` INT(1) NOT NULL,
  `hpool` CHAR(1) NOT NULL,
  `hbasement` INT(1) NOT NULL,
  PRIMARY KEY (`insid`),
  CONSTRAINT `fk_ins_home`
    FOREIGN KEY (`insid`)
    REFERENCES `WDS`.`insurance` (`insid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WDS`.`auto_ins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WDS`.`auto_ins` (
  `insid` BIGINT(20) NOT NULL,
  `auto_ins_type` CHAR(1) NOT NULL,
  `vin` VARCHAR(20) NOT NULL,
  `vmake` VARCHAR(30) NOT NULL,
  `vmodel` VARCHAR(30) NULL,
  `vyear` INT(4) NOT NULL,
  `vstatus` CHAR(1) NOT NULL,
  `licenseno` VARCHAR(10) NOT NULL,
  `driverfirstname` VARCHAR(30) NOT NULL,
  `driverlastname` VARCHAR(30) NOT NULL,
  `driverbirthdate` DATETIME NOT NULL,
  PRIMARY KEY (`insid`),
  CONSTRAINT `fk_ins_auto`
    FOREIGN KEY (`insid`)
    REFERENCES `WDS`.`insurance` (`insid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
