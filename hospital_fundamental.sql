-- drop database hospital
-- create database Hospital
-- use Hospital;

create table Pacientes (
 id_paciente int auto_increment primary key,
 nome_paciente varchar(50) not null,
 sexo_paciente char(1),
 data_nascimento_paciente date not null,
 cpf_paciente varchar(11) not null,
 rg_paciente varchar(9) not null,
 estado_moradia_paciente varchar(2) not null,
 cidade_moradia_paciente varchar(50) not null,
 bairro_moradia_paciente varchar(50) not null,
 logradouro_paciente varchar(50) not null,
 logradouro_paciente_numero varchar(4) not null,
 cep_paciente varchar(8) not null,
 telefone_paciente varchar(15) not null,
 email_paciente varchar(30) not null
);

create table Convenio (
 id_convenio int primary key auto_increment,
 id_paciente int not null,
 cobertura_convenio varchar(20),
 cnpj_empresa_paciente varchar(18) not null,
 id_empresa_convenio int not null
);

create table Empresa_convenio (
 id_empresa_convenio int primary key auto_increment,
 nome_empresa_convenio varchar(50),
 tempo_carencia varchar(50) not null
);

create table Consulta (
 id_consulta int primary key auto_increment,
 valor_consulta decimal(8, 2) not null,
 id_medico int not null,
 id_paciente int not null,
 data_consulta date not null,
 hora_consulta time not null,
 id_convenio int default 0,
 id_receita int default 0
);

create table Receita (
 id_receita int auto_increment primary key,
 medicamento varchar(30),
 data_emicao date not null,
 data_expiracao date not null
);

create table Medico (
 id_medico int primary key auto_increment,
 nome_medico varchar(30),
 sexo_medico char(1),
 salario_medico decimal(8, 2),
 id_especialidade int not null,
 id_posicao int not null
);

create table Especialidades (
 id_especialidade int primary key auto_increment,
 nome_especialidade varchar(55),
 min_salario decimal (8, 2) default null,
 max_salario decimal (8, 2) default null
);

create table Posicao (
 id_posicao int auto_increment primary key,
 nome_posicao varchar(35) not null
);

create table Internacao (
 id_internacao int auto_increment primary key,
 id_consulta int not null,
 id_quarto int not null,
 id_procedimento int not null,
 data_entrada date not null,
 data_prevista_alta date not null,
 data_alta date not null,
 observacoes text
);

create table Procedimento (
 id_procedimento int auto_increment primary key,
 nome_procedimento varchar(55),
 tempo_aproximado_duracao varchar(30)
);

create table Quarto (
 id_quarto int auto_increment primary key,
 id_enfermeiro int not null,
 numero_quarto int not null,
 id_tipo int
);

create table tipo_quarto (
 id_tipo int auto_increment primary key,
 descricao_tipo varchar(55),
 valor_tipo_quarto decimal(8, 2) not null
);

create table Enfermeiro (
 id_enfermeiro int auto_increment primary key,
 nome_enfermeiro varchar(55) not null,
 cpf_enfermeiro varchar(11) unique not null,
 cre_enfermeiro varchar(8) not null
);

-- Convenio
alter table Convenio add foreign key(id_paciente) references Pacientes(id_paciente);
alter table Convenio add foreign key(id_empresa_convenio) references Empresa_convenio(id_empresa_convenio);

-- Consulta
alter table Consulta add foreign key(id_medico) references Medico(id_medico);
alter table Consulta add foreign key(id_paciente) references Pacientes(id_paciente);
alter table Consulta add foreign key(id_convenio) references Convenio(id_convenio);
alter table Consulta add foreign key(id_receita) references Receita(id_receita);

-- Medico
alter table Medico add foreign key(id_especialidade) references Especialidades(id_especialidade);
alter table Medico add foreign key(id_posicao) references Posicao(id_posicao);

