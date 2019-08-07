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
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `Id` INT NOT NULL,
  `NameAddress` VARCHAR(255) NOT NULL,
  `BillNameAddress` VARCHAR(255) NOT NULL,
  `City` VARCHAR(255) NOT NULL,
  `ZipCode` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contact` (
  `Id` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  `CellPhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Login` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `Address_Id` INT NOT NULL,
  `Contact_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_User_Address1_idx` (`Address_Id` ASC) VISIBLE,
  INDEX `fk_User_Contact1_idx` (`Contact_Id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `mydb`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Contact1`
    FOREIGN KEY (`Contact_Id`)
    REFERENCES `mydb`.`Contact` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ClientOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ClientOrder` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `numOrder` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `PaiementMethod` VARCHAR(45) NOT NULL,
  `PaiementStatus` VARCHAR(45) NOT NULL,
  `User_Id` INT NOT NULL,
  `Address_Id` INT NOT NULL,
  `ShoppingCart_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_ClientOrder_User1_idx` (`User_Id` ASC) VISIBLE,
  INDEX `fk_ClientOrder_Address1_idx` (`Address_Id` ASC) VISIBLE,
  CONSTRAINT `fk_ClientOrder_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `mydb`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClientOrder_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `mydb`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `PizzaSize` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pizzeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pizzeria` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `DateOfCreation` DATETIME NOT NULL,
  `Website` VARCHAR(255) NOT NULL,
  `DeliveryBoy` INT NOT NULL,
  `Address_Id` INT NOT NULL,
  `Contact_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Pizzeria_Address1_idx` (`Address_Id` ASC) VISIBLE,
  INDEX `fk_Pizzeria_Contact1_idx` (`Contact_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizzeria_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `mydb`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizzeria_Contact1`
    FOREIGN KEY (`Contact_Id`)
    REFERENCES `mydb`.`Contact` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `Id` INT NOT NULL,
  `statusName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ingredients` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Id` INT NOT NULL,
  `Job` VARCHAR(255) NOT NULL,
  `User_Id` INT NOT NULL,
  `Status_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Employee_User1_idx` (`User_Id` ASC) VISIBLE,
  INDEX `fk_Employee_Status1_idx` (`Status_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `mydb`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Status1`
    FOREIGN KEY (`Status_Id`)
    REFERENCES `mydb`.`Status` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductChosen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductChosen` (
  `ClientOrder_Id` INT NOT NULL,
  `Products_Id` INT NOT NULL,
  `Quantite` INT NOT NULL,
  PRIMARY KEY (`ClientOrder_Id`, `Products_Id`),
  INDEX `fk_ClientOrder_has_Products_Products1_idx` (`Products_Id` ASC) VISIBLE,
  INDEX `fk_ClientOrder_has_Products_ClientOrder1_idx` (`ClientOrder_Id` ASC) VISIBLE,
  CONSTRAINT `fk_ClientOrder_has_Products_ClientOrder1`
    FOREIGN KEY (`ClientOrder_Id`)
    REFERENCES `mydb`.`ClientOrder` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClientOrder_has_Products_Products1`
    FOREIGN KEY (`Products_Id`)
    REFERENCES `mydb`.`Products` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock` (
  `Pizzeria_Id` INT NOT NULL,
  `Ingredients_Id` INT NOT NULL,
  `Quantite` INT NOT NULL,
  PRIMARY KEY (`Pizzeria_Id`, `Ingredients_Id`),
  INDEX `fk_Pizzeria_has_Ingredients_Ingredients1_idx` (`Ingredients_Id` ASC) VISIBLE,
  INDEX `fk_Pizzeria_has_Ingredients_Pizzeria1_idx` (`Pizzeria_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizzeria_has_Ingredients_Pizzeria1`
    FOREIGN KEY (`Pizzeria_Id`)
    REFERENCES `mydb`.`Pizzeria` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizzeria_has_Ingredients_Ingredients1`
    FOREIGN KEY (`Ingredients_Id`)
    REFERENCES `mydb`.`Ingredients` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Composition` (
  `Products_Id` INT NOT NULL,
  `Ingredients_Id` INT NOT NULL,
  PRIMARY KEY (`Products_Id`, `Ingredients_Id`),
  INDEX `fk_Products_has_Ingredients_Ingredients1_idx` (`Ingredients_Id` ASC) VISIBLE,
  INDEX `fk_Products_has_Ingredients_Products1_idx` (`Products_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Ingredients_Products1`
    FOREIGN KEY (`Products_Id`)
    REFERENCES `mydb`.`Products` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Ingredients_Ingredients1`
    FOREIGN KEY (`Ingredients_Id`)
    REFERENCES `mydb`.`Ingredients` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderClientStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderClientStatus` (
  `ClientOrder_Id` INT NOT NULL,
  `Status_Id` INT NOT NULL,
  PRIMARY KEY (`ClientOrder_Id`, `Status_Id`),
  INDEX `fk_ClientOrder_has_Status_Status1_idx` (`Status_Id` ASC) VISIBLE,
  INDEX `fk_ClientOrder_has_Status_ClientOrder1_idx` (`ClientOrder_Id` ASC) VISIBLE,
  CONSTRAINT `fk_ClientOrder_has_Status_ClientOrder1`
    FOREIGN KEY (`ClientOrder_Id`)
    REFERENCES `mydb`.`ClientOrder` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClientOrder_has_Status_Status1`
    FOREIGN KEY (`Status_Id`)
    REFERENCES `mydb`.`Status` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
