PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    Identificação INTEGER PRIMARY KEY,
    Nome          STRING,
    Telefone      INTEGER CHECK (length(Telefone) = 9),
    Email         STRING  CHECK (email LIKE '%@%.%') 
);

DROP TABLE IF EXISTS Acompanhante;
CREATE TABLE Acompanhante (
    Identificação INTEGER PRIMARY KEY,
    Nome          STRING
);

DROP TABLE IF EXISTS Funcionario;
CREATE TABLE Funcionario (
    Identificação INTEGER,
    Nome          STRING,
    Telefone      INTEGER CHECK (length(Telefone) = 9),
    Email         STRING  CHECK (email LIKE '%@%.%'),
    NSS           INTEGER UNIQUE,
    Função        STRING,
    PRIMARY KEY (
        Identificação
    )
);

DROP TABLE IF EXISTS FuncionarioTerra;
CREATE TABLE FuncionarioTerra (
    idFuncionarioTerra INTEGER,
    idFuncionario        STRING,
    idAeroporto          STRING  REFERENCES Aeroporto (IATA),
    PRIMARY KEY (
        idFuncionarioTerra,
        idFuncionario
    ),

    CONSTRAINT fk_idFuncionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario (Identificação) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idAeroporto FOREIGN KEY (idAeroporto) REFERENCES Aeroporto (IATA) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS FuncionarioAr;
CREATE TABLE FuncionarioAr (
    idFuncionarioAr INTEGER,
    idFuncionario     INTEGER REFERENCES Funcionario (Identificação),
    PRIMARY KEY (
        idFuncionarioAr,
        idFuncionario
    ),

    CONSTRAINT fk_idFuncionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario (Identificação) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Aeroporto;
CREATE TABLE Aeroporto (
    IATA        STRING PRIMARY KEY,
    Localização STRING
);

DROP TABLE IF EXISTS Rota;
CREATE TABLE Rota (
    idRota  INTEGER PRIMARY KEY,
    partida INTEGER REFERENCES Aeroporto (IATA),
    chegada INTEGER REFERENCES Aeroporto (IATA),

    CONSTRAINT fk_idAeroporto_partida FOREIGN KEY (partida) REFERENCES Aeroporto (IATA) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idAeroporto_chegada FOREIGN KEY (chegada) REFERENCES Aeroporto (IATA) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE  IF EXISTS Aviao;
CREATE TABLE Aviao (
    idAviao     INTEGER PRIMARY KEY,
    Fabricante  STRING,
    Modelo      INTEGER,
    Matrícula   STRING  UNIQUE,
    Lotação     INTEGER,
    idAeroporto INTEGER REFERENCES Aeroporto (IATA),

    CONSTRAINT fk_idAeroporto FOREIGN KEY (idAeroporto) REFERENCES Aeroporto (IATA) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS Voo;
CREATE TABLE Voo (
    idVoo              INTEGER PRIMARY KEY,
    Designação         STRING,
    DuraçãodeVoo       INTEGER,
    Combustível        INTEGER CHECK (Combustível > 0),
    TaxaAeroportuárias INTEGER,
    idRota             INTEGER REFERENCES Rota (idRota),

    CONSTRAINT fk_idRota FOREIGN KEY (idRota) REFERENCES Rota (idRota) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS FuncionarioArVoo;
CREATE TABLE FuncionarioArVoo (
    idFuncionarioAr INTEGER,
    idFuncionario INTEGER,
    idVoo             INTEGER REFERENCES Voo (idVoo),
    PRIMARY KEY (
        idFuncionarioAr,
        idVoo
    ),

    CONSTRAINT fk_idVoo FOREIGN KEY (idVoo) REFERENCES Voo (idVoo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idAviao FOREIGN KEY ( idFuncionarioAr, idFuncionario ) REFERENCES FuncionarioAr( idFuncionarioAr, idFuncionario ) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS FuncionarioArAviao;
CREATE TABLE FuncionarioArAviao (
    idFuncionarioAr INTEGER,
    idFuncionario INTEGER,
    idAviao           INTEGER REFERENCES Aviao (idAviao),
    PRIMARY KEY (
        idFuncionarioAr,
        idAviao
    ),

    CONSTRAINT fk_idAviao FOREIGN KEY (idAviao) REFERENCES Aviao (idAviao) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idFuncionarioAr FOREIGN KEY ( idFuncionarioAr, idFuncionario ) REFERENCES FuncionarioAr( idFuncionarioAr, idFuncionario ) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS PassagemAerea;
CREATE TABLE PassagemAerea (
    NBilheteEletrónico INTEGER PRIMARY KEY,
    Tarifa             INTEGER,
    idCliente          INTEGER REFERENCES Cliente (Identificação),
    idAcompanhante     INTEGER REFERENCES Acompanhante (Identificação),

    CONSTRAINT fk_idCliente FOREIGN KEY (idCliente) REFERENCES Cliente (Identificação) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idAcompanhante FOREIGN KEY (idAcompanhante) REFERENCES Acompanhante (Identificação) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS DataDeVoo;
CREATE TABLE DataDeVoo (
    idPassagemAerea INTEGER REFERENCES PassagemAerea (NBilheteEletrónico),
    idVoo           INTEGER REFERENCES Voo (idVoo),
    DataDePartida   STRING,
    DataDeChegada   STRING,
    PRIMARY KEY (
        idPassagemAerea,
        idVoo
    ),

    CONSTRAINT fk_idPassagemAerea FOREIGN KEY (idPassagemAerea) REFERENCES PassagemAerea (NBilheteEletrónico) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idVoo FOREIGN KEY (idVoo) REFERENCES Voo (idVoo) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS VooAviao;
CREATE TABLE VooAviao (
    idVoo   INTEGER,
    idAviao INTEGER,
    PRIMARY KEY (
        idVoo,
        idAviao
    ),

    CONSTRAINT fk_idVoo FOREIGN KEY (idVoo) REFERENCES Voo (idVoo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_idAviao FOREIGN KEY (idAviao) REFERENCES Aviao (idAviao) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE  IF EXISTS SelfHandling;
CREATE TABLE SelfHandling (
    idSelfHandling INTEGER PRIMARY KEY,
    TipoDeServiço  STRING,
    idAeroporto    INTEGER NOT NULL,
    
    CONSTRAINT fk_idAeroporto FOREIGN KEY (idAeroporto) REFERENCES Aeroporto (IATA) ON DELETE CASCADE ON UPDATE CASCADE
);

---FIXED JRS
COMMIT TRANSACTION;
