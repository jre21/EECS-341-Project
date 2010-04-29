delimiter $$

drop procedure if exists jlj.isUser $$
create procedure jlj.isUser(uname char(20), pword char(20))
begin
  select COUNT(*) from user where username = uname and password = pword;
end $$

drop procedure if exists jlj.register $$
create procedure jlj.register(uname char(20), tname char(30), pword char(30))
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
      insert into teamroster (teamname) values (tname);
      select '';
    end if;
  end if;
end $$

drop procedure if exists jlj.draft $$
create procedure jlj.draft(uname char(20), pname char(30), pos char(30))
begin
  declare success int;
  declare tname char(30);
  select 1 into success;
  select teamname into tname from user where username=uname;
  if pos = 'QB'
  then
    update teamroster set QB=pname where teamname=tname;
  elseif pos = 'RB1'
  then
    update teamroster set RB1=pname where teamname=tname;
  elseif pos = 'RB2'
  then
    update teamroster set RB2=pname where teamname=tname;
  elseif pos = 'WR1'
  then
    update teamroster set WR1=pname where teamname=(
      select teamname from user where username=tname
  );
  elseif pos = 'WR2'
  then
    update teamroster set WR2=pname where teamname=tname;
  elseif pos = 'WR3'
  then
    update teamroster set WR3=pname where teamname=tname;
  elseif pos = 'TE'
  then
    update teamroster set TE=pname where teamname=tname;
  elseif pos = 'DEF'
  then
    update teamroster set DEF=pname where teamname=tname;
  elseif pos = 'K'
  then
    update teamroster set K=pname where teamname=tname;
  elseif pos = 'BN1'
  then
    update teamroster set BN1=pname where teamname=tname;
  elseif pos = 'BN2'
  then
    update teamroster set BN2=pname where teamname=tname;
  elseif pos = 'BN3'
  then
    update teamroster set BN3=pname where teamname=tname;
  elseif pos = 'BN4'
  then
    update teamroster set BN4=pname where teamname=tname;
  elseif pos = 'BN5'
  then
    update teamroster set BN5=pname where teamname=tname;
  else select 0 into success;
  end if;
  if success>0
  then
    update players set availability=1, owner=uname where name=pname;
    insert into countpoints (teamname, playername, playerposition)
      values (tname, pname, pos);
  end if;
end $$

delimiter ;