-- Internacao
alter table Internacao add foreign key(id_consulta) references Consulta(id_consulta);
alter table Internacao add foreign key(id_quarto) references Quarto(id_quarto);
alter table Internacao add foreign key(id_procedimento) references Procedimento(id_procedimento);

-- Quarto
alter table Quarto add foreign key (id_tipo) references tipo_quarto(id_tipo);
alter table Quarto add foreign key (id_enfermeiro) references Enfermeiro(id_enfermeiro);

-- select * from Especialidades;
insert into Especialidades values (1, 'Pediatria', 7000.00, 13000.00),
(2, 'Clínica Geral', 7900.00, 13800.00),
(3, 'Gastroenterologia', 5400.00, 11200.00),
(4, 'Dermatologia', 5200.00, 13800.00),
(5, 'Ginecologia', 5200.00, 14400.00),
(6, 'Cardiologia', 8400.00, 12100.00),
(7, 'Psiquiatria', 7500.00, 16500.00);

-- select * from Posicao;
insert into Posicao values (1, 'Generalistas'), (2, 'Especialistas'), (3, 'Residentes');

-- select * from Medico;
insert into Medico values (1, 'Ryan Barros', 'M', 12542.00, 1, 1),
(2, 'Ryan Barros', 'M', 8520.00, 1, 2),
(3, 'Kamilly Porto', 'F', 7123.00, 1, 3),
(4, 'Cecília Barbosa', 'F', 13750.00, 2, 1),
(5, 'Pedro Monteiro', 'M', 10210.00, 2, 2),
(6, 'Luana Peixoto', 'F', 8120.00, 2, 3),
(7, 'Maria Clara Gomes', 'F', 11145.00, 3, 1),
(8, 'Luna Silva', 'F', 7423.00, 3, 2),
(9, 'Davi Lucca da Costa', 'M', 4103.00, 3, 3),
(10, 'Maria Pires', 'F', 13754.00, 4, 1),
(11, 'Carlos Eduardo Rocha', 'M', 10654.00, 4, 2),
(12, 'Maria Fernanda Ferreira', 'F', 6458.00, 4, 3),
(13, 'Nathan da Costa', 'M', 14320.00, 5, 1),
(14, 'Pedro Miguel Costela', 'M', 7845.00, 5, 2),
(15, 'Luana Cavalcanti', 'F', 5720.00, 5, 3),
(16, 'Vitória Peixoto', 'F', 11254.00, 6, 1),
(17, 'Lívia Pinto', 'F', 9865.00, 6, 2),
(18, 'Vitor Gabriel da Mota', 'M', 8954.00, 6, 3),
(19, 'Mirella Teixeira', 'F', 15899.00, 7, 1),
(20, 'Mirella Duarte', 'F', 10489.00, 7, 2),
(21, 'Pedro Henrique Azevedo', 'M', 8678.00, 7, 3),
(22, 'Natália Barbosa', 'F', 14569.00, 7, 1);

