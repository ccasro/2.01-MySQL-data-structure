-- MySQL Workbench Synchronization
-- Generated: 2025-11-04 20:36
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: proye

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `ex4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

CREATE TABLE IF NOT EXISTS `ex4`.`album` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `artist_id` INT(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `release_year` INT(11) NULL DEFAULT NULL,
  `cover_image` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `artist_id` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `album_ibfk_1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `ex4`.`artist` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`artist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`credit_card` (
  `subscription_id` INT(11) NOT NULL,
  `card_number` VARCHAR(20) NOT NULL,
  `expiry_month` INT(11) NOT NULL,
  `expiry_year` INT(11) NOT NULL,
  `security_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`subscription_id`),
  CONSTRAINT `credit_card_ibfk_1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `ex4`.`subscription` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`payment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `subscription_id` INT(11) NOT NULL,
  `order_number` VARCHAR(50) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `order_number` (`order_number` ASC) VISIBLE,
  INDEX `subscription_id` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `ex4`.`subscription` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`paypal_account` (
  `subscription_id` INT(11) NOT NULL,
  `paypal_username` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`subscription_id`),
  CONSTRAINT `paypal_account_ibfk_1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `ex4`.`subscription` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `num_songs` INT(11) NULL DEFAULT '0',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `status` ENUM('active', 'deleted') NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `playlist_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`playlist_shared` (
  `playlist_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `added_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`playlist_id`, `user_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `playlist_shared_ibfk_1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `ex4`.`playlist` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `playlist_shared_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`related_artist` (
  `artist_id` INT(11) NOT NULL,
  `related_artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`artist_id`, `related_artist_id`),
  INDEX `related_artist_id` (`related_artist_id` ASC) VISIBLE,
  CONSTRAINT `related_artist_ibfk_1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `ex4`.`artist` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `related_artist_ibfk_2`
    FOREIGN KEY (`related_artist_id`)
    REFERENCES `ex4`.`artist` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`song` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `album_id` INT(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `duration_seconds` INT(11) NULL DEFAULT NULL,
  `play_count` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `album_id` (`album_id` ASC) VISIBLE,
  CONSTRAINT `song_ibfk_1`
    FOREIGN KEY (`album_id`)
    REFERENCES `ex4`.`album` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`subscription` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `start_date` DATE NOT NULL,
  `renewal_date` DATE NOT NULL,
  `payment_method` ENUM('credit_card', 'paypal') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `subscription_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `birthdate` DATE NOT NULL,
  `gender` ENUM('M', 'F', 'Other') NULL DEFAULT NULL,
  `country` VARCHAR(100) NULL DEFAULT NULL,
  `postal_code` VARCHAR(20) NULL DEFAULT NULL,
  `type` ENUM('free', 'premium') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`user_favorite_album` (
  `user_id` INT(11) NOT NULL,
  `album_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `album_id`),
  INDEX `album_id` (`album_id` ASC) VISIBLE,
  CONSTRAINT `user_favorite_album_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `user_favorite_album_ibfk_2`
    FOREIGN KEY (`album_id`)
    REFERENCES `ex4`.`album` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`user_favorite_song` (
  `user_id` INT(11) NOT NULL,
  `song_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `song_id`),
  INDEX `song_id` (`song_id` ASC) VISIBLE,
  CONSTRAINT `user_favorite_song_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `user_favorite_song_ibfk_2`
    FOREIGN KEY (`song_id`)
    REFERENCES `ex4`.`song` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex4`.`user_follows_artist` (
  `user_id` INT(11) NOT NULL,
  `artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `artist_id`),
  INDEX `artist_id` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `user_follows_artist_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex4`.`user` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `user_follows_artist_ibfk_2`
    FOREIGN KEY (`artist_id`)
    REFERENCES `ex4`.`artist` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
