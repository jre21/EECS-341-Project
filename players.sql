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

update jlj.players set availability=0;

insert into jlj.totalstats (name) select name from jlj.players;
insert into jlj.weeklystats (name) select name from jlj.players;
