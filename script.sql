SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;



-- -----------------------------------------------------

-- Table `mydb`.`PAIS`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`PAIS` (

  `NOME` VARCHAR(25) NOT NULL ,

  `POPULACAO` INT NOT NULL ,

  `CAPITAL` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`NOME`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`TITULOS`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`TITULOS` (

  `TITULO` DATE NOT NULL ,

  `PAIS_NOME` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`PAIS_NOME`) ,

  INDEX `fk_TITULOS_PAIS_idx` (`PAIS_NOME` ASC) ,

  CONSTRAINT `fk_TITULOS_PAIS`

    FOREIGN KEY (`PAIS_NOME` )

    REFERENCES `mydb`.`PAIS` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`PARTICIPACAO`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`PARTICIPACAO` (

  `PARTICIPACAO` DATE NOT NULL ,

  `PAIS_NOME` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`PAIS_NOME`) ,

  INDEX `fk_PARTICIPACAO_PAIS1_idx` (`PAIS_NOME` ASC) ,

  CONSTRAINT `fk_PARTICIPACAO_PAIS1`

    FOREIGN KEY (`PAIS_NOME` )

    REFERENCES `mydb`.`PAIS` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`EQUIPES`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`EQUIPES` (

  `NOME` VARCHAR(25) NOT NULL ,

  `N_MEMBROS` INT NOT NULL ,

  PRIMARY KEY (`NOME`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`JOGADORES/TECNICOS`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`JOGADORES/TECNICOS` (

  `ID` INT NOT NULL ,

  `NOME` VARCHAR(45) NOT NULL ,

  `FUNCAO` VARCHAR(45) NOT NULL ,

  `IDADE` VARCHAR(45) NOT NULL ,

  `N_PARTICIPACOES` INT NULL ,

  `EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`ID`, `EQUIPES_NOME`) ,

  INDEX `fk_JOGADORES/TECNICOS_EQUIPES1_idx` (`EQUIPES_NOME` ASC) ,

  CONSTRAINT `fk_JOGADORES/TECNICOS_EQUIPES1`

    FOREIGN KEY (`EQUIPES_NOME` )

    REFERENCES `mydb`.`EQUIPES` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`CORES`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`CORES` (

  `COR` VARCHAR(20) NOT NULL ,

  `EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`EQUIPES_NOME`) ,

  INDEX `fk_CORES_EQUIPES1_idx` (`EQUIPES_NOME` ASC) ,

  CONSTRAINT `fk_CORES_EQUIPES1`

    FOREIGN KEY (`EQUIPES_NOME` )

    REFERENCES `mydb`.`EQUIPES` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`ESTADIO`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`ESTADIO` (

  `NOME` VARCHAR(45) NOT NULL ,

  `LOCALIZACAO` VARCHAR(45) NOT NULL ,

  `CAPACIDADE` VARCHAR(45) NOT NULL ,

  `AREA` VARCHAR(45) NOT NULL ,

  `FUSO` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`NOME`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`JOGOS`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`JOGOS` (

  `ID` INT NOT NULL ,

  `EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  `ESTADIO_NOME` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`ID`, `EQUIPES_NOME`, `ESTADIO_NOME`) ,

  INDEX `fk_JOGOS_EQUIPES1_idx` (`EQUIPES_NOME` ASC) ,

  INDEX `fk_JOGOS_ESTADIO1_idx` (`ESTADIO_NOME` ASC) ,

  CONSTRAINT `fk_JOGOS_EQUIPES1`

    FOREIGN KEY (`EQUIPES_NOME` )

    REFERENCES `mydb`.`EQUIPES` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_JOGOS_ESTADIO1`

    FOREIGN KEY (`ESTADIO_NOME` )

    REFERENCES `mydb`.`ESTADIO` (`NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`GOL_PARTIDA`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`GOL_PARTIDA` (

  `JOGOS_ID` INT NOT NULL ,

  `JOGADORES/TECNICOS_ID` INT NOT NULL ,

  `JOGADORES/TECNICOS_EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  PRIMARY KEY (`JOGOS_ID`, `JOGADORES/TECNICOS_ID`, `JOGADORES/TECNICOS_EQUIPES_NOME`) ,

  INDEX `fk_GOL_PARTIDA_JOGADORES/TECNICOS1_idx` (`JOGADORES/TECNICOS_ID` ASC, `JOGADORES/TECNICOS_EQUIPES_NOME` ASC) ,

  CONSTRAINT `fk_GOL_PARTIDA_JOGOS1`

    FOREIGN KEY (`JOGOS_ID` )

    REFERENCES `mydb`.`JOGOS` (`ID` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_GOL_PARTIDA_JOGADORES/TECNICOS1`

    FOREIGN KEY (`JOGADORES/TECNICOS_ID` , `JOGADORES/TECNICOS_EQUIPES_NOME` )

    REFERENCES `mydb`.`JOGADORES/TECNICOS` (`ID` , `EQUIPES_NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`CARTOES`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`CARTOES` (

  `AMARELO` INT NULL ,

  `VERMELHO` INT NULL ,

  `JOGADORES/TECNICOS_ID` INT NOT NULL ,

  `JOGADORES/TECNICOS_EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  `JOGOS_ID` INT NOT NULL ,

  PRIMARY KEY (`JOGADORES/TECNICOS_ID`, `JOGADORES/TECNICOS_EQUIPES_NOME`, `JOGOS_ID`) ,

  INDEX `fk_CARTOES_JOGOS1_idx` (`JOGOS_ID` ASC) ,

  CONSTRAINT `fk_CARTOES_JOGADORES/TECNICOS1`

    FOREIGN KEY (`JOGADORES/TECNICOS_ID` , `JOGADORES/TECNICOS_EQUIPES_NOME` )

    REFERENCES `mydb`.`JOGADORES/TECNICOS` (`ID` , `EQUIPES_NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_CARTOES_JOGOS1`

    FOREIGN KEY (`JOGOS_ID` )

    REFERENCES `mydb`.`JOGOS` (`ID` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`TORCIDA`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`TORCIDA` (

  `ID` INT NOT NULL ,

  `NOME` VARCHAR(45) NOT NULL ,

  `N_INTEGRANTES` INT NOT NULL ,

  `PAIS` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`ID`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`PARTICIPANTE`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`PARTICIPANTE` (

  `ID` INT NOT NULL ,

  `SENHA` VARCHAR(45) NOT NULL ,

  `NOME` VARCHAR(45) NOT NULL ,

  `EMAIL` VARCHAR(45) NOT NULL ,

  `TORCIDA_ID` INT NOT NULL ,

  PRIMARY KEY (`ID`) ,

  INDEX `fk_PARTICIPANTE_TORCIDA1_idx` (`TORCIDA_ID` ASC) ,

  CONSTRAINT `fk_PARTICIPANTE_TORCIDA1`

    FOREIGN KEY (`TORCIDA_ID` )

    REFERENCES `mydb`.`TORCIDA` (`ID` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `mydb`.`BOLAO`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `mydb`.`BOLAO` (

  `ID` INT NOT NULL ,

  `PALPITE` VARCHAR(45) NOT NULL ,

  `NACIONALIDADE_PARTICIPANTE` VARCHAR(45) NOT NULL ,

  `JOGOS_ID` INT NOT NULL ,

  `JOGOS_EQUIPES_NOME` VARCHAR(25) NOT NULL ,

  `PARTICIPANTE_ID` INT NOT NULL ,

  PRIMARY KEY (`ID`, `JOGOS_ID`, `JOGOS_EQUIPES_NOME`) ,

  INDEX `fk_BOLAO_JOGOS1_idx` (`JOGOS_ID` ASC, `JOGOS_EQUIPES_NOME` ASC) ,

  INDEX `fk_BOLAO_PARTICIPANTE1_idx` (`PARTICIPANTE_ID` ASC) ,

  CONSTRAINT `fk_BOLAO_JOGOS1`

    FOREIGN KEY (`JOGOS_ID` , `JOGOS_EQUIPES_NOME` )

    REFERENCES `mydb`.`JOGOS` (`ID` , `EQUIPES_NOME` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_BOLAO_PARTICIPANTE1`

    FOREIGN KEY (`PARTICIPANTE_ID` )

    REFERENCES `mydb`.`PARTICIPANTE` (`ID` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;








SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;