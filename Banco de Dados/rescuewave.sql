-- -----------------------------------------------------
-- Schema rescuewave
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `rescuewave` DEFAULT CHARACTER SET utf8 ;
USE `rescuewave` ;

-- -----------------------------------------------------
-- Table `rescuewave`.`OrgaoPublico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`OrgaoPublico` (
  `idOrgaoPublico` INT NOT NULL AUTO_INCREMENT,
  `nomeOrgaoPublico` VARCHAR(45) NULL DEFAULT NULL,
  `tipoOrgaoPublico` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idOrgaoPublico`));


-- -----------------------------------------------------
-- Table `rescuewave`.`EnderecoOrgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`EnderecoOrgao` (
  `idEnderecoOrgao` INT NOT NULL AUTO_INCREMENT,
  `CepOrgao` INT NOT NULL,
  `ruaOrgao` VARCHAR(45) NULL DEFAULT NULL,
  `bairroOrgao` VARCHAR(45) NULL DEFAULT NULL,
  `cidadeOrgao` VARCHAR(45) NULL DEFAULT NULL,
  `estadoOrgao` VARCHAR(2) NULL DEFAULT NULL,
  `OrgaoPublico_idOrgaoPublico` INT NOT NULL,
  PRIMARY KEY (`idEnderecoOrgao`, `OrgaoPublico_idOrgaoPublico`),
  FOREIGN KEY (`OrgaoPublico_idOrgaoPublico`)
  REFERENCES `rescuewave`.`OrgaoPublico` (`idOrgaoPublico`)
  );


-- -----------------------------------------------------
-- Table `rescuewave`.`TelefoneOrgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`TelefoneOrgao` (
  `idTelefoneOrgao` BIGINT NOT NULL AUTO_INCREMENT,
  `numeroOrgaoPublico` VARCHAR(11) NOT NULL,
  `OrgaoPublico_idOrgaoPublico` INT NOT NULL,
  PRIMARY KEY (`idTelefoneOrgao`, `OrgaoPublico_idOrgaoPublico`),
  FOREIGN KEY (`OrgaoPublico_idOrgaoPublico`)
  REFERENCES `rescuewave`.`OrgaoPublico` (`idOrgaoPublico`)
);


-- -----------------------------------------------------
-- Table `rescuewave`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `matriculaFuncionario` VARCHAR(45) NOT NULL,
  `nomeFuncionario` VARCHAR(45) NOT NULL,
  `cargoFuncionario` VARCHAR(45) NOT NULL,
  `emailFuncionario` VARCHAR(45) NOT NULL,
  `OrgaoPublico_idOrgaoPublico` INT NOT NULL,
  UNIQUE INDEX (`matriculaFuncionario` ASC) VISIBLE,
  PRIMARY KEY (`idFuncionario`, `OrgaoPublico_idOrgaoPublico`),
  FOREIGN KEY (`OrgaoPublico_idOrgaoPublico`)
  REFERENCES `rescuewave`.`OrgaoPublico` (`idOrgaoPublico`)
   );


-- -----------------------------------------------------
-- Table `rescuewave`.`AlertaEmergencial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`AlertaEmergencial` (
  `idAlertaEmergencial` INT NOT NULL AUTO_INCREMENT,
  `descricaoAlerta` VARCHAR(130) NOT NULL,
  `dataAlerta` DATE NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idAlertaEmergencial`, `Funcionario_idFuncionario`),
  FOREIGN KEY (`Funcionario_idFuncionario`)
  REFERENCES `rescuewave`.`Funcionario` (`idFuncionario`)
    );


