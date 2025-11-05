-- MySQL Workbench Synchronization
-- Generated: 2025-11-04 19:58
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: proye

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `ex3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

CREATE TABLE IF NOT EXISTS `ex3`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `birthdate` DATE NOT NULL,
  `gender` ENUM('M', 'F', 'Other') NULL DEFAULT NULL,
  `country` VARCHAR(100) NULL DEFAULT NULL,
  `postal_code` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`channel` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_channel_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_channel_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`subscription` (
  `user_id` INT(11) NOT NULL,
  `channel_id` INT(11) NOT NULL,
  `subscribed_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `channel_id`),
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_channel_id`
    FOREIGN KEY (`channel_id`)
    REFERENCES `ex3`.`channel` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`video` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `size_mb` DECIMAL(10,2) NULL DEFAULT NULL,
  `filename` VARCHAR(100) NULL DEFAULT NULL,
  `duration_seconds` INT(11) NULL DEFAULT NULL,
  `thumbnail` VARCHAR(150) NULL DEFAULT NULL,
  `views` INT(11) NULL DEFAULT 0,
  `likes` INT(11) NULL DEFAULT 0,
  `dislikes` INT(11) NULL DEFAULT 0,
  `status` ENUM('public', 'private', 'hidden') NULL DEFAULT 'public',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_video_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`tag` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`video_has_tag` (
  `video_id` INT(11) NOT NULL,
  `tag_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `tag_id`),
  INDEX `fk_video_has_tag_tag1_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_video_has_tag_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_has_tag_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `ex3`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `ex3`.`tag` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`video_like` (
  `is_like` TINYINT(4) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `video_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `user_id`),
  INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_video_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_user_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `ex3`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`playlist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('public', 'private') NULL DEFAULT 'public',
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`video_has_playlist` (
  `video_id` INT(11) NOT NULL,
  `playlist_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `playlist_id`),
  INDEX `fk_video_has_playlist_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_video_has_playlist_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_has_playlist_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `ex3`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `ex3`.`playlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_video_id_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_comment_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_comment_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `ex3`.`video` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ex3`.`comment_like` (
  `comment_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `is_like` TINYINT(4) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`, `user_id`),
  INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_comment_like_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ex3`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_like_user_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `ex3`.`comment` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
