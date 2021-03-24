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
Cod int not null auto_increment, # auto_increment, adiciona valores a cada cadastro feito,
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
('17532487622','Maria do Socorro Margalhaes','Rua 15 de novembro, 283','socorro2203@bol.com.br','87 38911141','0000.00');


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


#Inserindo dados na tabela NF_fornecedor
insert into NF_fornecedor values
(default,'67823647138264712837648291728362713827123455',1,40,702.40,17.56,'2020-03-18','78253856136475'),
(default,'24847213589742189738249325897325892348935898',4,25,250.00,10.00,'2020-03-18','78253856136475'),
(default,'32432893358924178358797182497382957325894298',3,30,580.25,19.34,'2020-05-23','06785653478677'),
(default,'87263762147824728174721218462784612784216788',6,15,136.34,9.10,'2020-08-15','02133124454896'),
(default,'09243745745382832374328943278989021484983984',2,50,800.85,16.05,'2020-07-02','06785653478677'),
(default,'98743276867842398757821978472189756893724874',8,20,230.00,11.50,'2020-09-30','02133124454896'),
(default,'73346775876532875238975823975328957897892358',5,35,493.30,14.10,'2020-01-12','02133124454896');


#Inserindo dados na tabela Produtos
insert into Produtos values
(1,1,40,940.00,23.50,'2025-11-29','2020-03-20'),
(2,4,25,375.00,15.00,'2023-07-12','2020-03-25'),
(3,3,30,759.00,25.30,'2026-01-18','2020-05-25'),
(4,6,15,188.85,12.59,'2022-03-23','2020-08-15'),
(5,2,50,1000.00,20.00,'2025-04-01','2020-07-03'),
(6,8,20,304.00,15.20,'2021-12-15','2020-10-01'),
(7,5,35,658.00,18.80,'2024-08-15','2020-01-02');


#Inserindo dados na tabela NF_venda
insert into NF_venda values
(default,6,2,25.18,12.59,'2020-04-30','17532487622','06749583244'),
(default,1,1,23.50,25.50,'2020-07-12','17532487622','25389212389'),
(default,8,3,45.60,15.20,'2020-08-24','17532487622','27621345390');


#Consultas 

#Produtos mais proximos da data de vencimento.
select p.Lote, ip.Nome , p.Qtd, p.Validade
from Produtos p inner join Info_produto ip
on p.Cod_produto = ip.Cod
where p.Validade = (select min(Validade) from Produtos);


#Verificar Dados de um cliente chamado Jaqueline

select * from Cliente
where Nome like 'Jaqueline%';


#verificar gastos totais e Ganhos com vendas

select sum(nf.Preco_compra) as Gastos_Totais, sum(nv.Preco_total) as Vendas 
from NF_fornecedor nf join NF_venda nv;


#Verificar o total de compras dos fornecedores 

select f.Nome, nf.Cnpj_fornecedor , sum(nf.Preco_compra) 
from Fornecedor f join NF_fornecedor nf
on f.Cnpj = nf.Cnpj_fornecedor
group by nf.Cnpj_fornecedor
having sum(nf.Preco_compra) >= max(sum(nf.Preco_compra));


#Verificar as Compras de um usuario pelo nome, ex: João Vincente 

select nv.Num_nota, ip.Nome as Produto, nv.Qtd, nv.Preco_total, nv.Preco_unidade, 
nv.Data_venda, c. Nome as Cliente, c.Cpf, f.Nome as Funcionario, f.Cpf
from Info_produto ip join NF_venda nv
on ip.Cod = nv.Cod_produto
join Cliente c 
on c.Cpf = nv.Cpf_cliente
join Funcionario f
on nv.Cpf_func = f.Cpf
where  c.Nome like 'João Vincente%';