-- -----------------------------------------------------
-- Table `rescuewave`.`EnderecoAlerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`EnderecoAlerta` (
  `idEnderecoAlerta` INT NOT NULL AUTO_INCREMENT,
  `ruaAlerta` VARCHAR(45) NOT NULL,
  `bairroAlerta` VARCHAR(45) NOT NULL,
  `cidadeAlerta` VARCHAR(45) NOT NULL,
  `estadoAlerta` VARCHAR(2) NOT NULL,
  `CepAlerta` INT NOT NULL,
  `AlertaEmergencial_idAlertaEmergencial` INT NOT NULL,
  PRIMARY KEY (`idEnderecoAlerta`, `AlertaEmergencial_idAlertaEmergencial`),
  FOREIGN KEY (`AlertaEmergencial_idAlertaEmergencial`)
  REFERENCES `rescuewave`.`AlertaEmergencial` (`idAlertaEmergencial`)
  );


-- -----------------------------------------------------
-- Table `rescuewave`.`AlertaDesaparecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`AlertaDesaparecimento` (
  `idAlertaDesaparecimento` INT NOT NULL,
  `idade` INT NOT NULL,
  `nomeDesaparecido` VARCHAR(45) NOT NULL,
  `linkFoto` VARCHAR(45) NOT NULL,
  `contatoEmergencia` VARCHAR(11) NOT NULL,
  `AlertaEmergencial_idAlertaEmergencial` INT NOT NULL,
  PRIMARY KEY (`idAlertaDesaparecimento`, `AlertaEmergencial_idAlertaEmergencial`),
  FOREIGN KEY (`AlertaEmergencial_idAlertaEmergencial`) 
  REFERENCES `rescuewave`.`AlertaEmergencial` (`idAlertaEmergencial`)
 );


