DROP TABLE IF EXISTS `jlj`.`weeklystats`;
DROP TABLE IF EXISTS `jlj`.`totalstats`;
DROP TABLE IF EXISTS `jlj`.`teamroster`;
DROP TABLE IF EXISTS `jlj`.`sumwin`;
DROP TABLE IF EXISTS `jlj`.`schedule`;
DROP TABLE IF EXISTS `jlj`.`players`;
DROP TABLE IF EXISTS `jlj`.`countpoints`;
DROP TABLE IF EXISTS `jlj`.`user`;

CREATE TABLE  `jlj`.`user` (
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

CREATE TABLE  `jlj`.`countpoints` (
  `teamname` char(30) NOT NULL DEFAULT '',
  `playername` char(30) NOT NULL DEFAULT '',
  `playerposition` char(3) DEFAULT NULL,
  `sumweekpoints` double DEFAULT NULL,
  `sumtotalpoints` double DEFAULT NULL,
  PRIMARY KEY (`teamname`,`playername`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `jlj`.`players` (
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

CREATE TABLE  `jlj`.`schedule` (
  `username` char(20) NOT NULL,
  `week1` char(20) DEFAULT NULL,
  `week2` char(20) DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `jlj`.`sumwin` (
  `username` char(30) NOT NULL DEFAULT '',
  `wins` int(11) DEFAULT NULL,
  `losses` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE  `jlj`.`teamroster` (
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

CREATE TABLE  `jlj`.`totalstats` (
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

CREATE TABLE  `jlj`.`weeklystats` (
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