-- select * from Pacientes;
insert into Pacientes values (1, 'Maria Eduarda Araújo', 'F', '2000-01-20', '21184627860', '30968674X', 'SP', 'São Paulo', 'Mooca', 'Rua Livia', 542, '39561674', '(11) 93333-1693', 'presentacion5292@uorak.com'),
(2, 'Maria Clara Nascimento', 'F', '1978-05-23', '43134633728', '329245430', 'ES', 'São Mateus', 'Guriri Norte', 'Avenida Esbertalina Barbosa Damiani', 1256, '29946490', '(11) 93811-4658', 'vashti2632@uorak.com'),
(3, 'Emilly Gonçalves', 'F', '1997-03-16', '48960351512', '486500561', 'SP', 'São Paulo', 'Parque Imperial', 'Rua Paracatu', 154, '04302021', '(11) 92654-7603', 'deivis7818@uorak.com'),
(4, 'Lucca Campos', 'M', '1968-08-23', '78563944630', '246365663', 'RJ', 'Campos dos Goytacazes', 'Centro', 'Rua Tenente-Coronel Cardoso', 25, '28035042', '(11) 93385-9287', 'zhana8671@uorak.com'),
(5, 'Isadora Silveira', 'F', '1976-06-12', '30765446596', '458874425', 'SP', 'Jundiaí', 'Vila Joana', 'Avenida São João', 289, '13216000', '(11) 92650-8731', 'severin4078@uorak.com'),
(6, 'Milena Ramos', 'F', '1984-12-04', '52254182528', '205582734', 'PI', 'Teresina', 'Centro', 'Rua Arlindo Nogueira', 45, '64000290', '(11) 92050-6263', 'jianwei6838@uorak.com'),
(7, 'Calebe Pires', 'M', '1958-01-18', '41541137477', '382842959', 'PR', 'Cornélio Procópio', 'Capota', 'Aquino', 245, '86300000', '(11) 92113-2806', 'xiaofen5213@uorak.com'),
(8, 'Ana Júlia Oliveira', 'F', '1960-05-17', '16485679162', '271129396', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua das Fiandeiras', 324, '04545005', '(11) 93534-2834', 'jiandong5989@uorak.com'),
(9, 'Kaique Correia', 'M', '1992-07-19', '16485679162', '377754936', 'SP', 'Diadema', 'Casa Grande', 'Rua Barão de Vitória', 658, '09961660', '(11) 92222-8480', 'asceneth5937@uorak.com'),
(10, 'Camila Freitas', 'F', '1962-12-11', '55586264374', '155306212', 'RS', 'Rio Grande', 'Zona Portuária', 'Avenida Almirante Maximiano Fonseca', 10, '96204040', '(11) 92783-0241', 'sadika5201@uorak.com'),
(11, 'Maria Fernanda Peixoto', 'F', '1999-12-30', '29691152207', '264139562', 'PR', 'Curitiba', 'Bom Retiro', 'Rua Carlos Augusto Cornelsen', 127, '80520560', '(11) 92008-2155', 'idolina1454@uorak.com'),
(12, 'Igor Barbosa', 'M', '2002-09-25', '26412118071', '117205758', 'PI', 'Teresina', 'Centro', 'Rua Arlindo Nogueira', 165, '64000290', '(11) 92234-0029', 'sean4988@uorak.com'),
(13, 'Isadora da Cruz', 'F', '1997-04-09', '46386549163', '212122253', 'SP', 'Cotia', 'Lageadinho', 'Rodovia Raposo Tavares', 846, '06709015', '(11) 92752-2435', 'wladimir7566@uorak.com'),
(14, 'Melissa Jesus', 'F', '1980-02-12', '18671750531', '18826355X', 'PI', 'Teresina', 'Centro', 'Rua Arlindo Nogueira', 02, '64000290', '(11) 93527-6835', 'petar8873@uorak.com'),
(15, 'Alícia da Luz', 'F', '1990-06-14', '33959382049', '389131635', 'MS', 'Campo Grande', 'Monte Castelo', 'Rua da Imprensa', 32, '79002290', '(11) 93363-6058', 'anuta8421@uorak.com'),
(16, 'Alcimar da Silva', 'M', '1992-06-15', '33915302049', '393031635', 'SP', 'Campo Grande', 'Monte Castelo', 'Rua da Imprensa', 30, '79002290', '(11) 90963-6788', 'hamilto6924@uorak.com'),
(17, 'Jussara Camargo', 'F', '1985-02-23', '01559382849', '379169835', 'PI', 'Teresina', 'Centro', 'Rua Arlindo Nogueira', 589, '64000290', '(11) 93215-6758', 'graus4596@uorak.com'),
(18, 'Henrique Brito', 'M', '1999-02-03', '99951896349', '303605635', 'RJ', 'Campos dos Goytacazes', 'Centro', 'Rua Tenente-Coronel Cardoso', 789, '28035042', '(11) 93763-8958', 'henri5684@uorak.com'),
(19, 'Fabricio Melo', 'M', '2000-06-19', '31596785049', '389131569', 'SP', 'Vila Olímpia', 'Frederico Garcia', 'Rua dos impurtunaz', 15, '15982290', '(11) 99623-4858', 'fafa8921@uorak.com'),
(20, 'Cristiano Santos', 'M', '1994-12-21', '49916987049', '169845692', 'RJ', 'Volta Redonda', 'Praça Brasil', 'Rua da doninha', 587, '16895103', '(11) 96521-6058', 'cris98562@uorak.com');

-- select * from Receita;
insert into Receita values (1, 'Alectinibe', '2022-02-05', '2022-03-05'),
(2, 'Baricitinibe', '2022-02-05', '2022-03-05'),
(3, 'Brexpiprazol', '2022-02-05', '2022-03-05'),
(4, 'Ledipasvir', '2022-02-05', '2022-03-05'),
(5, 'Rasagilina', '2022-02-05', '2022-03-05'),
(6, 'Tinidazol', '2022-02-05', '2022-03-05'),
(7, 'Mefobarbital', '2022-02-05', '2022-03-05'),
(8, 'Sargramostim', '2022-02-05', '2022-03-05'),
(9, 'Iodeto de ecotiofato', '2022-02-05', '2022-03-05'),
(10, 'Ergonovina', '2022-02-05', '2022-03-05'),
(11, 'Fluocinonida', '2022-02-05', '2022-03-05'),
(12, 'Desloratadina', '2022-02-05', '2022-03-05'),
(13, 'Cicloserina', '2022-02-05', '2022-03-05'),
(14, 'Pancurônio', '2022-02-05', '2022-03-05'),
(15, 'Oprelvecina', '2022-02-05', '2022-03-05'),
(16, 'Moxifloxacino', '2022-02-05', '2022-03-05'),
(17, 'Pravastatina', '2022-02-05', '2022-03-05'),
(18, 'Clobazam', '2022-02-05', '2022-03-05'),
(19, 'Sulfassalazina', '2022-02-05', '2022-03-05'),
(20, 'Doxepina', '2022-02-05', '2022-03-05');

-- select * from empresa_convenio
insert into Empresa_convenio values (1, 'SulAmérica', '2 meses'), 
(2, 'NotreDame Intermédica', '3 meses'), 
(3, 'Prevent Senior', '1 mês'), 
(4, 'Assim Saúde', '5 meses'), 
(5, 'entral Nacional Unimed (CNU)', '4 meses'), 
(6, 'GreenLine Sistema de Saúde', '2 meses'), 
(7, 'Bradesco Seguros', '5 meses'), 
(8, 'Hapvida Saúde', '3 meses'), 
(9, 'São Francisco Saúde', '6 meses'), 
(10, 'Amil Assistência Médica', '4 meses');

-- select * from Convenio;
insert into Convenio value (1, 1, 'Total', '14.844.732/0001-72', 1),
(2, 2, 'Total', '22.785.125/0001-07', 2),
(3, 3, 'Total', '25.585.386/0001-71', 3),
(4, 4, 'Total', '53.335.618/0001-79', 6),
(5, 5, 'Total', '70.778.685/0001-87', 7),
(6, 6, 'Total', '22.822.635/0001-07', 8),
(7, 7, 'Total', '37.070.777/0001-32', 9),
(8, 8, 'Total', '12.291.839/0001-05', 10),
(9, 9, 'Total', '76.675.227/0001-07', 4),
(10, 10, 'Total', '51.803.286/0001-84', 5),
(11, 11, 'Total', '29.501.132/0001-89', 3),
(12, 12, 'Total', '05.581.296/0001-03', 9),
(13, 13, 'Total', '27.888.026/0001-74', 10),
(14, 14, 'Total', '53.278.023/0001-29', 5),
(15, 15, 'Total', '70.276.035/0001-33', 8),
(16, 16, 'Total', '51.803.286/0001-84', 5),
(17, 17, 'Total', '12.291.839/0001-05', 10),
(18, 18, 'Total', '25.585.386/0001-71', 3),
(19, 19, 'Total', '53.278.023/0001-29', 5),
(20, 20, 'Total', '76.675.227/0001-07', 4);

-- select * from Procedimento;
insert into Procedimento values (1, 'Cirurgia eletiva', 'Pode variar de 2 à 5 horas'),
(2, 'Cirurgia de urgência', 'Pode variar de 2 à 8 horas'),
(3, 'Cirurgia de emergência', 'Pode variar de 2 à 14 horas');

-- select * from tipo_quarto;
insert into tipo_quarto values(1, 'Quarto coletivo ou enfermaria', 250.00),
(2, 'Exclusivo com banheiro particular', 500.00),
(3, 'Presidencial (Para pacientes VIP)', 1500.00);

-- select * from Enfermeiro;
insert into Enfermeiro values(1, 'Evelyn Oliveira', '17453176352', '264896SP'), 
(2, 'Ana Sophia Teixeira', '92767122161', '175692SP'), 
(3, 'Gustavo Lopes', '12221312260', '318960SP');

-- select * from Quarto;
insert into Quarto values(1, 1, 10, 1), (2, 1, 11, 1), (3, 2, 12, 2), (4, 2, 13, 3), (5, 3, 14, 3);

-- select * from Consulta;
insert into Consulta value (1, 210.00, 19, 1, '2022-02-05', '09:00:00', 1, 1),
(2, 124.00, 2, 2, '2022-02-05', '09:30:00', 2, 2),
(3, 245.00, 15, 3, '2022-02-05', '07:30:00', 3, 3),
(4, 136.00, 9, 4, '2022-02-05', '08:00:00', 4, 4),
(5, 210.00, 16, 5, '2022-02-05', '10:00:00', 5, 5),
(6, 489.00, 19, 6, '2022-02-05', '10:30:00', 6, 6),
(7, 154.00, 21, 7, '2022-02-05', '11:00:00', 7, 7),
(8, 345.00, 6, 8, '2022-02-05', '12:00:00', 8, 8),
(9, 123.00, 7, 9, '2022-02-05', '12:00:00', 9, 9),
(10, 210.00, 14, 10, '2022-02-05', '13:00:00', 10, 10),
(11, 456.00, 16, 11, '2022-02-05', '11:00:00', 11, 11),
(12, 142.00, 12, 12, '2022-02-05', '12:30:00', 12, 12),
(13, 169.00, 3, 13, '2022-02-05', '13:00:00', 13, 13),
(14, 150.00, 7, 14, '2022-02-05', '13:30:00', 14, 14),
(15, 210.00, 18, 15, '2022-02-05', '14:00:00', 15, 15),
(16, 319.00, 22, 10, '2022-02-05', '15:30:00', 16, 16),
(17, 452.00, 20, 8, '2022-02-05', '14:30:00', 17, 17),
(18, 189.00, 4, 3, '2022-02-05', '20:00:00', 18, 18),
(19, 160.00, 15, 14, '2022-02-05', '10:00:00', 19, 19),
(20, 164.00, 8, 9, '2022-02-05', '18:00:00', 20, 20);
-- insert into Consulta (id_consulta, valor_consulta, id_medico, id_paciente, data_consulta, hora_consulta) value (21, 287.00, 9, 10, '2022-08-25', '09:00:00'), (22, 287.00, 10, 8, '2022-08-25', '09:00:00');

-- select * from Internacao;
insert into Internacao values (1, 3, 3, 1, '2022-02-05', '2022-02-10', '2022-02-10', 'Paciente apresentou melhora total'),
(2, 5, 2, 2, '2022-02-05', '2022-02-20', '2022-02-16', 'Paciente apresentou melhora total antes do previsto'),
(3, 14, 1, 2, '2022-02-05', '2022-02-22', '0000-00-00', 'Paciente apresentou declínio e permanece internado'),
(4, 16, 4, 1, '2022-02-05', '2022-02-10', '2022-02-12', 'Paciente apresentou melhora total'),
(5, 11, 5, 3, '2022-02-05', '2022-03-25', '2022-05-20', 'Paciente recebeu alta e permanecerá em acompanhamento medico'),
(6, 1, 2, 3, '2022-02-05', '2022-04-14', '2022-04-28', 'Paciente apresentou melhora parcial e permanecerá em acompanhamento medico'),
(7, 20, 4, 2, '2022-02-05', '2022-03-03', '2022-03-03', 'Paciente apresentou melhora total');

-- Alteração tabela Medicos add crm_medico
alter table Medico add crm_medico varchar(8);
update Medico set crm_medico = '056984SP' where id_medico = 1;
update Medico set crm_medico = '916782SP' where id_medico = 2;
update Medico set crm_medico = '496301SP' where id_medico = 3;
update Medico set crm_medico = '348961SP' where id_medico = 4;
update Medico set crm_medico = '591203SP' where id_medico = 5;
update Medico set crm_medico = '866017SP' where id_medico = 6;
update Medico set crm_medico = '965521SP' where id_medico = 7;
update Medico set crm_medico = '996504SP' where id_medico = 8;
update Medico set crm_medico = '326587SP' where id_medico = 9;
update Medico set crm_medico = '982147SP' where id_medico = 10;
update Medico set crm_medico = '962571SP' where id_medico = 11;
update Medico set crm_medico = '018654SP' where id_medico = 12;
update Medico set crm_medico = '754213SP' where id_medico = 13;
update Medico set crm_medico = '648272SP' where id_medico = 14;
update Medico set crm_medico = '082736SP' where id_medico = 15;
update Medico set crm_medico = '980132SP' where id_medico = 16;
update Medico set crm_medico = '275831SP' where id_medico = 17;
update Medico set crm_medico = '615486SP' where id_medico = 18;
update Medico set crm_medico = '345768SP' where id_medico = 19;
update Medico set crm_medico = '910255SP' where id_medico = 20;
update Medico set crm_medico = '010205SP' where id_medico = 21;
update Medico set crm_medico = '946130SP' where id_medico = 22;

-- Alteração na tabela Medicos add em_atividade
alter table Medico add em_atividade varchar(50);
update Medico set em_atividade = 'Férias' where id_medico = 1;
update Medico set em_atividade = 'Ativo' where id_medico = 2;
update Medico set em_atividade = 'Ativo' where id_medico = 3;
update Medico set em_atividade = 'Ativo' where id_medico = 4;
update Medico set em_atividade = 'Férias' where id_medico = 5;
update Medico set em_atividade = 'Ativo' where id_medico = 6;
update Medico set em_atividade = 'Ativo' where id_medico = 7;
update Medico set em_atividade = 'Ativo' where id_medico = 8;
update Medico set em_atividade = 'Ativo' where id_medico = 9;
update Medico set em_atividade = 'Ativo' where id_medico = 10;
update Medico set em_atividade = 'Ativo' where id_medico = 11;
update Medico set em_atividade = 'Ativo' where id_medico = 12;
update Medico set em_atividade = 'Ativo' where id_medico = 13;
update Medico set em_atividade = 'Ativo' where id_medico = 14;
update Medico set em_atividade = 'Ativo' where id_medico = 15;
update Medico set em_atividade = 'Ativo' where id_medico = 16;
update Medico set em_atividade = 'Ativo' where id_medico = 17;
update Medico set em_atividade = 'Ativo' where id_medico = 18;
update Medico set em_atividade = 'Ativo' where id_medico = 19;
update Medico set em_atividade = 'Ativo' where id_medico = 20;
update Medico set em_atividade = 'Ativo' where id_medico = 21;
update Medico set em_atividade = 'Ativo' where id_medico = 22;

select * from especialidades;
select * from medico;
select * from internacao;
select * from consulta;
select * from convenio;
select * from pacientes;
select * from receita;
select * from quarto;
select * from tipo_quarto;

-- 1- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.
select avg(valor_consulta) as "Valor médio das consultas" from Consulta where data_consulta like '%2022%';
select Consulta.*, Convenio.id_empresa_convenio from Consulta
	inner join Convenio on Convenio.id_convenio = Consulta.id_convenio where data_consulta like '%2022%';

-- 2- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.
select * from internacao where data_alta > data_prevista_alta;

-- 3- Receituário completo da primeira consulta registrada com receituário associado.
select consulta.id_consulta, receita.* from receita
	inner join consulta on consulta.id_receita = receita.id_receita where id_consulta = 1;

-- 4- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).
-- Com convenio
select * from consulta where valor_consulta = (select min(valor_consulta) from consulta) or valor_consulta = (select max(valor_consulta) from consulta);
-- Sem convenio
select * from consulta where valor_consulta = (select min(valor_consulta) from consulta) and id_convenio = null or valor_consulta = (select max(valor_consulta) from consulta) and id_convenio = null;

