-- MySQL Script generated by MySQL Workbench
-- Sun Jan 24 19:39:29 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(256) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `token` VARCHAR(100) NULL,
  PRIMARY KEY (`idUsers`),
  UNIQUE INDEX `idUsers_UNIQUE` (`idUsers` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cars` (
  `idCars` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `speed` INT NOT NULL,
  `brand` VARCHAR(70) NOT NULL,
  `number_plate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCars`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Localisations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Localisations` (
  `idLocalisations` INT NOT NULL,
  `latitude` INT NOT NULL,
  `longitude` INT NOT NULL,
  `osmNodeId` VARCHAR(45) NOT NULL,
  `DirectionPaths_idDirectionPaths` INT NOT NULL,
  PRIMARY KEY (`idLocalisations`, `DirectionPaths_idDirectionPaths`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CarRides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CarRides` (
  `idCarRides` INT NOT NULL AUTO_INCREMENT,
  `Distance` DOUBLE NOT NULL,
  `startLocalisation` VARCHAR(45) NOT NULL,
  `startTime` TIME NOT NULL,
  `endTime` TIME NOT NULL,
  `usingUser` VARCHAR(45) NULL,
  `providingUser` VARCHAR(45) NOT NULL,
  `directionPath` VARCHAR(45) NULL,
  `remoteID` VARCHAR(45) NOT NULL,
  `cars` INT NOT NULL,
  `CarRides_Distance` DOUBLE NOT NULL,
  `startLocalisation` INT NOT NULL,
  `Localisations_DirectionPaths_idDirectionPaths` INT NOT NULL,
  `endLocalisation` INT NOT NULL,
  `Localisations_DirectionPaths_idDirectionPaths1` INT NOT NULL,
  PRIMARY KEY (`idCarRides`),
  INDEX `fk_CarRides_Cars1_idx` (`cars` ASC) VISIBLE,
  INDEX `fk_CarRides_Localisations1_idx` (`startLocalisation` ASC, `Localisations_DirectionPaths_idDirectionPaths` ASC) VISIBLE,
  INDEX `fk_CarRides_Localisations2_idx` (`endLocalisation` ASC, `Localisations_DirectionPaths_idDirectionPaths1` ASC) VISIBLE,
  CONSTRAINT `fk_CarRides_Cars1`
    FOREIGN KEY (`cars`)
    REFERENCES `mydb`.`Cars` (`idCars`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CarRides_Localisations1`
    FOREIGN KEY (`startLocalisation` , `Localisations_DirectionPaths_idDirectionPaths`)
    REFERENCES `mydb`.`Localisations` (`idLocalisations` , `DirectionPaths_idDirectionPaths`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CarRides_Localisations2`
    FOREIGN KEY (`endLocalisation` , `Localisations_DirectionPaths_idDirectionPaths1`)
    REFERENCES `mydb`.`Localisations` (`idLocalisations` , `DirectionPaths_idDirectionPaths`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users_CarRides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_CarRides` (
  `Users_idUsers` INT NOT NULL,
  `Rides_idRides` INT NOT NULL,
  PRIMARY KEY (`Users_idUsers`, `Rides_idRides`),
  INDEX `fk_Users_has_Rides_Rides1_idx` (`Rides_idRides` ASC) VISIBLE,
  INDEX `fk_Users_has_Rides_Users_idx` (`Users_idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Rides_Users`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Rides_Rides1`
    FOREIGN KEY (`Rides_idRides`)
    REFERENCES `mydb`.`CarRides` (`idCarRides`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Journeys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Journeys` (
  `idJourneys` INT NOT NULL,
  `usingUsers_id` INT NOT NULL,
  PRIMARY KEY (`idJourneys`),
  INDEX `fk_Journeys_Users1_idx` (`usingUsers_id` ASC) VISIBLE,
  CONSTRAINT `fk_Journeys_Users1`
    FOREIGN KEY (`usingUsers_id`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pricing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pricing` (
  `idPricing` INT NOT NULL,
  `amount` INT NOT NULL,
  `currency` VARCHAR(45) NOT NULL,
  `income` INT NOT NULL,
  `pay_providing_user` INT NOT NULL,
  `price_providing_user` INT NOT NULL,
  PRIMARY KEY (`idPricing`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Covoits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Covoits` (
  `idCovoits` INT NOT NULL,
  `carRide` VARCHAR(70) NOT NULL,
  `usingUsers_id` INT NOT NULL,
  `Journeys_idJourneys` INT NOT NULL,
  `providingusers_id` INT NOT NULL,
  `Money_idMoney` INT NOT NULL,
  PRIMARY KEY (`idCovoits`, `Journeys_idJourneys`, `Money_idMoney`),
  INDEX `fk_Covoits_Users1_idx` (`usingUsers_id` ASC) VISIBLE,
  INDEX `fk_Covoits_Journeys1_idx` (`Journeys_idJourneys` ASC) VISIBLE,
  INDEX `fk_Covoits_Users2_idx` (`providingusers_id` ASC) VISIBLE,
  INDEX `fk_Covoits_Money1_idx` (`Money_idMoney` ASC) VISIBLE,
  CONSTRAINT `fk_Covoits_Users1`
    FOREIGN KEY (`usingUsers_id`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Covoits_Journeys1`
    FOREIGN KEY (`Journeys_idJourneys`)
    REFERENCES `mydb`.`Journeys` (`idJourneys`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Covoits_Users2`
    FOREIGN KEY (`providingusers_id`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Covoits_Money1`
    FOREIGN KEY (`Money_idMoney`)
    REFERENCES `mydb`.`Pricing` (`idPricing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DirectionPaths`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DirectionPaths` (
  `startLocalisation` VARCHAR(256) NOT NULL,
  `idDirectionPaths` INT NOT NULL,
  `path` VARCHAR(70) NOT NULL,
  `CarRides_idRides` INT NOT NULL,
  `CarRides_Distance` DOUBLE NOT NULL,
  `CarRides_CarRides_idRides` INT NOT NULL,
  `CarRides_CarRides_Distance` DOUBLE NOT NULL,
  PRIMARY KEY (`idDirectionPaths`),
  INDEX `fk_DirectionPaths_CarRides1_idx` (`CarRides_idRides` ASC, `CarRides_Distance` ASC, `CarRides_CarRides_idRides` ASC, `CarRides_CarRides_Distance` ASC) VISIBLE,
  CONSTRAINT `fk_DirectionPaths_CarRides1`
    FOREIGN KEY (`CarRides_idRides` , `CarRides_Distance` , `CarRides_CarRides_Distance`)
    REFERENCES `mydb`.`CarRides` (`idCarRides` , `Distance` , `CarRides_Distance`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Journeys_CarRides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Journeys_CarRides` (
  `Journeys_idJourneys` INT NOT NULL,
  `CarRides_idRides` INT NOT NULL,
  `id_Journeys_CarRides` INT NOT NULL,
  PRIMARY KEY (`Journeys_idJourneys`, `CarRides_idRides`, `id_Journeys_CarRides`),
  INDEX `fk_Journeys_has_CarRides_CarRides1_idx` (`CarRides_idRides` ASC, `id_Journeys_CarRides` ASC) VISIBLE,
  INDEX `fk_Journeys_has_CarRides_Journeys1_idx` (`Journeys_idJourneys` ASC) VISIBLE,
  CONSTRAINT `fk_Journeys_has_CarRides_Journeys1`
    FOREIGN KEY (`Journeys_idJourneys`)
    REFERENCES `mydb`.`Journeys` (`idJourneys`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Journeys_has_CarRides_CarRides1`
    FOREIGN KEY (`CarRides_idRides`)
    REFERENCES `mydb`.`CarRides` (`idCarRides`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
