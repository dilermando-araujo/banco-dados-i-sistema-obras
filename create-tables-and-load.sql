use db_obras;

-- criar tabelas

create table obras_segmentos (
	codigo int not null,
    nome varchar(200) not null,
    
    constraint pk_obras_segmentos 
        primary key(codigo)
);

create table obras_situacoes (
	codigo int not null,
    nome varchar(200) not null,
    
    constraint pk_obras_situacoes 
        primary key (codigo)
);

create table obras_niveis_prioridade (
	codigo int not null,
    nome varchar(200) not null,
    
    constraint pk_obras_niveis_prioridade 
        primary key (codigo)
);

create table engenheiros_especialidades (
	codigo int not null,
    nome varchar(200) not null,
    
    constraint pk_engenheiros_especialidade 
        primary key (codigo)
);

create table funcionarios_prefeitura_cargos (
    codigo int not null,
    nome varchar(200) not null,
    
    constraint pk_funcionarios_prefeitura_cargos
        primary key(codigo)
);

create table engenheiros (
	crea varchar(11) not null,
    nome varchar(200) not null,
    sexo varchar(1) not null,
    especialidade int not null,
    telefone_celular varchar(11),
   	telefone_residencial varchar(11),
    email varchar(200) not null,
    endereco_residencial varchar(200) not null,
    data_admissao_prefeitura date not null,
    
    constraint pk_engenheiros 
        primary key (crea),

    constraint fk_engenheiros_engenheiros_especialidades
        foreign key(especialidade)
        references engenheiros_especialidades(codigo)
);

create table associacoes_bairros_representantes (
    cpf varchar(12) not null,
    rg varchar(9) not null,
    nome varchar(200) not null,
    endereco varchar(200) not null,
    sexo varchar(1) not null,
    data_nascimento date not null,
    telefone_contato varchar(11) not null,
    profissao varchar(200) not null,

    constraint pk_associacoes_bairros_representantes 
        primary key(cpf)
);

create table associacoes_bairros (
    codigo int not null,
    bairro varchar(200) not null,
    endereco varchar(200),
    representante varchar(12) not null,

    constraint pk_associacoes_bairros 
        primary key(codigo),

    constraint fk_associacoes_bairros_associacoes_bairros_representantes
        foreign key(representante)
        references associacoes_bairros_representantes(cpf)
);

create table obras (
	codigo int not null,
    associacao_bairro_idealizadora int not null,
    engenheiro_responsavel varchar(11),
    segmento int not null,
    prioridade int not null,
    situacao int not null,
    descricao varchar(200) not null,
    data_previsao_inicio date not null,
    data_previsao_termino date not null,
    valor_estimado decimal(18,2) not null,
    
    constraint pk_obras 
        primary key (codigo),

    constraint fk_obras_engenheiros
        foreign key (engenheiro_responsavel)
        references engenheiros(crea),

    constraint fk_obras_obras_segmentos
        foreign key (segmento)
        references obras_segmentos(codigo),

    constraint fk_obras_obras_niveis_prioridade
        foreign key (prioridade)
        references obras_niveis_prioridade(codigo),

    constraint fk_obras_obras_situacoes
        foreign key (situacao)
        references obras_situacoes(codigo),

    constraint fk_obras_associacoes_bairros
        foreign key (associacao_bairro_idealizadora)
        references associacoes_bairros(codigo)
);

create table obras_ocorrencias (
	codigo int not null,
    obra int not null,
    ocorrida_em datetime not null,
    descricao varchar(200) not null,
    
    constraint pk_obras_ocorrencias 
        primary key (codigo),

    constraint fk_obras_ocorrencias_obras
        foreign key (obra)
        references obras(codigo)
);

create table obras_vistorias (
	codigo int not null,
    obra int not null,
    engenheiro_responsavel varchar(11) not null,
    realizada_em date not null,
    percentual_esperado decimal(10,2) not null,
    percentual_realizado decimal(10,2) not null,
	
    constraint pk_obras_vistorias 
        primary key (codigo),

    constraint fk_obras_vistorias_obras
        foreign key (obra)
        references obras(codigo),

    constraint fk_obras_vistorias_engenheiros
        foreign key (engenheiro_responsavel)
        references engenheiros(crea)
);

