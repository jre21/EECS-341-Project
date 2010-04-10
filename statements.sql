delimiter $$

drop procedure if exists isUser $$
create procedure isUser(uname char(20), pword char(30))
begin
  select COUNT(*) from USER where username = uname and password = pword;
end $$

delimiter ;