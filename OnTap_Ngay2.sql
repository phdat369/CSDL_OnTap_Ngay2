create database ontapngay2;
use ontapngay2;

create table customers (
    id int primary key auto_increment,
    full_name varchar(100) not null,
    phone varchar(15) unique,
    address varchar(255),
    customer_type enum('normal','vip') default 'normal'
);

create table products (
    id int primary key auto_increment,
    product_name varchar(100) not null,
    category varchar(50),
    price decimal(10,2) check (price > 0),
    stock int default 0 check (stock >= 0)
);

create table orders (
    id int primary key auto_increment,
    customer_id int,
    order_date datetime default current_timestamp,
    status enum('completed','cancelled') default 'completed',
    foreign key (customer_id) references customers (id)
);

create table order_details (
    id int primary key auto_increment,
    order_id int,
    product_id int,
    quantity int check (quantity > 0),
    total_price decimal(10,2),
    foreign key (order_id) references orders (id),
    foreign key (product_id) references products (id),
    unique(order_id,product_id)
);

insert into customers (full_name, phone, address, customer_type) 
values ('nguyen van a', '090000001', 'hcm', 'vip'),
       ('tran thi b', '090000002', 'hn', 'normal'),
	   ('le van c', '090000003', 'dn', 'vip'),
       ('pham thi d', '090000004', 'ht', 'normal'),
       ('hoang van e', '090000005', 'hp', 'vip'),
       ('do thi f', '090000006', 'pq', 'normal'),
	   ('vu van g', '090000007', 'na', 'vip');
       

insert into products (product_name, category, price, stock) 
values ('iphone 13', 'electronics', 20000000, 10),
       ('Lavie', 'Nước giải khát', 20000, 8),
       ('laptop dell', 'electronics', 25000000, 5),
       ('ao thun', 'fashion', 200000, 50),
       ('Danisa', 'Nước giải khát', 59000, 30),
       ('giay sneaker', 'fashion', 800000, 20),
       ('ban hoc', 'furniture', 1500000, 0),
       ('ghe van phong', 'furniture', 1200000, 15),
       ('Aquafina', 'Nước giải khát', 20000, 5),
       ('tai nghe', 'electronics', 500000, 0);

insert into orders (customer_id, status) 
values (1, 'completed'),
	   (2, 'completed'),
       (3, 'cancelled'),
       (4, 'completed'),
       (5, 'cancelled');
       
insert into order_details (order_id, product_id, quantity, total_price) 
values (1, 1, 1, 20000000),
       (1, 4, 2, 400000),
       (1, 7, 1, 1500000),
	   (2, 2, 1, 18000000),
       (2, 5, 2, 118000),
       (3, 3, 1, 25000000),
       (3, 6, 1, 800000),
       (4, 4, 3, 600000),
       (4, 8, 1, 1200000),
       (5, 1, 2, 40000000),
       (5, 9, 1, 20000),
       (5, 5, 1, 59000);

select product_name 
from products
where category = 'Nước giải khát' and (price between 10000 and 50000);

select full_name
from customers
where full_name like ('nguyen%') or address = 'hn';

select o.id as 'Mã đơn',
       o.order_date as 'Ngày mua',
       o.status as 'Trạng thái',
       c.full_name as 'Tên khách hàng'
from orders o
join customers c
on o.customer_id = c.id
order by o.order_date desc;

select c.full_name as 'Tên khách hàng',
       o.order_date as 'Ngày mua',
       p.product_name as 'Tên sản phẩm',
       od.quantity as 'Số lượng',
       (od.total_price / od.quantity) as 'Đơn giá'
from order_details od
join orders o on od.order_id = o.id
join customers c on o.customer_id = c.id
join products p on od.product_id = p.id;

select c.id,c.full_name,c.phone,c.address,c.customer_type
from customers c
left join orders o
on c.id = o.customer_id
where o.id is null;
