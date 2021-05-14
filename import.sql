create table funcionarios_prefeitura_cargos (
    codigo int not null,
    nome varchar(200) not null,

    constraint pk_funcionarios_prefeitura_cargos
        primary key(codigo)
);

create table funcionarios_prefeitura (
    matricula int not null,
    nome varchar(200) not null,
    sexo varchar(1) not null,
    endereco varchar(200) not null,
    cargo int not null,
    data_admissao date not null,

    constraint pk_funcionarios_prefeitura
        primary key (matricula),

    constraint fk_funcionarios_prefeitura_cargos
        foreign key(cargo)
        references funcionarios_prefeitura_cargos(codigo)
);

create table funcionarios_prefeitura_telefones (
    matricula_funcionario int not null,
    telefone int not null,

    constraint pk_funcionarios_prefeitura_telefones
        primary key(matricula_funcionario, telefone),

    constraint fk_funcionarios_prefeitura_telefones
        foreign key(matricula_funcionario)
        references funcionarios_prefeitura(matricula_funcionario)
);

create table reunioes (
    codigo int not null,
    ocorrida_em date not null,

    constraint pk_reunioes primary key(codigo)
);

create table reunioes_participantes (
    codigo_reuniao int not null,
    matricula_participante int not null,

    constraint pk_reunioes_participantes
        primary key(codigo_reuniao, matricula_participante),

    constraint fk_reuniao
        foreign key(codigo_reuniao)
        references reunioes(codigo),

    constraint fk_participantes
        foreign key(matricula_participante)
        references funcionarios_prefeitura(matricula)
);

create table reunioes_obras_selecionadas (
    codigo_reuniao int not null,
    codigo_obra int not null,

    constraint pk_reunioes_participantes
        primary key(codigo_reuniao, codigo_obra),

    constraint fk_reuniao
        foreign key(codigo_reuniao)
        references reunioes(codigo),

    constraint fk_obra
        foreign key(codigo_obra)
        references obras(codigo)
);

create table construtoras (
    cnpj int not null,
    razao_social varchar(200) not null,
    endereco varchar(200) not null,
    nome varchar(200) not null,
    telefone_contato int not null,

    constraint pk_construtoras 
        primary key(cnpj)
);

create table obras_contratos_construtoras (
    numero_contrato int not null,
    construtora int not null,
    percentual_participacao decimal(8, 2) not null,

    constraint pk_obras_contratos_construtoras 
        primary key(numero_contrato, construtora),

    constraint fk_numero_contrato
        foreign key(numero_contrato)
        references obras_contratos(numero_contrato),

    constraint fk_construtora
        foreign key(construtora)
        references construtoras(cnpj)
);

create table associacoes_bairros_representantes (
    cpf int not null,
    rg int not null,
    nome varchar(200) not null,
    endereco varchar(200) not null,
    sexo varchar(1) not null,
    data_nascimento date not null,
    telefone_contato int not null,
    profissao varchar(200) not null,

    constraint pk_associacoes_bairros_representantes 
        primary key(cpf)
);

create table associacoes_bairros (
    codigo int not null,
    bairro varchar(200) not null,
    endereco varchar(200),
    representante int not null

    constraint pk_associacoes_bairros primary key (codigo),

    constraint fk_representante 
        foreign key(representante)
        references associacoes_bairros_representantes(cpf)
);

