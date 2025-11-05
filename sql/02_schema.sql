-- MySQL Workbench Synchronization
-- Generated: 2025-11-04 13:13
-- Model: Exercise1
-- Version: 1.0
-- Project: Bottle bottom
-- Author: proye

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `ex1`  DEFAULT CHARACTER SET utf8mb4  DEFAULT COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex1`.`provider` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(25) NULL DEFAULT NULL,
  `fax` VARCHAR(25) NULL DEFAULT NULL,
  `tax_id` VARCHAR(20) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tax_id_UNIQUE` (`tax_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`glasses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `provider_id` INT(11) NOT NULL,
  `brand` VARCHAR(100) NULL DEFAULT NULL,
  `lens_power` DECIMAL(4,2) NULL DEFAULT NULL,
  `frame_type` ENUM('floating', 'plastic', 'metal') NULL DEFAULT NULL,
  `frame_color` VARCHAR(45) NULL DEFAULT NULL,
  `lens_color` VARCHAR(45) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_glasses_provider_idx` (`provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_provider`
    FOREIGN KEY (`provider_id`)
    REFERENCES `ex1`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`client` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `phone` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `registered_at` DATETIME NULL DEFAULT NULL,
  `referred_by_client_id` INT(11) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_referred_idx` (`referred_by_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_referred`
    FOREIGN KEY (`referred_by_client_id`)
    REFERENCES `ex1`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`sale` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `sale_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `glasses_id` INT(11) NOT NULL,
  `client_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sale_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  INDEX `fk_sale_client1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_sale_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `ex1`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ex1`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `ex1`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`address` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL DEFAULT NULL,
  `street_number` VARCHAR(10) NULL DEFAULT NULL,
  `floor` VARCHAR(10) NULL DEFAULT NULL,
  `door` VARCHAR(10) NULL DEFAULT NULL,
  `postal_code` VARCHAR(20) NULL DEFAULT NULL,
  `city` VARCHAR(100) NULL DEFAULT NULL,
  `country` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`client_has_address` (
  `client_has_address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `address_id` INT(11) NOT NULL,
  `client_id` INT(11) NOT NULL,
  PRIMARY KEY (`client_has_address_id`, `client_id`),
  INDEX `fk_client_has_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_client_has_address_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `ex1`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_address_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ex1`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`provider_has_address` (
  `provider_has_address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `address_id` INT(11) NOT NULL,
  `provider_id` INT(11) NOT NULL,
  PRIMARY KEY (`provider_has_address_id`, `provider_id`),
  INDEX `fk_provider_has_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_provider_has_address_provider1_idx` (`provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_provider_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `ex1`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_has_address_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `ex1`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `ex1`.`employee` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
