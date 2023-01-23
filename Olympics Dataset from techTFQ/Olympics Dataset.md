# Welcome to my Olympics Dataset Project! <img align="center" src="https://user-images.githubusercontent.com/103854541/213895210-d40024c5-6db4-478e-907d-06ef78f83a80.gif" width="120" height="120">  


<img src="https://user-images.githubusercontent.com/103854541/213895951-0cb21ca5-1b7c-4c01-a033-7a3c3ebf25ce.jpg" width="500" height="500"> 



try this project on your own [here](https://techtfq.com/blog/practice-writing-sql-queries-using-real-dataset) or find my raw SQL solution [here]

Kaggle Dataset Download [Link](https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results)


#### Table 1: athlete_events

| column   | type         |    
| -------- | ------------ |
| ID       | FLOAT        |
| Name     | VARCHAR(255) |
| Sex      | VARCHAR(255) |
| Age      | FLOAT        |
| Height   | FLOAT        |
| Weight   | FLOAT        |
| Team     | VARCHAR(255) |
| NOC      | VARCHAR(255) |
| Games    | VARCHAR(255) |
| Year     | FLOAT        |
| Season   | VARCHAR(255) |
| City     | VARCHAR(255) |
| Sport    | VARCHAR(255) |
| Event    | VARCHAR(255) |
| Medal    | VARCHAR(255) |


#### Table 2: noc_regions 

| column  | type         |    
| ------- | ------------ |
| NOC     | VARCHAR(255) |
| region  | VARCHAR(255) |
| notes   | VARCHAR(255) |


## Case Study Questions

#### 1. How many olympics games have been held?
Problem statement: Write a SQL query to find the total no of Olympic Games held as per the dataset.

```sql
SELECT COUNT(DISTINCT(Games)) as NumberOfGames 
FROM athlete_events$
```


##### Asnwer:

| NumberOfGames |    
| ------------- |
| 51            |



#### 2. List down all Olympics games held so far.
 Problem statement: Write a SQL query to list down all the Olympic Games held so far

```sql
SELECT DISTINCT Year, Season, City
FROM athlete_events$
ORDER BY Year
```

##### Asnwer:

| Year | Season | City
| ---- | ------ | ---------------------- |
| 1896	| Summer |	Athina                 |
| 1900	| Summer	| Paris                  |
| 1904	| Summer	| St. Louis              |
| 1906	| Summer	| Athina                 | 
| 1908	| Summer	| London                 |
| 1912	| Summer	| Stockholm              | 
| 1920	| Summer	| Antwerpen              |
| 1924	| Winter	| Chamonix               |
| 1924	| Summer	| Paris                  |
| 1928	| Summer	| Amsterdam              |
| 1928	| Winter	| Sankt Moritz           |
| 1932	| Summer	| Los Angeles            |
| 1932	| Winter	| Lake Placid            |
| 1936	| Summer	| Berlin                 |
| 1936	| Winter	| Garmisch-Partenkirchen |
| 1948	| Summer	| London                 |
| 1948	| Winter	| Sankt Moritz           |
| 1952	| Winter	| Oslo                   |
| 1952	| Summer	| Helsinki               |
| 1956	| Summer	| Melbourne              |
| 1956	| Winter	| Cortina d'Ampezzo      |
| 1956	| Summer	| Stockholm              |
| 1960	| Winter	| Squaw Valley           |
| 1960	| Summer	| Roma                   |
| 1964	| Summer	| Tokyo                  |
| 1964	| Winter	| Innsbruck              |
| 1968	| Winter	| Grenoble               |
| 1968	| Summer	| Mexico City            |
| 1972	| Summer	| Munich                 |
| 1972	| Winter	| Sapporo                |
| 1976	| Winter	| Innsbruck              |
| 1976	| Summer	| Montreal               |
| 1980	| Winter	| Lake Placid            |
| 1980	| Summer	| Moskva                 |
| 1984	| Summer	| Los Angeles            |
| 1984	| Winter	| Sarajevo               |
| 1988	| Winter	| Calgary                |
| 1988	| Summer	| Seoul                  |
| 1992	| Summer	| Barcelona              |
| 1992	| Winter	| Albertville            |
| 1994	| Winter	| Lillehammer            |
| 1996	| Summer	| Atlanta                |
| 1998	| Winter	| Nagano                 |
| 2000	| Summer	| Sydney                 |
| 2002	| Winter	| Salt Lake City         |
| 2004	| Summer	| Athina                 |
| 2006	| Winter	| Torino                 |
| 2008	| Summer	| Beijing                |
| 2010	| Winter	| Vancouver              |
| 2012	| Summer	| London                 |
| 2014	| Winter	| Sochi                  |
| 2016	| Summer	| Rio de Janeiro         |


#### 3. Mention the total no of nations who participated in each olympics game?
 Problem statement: SQL query to fetch total no of countries participated in each olympic games

```sql
with all_countries as

(SELECT  Distinct Games, reg.noc
FROM athlete_events$ ev
JOIN noc_regions$ reg 
ON ev.noc = reg.noc 
GROUP BY Games, reg.noc) 

SELECT Games, count(1) as total_countires
FROM all_countries
GROUP BY Games
ORDER BY Games 
```

##### Asnwer:

| Games       | total_countries |
| ----------- | --------------- |
| 1896 Summer	| 12              |
| 1900 Summer	| 31              |
| 1904 Summer	| 15              |
| 1906 Summer	| 21              |
| 1908 Summer	| 22              |
| 1912 Summer	| 29              |
| 1920 Summer	| 29              |
| 1924 Summer	| 45              |
| 1924 Winter	| 19              |
| 1928 Summer	| 46              |
| 1928 Winter	| 25              |
| 1932 Summer	| 47              |
| 1932 Winter	| 17              |
| 1936 Summer	| 49              |
| 1936 Winter	| 28              |
| 1948 Summer	| 58              |
| 1948 Winter	| 28              |
| 1952 Summer	| 68              |
| 1952 Winter	| 30              |
| 1956 Summer	| 71              |
| 1956 Winter	| 32              |
| 1960 Summer	| 83              |
| 1960 Winter	| 30              |
| 1964 Summer	| 93              |
| 1964 Winter	| 36              |
| 1968 Summer	| 111             |
| 1968 Winter	| 37              |
| 1972 Summer	| 120             |
| 1972 Winter	| 35              |
| 1976 Summer	| 91
| 1976 Winter	| 37
| 1980 Summer	| 80
| 1980 Winter	| 37
| 1984 Summer	| 139
| 1984 Winter	| 49
| 1988 Summer	| 158
| 1988 Winter	| 57
| 1992 Summer	| 168
| 1992 Winter	| 64
| 1994 Winter	| 67
| 1996 Summer	| 196
| 1998 Winter	| 72
| 2000 Summer	| 199
| 2002 Winter	| 77
| 2004 Summer	| 200
| 2006 Winter	| 79
| 2008 Summer	| 203
| 2010 Winter	| 82
| 2012 Summer	| 204
| 2014 Winter	| 89
| 2016 Summer	| 206


#### 4. Which year saw the highest and lowest no of countries participating in olympics
Write a SQL query to return the Olympic Games which had the highest participating countries and the lowest participating countries

```sql
with all_countries as

(SELECT  Distinct Games, reg.noc
FROM athlete_events$ ev
JOIN noc_regions$ reg 
ON ev.noc = reg.noc 
GROUP BY Games, reg.noc),

Tot_Countries as
(
SELECT Games, count(1) as total_countries
FROM all_countries
GROUP BY Games
)

SELECT DISTINCT
CONCAT(first_value(Games) over (order by total_countries), ' - '
, first_value(total_countries) over(order by total_countries)) as Lowest_Countries, 
 concat(first_value(Games) over(order by total_countries desc), ' - '
 , first_value(total_countries) over(order by total_countries desc)) as Highest_Countries
      from tot_countries
      order by 1; 
```

##### Asnwer:

| Lowest_Countries | Highest_Countries |
| ---------------- | ----------------- |
| 1896 Summer - 12	| 2016 Summer - 206 |


#### 5. Which nation has participated in all of the olympic games
SQL query to return the list of countries who have been part of every Olympics games

```sql
WITH countries as
(SELECT Games, reg.noc as country
FROM athlete_events$ ev
JOIN noc_regions$ reg --joining the other table
ON ev.noc = reg.noc --setting noc number of columns to be the same
GROUP BY Games, reg.noc),

games as
(SELECT country, COUNT(DISTINCT Games) as total_number_games
FROM countries
GROUP BY country)

SELECT country, total_number_games
FROM games
WHERE total_number_games >= (SELECT COUNT(DISTINCT Games) FROM countries)
ORDER BY total_number_games desc
```

##### Asnwer:

| country | total_number_games |
| ------- | ------------------ |
| FRA	    | 51
| GBR	    | 51
| ITA	    | 51
| SUI	    | 51


#### 6. Identify the sport which was played in all summer olympics
SQL query to fetch the list of all sports which have been part of every olympics

```sql
With t1 as
(Select count(distinct Games) as total_summer_games
FROM athlete_events$ 
WHERE Season = 'Summer'
),
t2 as
(SELECT DISTINCT Sport, Games
FROM athlete_events$
WHERE Season = 'Summer'
),

t3 as
(SELECT Sport, Count(Games) as no_of_games
from t2
group by Sport)

SELECT *
FROM t3
JOIN t1 
on t1.total_summer_games = t3.no_of_games
```

##### Asnwer:

| Sport      | no_of_games | total_summer_games |
| ---------- | ----------- | ------------------ |
| Gymnastics |	29          |	29                 |
| Fencing    |	29	         | 29                 |
| Swimming   |	29	         | 29                 |
| Cycling  	 | 29	         | 29                 |
| Athletics  |	29	         | 29                 |


#### 7. Which Sports were just played only once in the olympics
Using SQL query, Identify the sport which were just played once in all of olympics

```sql
WITH t1 as
(SELECT Sport, COUNT(DISTINCT Games) as no_of_games
FROM athlete_events$
GROUP BY Sport
)

SELECT Sport, no_of_games
FROM t1
WHERE no_of_games = 1 
ORDER BY Sport 
```

##### Asnwer:

| Sport               | no_of_games |
| ------------------- | ----------- |
| Aeronautics	        | 1
| Basque Pelota	      | 1
| Cricket	            | 1
| Croquet	            | 1
| Jeu De Paume       	| 1
| Military Ski Patrol	| 1
| Motorboating	       | 1
| Racquets	           | 1
| Roque	              | 1
| Rugby Sevens	       | 1


#### 8. Fetch the total no of sports played in each olympic games
Write SQL query to fetch the total no of sports played in each olympics

```sql

SELECT Games, count(DISTINCT (Sport)) as no_of_sports
from athlete_events$
group by games
order by no_of_sports desc 
```

##### Asnwer:

| Games       | no_of_sports |
| ----------- | ------------ |
| 2016 Summer	| 34
| 2008 Summer	| 34
| 2004 Summer	| 34
| 2000 Summer	| 34
| 2012 Summer	| 32
| 1996 Summer	| 31
| 1992 Summer	| 29
| 1988 Summer	| 27
| 1984 Summer	| 25
| 1920 Summer	| 25
| 1908 Summer	| 24
| 1936 Summer	| 24
| 1976 Summer	| 23
| 1980 Summer	| 23
| 1972 Summer	| 23
| 1964 Summer	| 21
| 1968 Summer	| 20
| 1900 Summer	| 20
| 1924 Summer	| 20
| 1948 Summer	| 20
| 1952 Summer	| 19
| 1956 Summer	| 19
| 1960 Summer	| 19
| 1904 Summer	| 18
| 1932 Summer	| 18
| 1912 Summer	| 17
| 1928 Summer	| 17
| 2006 Winter	| 15
| 2014 Winter	| 15
| 2010 Winter	| 15
| 2002 Winter	| 15
| 1998 Winter	| 14
| 1906 Summer	| 13
| 1992 Winter	| 12
| 1994 Winter	| 12
| 1964 Winter	| 10
| 1972 Winter	| 10
| 1976 Winter	| 10
| 1968 Winter	| 10
| 1988 Winter	| 10
| 1980 Winter	| 10
| 1984 Winter	| 10
| 1924 Winter	| 10
| 1896 Summer	| 9
| 1948 Winter	| 9
| 1952 Winter	| 8
| 1928 Winter	| 8
| 1936 Winter	| 8
| 1960 Winter	| 8
| 1956 Winter	| 8
| 1932 Winter	| 7


#### 9. Fetch oldest athletes to win a gold medal
SQL Query to fetch the details of the oldest athletes to win a gold medal at the olympics

```sql
SELECT TOP 2 name, sex, age, team, games, city, sport, event, medal 
FROM athlete_events$
WHERE Medal = 'Gold'
ORDER BY AGE desc
```

##### Asnwer:

| name              | sex | age | team          | games       | city      | sport    | event                                            | medal | 
| ----------------- | --- | --- | ------------- | ----------- | --------- | -------- | ------------------------------------------------ | ----- |
| Oscar Gomer Swahn | M	  | 64	 | Sweden	       | 1912 Summer	| Stockholm	| Shooting	| Shooting Men's Running Target, Single Shot, Team |	Gold  |
| Charles Jacobus   |	M	  | 64	 | United States |	1904 Summer	| St. Louis	| Roque    |	Roque Men's Singles	                             | Gold  |


#### 10. Find the Ratio of male and female athletes participated in all olympic games
Write a SQL query to get the ratio of male and female participants


##### Asnwer:


| ratio   |
| ------- |
| 1: 2.00 |


#### 11. Fetch the top 5 athletes who have won the most gold medals
SQL query to fetch the top 5 athletes who have won the most gold medals

```sql
WITH t1 as 
(SELECT Name, Team, COUNT(Medal) as total_gold_medals
FROM athlete_events$
WHERE Medal ='Gold'
GROUP BY Name, Team),

t2 as 
(SELECT *, dense_rank() over (order by total_gold_medals desc) as rank
FROM t1)

SELECT *
FROM t2
WHERE rank <=5;
```

##### Asnwer:

| name                                          | Team           | total_gold_medals | rank |
| --------------------------------------------- | -------------- | ------------------| ---- |
| Michael Fred Phelps, II	                      | United States  |	23	               | 1
Raymond Clarence "Ray" Ewry	                    | United States	 | 10                | 2
Mark Andrew Spitz	                              | United States	 | 9                 |	3
Frederick Carlton "Carl" Lewis                  |	United States	 | 9	                | 3
Larysa Semenivna Latynina (Diriy-)              |	Soviet Union	  | 9	                | 3
Paavo Johannes Nurmi	                           | Finland	       | 9	                | 3
Usain St. Leo Bolt	                             | Jamaica	       | 8	                | 4
Sawao Kato                                     	| Japan	         | 8	                | 4
Ole Einar Bjrndalen                             |	Norway	        | 8                 |	4
Jennifer Elisabeth "Jenny" Thompson (-Cumpelik)	| United States  | 8	                | 4
Matthew Nicholas "Matt" Biondi	                 | United States	 | 8	                | 4
Donald Arthur "Don" Schollander	                | United States	 | 7                 |	5
Nikolay Yefimovich Andrianov	                   | Soviet Union	  | 7                 |	5
Borys Anfiyanovych Shakhlin	                    | Soviet Union	  | 7	                | 5
Viktor Ivanovych Chukarin	                      | Soviet Union	  | 7	                | 5
Aladr Gerevich (-Gerei)                        	| Hungary        | 7	                | 5
Vra slavsk (-Odloilov)	                         | Czechoslovakia | 7                 |	5


#### 12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
SQL Query to fetch the top 5 athletes who have won the most medals (Medals include gold, silver and bronze)

```sql
SELECT TOP 5 Name, Team, COUNT(Medal) as tot_number_medals
FROM athlete_events$
WHERE Medal IN ('Gold', 'Silver', 'Bronze')
GROUP BY Name, Team
ORDER BY tot_number_medals desc
```

##### Asnwer:

| Name                               | Team          | tot_number_medals |
| ---------------------------------- | ------------- | ----------------- |
| Michael Fred Phelps, II           	| United States	| 28
| Larysa Semenivna Latynina (Diriy-)	| Soviet Union	 | 18
| Nikolay Yefimovich Andrianov	      | Soviet Union	 | 15
| Edoardo Mangiarotti	               | Italy         |	13
| Takashi Ono                        |	Japan	        | 13


#### 13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won
Write a SQL query to fetch the top 5 most successful countries in olympics. (Success is defined by no of medals won)
```sql

WITH countries as
(
SELECT Team, COUNT(Medal) as tot_number_medals
FROM athlete_events$
WHERE Medal IN ('Gold', 'Silver', 'Bronze')
GROUP BY Team),

rank as
(SELECT *, 
DENSE_RANK() over (order by tot_number_medals desc) as rnk
FROM countries)

Select Team, tot_number_medals, rnk
FROM rank
WHERE rnk <=5;
```

##### Asnwer:

| Team          | tot_number_medals | rnk |
| ------------- | ----------------- | --- |
| United States	| 5219	             | 1
| Soviet Union	 | 2451	             | 2
| Germany	      | 1984	             | 3
| Great Britain |	1673	             | 4
| France        |	1550	             | 5


#### 14. List down total gold, silver and bronze medals won by each country.
Write a SQL query to list down the  total gold, silver and bronze medals won by each country

```sql
SELECT country,
coalesce([Gold], 0) as Gold, --coalesce is to remove NULLS
coalesce([Silver], 0) as Silver,
coalesce([Bronze], 0) as Bronze

FROM
(
SELECT n.region as country, Medal, COUNT(1) as tot_medals
FROM athlete_events$ a
INNER JOIN noc_regions$ n
ON a.noc = n.noc
WHERE Medal <> 'NA' -- excluding NA from our result
GROUP BY n.region, Medal
--ORDER BY n.region, Medal
) AS Source_table

PIVOT --converts rows into columns
( 
	SUM(tot_medals) 
	FOR[Medal] IN ([Gold], [Silver], [Bronze])
 ) AS Pivot_table

 ORDER BY gold desc, silver desc, bronze desc
 ```
 
 
##### Asnwer:

| country                     | gold | silver | bronze |
| --------------------------- | ---- | ------ | ------ |
| USA	                      | 2638 | 1641   | 1358
| Russia                      |	1599 | 1170   | 1178
| Germany                     |	1301 | 1195   | 1260
| UK                          |	678  | 739    | 651
| Italy	                      | 575  | 531    | 531
| France	              | 501  | 610    | 666
| Sweden	              | 479  | 522    | 535
| Canada	              | 463  | 438    | 451
| Hungary	              | 432  | 332    | 371
| Norway	              | 378  | 361    | 294
| Australia	              | 368  | 459    | 522
| China	                      | 351  | 349    | 293
| Netherlands                 |	287  | 340    | 413
| Japan	                      | 247  | 309    | 357
| South Korea	              | 221  | 232    | 185
| Finland	              | 198  | 270    | 432
| Denmark	              | 179  | 241    | 177
| Switzerland	              | 175  | 248    | 268
| Cuba	                      | 164  | 129    | 116
| Romania	              | 161  | 200    | 292
| Serbia	              | 157  | 222    | 160
| India	                      | 138  | 19     | 40
| Czech Republic	      | 123  | 262    | 259
| Poland	              | 117  | 195    | 253
| Spain	                      | 110  | 243    | 136
| Brazil	              | 109  | 175    | 191
| Austria	              | 108  | 186    | 156
| Belgium	              | 98   | 197    | 173
| Argentina	              | 91   | 92     | 91
| New Zealand                 |	90   | 56     | 82
| Greece	              | 62   | 109    |	84
| Croatia	              | 58   | 54     | 37
| Bulgaria	              | 54   | 144    | 144
| Ukraine	              | 47   | 52     | 100
| Pakistan	              | 42   | 45     | 34
| Turkey	              | 40   | 27     | 28
| Jamaica	              | 38   | 75     | 44
| Kenya	                      | 34   | 41     | 31
| South Africa	              | 32   | 47     | 52
| Uruguay	              | 31   | 2      | 30
| Mexico	              | 30   | 26     | 54
| Belarus	              | 24   | 44     | 71
| Nigeria                     |	23   | 30     | 46
| Ethiopia	              | 22   | 9      | 22
| Kazakhstan	              | 20   | 25     | 32
| Cameroon                    |	20   | 1      | 1
| Iran	                      | 18   | 21     | 29
| Zimbabwe	              | 17   | 4      | 1
| North Korea	              | 16   | 16     | 35
| Slovakia	              | 15   | 19     | 13
| Bahamas	              | 14   | 11     | 15
| Estonia	              | 13   | 12     | 25
| Fiji	                      | 13   | 0      | 0
| Indonesia	              | 11   | 17     | 13
| Uzbekistan	              | 10   | 7      | 17
| Ireland	              | 9    | 13     | 13
| Thailand	              | 9    | 8      | 13
| Slovenia	              | 8    | 13     | 27
| Georgia	              | 8    | 6      | 18
| Azerbaijan	              | 7    | 12     | 25
| Trinidad	              | 7    | 8      | 22
| Egypt	                      | 7    | 8      | 12
| Lithuania                   |	6    | 7      | 48
| Morocco                     |	6    | 5      | 12
| Colombia	              | 5    | 9      | 14
| Algeria                     |	5    | 4      | 8
| Portugal	              | 4    | 11     | 26
| Luxembourg	              | 4    | 4      | 0
| Taiwan	              | 3    | 28     | 18
| Latvia	              | 3    | 19     | 13
| Chile	                      | 3    | 9      | 20
| Tunisia	              | 3    | 3      | 7
| Dominican Republic	      | 3    | 2      | 2
| Mongolia	              | 2    | 10     | 14
| Armenia	              | 2    | 5      | 9
| Venezuela	              | 2    | 3      | 10
| Uganda	              | 2    | 3      | 2
| Liechtenstein	              | 2    | 2      | 5
| Peru	                      | 1    | 14     | 0
| Vietnam	              | 1    | 3      | 0
| Puerto Rico	              | 1    | 2      | 6
| Syria	                      | 1    | 2      | 2
| Israel	              | 1    | 1      | 7
| Haiti	                      | 1    | 1      | 5
| Individual Olympic Athletes | 1    | 1      | 3
| Costa Rica                  |	1    | 1      | 2
| Tajikistan	              | 1    | 1      | 2
| Bahrain	              | 1    | 1      | 1
| Ivory Coast                 |	1    | 1      | 1
| Grenada                     |	1    | 1      | 0
| Burundi	              | 1    | 1      | 0
| Ecuador	              | 1    | 1      | 0
| Panama	              | 1    | 0      | 2
| Mozambique	              | 1    | 0      | 1
| Suriname	              | 1    | 0      | 1
| United Arab Emirates        |	1    | 0      | 1
| Nepal	                      | 1    | 0      | 0
| Jordan	              | 1    | 0      | 0
| Kosovo	              | 1    | 0      | 0
| Paraguay	              | 0    | 17     | 0
| Iceland	              | 0    | 15     | 2
| Montenegro	              | 0    | 14     | 0
| Malaysia	              | 0    | 11     | 5
| Namibia	              | 0    | 4      | 0
| Philippines	              | 0    | 3      | 7
| Moldova	              | 0    | 3      | 5
| Lebanon	              | 0    | 2      | 2
| Sri Lanka	              | 0    | 2      | 0
| Tanzania	              | 0    | 2      | 0
| Ghana	                      | 0    | 1      | 22
| Saudi Arabia	              | 0    | 1      | 5
| Qatar	                      | 0    | 1      | 4
| Kyrgyzstan	              | 0    | 1      | 2
| Niger	                      | 0    | 1      | 1
| Zambia	              | 0    | 1      | 1
| Tonga	                      | 0    | 1      | 0
| Virgin Islands, US	      | 0    | 1      | 0
| Senegal	              | 0    | 1      | 0
| Sudan	                      | 0    | 1      | 0
| Guatemala                   |	0    | 1      | 0
| Gabon	                      | 0    | 1      | 0
| Curacao	              | 0    | 1      | 0
| Cyprus	              | 0    | 1      | 0
| Botswana	              | 0    | 1      | 0
| Afghanistan	              | 0    | 0      | 2
| Kuwait	              | 0    | 0      | 2
| Iraq	                      | 0    | 0      | 1
| Guyana	              | 0    | 0      | 1
| Barbados	              | 0    | 0      | 1
| Bermuda	              | 0    | 0      | 1
| Djibouti	              | 0    | 0      | 1
| Eritrea	              | 0    | 0      | 1
| Monaco	              | 0    | 0      | 1
| Mauritius	              | 0    | 0      | 1
| Macedonia	              | 0    | 0      | 1
| Togo	                      | 0    | 0      | 1


#### 15. List down total gold, silver and bronze medals won by each country corresponding to each olympic games
Write a SQL query to list down the  total gold, silver and bronze medals won by each country corresponding to each olympic games