-- -----------------------------------------------------
-- Table `rescuewave`.`AlertaDesastreNatural`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rescuewave`.`AlertaDesastreNatural` (
  `idAlertsDesastreNatural` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `risco` VARCHAR(6) NOT NULL,
  `AlertaEmergencial_idAlertaEmergencial` INT NOT NULL,
  PRIMARY KEY (`idAlertsDesastreNatural`, `AlertaEmergencial_idAlertaEmergencial`),
  FOREIGN KEY (`AlertaEmergencial_idAlertaEmergencial`)
  REFERENCES `rescuewave`.`AlertaEmergencial` (`idAlertaEmergencial`)
);

-- --------------------------------------------------
-- Inserts
-- --------------------------------------------------

-- --------------------------------------------------
-- Insert OrgaoPublico
-- --------------------------------------------------
INSERT INTO OrgaoPublico (nomeOrgaoPublico, tipoOrgaoPublico) 
VALUES 
('Policia Militar', 'Segurança'),
('Corpo de Bombeiros', 'Emergência'),
('Defesa Civil', 'Emergência'),
('Delegacia de Polícia', 'Segurança'),
('Prefeitura Municipal', 'Administração'),
('Instituto de Metereologia', 'Segurança'),
('Guarda Municipal', 'Segurança');

-- --------------------------------------------------
-- Insert EnderecoOrgao
-- --------------------------------------------------
INSERT INTO EnderecoOrgao (CepOrgao, ruaOrgao, bairroOrgao, cidadeOrgao, estadoOrgao, OrgaoPublico_idOrgaoPublico)
VALUES
(58411111, 'Rua A', 'Centro', 'Campina Grande', 'PB', 1),
(58422222, 'Rua B', 'Pedregal', 'Campina Grande', 'PB', 2),
(58433333, 'Rua C', 'Universitario', 'Campina Grande', 'PB', 3),
(58544444, 'Rua D', 'Centro', 'Queimadas', 'PB', 4),
(58455555, 'Rua E', 'Catole', 'Campina Grande', 'PB', 5),
(58566666, 'Rua F', 'Centro', 'Lagoa Seca', 'PB', 6),
(58677777, 'Rua G', 'Centro', 'São José da Mata', 'PB', 7);

-- --------------------------------------------------
-- Insert TelefoneOrgao
-- --------------------------------------------------
INSERT INTO TelefoneOrgao (numeroOrgaoPublico, OrgaoPublico_idOrgaoPublico) 
VALUES 
(8392334455, 1), 
(8392543455, 1), 
(8391114455, 1), 
(8398744455, 2), 
(8398234655, 2), 
(8394232211, 3), 
(8393123100, 4), 
(8393654100, 4), 
(8398765011, 5), 
(8399865233, 6), 
(8399902233, 6), 
(8399992233, 6), 
(8322334455, 7);


-- --------------------------------------------------
-- Insert Funcionario
-- --------------------------------------------------
INSERT INTO Funcionario (matriculaFuncionario, nomeFuncionario, cargoFuncionario, emailFuncionario, OrgaoPublico_idOrgaoPublico)
VALUES
('F001', 'João Silva', 'Tenente', 'joao.silva@policiamilitar.com', 1),
('F002', 'Maria Souza', 'Bombeiro', 'maria.souza@bombeiros.com', 2),
('F003', 'Pedro Santos', 'Agente de Proteção', 'pedro.santos@defesacivil.com', 3),
('F004', 'Ana Oliveira', 'Delegada', 'ana.oliveira@policiacivil.com', 4),
('F005', 'Carlos Mendes', 'Secretário', 'carlos.mendes@prefeitura.com', 5),
('F006', 'Lúcia Pereira', 'Meterologista', 'lucia.pereira@cruzvermelha.com', 6),
('F007', 'Paulo Costa', 'Guarda Municipal', 'paulo.costa@guardamunicipal.com', 7),
('F008', 'Marcos Oliveira', 'Soldado', 'marcos.oliveira@policiamilitar.com', 1), 
('F009', 'Rafaela Silva', 'Tenente', 'rafaela.silva@policiamilitar.com', 1), 
('F010', 'Gustavo Souza', 'Bombeiro', 'gustavo.souza@bombeiros.com', 2), 
('F011', 'Camila Santos', 'Agente de Proteção', 'camila.santos@defesacivil.com', 3),
('F012', 'Danilo Santos', 'Delegado', 'danilo.santos@delegaciapolicial.com', 4), 
('F013', 'Fernanda Almeida', 'Secretária', 'fernanda.almeida@prefeitura.com', 5), 
('F014', 'Mariana Oliveira', 'Meteorologista', 'mariana.oliveira@institutometeorologia.com', 6), 
('F015', 'Lucas Costa', 'Guarda Municipal', 'lucas.costa@guardamunicipal.com', 7);

-- --------------------------------------------------
-- Insert AlertaEmergencial
-- --------------------------------------------------
INSERT INTO AlertaEmergencial (descricaoAlerta, dataAlerta, Funcionario_idFuncionario)
VALUES
('Desaparecimento de criança em parque público', '2024-03-30', 1),
('Incêndio florestal em área montanhosa', '2024-03-30', 2),
('Desaparecimento de pessoa em área urbana', '2024-03-31', 3),
('Deslizamento de terra em zona rural', '2024-03-31', 4),
('Desaparecimento de idoso na região central', '2024-03-31', 5),
('Alerta de enchente em áreas ribeirinhas', '2024-03-31', 6),
('Desaparecimento de jovem em área residencial', '2024-04-1', 7),
('Risco de incêndio em região de vegetação densa', '2024-04-1', 1),
('Desaparecimento de mulher em local comercial', '2024-04-2', 2),
('Possível deslizamento de terra em encostas', '2024-04-2', 3),
('Desaparecimento de criança ', '2024-04-3', 4),
('Seca prolongada', '2024-04-3', 5),
('Desaparecimento de estudante universitario', '2024-04-4', 6),
('Alerta de tempestade em áreas de risco', '2024-04-4', 7),
('Rompimento de barragens na bacia hidrográfica', '2024-04-5', 1);

-- --------------------------------------------------
-- Insert EnderecoAlerta
-- --------------------------------------------------
INSERT INTO EnderecoAlerta (ruaAlerta, bairroAlerta, cidadeAlerta, estadoAlerta, CepAlerta, AlertaEmergencial_idAlertaEmergencial)
VALUES
('Rua da Esperança', 'Centro', 'Campina Grande', 'PB', 58410021, 1),
('Rua das Árvores', 'Catolé', 'Campina Grande', 'PB', 58420173, 2),
('Avenida da Liberdade', 'Ligeiro', 'Queimadas', 'PB', 58430082, 3),
('Rua do Comércio', 'Prata', 'Campina Grande', 'PB', 58440294, 4),
('Rua das Flores', 'Centro', 'Campina Grande', 'PB', 58450407, 5),
('Avenida Principal', 'Bodocongó', 'Campina Grande', 'PB', 58460550, 6),
('Rua da Lagoa', 'Centro', 'Lagoa Seca', 'PB', 58470691, 7),
('Rua da Paz', 'Centro', 'Queimadas', 'PB', 58480812, 8),
('Rua do Sol', 'São José', 'Campina Grande', 'PB', 58490923, 9),
('Rua da Felicidade', 'Bodocongó', 'Campina Grande', 'PB', 58501034, 10),
('Rua da Harmonia', 'Liberdade', 'Queimadas', 'PB', 58511145, 11),
('Rua da União', 'Catolé', 'Campina Grande', 'PB', 58521256, 12),
('Rua da Amizade', 'Bairro Novo', 'Queimadas', 'PB', 58531367, 13),
('Rua da Solidariedade', 'José Pinheiro', 'Campina Grande', 'PB', 58541478, 14),
('Rua da Justiça', 'Cruzeiro', 'Campina Grande', 'PB', 58551589, 15);

-- --------------------------------------------------
-- Insert AlertaDesaparecimento
-- --------------------------------------------------
INSERT INTO AlertaDesaparecimento (idAlertaDesaparecimento, idade, nomeDesaparecido, linkFoto, contatoEmergencia, AlertaEmergencial_idAlertaEmergencial)
VALUES
(1, 8, 'Lucas Silva', 'http://example.com/lucas.jpg', 83987654321, 1),
(2, 35, 'Ana Souza', 'http://example.com/ana.jpg', 83981234567, 3),
(3, 16, 'Mateus Santos', 'http://example.com/mateus.jpg', 83980123456, 7),
(4, 40, 'Isabela Oliveira', 'http://example.com/isabela.jpg', 83988776655, 9),
(5, 10, 'Pedro Costa', 'http://example.com/pedro.jpg', 83981122334, 11),
(6, 21, 'Mariana Pereira', 'http://example.com/mariana.jpg', 83980011223, 13),
(7, 76, 'Julia Lima', 'http://example.com/julia.jpg', 83984455667, 5);


-- --------------------------------------------------
-- Insert AlertaDesastreNatural
-- --------------------------------------------------
INSERT INTO AlertaDesastreNatural (idAlertsDesastreNatural, tipo, risco, AlertaEmergencial_idAlertaEmergencial)
VALUES
(1, 'Chuvas intensas e enchentes', 'Alto', 6), 
(2, 'Seca prolongada', 'Médio', 12), 
(3, 'Vendavais e tempestades ', 'Alto', 14), 
(4, 'Deslizamento de terra', 'Médio', 4), 
(5, 'Incêndios florestais', 'Alto', 8), 
(6, 'Deslizamento de terra', 'Médio', 10), 
(7, 'Incêndios florestais', 'Médio', 2), 
(8, 'Rompimento de barragens', 'Baixo', 15); 


-- ---------------------------------------------------
-- Quantos telefones tem o órgão público com o ID 1?
-- ---------------------------------------------------
SELECT orgao.nomeOrgaoPublico, COUNT(telefone.idTelefoneOrgao) AS total_telefones
FROM TelefoneOrgao AS telefone
JOIN OrgaoPublico AS orgao ON telefone.OrgaoPublico_idOrgaoPublico = orgao.idOrgaoPublico
WHERE telefone.OrgaoPublico_idOrgaoPublico = 1;


-- ---------------------------------------------------
-- Quantos alertas ocorreram em Campina Grande?
-- ---------------------------------------------------
SELECT COUNT(*) AS total_alertas
FROM AlertaEmergencial
JOIN EnderecoAlerta ON AlertaEmergencial.idAlertaEmergencial = EnderecoAlerta.AlertaEmergencial_idAlertaEmergencial
WHERE EnderecoAlerta.cidadeAlerta = 'Campina Grande';

-- ---------------------------------------------------
-- Qual o último alerta que ocorreu?
-- ---------------------------------------------------
SELECT *
FROM AlertaEmergencial
ORDER BY dataAlerta DESC
LIMIT 1;

-- ---------------------------------------------------
-- Em qual órgão Danilo trabalha?
-- ---------------------------------------------------
SELECT OrgaoPublico.*
FROM Funcionario
JOIN OrgaoPublico ON Funcionario.OrgaoPublico_idOrgaoPublico = OrgaoPublico.idOrgaoPublico
WHERE Funcionario.nomeFuncionario = 'Danilo Santos';

-- ---------------------------------------------------
-- Quantos alertas de desastre natural foram registrados?
-- ---------------------------------------------------
SELECT COUNT(*) AS total_alertas_desastre_natural
FROM AlertaDesastreNatural;

-- ---------------------------------------------------
-- Qual a matrícula de Danilo?
-- ---------------------------------------------------
SELECT matriculaFuncionario
FROM Funcionario
WHERE nomeFuncionario = 'Danilo Santos';