-- 5- Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.
select timestampdiff (day,data_entrada,data_alta) as "Número de dias entre a entrada e a alta" from internacao;
select internacao.* from internacao
	inner join quarto on internacao.id_quarto = quarto.id_quarto
    inner join tipo_quarto on quarto.id_tipo = tipo_quarto.id_tipo;

-- 6- Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.
select internacao.* from internacao 
	inner join quarto on internacao.id_quarto = quarto.id_quarto 
    inner join tipo_quarto on quarto.id_tipo = tipo_quarto.id_tipo where tipo_quarto.id_tipo = 2;

-- 7- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.
update Pacientes set data_nascimento_paciente = '2010-10-10' where id_paciente = 1;
select Pacientes.nome_paciente as "Paciente", (case when pacientes.data_nascimento_paciente > '2004-11-25' then "Menor de idade" else "Adulto" end) as "Data da consulta", medico.nome_medico as "Nome do médico", especialidades.nome_especialidade as "Especialidade do médico" from consulta
	inner join pacientes on consulta.id_paciente = pacientes.id_paciente
    inner join medico on consulta.id_medico = medico.id_medico
    inner join especialidades on medico.id_especialidade = especialidades.id_especialidade order by data_consulta;

-- 8- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
select consulta.id_consulta, pacientes.nome_paciente as "Paciente", medico.nome_medico as "Nome do médico", internacao.data_entrada as "Data de entrada", procedimento.nome_procedimento as "Procedimento", quarto.id_tipo as "Tipo do quarto" from internacao
	inner join consulta on internacao.id_consulta = internacao.id_consulta
    inner join quarto on quarto.id_quarto = internacao.id_quarto
    inner join pacientes on pacientes.id_paciente = consulta.id_paciente
    inner join procedimento on internacao.id_procedimento = procedimento.id_procedimento
    inner join medico on medico.id_medico = consulta.id_medico where id_especialidade = 3 and id_tipo = 1;

-- 9- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou
select consulta.id_consulta, medico.nome_medico, medico.crm_medico from medico
	inner join consulta on medico.id_medico = consulta.id_medico;
    
-- 10- Todos os médicos que tenham "Gabriel" no nome.
select * from medico where nome_medico like '%Gabriel%';

-- 11- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.
select enfermeiro.* from enfermeiro
	inner join quarto on enfermeiro.id_enfermeiro = quarto.id_enfermeiro;
