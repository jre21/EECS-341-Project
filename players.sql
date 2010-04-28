load data local infile 'players1.csv' into table players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players2.csv' into table players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players3.csv' into table players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

load data local infile 'players4.csv' into table players
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
(name, nflteam, position);

update players set availability=0;
