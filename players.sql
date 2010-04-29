load data local infile 'players1.csv' into table jlj.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players2.csv' into table jlj.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players3.csv' into table jlj.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players4.csv' into table jlj.players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

update jlj.players set totalpoints=0, weekpoints=0, availability=0;

insert into jlj.totalstats (name) select name from jlj.players;
update totalstats set passTD=0,passyards=0,interceptions=0,rushTD=0,
rushyards=0,fumbles=0,receivingTD=0,receivingyards=0,pointsallowed=0,
turnovers=0,sacks=0,defensiveTD=0,fieldgoalless40=0,fieldgoalgreater40=0,
missedfieldgoaless40=0,missedfieldgoalgreater40=0,PAT=0,missedPAT=0,
calpoints=0;
insert into jlj.weeklystats (name) select name from jlj.players;
update weeklystats set passTD=0,passyards=0,interceptions=0,rushTD=0,
rushyards=0,fumbles=0,receivingTD=0,receivingyards=0,pointsallowed=0,
turnovers=0,sacks=0,defensiveTD=0,fieldgoalless40=0,fieldgoalgreater40=0,
missedfieldgoaless40=0,missedfieldgoalgreater40=0,PAT=0,missedPAT=0,
calpoints=0;

