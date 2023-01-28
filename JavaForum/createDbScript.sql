-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema forum_java
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema forum_java
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `forum_java` DEFAULT CHARACTER SET utf8 ;
USE `forum_java` ;

-- -----------------------------------------------------
-- Table `forum_java`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_java`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nick` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum_java`.`questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_java`.`questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(64) NOT NULL,
  `content` VARCHAR(256) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_questions_users_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_questions_users`
    FOREIGN KEY (`userId`)
    REFERENCES `forum_java`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum_java`.`answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_java`.`answers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(256) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `userId` INT NOT NULL,
  `questionId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_answers_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_answers_questions1_idx` (`questionId` ASC) VISIBLE,
  CONSTRAINT `fk_answers_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `forum_java`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answers_questions1`
    FOREIGN KEY (`questionId`)
    REFERENCES `forum_java`.`questions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `forum_java`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `forum_java`.`ratings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rate` DOUBLE NOT NULL,
  `userId` INT NOT NULL,
  `answerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ratings_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_ratings_answers1_idx` (`answerId` ASC) VISIBLE,
  CONSTRAINT `fk_ratings_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `forum_java`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ratings_answers1`
    FOREIGN KEY (`answerId`)
    REFERENCES `forum_java`.`answers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
