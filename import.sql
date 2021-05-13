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