create table obras_vistorias_inconformidades (
	codigo int not null,
    vistoria int not null,
    descricao varchar(200) not null,
    
    constraint pk_obras_vistorias_inconformidades 
        primary key (codigo),

    constraint fk_obras_vistorias_inconformidades_obras_vistorias
        foreign key (vistoria)
        references obras_vistorias(codigo)
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

    constraint fk_funcionarios_prefeitura_funcionarios_prefeitura_cargos
        foreign key(cargo)
        references funcionarios_prefeitura_cargos(codigo)
);

create table funcionarios_prefeitura_telefones (
    matricula_funcionario int not null,
    telefone varchar(11) not null,

    constraint pk_funcionarios_prefeitura_telefones
        primary key(matricula_funcionario, telefone),

    constraint fk_funcionarios_prefeitura_telefones_funcionarios_prefeitura
        foreign key(matricula_funcionario)
        references funcionarios_prefeitura(matricula)
);

create table reunioes (
    codigo int not null,
    ocorrida_em date not null,

    constraint pk_reunioes 
        primary key (codigo)
);

create table reunioes_participantes (
    codigo_reuniao int not null,
    matricula_participante int not null,

    constraint pk_reunioes_participantes
        primary key (codigo_reuniao, matricula_participante),

    constraint fk_reunioes_participantes_reunioes
        foreign key (codigo_reuniao)
        references reunioes(codigo),

    constraint fk_reunioes_participantes_funcionarios_prefeitura
        foreign key (matricula_participante)
        references funcionarios_prefeitura(matricula)
);

create table reunioes_obras_selecionadas (
    codigo_reuniao int not null,
    codigo_obra int not null,

    constraint pk_reunioes_obras_selecionadas
        primary key (codigo_reuniao, codigo_obra),

    constraint fk_reunioes_obras_selecionadas_reunioes
        foreign key(codigo_reuniao)
        references reunioes(codigo),

    constraint fk_reunioes_obras_selecionadas_obras
        foreign key(codigo_obra)
        references obras(codigo)
);

create table construtoras (
    cnpj varchar(14) not null,
    razao_social varchar(200) not null,
    endereco varchar(200) not null,
    nome varchar(200) not null,
    telefone_contato varchar(11) not null,

    constraint pk_construtoras 
        primary key(cnpj)
);

create table obras_contratos (
    numero_contrato int not null,
    obra int not null,
    
    constraint pk_obras_contratos 
        primary key (numero_contrato, obra),
  
    constraint fk_obras_contratos_obras
        foreign key (obra)
        references obras(codigo)
);

create table obras_contratos_construtoras (
    numero_contrato int not null,
    construtora varchar(14) not null,
    percentual_participacao decimal(8, 2) not null,

    constraint pk_obras_contratos_construtoras 
        primary key(numero_contrato, construtora),

    constraint fk_obras_contratos_construtoras_obras_contratos
        foreign key(numero_contrato)
        references obras_contratos(numero_contrato),

    constraint fk_obras_contratos_construtoras
        foreign key(construtora)
        references construtoras(cnpj)
);

-- popular as tabelas

insert into funcionarios_prefeitura_cargos (codigo, nome) values (1, 'Analista de Projetos de Obras');
insert into funcionarios_prefeitura_cargos (codigo, nome) values (2, 'Assistente de Processamento de Dados');
insert into funcionarios_prefeitura_cargos (codigo, nome) values (3, 'Administrador');
insert into funcionarios_prefeitura_cargos (codigo, nome) values (4, 'Arquivista');

insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (1,'Leonel Farinha Sá', 'M', 'Rua A', 1, '2001/06/10');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (2,'Matias Cisneiros Poças', 'M', 'Rua B', 2, '2001/06/10');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (3,'Marcelino Reino Cortesão', 'M', 'Rua 26', 1, '2002/05/08');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (4,'Suely Lários Botica', 'F', 'Rua B', 3, '2003/05/01');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (5,'Haniel Malho Condorcet', 'M', 'Avenida Val Paraiso', 1, '2014/01/10');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (6,'Luena Marinho Goulão', 'F', 'Rua 375', 1, '2016/03/15');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (7,'Raquel de Souza Ferreira', 'F', 'Rua 03', 2, '2016/04/20');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (8,'Nalini Barreto César', 'F', 'Avenida C', 1, '2017/04/20');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (9,'Eliana Bernardes Almada', 'F', 'Rua 02', 3, '2017/10/10');
insert into funcionarios_prefeitura (matricula, nome, sexo, endereco, cargo, data_admissao) values (10,'Guilherme dos Anges Pereira', 'M', 'Rua 05', 4, '2017/10/10');

insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (1, '85999235632');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (2, '85999432108');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (3, '85986332214');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (4, '85986123412');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (5, '85996123456');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (6, '85986422114');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (7, '85986332290');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (8, '85986123212');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (9, '85999112200');
insert into funcionarios_prefeitura_telefones (matricula_funcionario, telefone) values (10, '85988112233');

insert into associacoes_bairros_representantes (cpf, rg, nome, endereco, sexo, data_nascimento, telefone_contato, profissao) values ('08126460377', '414379639', 'Olivia Marli Fogaça', 'Rua D', 'F', '1967/02/20', '85985914977', 'Programadora');
insert into associacoes_bairros_representantes (cpf, rg, nome, endereco, sexo, data_nascimento, telefone_contato, profissao) values ('93317384395', '420891948', 'Adriana Pietra Melo', 'Rua 1', 'F', '1988/04/04', '85982798905', 'Design');
insert into associacoes_bairros_representantes (cpf, rg, nome, endereco, sexo, data_nascimento, telefone_contato, profissao) values ('58538428381', '450258336', 'Manuela Renata Marli Porto', 'Rua Germano Franck', 'F', '1981/01/01', '85999938071', 'Artista');
insert into associacoes_bairros_representantes (cpf, rg, nome, endereco, sexo, data_nascimento, telefone_contato, profissao) values ('90193991365', '175108031', 'Ana Elisa Rodrigues', 'Vila Dom Vital', 'F', '1979/05/06', '85983446908', 'Enfermeira');
insert into associacoes_bairros_representantes (cpf, rg, nome, endereco, sexo, data_nascimento, telefone_contato, profissao) values ('31885476337', '256548687', 'Benedito Hugo Gabriel Freitas', 'Rua Ímpar', 'M', '1973/02/13', '85991307182', 'Professor');

insert into associacoes_bairros (codigo, bairro, endereco, representante) values (1, 'Jangurussu', 'Rua 44', '08126460377');
insert into associacoes_bairros (codigo, bairro, endereco, representante) values (2, 'Parque Dois Irmãos', 'Av. Dois', '93317384395');
insert into associacoes_bairros (codigo, bairro, endereco, representante) values (3, 'Parangaba', 'R. Perdigão de Oliveira', '58538428381');
insert into associacoes_bairros (codigo, bairro, endereco, representante) values (4, 'Conjunto Palmeiras', 'R. Teresa Bernardes', '90193991365');
insert into associacoes_bairros (codigo, bairro, endereco, representante) values (5, 'Álvaro Weyne', 'Av. Francisco Sá', '31885476337');

insert into construtoras (cnpj, razao_social, endereco, nome, telefone_contato) values ('67689286000135', 'Construfor', 'Alameda 1', 'Construfor', '85996142895');
insert into construtoras (cnpj, razao_social, endereco, nome, telefone_contato) values ('52894645000119', 'Fortbuild', 'Alameda 2', 'Fortbuild', '8534751296');
insert into construtoras (cnpj, razao_social, endereco, nome, telefone_contato) values ('04999585000156', 'Fortjolo', 'Alameda 3', 'Fortjolo', '85994753248');
insert into construtoras (cnpj, razao_social, endereco, nome, telefone_contato) values ('24225360000150', 'Construtora Araújo', 'Alameda 4', 'Construtora Araújo', '85996543275');
insert into construtoras (cnpj, razao_social, endereco, nome, telefone_contato) values ('25658093000177', 'Premium Construções', 'Alameda 5', 'Premium Construções', '8536759826');

