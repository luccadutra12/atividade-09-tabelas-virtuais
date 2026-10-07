create database vendas_online_db

use vendas_online_db 

create table clientes (
    id int identity (1,1) primary key,
    nome varchar(100) not null,
    cpf char(11) not null unique,
    email varchar(120),
    cidade varchar(60),
    ativo bit default 1
);
GO

CREATE INDEX idx_cidade
ON clientes(cidade);
GO

create table pedidos(
id int identity(1,1) primary key,
id_cliente int not null,
valor decimal(10,2) not null,
data_pedido date not null,

foreign key (id_cliente) references clientes(id)
);
go

create index idx_data_pedido
on pedidos(data_pedido);
go

insert into clientes (nome, cpf, cidade)
values
('Ana Souza', '11111111111', 'São Paulo'),
('Bruno Lima', '22222222222', 'São Paulo'),
('Carla Nunes', '33333333333', 'Rio de Janeiro'),
('Diego Martins', '44444444444', 'Curitiba'),
('Elisa Rocha', '55555555555', 'São Paulo');
go

insert into pedidos (id_cliente, valor, data_pedido)
values
(1, 150.00, '2025-01-10'),
(1, 89.90, '2025-02-05'),
(2, 320.00, '2025-03-12'),
(3, 500.00, '2025-04-01'),
(3, 75.50, '2025-04-15'),
(4, 120.00, '2025-05-02');
go

create table entregas (
id int identity(1,1) primary key,
id_pedido int not null,
data_entrega date not null,
status varchar(30) not null,
valor_frete decimal(10,2) not null,

foreign key (id_pedido) references pedidos(id)
);

go 
create index idx_status_entrega
on entregas (status);
go 

insert into entregas (id_pedido, data_entrega, status, valor_frete)
values
(1, '2025-01-13', 'Entregue', 25.00),
(2, '2025-02-07', 'Entregue', 18.50),
(3, '2025-03-20', 'Cancelada', 0.00),
(4, '2025-04-05', 'Entregue', 35.00),
(5, '2025-04-17', 'Pendente', 28.90),
(6, '2025-05-06', 'Entregue', 22.00);
go

create view vw_resumo_entregas as
select
count(*) as total_entregas,
avg(valor_frete) as medida_valor_frete
from entregas;
go

create view vw_entregas_concluidas as
select
 e.id_pedido,
    p.valor as valor_pedido,
    e.valor_frete,
    e.data_entrega
    from entregas as e
    inner join pedidos as p 
    on e.id_pedido = p.id
    where e.status = 'Entregue';
    go

    select * from vw_resumo_entregas;
    go

    select * from vw_entregas_concluidas;
    go