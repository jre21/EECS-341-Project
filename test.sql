drop database if exists foo;
create database foo;
create user 'foo'@'localhost' identified by 'bar';
grant all on foo.* to 'foo'@'localhost' identified by 'bar';
DROP TABLE IF EXISTS `foo`.`weeklystats`;
DROP TABLE IF EXISTS `foo`.`totalstats`;
DROP TABLE IF EXISTS `foo`.`teamroster`;
DROP TABLE IF EXISTS `foo`.`sumwin`;
DROP TABLE IF EXISTS `foo`.`schedule`;
DROP TABLE IF EXISTS `foo`.`players`;
DROP TABLE IF EXISTS `foo`.`countpoints`;
DROP TABLE IF EXISTS `foo`.`user`;

CREATE TABLE  `foo`.`user` (
  `username` char(20) NOT NULL DEFAULT '',
  `teamname` char(30) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `totalpoints` double DEFAULT NULL,
  `weekpoints` double DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `windata` int(11) DEFAULT NULL,
  `lossdata` int(11) DEFAULT NULL,
  `modes` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `Teamname` (`teamname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`countpoints` (
  `teamname` char(30) NOT NULL DEFAULT '',
  `playername` char(30) NOT NULL DEFAULT '',
  `playerposition` char(3) DEFAULT NULL,
  `sumweekpoints` double DEFAULT NULL,
  `sumtotalpoints` double DEFAULT NULL,
  PRIMARY KEY (`teamname`,`playername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`players` (
  `name` char(30) NOT NULL DEFAULT '',
  `nflteam` char(30) DEFAULT NULL,
  `position` char(3) DEFAULT NULL,
  `totalpoints` double DEFAULT NULL,
  `weekpoints` double DEFAULT NULL,
  `availability` int(10) unsigned DEFAULT NULL,
  `injurystate` char(1) DEFAULT NULL,
  `owner` char(30) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `FK_players_1` (`owner`),
  CONSTRAINT `FK_players_1` FOREIGN KEY (`owner`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`schedule` (
  `username` char(20) NOT NULL,
  `week1` char(20) DEFAULT NULL,
  `week2` char(20) DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`sumwin` (
  `username` char(30) NOT NULL DEFAULT '',
  `wins` int(11) DEFAULT NULL,
  `losses` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`teamroster` (
  `teamname` char(30) NOT NULL DEFAULT '',
  `QB` char(30) DEFAULT NULL,
  `RB1` char(30) DEFAULT NULL,
  `RB2` char(30) DEFAULT NULL,
  `WR1` char(30) DEFAULT NULL,
  `WR2` char(30) DEFAULT NULL,
  `WR3` char(30) DEFAULT NULL,
  `TE` char(30) DEFAULT NULL,
  `DEF` char(30) DEFAULT NULL,
  `K` char(30) DEFAULT NULL,
  `BN1` char(30) DEFAULT NULL,
  `BN2` char(30) DEFAULT NULL,
  `BN3` char(30) DEFAULT NULL,
  `BN4` char(30) DEFAULT NULL,
  `BN5` char(30) DEFAULT NULL,
  PRIMARY KEY (`teamname`),
  KEY `QB` (`QB`),
  KEY `RB1` (`RB1`),
  KEY `RB2` (`RB2`),
  KEY `WR1` (`WR1`),
  KEY `WR2` (`WR2`),
  KEY `WR3` (`WR3`),
  KEY `TE` (`TE`),
  KEY `DEF` (`DEF`),
  KEY `K` (`K`),
  KEY `BN1` (`BN1`),
  KEY `BN2` (`BN2`),
  KEY `BN3` (`BN3`),
  KEY `BN4` (`BN4`),
  KEY `BN5` (`BN5`),
  CONSTRAINT `FK_teamroster_1` FOREIGN KEY (`teamname`) REFERENCES `user` (`teamname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`totalstats` (
  `name` char(30) NOT NULL DEFAULT '',
  `passTD` double DEFAULT NULL,
  `passyards` double DEFAULT NULL,
  `interceptions` double DEFAULT NULL,
  `rushTD` double DEFAULT NULL,
  `rushyards` double DEFAULT NULL,
  `fumbles` double DEFAULT NULL,
  `receivingTD` double DEFAULT NULL,
  `receivingyards` double DEFAULT NULL,
  `pointsallowed` double DEFAULT NULL,
  `turnovers` double DEFAULT NULL,
  `sacks` double DEFAULT NULL,
  `defensiveTD` double DEFAULT NULL,
  `fieldgoalless40` double DEFAULT NULL,
  `fieldgoalgreater40` double DEFAULT NULL,
  `missedfieldgoaless40` double DEFAULT NULL,
  `missedfieldgoalgreater40` double DEFAULT NULL,
  `PAT` double DEFAULT NULL,
  `missedPAT` double DEFAULT NULL,
  `calpoints` double DEFAULT NULL,
  PRIMARY KEY (`name`),
  CONSTRAINT `totalstats_ibfk_1` FOREIGN KEY (`name`) REFERENCES `players` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `foo`.`weeklystats` (
  `name` char(30) NOT NULL DEFAULT '',
  `passTD` double DEFAULT NULL,
  `passyards` double DEFAULT NULL,
  `interceptions` double DEFAULT NULL,
  `rushTD` double DEFAULT NULL,
  `rushyards` double DEFAULT NULL,
  `fumbles` double DEFAULT NULL,
  `receivingTD` double DEFAULT NULL,
  `receivingyards` double DEFAULT NULL,
  `pointsallowed` double DEFAULT NULL,
  `turnovers` double DEFAULT NULL,
  `sacks` double DEFAULT NULL,
  `defensiveTD` double DEFAULT NULL,
  `fieldgoalless40` double DEFAULT NULL,
  `fieldgoalgreater40` double DEFAULT NULL,
  `missedfieldgoaless40` double DEFAULT NULL,
  `missedfieldgoalgreater40` double DEFAULT NULL,
  `PAT` double DEFAULT NULL,
  `missedPAT` double DEFAULT NULL,
  `calpoints` double DEFAULT NULL,
  PRIMARY KEY (`name`),
  CONSTRAINT `weeklystats_ibfk_1` FOREIGN KEY (`name`) REFERENCES `players` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
delimiter $$

drop procedure if exists foo.isUser $$
create procedure foo.isUser(uname char(20), pword char(20))
begin
  select COUNT(*) from user where username = uname and password = pword;
end $$

drop procedure if exists foo.register $$
create procedure foo.register(uname char(20), tname char(30), pword char(30))
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

drop procedure if exists foo.draft $$
create procedure foo.draft(uname char(20), pname char(30), pos char(30))
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
load data local infile 'players1.csv' into table foo.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players2.csv' into table foo.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players3.csv' into table foo.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players4.csv' into table foo.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

update foo.players set availability=0;

insert into foo.totalstats (name) select name from foo.players;
insert into foo.weeklystats (name) select name from foo.players;
