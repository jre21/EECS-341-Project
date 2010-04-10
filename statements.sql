delimiter $$

drop procedure if exists isUser $$
create procedure isUser(uname char(20), pword char(30))
begin
  select COUNT(*) from USER where username = uname and password = pword;
end $$

drop procedure if exists register $$
create procedure register(uname char(20), pword char(30))
begin
  declare rows int;
  select count(*) into rows from USER where username = uname;
  if
    rows!=0
  then
    select 'Error: user exists';
  elseif
    pword=''
  then
    select 'Error: invalid password';
  else
    insert into USER (username, password) values (uname, pword);
    select '';
  end if;
end $$

delimiter ;
