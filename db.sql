drop database if exists jlj;
create database jlj;
create user 'jlj'@'localhost' identified by 'fanball';
grant all on jlj.* to 'jlj'@'localhost' identified by 'fanball';
