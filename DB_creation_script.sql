-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema library_management_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library_management_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library_management_system` DEFAULT CHARACTER SET latin1 ;
USE `library_management_system` ;

-- -----------------------------------------------------
-- Table `library_management_system`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`author` (
  `author_id` INT(11) NOT NULL DEFAULT '0',
  `author_first_name` VARCHAR(300) NULL DEFAULT NULL,
  `author_middle_name` VARCHAR(300) NULL DEFAULT NULL,
  `author_last_name` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`category` (
  `category_id` INT(11) NOT NULL DEFAULT '0',
  `category_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`book` (
  `book_id` INT(11) NOT NULL DEFAULT '0',
  `book_title` VARCHAR(500) NULL DEFAULT NULL,
  `category_id` INT(11) NULL DEFAULT NULL,
  `publication_date` DATE NULL DEFAULT NULL,
  `copies_owned` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_book_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `library_management_system`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`library_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`library_member` (
  `member_id` INT(11) NOT NULL DEFAULT '0',
  `first_name` VARCHAR(300) NULL DEFAULT NULL,
  `middle_name` VARCHAR(300) NULL DEFAULT NULL,
  `last_name` VARCHAR(300) NULL DEFAULT NULL,
  `joined_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`book_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`book_author` (
  `book_id` INT(11) NULL DEFAULT NULL,
  `author_id` INT(11) NULL DEFAULT NULL,
  `library_member_member_id` INT(11) NOT NULL,
  INDEX `fk_bookauthor_book` (`book_id` ASC) VISIBLE,
  INDEX `fk_bookauthor_author` (`author_id` ASC) VISIBLE,
  PRIMARY KEY (`library_member_member_id`),
  CONSTRAINT `fk_bookauthor_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library_management_system`.`book` (`book_id`),
  CONSTRAINT `fk_bookauthor_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `library_management_system`.`author` (`author_id`),
  CONSTRAINT `fk_book_author_library_member1`
    FOREIGN KEY (`library_member_member_id`)
    REFERENCES `library_management_system`.`library_member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`borrow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`borrow` (
  `book_id` INT(11) NOT NULL,
  `member_id` INT(11) NULL,
  `borrow_date` DATE NULL DEFAULT NULL,
  `returned_date` DATE NULL DEFAULT NULL,
  INDEX `fk_loan_book` (`book_id` ASC) VISIBLE,
  INDEX `fk_loan_member` (`member_id` ASC) VISIBLE,
  PRIMARY KEY (`book_id`),
  CONSTRAINT `fk_loan_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library_management_system`.`book` (`book_id`),
  CONSTRAINT `fk_loan_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library_management_system`.`library_member` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`fine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`fine` (
  `book_id` INT(11) NULL DEFAULT NULL,
  `member_id` INT(11) NOT NULL,
  `fine_date` DATE NULL DEFAULT NULL,
  `fine_amount` INT(11) NULL DEFAULT NULL,
  INDEX `fk_fine_book` (`book_id` ASC) VISIBLE,
  INDEX `fk_fine_member` (`member_id` ASC) VISIBLE,
  PRIMARY KEY (`member_id`),
  CONSTRAINT `fk_fine_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library_management_system`.`book` (`book_id`),
  CONSTRAINT `fk_fine_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library_management_system`.`library_member` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`fine_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`fine_payment` (
  `id` INT(11) NOT NULL DEFAULT '0',
  `member_id` INT(11) NULL DEFAULT NULL,
  `payment_date` DATE NULL DEFAULT NULL,
  `payment_amount` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_finepay_member` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_finepay_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library_management_system`.`library_member` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library_management_system`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library_management_system`.`reservations` (
  `res_id` INT(11) NOT NULL DEFAULT '0',
  `book_id` INT(11) NULL DEFAULT NULL,
  `member_id` INT(11) NULL DEFAULT NULL,
  `res_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  INDEX `fk_res_book` (`book_id` ASC) VISIBLE,
  INDEX `fk_res_member` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_res_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `library_management_system`.`book` (`book_id`),
  CONSTRAINT `fk_res_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `library_management_system`.`library_member` (`member_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