insert into obras_niveis_prioridade (codigo, nome) values (1, 'Baixo');
insert into obras_niveis_prioridade (codigo, nome) values (2, 'Médio');
insert into obras_niveis_prioridade (codigo, nome) values (3, 'Alto');

insert into obras_segmentos (codigo, nome) values (1, 'Comércio');
insert into obras_segmentos (codigo, nome) values (2, 'Saúde');
insert into obras_segmentos (codigo, nome) values (3, 'Infraestrutura');
insert into obras_segmentos (codigo, nome) values (4, 'Residencial');
insert into obras_segmentos (codigo, nome) values (5, 'Lazer');

insert into obras_situacoes (codigo, nome) values (1, 'Suspensa');
insert into obras_situacoes (codigo, nome) values (2, 'Sugerida');
insert into obras_situacoes (codigo, nome) values (3, 'Aprovada');
insert into obras_situacoes (codigo, nome) values (4, 'Em execução');
insert into obras_situacoes (codigo, nome) values (5, 'Concluída');

insert into engenheiros_especialidades (codigo, nome) values (1, 'Construção urbana');
insert into engenheiros_especialidades (codigo, nome) values (2, 'Materiais de construção');
insert into engenheiros_especialidades (codigo, nome) values (3, 'Geotecnia');
insert into engenheiros_especialidades (codigo, nome) values (4, 'Infraestrutura e transporte');
insert into engenheiros_especialidades (codigo, nome) values (5, 'Cálculo estrutural');
insert into engenheiros_especialidades (codigo, nome) values (6, 'Saneamento');
insert into engenheiros_especialidades (codigo, nome) values (7, 'Hidráulica');
insert into engenheiros_especialidades (codigo, nome) values (8, 'Segurança do trabalho');
insert into engenheiros_especialidades (codigo, nome) values (9, 'Gestão de projetos');
insert into engenheiros_especialidades (codigo, nome) values (10, 'Sustentabilidade');
insert into engenheiros_especialidades (codigo, nome) values (11, 'Auditoria');
insert into engenheiros_especialidades (codigo, nome) values (12, 'Engenharia de custos');

insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000001-0', 'João Lucas Edson Bernardes', 'M', 9, '8526440709', '85994987866', 'joaolucasedsonbernardes-79@gmail.com', 'Rua Ernesto Igel', '2001/01/10');
insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000002-0', 'Daniela Alice Josefa Barbosa', 'F', 8, '8537302719', '85994640017', 'danielaalicejosefabarbosa-83@gmail.com', 'Rua T', '2001/01/10');
insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000003-0', 'Lucca Nathan Felipe Moura', 'M', 11, '8527653062', '85986647602', 'luccanathanfelipemoura-78@hotmail.com', 'Avenida Mister Hull', '2002/05/10');
insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000004-0', 'Breno Paulo Benício Carvalho', 'M', 11, '8526938012', '85992273169', 'bbrenopaulobeniciocarvalho@yahoo.com', 'Rua 531', '2003/06/08');
insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000005-0', 'Renata Alessandra Catarina da Rocha', 'F', 9, '8526045137', '85994283059', 'rrenataalessandracatarinadarocha@gmail.com', 'Travessa Bengui', '2005/04/01');
insert into engenheiros (crea, nome, sexo, especialidade, telefone_celular, telefone_residencial, email, endereco_residencial, data_admissao_prefeitura) value ('000000006-0', 'Daniela Letícia da Rosa', 'F', 5, '8539922424', '85987707117', 'danielaleticiadarosa-76@gmail.com', 'Rua de Pedestre 3', '2013/03/20');

insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values (1, 2, '000000001-0', 2, 1, 5, 'Areninha', '2020-09-21', '2021-07-15', 18000);
insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values (2, 3, '000000005-0', 2, 1, 4, 'Posto de Saúde', '2020-09-25', '2021-07-25', 80000);
insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values (3, 5, '000000006-0', 4, 2, 1, 'Apartamento', '2021-01-30', '2021-10-30', 500000000);
insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values (4, 1, '000000002-0', 3, 1, 4, 'Clínica Geral', '2021-03-15', '2022-04-10', 50000);
insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values (5, 1, null, 1, 3, 2, 'Loja de sapatos', '2021-06-12', '2021-11-12', 25000);
insert into obras (codigo, associacao_bairro_idealizadora, engenheiro_responsavel, segmento, prioridade, situacao, descricao, data_previsao_inicio, data_previsao_termino, valor_estimado) values(6, 4, null, 5, 2, 2, 'Boardwalk', '2021-03-10', '2021-11-10', 150000);

insert into reunioes (codigo, ocorrida_em) values (1, '2020/06/01');
insert into reunioes (codigo, ocorrida_em) values (2, '2020/11/10');

insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (1, 1);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (1, 3);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (1, 4);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (2, 1);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (2, 2);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (2, 8);
insert into reunioes_participantes (codigo_reuniao, matricula_participante) values (2, 9);

insert into reunioes_obras_selecionadas (codigo_reuniao, codigo_obra) values (1, 1);
insert into reunioes_obras_selecionadas (codigo_reuniao, codigo_obra) values (1, 2);
insert into reunioes_obras_selecionadas (codigo_reuniao, codigo_obra) values (2, 1);
insert into reunioes_obras_selecionadas (codigo_reuniao, codigo_obra) values (2, 2);

insert into obras_contratos (numero_contrato, obra) values (1, 1);
insert into obras_contratos (numero_contrato, obra) values (2, 2);
insert into obras_contratos (numero_contrato, obra) values (3, 3);
insert into obras_contratos (numero_contrato, obra) values (4, 4);

insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (1, '04999585000156', 20);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (1, '24225360000150', 80);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (2, '24225360000150', 60);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (2, '67689286000135', 20);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (2, '25658093000177', 20);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (3, '52894645000119', 50);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (3, '25658093000177', 50);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (4, '04999585000156', 30);
insert into obras_contratos_construtoras (numero_contrato, construtora, percentual_participacao) values (4, '24225360000150', 70);

insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (1, 1, '000000004-0', '2021-04-01', 50.00, 50.00);
insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (2, 1, '000000003-0', '2021-06-28', 80.00, 70.00);
insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (3, 2, '000000003-0', '2020-12-12', 25.00, 25.00);
insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (4, 2, '000000004-0', '2021-05-28', 80.00, 80.00);
insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (5, 3, '000000003-0', '2021-03-30', 25.00, 10.00);
insert into obras_vistorias (codigo, obra, engenheiro_responsavel, realizada_em, percentual_esperado, percentual_realizado) values (6, 4, '000000002-0', '2021-05-15', 30.00, 40.00);

insert into obras_vistorias_inconformidades (codigo, vistoria, descricao) values (1, 1, 'Falta de materiais de segurança adequados para os operários');
insert into obras_vistorias_inconformidades (codigo, vistoria, descricao) values (2, 3, 'Problemas de vazamento nos níveis superiores');
insert into obras_vistorias_inconformidades (codigo, vistoria, descricao) values (3, 3, 'Aparelhos de segurança dos funcionários insuficiente');
insert into obras_vistorias_inconformidades (codigo, vistoria, descricao) values (4, 3, 'Utilização de materiais para a construção de baixa qualidade');

insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (1, 1, '2021-02-09', 'Aplicada a primeira demão de tinta nas paredes');
insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (2, 1, '2021-03-26', 'Aplicação dos ladrilhos');
insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (3, 2, '2021-03-12', 'Construídas as paredes da obra');
insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (4, 2, '2021-05-27', 'Finalizada a laje para o segundo andar');
insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (5, 3, '2020-12-24', 'Finalização do telhado e aplicação de telhas');
insert into obras_ocorrencias (codigo, obra, ocorrida_em, descricao) values (6, 4, '2021-04-27', 'Impermeabilização das áreas molhadas');
