#Criando Banco de Dados

create database Farmacia_Koka    #Cria um Banco de Dados: Farmacia_Koka
default character set utf8       #função para cria um bd que aceita
default collate utf8_general_ci; #o uso de caracteres geral.Ex:Acentuação

use Farmacia_Koka ;

#Criação das Tabelas

#Tabela Produtos
create table if not exists Produtos(
Lote int not null,
Cod_produto int not null, 
Qtd int not null,
Preco_total decimal(10,2) not null, #1º paramentro é a qtd total de nº
Preco_unidade decimal(10,2) not null,#2º a qtd de nº após a virgula
Validade date,
Data_cadastro date #date, o usuario insere uma data no formato de ano-mês-dia
)default charset = utf8; #padroniza a tabela para receber caracteres geral

#Tabela das Informação dos Produto
create table if not exists Info_produto(
Cod int not null auto_increment, # auto_increment, adiciona valores a cada cadastro feito
Nome varchar(50) not null,
Drecricao varchar(500) not null,
primary key(Cod)
)default charset = utf8;

#Tabela da Nota Fiscal do Fornecedor
create table if not exists NF_fornecedor(
Lote int not null auto_increment,
Chave_acesso varchar(44) not null,
Cod_produto int not null,
Qtd int not null,
Preco_compra decimal(10,2) not null,
Preco_unidade decimal(10,2) not null,
Data_recebimento date not null,
Cnpj_fornecedor varchar(14) not null,
primary key(Lote)
)default charset = utf8;

#Tabela da Nota Fiscal das Vendas(Produtos vendidos na farmacia)
create table if not exists NF_venda(
Num_nota int not null auto_increment,
Cod_produto int not null,
Qtd int not null,
Preco_total decimal(10,2) not null,
Preco_unidade decimal(10,2) not null,
Data_venda date not null,
Cpf_func varchar(11) not null,
Cpf_cliente varchar(11) not null,
primary key(Num_nota)
)default charset = utf8;
#Tabela de dados dos Fornecedores
create table if not exists Fornecedor(
Cnpj varchar(14) not null,
Nome varchar(80) not null,
Endereco varchar(100) not null,
Email varchar(50) not null,
Telefone varchar(20) not null,
primary key(Cnpj)
)default charset = utf8;

#Tabela de dados dos Funcionarios
create table if not exists Funcionario(
Cpf varchar(11) not null,
Nome varchar(80) not null,
Endereco varchar(100) not null,
Email varchar(50) not null,
Telefone varchar(20) not null,
Salario decimal(10,2) not null,
primary key(Cpf)
)default charset = utf8;

#Tabela de dados dos Clientes
create table if not exists Cliente(
Cpf varchar(11) not null,
Nome varchar(80) not null,
Endereco varchar(100) not null,
Email varchar(50) not null,
Telefone varchar(20) not null,
Divida decimal(10,2) not null,
primary key(Cpf)
)default charset = utf8;


#Definido Chaves Estrangeiras:

#Chaves Estrangeiras da tabela Produtos
ALTER TABLE Produtos
ADD FOREIGN KEY (Lote)
REFERENCES NF_fornecedor(Lote);

ALTER TABLE Produtos
ADD FOREIGN KEY (Cod_Produto)
REFERENCES Info_produto(Cod);


#Chaves Estrangeiras da tabela NF_fornecedor
ALTER TABLE NF_fornecedor
ADD FOREIGN KEY (Cod_produto)
REFERENCES Info_produto(Cod);

ALTER TABLE NF_fornecedor
ADD FOREIGN KEY (Cnpj_fornecedor)
REFERENCES Fornecedor(Cnpj);

#Chaves Estrangeiras da tabela NF_venda
ALTER TABLE NF_venda
ADD FOREIGN KEY (Cod_produto)
REFERENCES Produtos(Cod_produto);

ALTER TABLE NF_venda
ADD FOREIGN KEY (Cpf_func)
REFERENCES Funcionario(Cpf);

ALTER TABLE NF_venda
ADD FOREIGN KEY (Cpf_cliente)
REFERENCES Cliente(Cpf);


#Inserindo dados para testes:

#Inserindo dados na tabela Funcionario
insert into Funcionario values
('17532487622','Maria do Socorro Margalhaes','Rua 15 de novembro, 283',
'socorro2203@bol.com.br','87 38911141','0000.00');


#Inserindo dados na tabela Cliente
insert into Cliente values
('06749583244','João Vincente Cruz','Rua Esperança, 254','Sem Email','87 999452315','240.35'),
('07532463432','Maria Eunice Duarte','Rua João XXIII, 275','Sem Email','87 998214254','120.30'),
('27621345390','Marcos Castro Oliveira Junior','Rua Vila Nova , 430','Marcos.Castro.Jr@gmail.com','87 991191532','0.00'),
('23142312353','Fernando Minguel Bento Costa','Sitio Neco, 189','febentocosta@hotmail.com','87 991904323','342.87'),
('25389212389','Jaqueline Cordeiro da Silva','Rua Romão Oliveira , 321','Linesilva@gmail.com','87 999214353','43.70');


#Inserindo dados na tabela Fornecedor
insert into Fornecedor values
('78253856136475','Drogarias Cariri Ltda','Rua São paulo,785, Juazeiro do Norte-CE','DrogariaCariri@gmail.com','88 934344335'),
('06785653478677','Farmace','Rua Coronel Gregório Callou, SN,Barbalha-CE','FarmaceBarbalha@gmail.com','88 981923426'),
('02133124454896','Utradrogs Ltda ','Rua Jardim Bonanca,Osasco-SP','utradrog.sp@gmail.com.br','11 989767879');


#Inserindo dados na tabela Info_produto
insert into Info_produto values
(default,'Dorflex','Relaxante muscular e analgésico que serve para o alívio de dores musculares e dor de cabeça'),
(default,'Dipirona','Metamizol, analgésico e antipirético,febre alta'),
(default,'Paracetamol',' fármaco com propriedades analgésicas e antipiréticas utilizado essencialmente para tratar a febre e a dor leve e moderada.'),
(default,'Ibuprofeno','anti-inflamatórios não esteróides utilizado para o tratamento da dor, febre e inflamação'),
(default,'Amoxicilina','Penicilina semi sintética de espectro moderado utilizado no tratamento de infeções bacterianas causadas por microorganismos susceptíveis'),
(default,'Rivotril','clonazepam,inibição leve das funções do sistema nervoso central permitindo assim uma ação anticonvulsivante, alguma sedação, relaxamento muscular e efeito tranquilizante'),
(default,'BENEGRIP','Desempenha atividade antialérgica nos processos gripais, descongestionando o nariz e reduzindo a coriza. Estimula o sistema nervoso central, suavemente, conferindo sensação de bem-estar'),
(default,'Multigrip','Tratamento dos sintomas de gripes e resfriados, alívio da congestão nasal, coriza, febre, dor de cabeça e dores musculares presentes nos estados gripais.'),
(default,'Biotônico','suplemento mineral indicado como auxiliar nas anemias carenciais e em dietas inadequadas. É um medicamento de uso oral composto por substâncias que fornecem ferro e fósforo');

