-- MySQL Script generated by MySQL Workbench
-- Thu Apr  8 20:24:33 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema enterprise
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema enterprise
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enterprise` DEFAULT CHARACTER SET utf8 ;
USE `enterprise` ;

-- -----------------------------------------------------
-- Table `enterprise`.`vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`vendor` (
  `vendor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE INDEX `vendor_id_UNIQUE` (`vendor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `brand` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `vendor_id` INT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  INDEX `vendor_id_idx` (`vendor_id` ASC) VISIBLE,
  CONSTRAINT `vendor_id`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `enterprise`.`vendor` (`vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`configurables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`configurables` (
  `configuration_id` INT NOT NULL AUTO_INCREMENT,
  `configuration_type` VARCHAR(45) NULL,
  `product_id` INT NULL,
  PRIMARY KEY (`configuration_id`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  UNIQUE INDEX `configuration_id_UNIQUE` (`configuration_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `enterprise`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`model` (
  `model_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`model_id`, `product_id`),
  UNIQUE INDEX `model_id_UNIQUE` (`model_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `productid`
    FOREIGN KEY (`product_id`)
    REFERENCES `enterprise`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`model_configurations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`model_configurations` (
  `configuration_id` INT NOT NULL AUTO_INCREMENT,
  `model_id` INT NOT NULL,
  `configuration_specific` VARCHAR(45) NULL,
  PRIMARY KEY (`configuration_id`, `model_id`),
  INDEX `model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `configuration_id`
    FOREIGN KEY (`configuration_id`)
    REFERENCES `enterprise`.`configurables` (`configuration_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `enterprise`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`apple_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`apple_account` (
  `apple_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `balance` FLOAT NULL,
  PRIMARY KEY (`apple_id`),
  UNIQUE INDEX `apple_id_UNIQUE` (`apple_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`checkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`checkout` (
  `checkout_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL,
  `payment_method` VARCHAR(45) NULL,
  `store_id` INT NULL,
  `apple_id` INT NULL,
  PRIMARY KEY (`checkout_id`),
  UNIQUE INDEX `checkout_id_UNIQUE` (`checkout_id` ASC) VISIBLE,
  INDEX `store_id_idx` (`store_id` ASC) VISIBLE,
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  CONSTRAINT `store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `enterprise`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `apple_id`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`product_purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`product_purchases` (
  `model_id` INT NOT NULL,
  `checkout_id` INT NOT NULL,
  `cost` FLOAT NULL,
  PRIMARY KEY (`model_id`, `checkout_id`),
  INDEX `checkout_idx` (`checkout_id` ASC) VISIBLE,
  CONSTRAINT `modelid`
    FOREIGN KEY (`model_id`)
    REFERENCES `enterprise`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `checkout`
    FOREIGN KEY (`checkout_id`)
    REFERENCES `enterprise`.`checkout` (`checkout_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`stock` (
  `store_id` INT NOT NULL,
  `model_id` INT NOT NULL,
  `count` INT NULL,
  `price` FLOAT NULL,
  PRIMARY KEY (`store_id`, `model_id`),
  INDEX `model_id_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `storeid`
    FOREIGN KEY (`store_id`)
    REFERENCES `enterprise`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `model__id`
    FOREIGN KEY (`model_id`)
    REFERENCES `enterprise`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`developer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`developer` (
  `dev_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`dev_id`),
  UNIQUE INDEX `dev_id_UNIQUE` (`dev_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`app` (
  `app_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  `dev_id` INT NULL,
  PRIMARY KEY (`app_id`),
  INDEX `dev_id_idx` (`dev_id` ASC) VISIBLE,
  UNIQUE INDEX `app_id_UNIQUE` (`app_id` ASC) VISIBLE,
  CONSTRAINT `dev_id`
    FOREIGN KEY (`dev_id`)
    REFERENCES `enterprise`.`developer` (`dev_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`app_purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`app_purchase` (
  `app_id` INT NOT NULL,
  `apple_id` INT NOT NULL,
  `date` DATE NULL,
  `cost` FLOAT NULL,
  PRIMARY KEY (`app_id`, `apple_id`),
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  CONSTRAINT `app_id`
    FOREIGN KEY (`app_id`)
    REFERENCES `enterprise`.`app` (`app_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `appleid`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`in_app_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`in_app_items` (
  `iai_id` INT NOT NULL AUTO_INCREMENT,
  `app_id` INT NOT NULL,
  `type` TINYINT NULL,
  `price` FLOAT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`iai_id`, `app_id`),
  INDEX `app_id_idx` (`app_id` ASC) VISIBLE,
  UNIQUE INDEX `iai_id_UNIQUE` (`iai_id` ASC) VISIBLE,
  CONSTRAINT `appid`
    FOREIGN KEY (`app_id`)
    REFERENCES `enterprise`.`app` (`app_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`in_app_purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`in_app_purchase` (
  `iai_id` INT NOT NULL,
  `apple_id` INT NOT NULL,
  `date` DATE NULL,
  `cost` FLOAT NULL,
  `amount` INT NULL,
  PRIMARY KEY (`iai_id`, `apple_id`),
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  CONSTRAINT `apple__id`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `iai_id`
    FOREIGN KEY (`iai_id`)
    REFERENCES `enterprise`.`in_app_items` (`iai_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`consumable_ownership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`consumable_ownership` (
  `iai_id` INT NOT NULL,
  `apple_id` INT NOT NULL,
  `amount` INT NULL,
  PRIMARY KEY (`iai_id`, `apple_id`),
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  CONSTRAINT `iaiid`
    FOREIGN KEY (`iai_id`)
    REFERENCES `enterprise`.`in_app_items` (`iai_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `apple-id`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` BIGINT NULL,
  PRIMARY KEY (`artist_id`),
  UNIQUE INDEX `artist_id_UNIQUE` (`artist_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`song` (
  `song_id` INT NOT NULL AUTO_INCREMENT,
  `artist_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `album_name` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  PRIMARY KEY (`song_id`, `artist_id`),
  INDEX `artist_id_idx` (`artist_id` ASC) VISIBLE,
  UNIQUE INDEX `song_id_UNIQUE` (`song_id` ASC) VISIBLE,
  CONSTRAINT `artist_id`
    FOREIGN KEY (`artist_id`)
    REFERENCES `enterprise`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`song_purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`song_purchases` (
  `song_id` INT NOT NULL,
  `apple_id` INT NOT NULL,
  `date` DATE NULL,
  `cost` FLOAT NULL,
  PRIMARY KEY (`song_id`, `apple_id`),
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  CONSTRAINT `song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `enterprise`.`song` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `apple___id`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enterprise`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enterprise`.`device` (
  `serial_id` INT NOT NULL AUTO_INCREMENT,
  `model_id` INT NOT NULL,
  `apple_id` INT NOT NULL,
  PRIMARY KEY (`serial_id`, `model_id`, `apple_id`),
  INDEX `apple_id_idx` (`apple_id` ASC) VISIBLE,
  UNIQUE INDEX `serial_id_UNIQUE` (`serial_id` ASC) VISIBLE,
  CONSTRAINT `model-id`
    FOREIGN KEY (`model_id`)
    REFERENCES `enterprise`.`model` (`model_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `apple--id`
    FOREIGN KEY (`apple_id`)
    REFERENCES `enterprise`.`apple_account` (`apple_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
