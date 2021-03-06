-- MySQL Script generated by MySQL Workbench
-- Wed Mar 27 13:16:39 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema filemaindb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema filemaindb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `filemaindb` DEFAULT CHARACTER SET utf8 ;
USE `filemaindb` ;

-- -----------------------------------------------------
-- Table `filemaindb`.`utilizador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`utilizador` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`utilizador` (
  `Email` VARCHAR(50) NOT NULL,
  `NomeUtilizador` VARCHAR(100) NULL,
  `CategoriaProfissional` VARCHAR(300) NULL,
  PRIMARY KEY (`Email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`cultura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`cultura` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`cultura` (
  `IDcultura` INT NOT NULL AUTO_INCREMENT,
  `NomeCultura` VARCHAR(100) NULL,
  `DescricaoCultura` TEXT NULL,
  `utilizador_Email` VARCHAR(50) NULL,
  PRIMARY KEY (`IDcultura`),
  INDEX `Email_utilizador_idx` (`utilizador_Email` ASC)  ,
  CONSTRAINT `Email_utilizador`
    FOREIGN KEY (`utilizador_Email`)
    REFERENCES `filemaindb`.`utilizador` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`variavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`variavel` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`variavel` (
  `IDvariavel` INT NOT NULL,
  `NomeVariavel` VARCHAR(100) NULL,
  PRIMARY KEY (`IDvariavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`variaveis_medidas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`variaveis_medidas` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`variaveis_medidas` (
  `LimiteInferior` DECIMAL(8,2) NULL,
  `LimiteSuperior` DECIMAL(8,2) NULL,
  `Variavel_IDVariavel` INT NULL,
  `Cultura_IDCultura` INT NULL,
  INDEX `variaveis_idvariavel_idx` (`Variavel_IDVariavel` ASC)  ,
  INDEX `cultura_idcultura_idx` (`Cultura_IDCultura` ASC)  ,
  CONSTRAINT `variaveis_idvariavel`
    FOREIGN KEY (`Variavel_IDVariavel`)
    REFERENCES `filemaindb`.`variavel` (`IDvariavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cultura_idcultura`
    FOREIGN KEY (`Cultura_IDCultura`)
    REFERENCES `filemaindb`.`cultura` (`IDcultura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`medicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`medicao` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`medicao` (
  `NumeroMedicao` INT NOT NULL AUTO_INCREMENT,
  `DataHoraMedicao` TIMESTAMP(6) NULL,
  `ValorMedicao` DECIMAL(8,2) NULL,
  `VariaveisMedidas_IDCultura` INT NULL,
  `VariaveisMedidas_IDVariavel` INT NULL,
  PRIMARY KEY (`NumeroMedicao`),
  INDEX `id_cultura_idx` (`VariaveisMedidas_IDCultura` ASC)  ,
  INDEX `id_variavel_idx` (`VariaveisMedidas_IDVariavel` ASC)  ,
  CONSTRAINT `id_cultura`
    FOREIGN KEY (`VariaveisMedidas_IDCultura`)
    REFERENCES `filemaindb`.`variaveis_medidas` (`Cultura_IDCultura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_variavel`
    FOREIGN KEY (`VariaveisMedidas_IDVariavel`)
    REFERENCES `filemaindb`.`variaveis_medidas` (`Variavel_IDVariavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`medicoes_temperatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`medicoes_temperatura` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`medicoes_temperatura` (
  `IDmedicao` INT NOT NULL AUTO_INCREMENT,
  `DataHoraMedicao` TIMESTAMP(6) NULL,
  `ValorMedicaoTemperatura` DECIMAL(8,2) NULL,
  PRIMARY KEY (`IDmedicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`medicoes_luminusidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`medicoes_luminusidade` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`medicoes_luminusidade` (
  `IDMedicao` INT NOT NULL AUTO_INCREMENT,
  `DataHoraMedicao` TIMESTAMP(6) NULL,
  `ValorMedicaoLuminosidade` DECIMAL(8,2) NULL,
  PRIMARY KEY (`IDMedicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`sistema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`sistema` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`sistema` (
  `LimiteInferiorTemperatura` DECIMAL(8,2) NULL,
  `LimiteSuperiorTemperatura` DECIMAL(8,2) NULL,
  `LimiteSuperiorLuz` DECIMAL(8,2) NULL,
  `LimiteInferiorLuz` DECIMAL(8,2) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`utilizador_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`utilizador_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`utilizador_log` (
  `Email` VARCHAR(50) NULL,
  `NomeUtilizador` VARCHAR(100) NULL,
  `CategoriaProfissional` VARCHAR(300) NULL,
  `Utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `operacao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`cultura_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`cultura_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`cultura_log` (
  `IDCultura` INT NULL,
  `NomeCultura` VARCHAR(100) NULL,
  `DescricaoCultura` TEXT NULL,
  `Utilizador_Email` VARCHAR(50) NULL,
  `utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `operacao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`sistema_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`sistema_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`sistema_log` (
  `LimiteInferiorTemperatura` DECIMAL(8,2) NULL,
  `LimiteSuperiorTemperatura` DECIMAL(8,2) NULL,
  `LimiteSuperiorLuz` DECIMAL(8,2) NULL,
  `LimiteInferiorLuz` DECIMAL(8,2) NULL,
  `utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `operacao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`medicao_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`medicao_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`medicao_log` (
  `NumeroMedicao` INT NULL,
  `DataHoraMedicao` TIMESTAMP(6) NULL,
  `ValorMedicao` DECIMAL(8,2) NULL,
  `IDCultura` INT NULL,
  `VariaveisMedidas_IDVariavel` INT NULL,
  `utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `operacao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`variavel_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`variavel_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`variavel_log` (
  `IDvariavel` INT NULL,
  `NomeVariavel` VARCHAR(100) NULL,
  `utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `opercao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filemaindb`.`variaveis_medidas_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filemaindb`.`variaveis_medidas_log` ;

CREATE TABLE IF NOT EXISTS `filemaindb`.`variaveis_medidas_log` (
  `LimiteInferior` DECIMAL(8,2) NULL,
  `LimiteSuperior` DECIMAL(8,2) NULL,
  `Variavel_IDVariavel` INT NULL,
  `Cultura_IDCultura` INT NULL,
  `utilizador` VARCHAR(100) NULL,
  `data_operacao` TIMESTAMP(6) NULL,
  `operacao` VARCHAR(1) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

USE `filemaindb` ;

-- -----------------------------------------------------
-- procedure select_all_medicoes
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`select_all_medicoes`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `select_all_medicoes` ()
BEGIN
	select * from medicao;
    insert into medicao_log
		values(null,null,null,null,null,current_user(),now(),"S",null);
        
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_por_dia
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`consulta_por_dia`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `consulta_por_dia` (datahora timestamp(6))
BEGIN
	select * from medicao
    where cast(datahora as date) = cast(medicao.datahoramedicao as date) ;
    insert into medicao_log
		values(null,medicao.DataHoraMedicao,null,null,null,current_user(),now(),"S",null);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_Email_por_CategoriaProfissional
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`consulta_Email_por_CategoriaProfissional`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `consulta_Email_por_CategoriaProfissional` (CP varchar(300))
BEGIN
	select email from utilizador
    where utilizador.CategoriaProfissional=CP;
    insert into utilizador_log
		values(null,null,CP,current_user(),now(),'S',null);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure consulta_utilizador_email_por_NomeCultura
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`consulta_utilizador_email_por_NomeCultura`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `consulta_utilizador_email_por_NomeCultura` (NC varchar(100))
BEGIN
	select utilizador_email from cultura
    where cultura.NomeCultura=NC;
    insert into cultura_log
		values(null,NC,null,null,current_user(),now(),'S',null);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure cria_utilizador
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`cria_utilizador`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `cria_utilizador` (Email varchar(50),Nome varchar(100),CProf varchar(300),p_Name varchar(100),p_Passw varchar(100))
BEGIN
	DECLARE `_HOST` CHAR(14) DEFAULT '@''localhost''';
    
    SET `p_Name` := CONCAT('''', REPLACE(TRIM(`p_Name`), CHAR(39), CONCAT(CHAR(92), CHAR(39))), ''''),
    `p_Passw` := CONCAT('''', REPLACE(`p_Passw`, CHAR(39), CONCAT(CHAR(92), CHAR(39))), '''');
    SET @`sql` := CONCAT('CREATE USER ', `p_Name`, `_HOST`, ' IDENTIFIED BY ', `p_Passw`);
    PREPARE `stmt` FROM @`sql`;
    EXECUTE `stmt`;
    SET @`sql` := CONCAT('GRANT ALL PRIVILEGES ON *.* TO ', `p_Name`, `_HOST`);
    PREPARE `stmt` FROM @`sql`;
    EXECUTE `stmt`;
    DEALLOCATE PREPARE `stmt`;
    FLUSH PRIVILEGES;
    insert into utilizador
		values(Email,Nome,CProf);
	
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure apaga_utilizador
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`apaga_utilizador`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `apaga_utilizador` (E varchar(50))
BEGIN
	select substring_index(E,'@',1) as username;
    drop user username@'%';
    delete from utilizador
		where E=utilizador.Email;
	
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insere_medicao
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`insere_medicao`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `insere_medicao` (valor decimal(8,2),idCultura int,idVariavel int)
BEGIN 
	
	insert into medicao
		values(null,now(),valor,idCultura,idVariavel);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure exporta_utilizador_log
-- -----------------------------------------------------

USE `filemaindb`;
DROP procedure IF EXISTS `filemaindb`.`exporta_utilizador_log`;

DELIMITER $$
USE `filemaindb`$$
CREATE PROCEDURE `exporta_utilizador_log` ()
BEGIN
	set @lastmigrated = (SELECT max(id) from utilizador_log);
    set @filename= '_UtilizadorLog.csv';
	set @comando1 = 'select * from `utilizador_log` into outfile ';
    set @comando2 = CONCAT('FIELDS TERMINATED BY ',CHAR(39),char(44),char(39),'ENCLOSED BY ',char(39),CHAR(34),CHAR(39),'LINES TERMINATED BY ',char(39),char(92),char(110),char(39));
	SET @stmt = CONCAT(@comando1,char(39),@lastmigrated,@filename,char(39),@comando2);
   select @stmt;
	PREPARE s1 FROM @stmt;
	EXECUTE s1;
	DROP PREPARE s1;

END$$

DELIMITER ;
USE `filemaindb`;

DELIMITER $$

USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`utilizador_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`utilizador_AFTER_INSERT` AFTER INSERT ON `utilizador` FOR EACH ROW
BEGIN
    insert into utilizador_log
		values (new.Email,
				new.NomeUtilizador,
                new.CategoriaProfissional,
                current_user(),
                now(),
                "I",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`utilizador_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`utilizador_AFTER_DELETE` AFTER DELETE ON `utilizador` FOR EACH ROW

BEGIN
    insert into utilizador_log
		values (old.Email,
				old.NomeUtilizador,
                old.CategoriaProfissional,
                current_user(),
                now(),
                "D",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`cultura_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`cultura_AFTER_INSERT` AFTER INSERT ON `cultura` FOR EACH ROW
BEGIN
    insert into cultura_log (IDCultura, NomeCultura, DescricaoCultura, Utilizador_Email, utilizador, data_operacao, operacao, id) 
		values (new.IDCultura,new.NomeCultura,new.DescricaoCultura,new.utilizador_Email, current_user(),now(),"I",null);
        
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`cultura_AFTER_UPDATE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`cultura_AFTER_UPDATE` AFTER UPDATE ON `cultura` FOR EACH ROW
BEGIN
    insert into cultura_log (IDCultura, NomeCultura, DescricaoCultura, Utilizador_Email, utilizador, data_operacao, operacao, id) 
		values (new.IDCultura,new.NomeCultura,new.DescricaoCultura,new.utilizador_Email, current_user(),now(),"U",null);
	
    
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`cultura_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`cultura_AFTER_DELETE` AFTER DELETE ON `cultura` FOR EACH ROW
BEGIN
    insert into cultura_log (IDCultura, NomeCultura, DescricaoCultura, Utilizador_Email, utilizador, data_operacao, operacao, id) 
		values (old.IDCultura,old.NomeCultura,old.DescricaoCultura,old.utilizador_Email, current_user(),now(),"D",null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variavel_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variavel_AFTER_INSERT` AFTER INSERT ON `variavel` FOR EACH ROW
BEGIN
    insert into variavel_log
		values (new.IDvariavel,
				new.NomeVariavel,
                current_user(),
                now(),
                "I",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variavel_AFTER_UPDATE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variavel_AFTER_UPDATE` AFTER UPDATE ON `variavel` FOR EACH ROW
BEGIN
    insert into variavel_log
		values (new.IDvariavel,
				new.NomeVariavel,
                current_user(),
                now(),
                "U",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variavel_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variavel_AFTER_DELETE` AFTER DELETE ON `variavel` FOR EACH ROW
BEGIN

    insert into variavel_log
		values (old.IDvariavel,
				old.NomeVariavel,
                current_user(),
                now(),
                "D",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variaveis_medidas_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variaveis_medidas_AFTER_INSERT` AFTER INSERT ON `variaveis_medidas` FOR EACH ROW
BEGIN
    insert into variavel_log
		values (new.LimiteInferior,
				new.LimiteSuperior,
                new.Variavel_IDVariavel,
                new.Cultura_IDCultura,
                current_user(),
                now(),
                "I",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variaveis_medidas_AFTER_UPDATE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variaveis_medidas_AFTER_UPDATE` AFTER UPDATE ON `variaveis_medidas` FOR EACH ROW
BEGIN

    insert into variavel_log
		values (new.LimiteInferior,
				new.LimiteSuperior,
                new.Variavel_IDVariavel,
                new.Cultura_IDCultura,
                current_user(),
                now(),
                "U",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`variaveis_medidas_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`variaveis_medidas_AFTER_DELETE` AFTER DELETE ON `variaveis_medidas` FOR EACH ROW
BEGIN
    insert into variavel_log
		values (old.LimiteInferior,
				old.LimiteSuperior,
                old.Variavel_IDVariavel,
                old.Cultura_IDCultura,
                current_user(),
                now(),
                "D",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`medicao_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`medicao_AFTER_INSERT` AFTER INSERT ON `medicao` FOR EACH ROW
BEGIN
    insert into medicao_log
		values (new.NumeroMedicao,new.DataHoraMedicao,new.ValorMedicao,new.VariaveisMedidas_IDCultura,new.VariaveisMedidas_IDVariavel, current_user(),now(),"I",null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`medicao_AFTER_UPDATE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`medicao_AFTER_UPDATE` AFTER UPDATE ON `medicao` FOR EACH ROW
BEGIN
    insert into medicao_log
		values (new.NumeroMedicao,new.DataHoraMedicao,new.ValorMedicao,new.VariaveisMedidas_IDCultura,new.VariaveisMedidas_IDVariavel, current_user(),now(),"U",null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`medicao_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`medicao_AFTER_DELETE` AFTER DELETE ON `medicao` FOR EACH ROW
BEGIN
    insert into medicao_log
		values (old.NumeroMedicao,old.DataHoraMedicao,old.ValorMedicao,old.VariaveisMedidas_IDCultura,old.VariaveisMedidas_IDVariavel, current_user(),now(),"D",null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`sistema_AFTER_INSERT` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`sistema_AFTER_INSERT` AFTER INSERT ON `sistema` FOR EACH ROW
BEGIN
    insert into sistema_log
		values (new.LimiteInferiorTemperatura,
				new.LimiteSuperiorTemperatura,
                new.LimiteSuperiorLuz,
                new.LimiteInferiorLuz,
                current_user(),
                now(),
                "I",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`sistema_AFTER_UPDATE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`sistema_AFTER_UPDATE` AFTER UPDATE ON `sistema` FOR EACH ROW
BEGIN
	
    insert into sistema_log
		values (new.LimiteInferiorTemperatura,
				new.LimiteSuperiorTemperatura,
                new.LimiteSuperiorLuz,
                new.LimiteInferiorLuz,
                current_user(),
                now(),
                "U",
                null);
END$$


USE `filemaindb`$$
DROP TRIGGER IF EXISTS `filemaindb`.`sistema_AFTER_DELETE` $$
USE `filemaindb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `filemaindb`.`sistema_AFTER_DELETE` AFTER DELETE ON `sistema` FOR EACH ROW
BEGIN
    insert into sistema_log
		values (old.LimiteInferiorTemperatura,
				old.LimiteSuperiorTemperatura,
                old.LimiteSuperiorLuz,
                old.LimiteInferiorLuz,
                current_user(),
                now(),
                "D",
                null);
END$$


DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS Admininstrador;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Admininstrador' IDENTIFIED BY 'admin';

GRANT SELECT ON TABLE `filemaindb`.`medicoes_luminusidade` TO 'Admininstrador';
GRANT SELECT ON TABLE `filemaindb`.`medicoes_temperatura` TO 'Admininstrador';
GRANT DELETE, INSERT, UPDATE, SELECT ON TABLE `filemaindb`.`sistema` TO 'Admininstrador';
GRANT SELECT ON TABLE `filemaindb`.`sistema_log` TO 'Admininstrador';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `filemaindb`.`utilizador` TO 'Admininstrador';
GRANT SELECT ON TABLE `filemaindb`.`utilizador_log` TO 'Admininstrador';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `filemaindb`.`variavel` TO 'Admininstrador';
GRANT SELECT ON TABLE `filemaindb`.`variavel_log` TO 'Admininstrador';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `filemaindb`.`variaveis_medidas` TO 'Admininstrador';
GRANT SELECT ON TABLE `filemaindb`.`variaveis_medidas_log` TO 'Admininstrador';
SET SQL_MODE = '';
DROP USER IF EXISTS Investigador;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Investigador';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
