delimiter $$

drop procedure if exists isUser $$
create procedure isUser(uname char(20), pword char(20))
begin
  select COUNT(*) from user where username = uname and password = pword;
end $$

drop procedure if exists register $$
create procedure register(uname char(20), tname char(30), pword char(30))
begin
  declare rows int;
  select count(*) into rows from user where username = uname;
  if
    rows!=0
  then
    select 'Error: user exists';
  end if;
  if
    rows=0
  then
    select count(*) into rows from user where teamname = tname;
    if
      rows!=0
    then
      select 'Error: team already in use';
    else
      insert into user (username, teamname, password, modes)
        values (uname, tname, pword, 0);
      select '';
    end if;
  end if;
end $$

delimiter ;
