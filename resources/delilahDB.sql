-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema resto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema resto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `resto` DEFAULT CHARACTER SET utf8 ;
USE `resto` ;

-- -----------------------------------------------------
-- Table `resto`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resto`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_rol` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_fullName` VARCHAR(60) NOT NULL,
  `user_email` VARCHAR(60) NOT NULL,
  `user_phone` INT NOT NULL,
  `user_address` VARCHAR(60) NOT NULL,
  `user_password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `idusuarios_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 48
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `resto`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resto`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `fk_user_id` INT NOT NULL,
  `order_state` VARCHAR(45) NOT NULL,
  `order_date` VARCHAR(18) NOT NULL,
  `order_price` INT NOT NULL,
  `order_way_to_pay` VARCHAR(45) NOT NULL,
  `order_description` LONGTEXT NOT NULL,
  PRIMARY KEY (`order_id`, `fk_user_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_users_id_idx` (`fk_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`fk_user_id`)
    REFERENCES `resto`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `resto`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resto`.`products` (
  `products_id` INT NOT NULL AUTO_INCREMENT,
  `products_Price` INT UNSIGNED NOT NULL,
  `products_Name` VARCHAR(45) NOT NULL,
  `products_link_img` LONGTEXT NOT NULL,
  PRIMARY KEY (`products_id`),
  UNIQUE INDEX `idproducts_UNIQUE` (`products_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `resto`.`product_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `resto`.`product_order` (
  `fk_order_id` INT NOT NULL,
  `fk_products_id` INT NOT NULL,
  `fk_order_user_id` INT NOT NULL,
  PRIMARY KEY (`fk_order_id`, `fk_order_user_id`, `fk_products_id`),
  INDEX `fk_products_id_idx` (`fk_products_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`fk_order_id` , `fk_order_user_id`)
    REFERENCES `resto`.`orders` (`order_id` , `fk_user_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_products_id`
    FOREIGN KEY (`fk_products_id`)
    REFERENCES `resto`.`products` (`products_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
