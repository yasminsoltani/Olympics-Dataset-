-- 1. How many olympics games have been held?
--Write a SQL query to find the total no of Olympic Games held as per the dataset.

SELECT *
FROM athlete_events$
ORDER BY ID 

SELECT *
FROM noc_regions$

SELECT COUNT(DISTINCT(Games)) as NumberOfGames 
FROM athlete_events$

--ANSWER: 51

--2. List down all Olympics games held so far.
--Write a SQL query to list down all the Olympic Games held so far.
SELECT DISTINCT Year, Season, City
FROM athlete_events$
ORDER BY Year

--3. Mention the total no of nations who participated in each olympics game?
--SQL query to fetch total no of countries participated in each olympic games.

with all_countries as

(SELECT  Distinct Games, reg.noc
FROM athlete_events$ ev
JOIN noc_regions$ reg --joining the other table
ON ev.noc = reg.noc --setting noc number of columns to be the same
GROUP BY Games, reg.noc) 

SELECT Games, count(1) as total_countires
FROM all_countries
GROUP BY Games
ORDER BY Games 

--4. Which year saw the highest and lowest no of countries participating in olympics
--Write a SQL query to return the Olympic Games which had the highest participating countries
--and the lowest participating countries.


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


--5. Which nation has participated in all of the olympic games
--SQL query to return the list of countries who have been part of every Olympics games.
--1) Find total number of Olympic Games
--2) Find total number of countries
--3) Fetch the countries who have participated in all games

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

--Different approach
--I initially used this but wasn't able to fetch only the countries who participated in all the 51 games so
--just selected the top 4 rows (which were the 4 countries that participated in all 51 games, but I know that's not how you're supposed to do it lol)

With t1 as
(SELECT Team, COUNT(DISTINCT Games) as tot_num_games
FROM athlete_events$
GROUP BY Team
)

SELECT TOP 4 * --in our case we know the top 4 rows are the ones we are looking for, but we should assume we wouldn't know in first place... so this approach doesn't work, but it was the best I could come up with at first  
FROM t1
ORDER BY tot_num_games desc


--6. Identify the sport which was played in all summer olympics.
--SQL query to fetch the list of all sports which have been part of every olympics.
-- 1) Find total no of summer olympics games
-- 2) Find for each sport, how many games where they played in
-- 3) compare 1 & 2

--answering question 1

With t1 as
(Select count(distinct Games) as total_summer_games
FROM athlete_events$ 
WHERE Season = 'Summer'
),

--answering question 2

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

--7. Which Sports were just played only once in the olympics.
-- Using SQL query, Identify the sport which were just played once in all of olympics


WITH t1 as
(SELECT distinct games, Sport
FROM athlete_events$
),
t2 as
(SELECT sport, Count(games) as no_of_games
from t1
group by sport)

 select t2.*, t1.games
 from t2
 join t1 on t1.sport = t2.sport
 where t2.no_of_games = 1
 order by sport;

--8. Fetch the total no of sports played in each olympic games
-- Write SQL query to fetch the total no of sports played in each olympics

SELECT Games, count(DISTINCT (Sport)) as no_of_sports
from athlete_events$
group by games
order by no_of_sports desc 


--9. Fetch oldest athletes to win a gold medal
--SQL Query to fetch the details of the oldest athletes to win a gold medal at the olympics.

SELECT TOP 2 name, sex, age, team, games, city, sport, event, medal 
FROM athlete_events$
WHERE Medal = 'Gold'
ORDER BY AGE desc

--10. Find the Ratio of male and female athletes participated in all olympic games.
-- Write a SQL query to get the ratio of male and female participants
--1) Group males and females participant in two different tables
--2) Find the number of total females and total males
--3) Do the ratio of those two tables


with m as
(SELECT COUNT(Sex) as tot_males
FROM athlete_events$
WHERE Sex = 'M'
GROUP BY Sex
),

f as
(SELECT COUNT(Sex) as tot_females
FROM athlete_events$
WHERE Sex = 'F'
GROUP BY Sex
)

SELECT concat('1: ', str(CAST(tot_males/tot_females AS decimal), 4, 3)) as ratio --I tried converting the ratio in decimal using CAST and 
-- then str() to return specific number of digits and decimal places but did not succeed as the final output was still 2 instead than 2.64 :(
FROM m, f


--11. Fetch the top 5 athletes who have won the most gold medals
--SQL query to fetch the top 5 athletes who have won the most gold medals
--1. Find athletes who won gold medal
--2. Find total number of gold medal won by each athlete
--3. Order them from greater to smaller

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

--12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
--SQL Query to fetch the top 5 athletes who have won the most medals (Medals include gold, silver and bronze)

SELECT TOP 5 Name, Team, COUNT(Medal) as tot_number_medals
FROM athlete_events$
WHERE Medal IN ('Gold', 'Silver', 'Bronze')
GROUP BY Name, Team
ORDER BY tot_number_medals desc
 
 --13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won
 --Write a SQL query to fetch the top 5 most successful countries in olympics. (Success is defined by no of medals won).

WITH countries AS
( SELECT n.region, count(medal) AS total_medals
            FROM athlete_events$ a
            JOIN noc_regions$ n 
			ON n.noc = a.noc
            WHERE medal <> 'NA'
            GROUP BY n.region),

rank AS
(SELECT *, 
DENSE_RANK() OVER (ORDER BY total_medals DESC) AS rnk
FROM countries)

SELECT *
FROM rank
WHERE rnk <=5
ORDER BY total_medals DESC

--14. List down total gold, silver and bronze medals won by each country.
--Write a SQL query to list down the  total gold, silver and bronze medals won by each country

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

 -- 15. List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
 -- Write a SQL query to list down the  total gold, silver and bronze medals won by each country corresponding to each olympic games.

 SELECT n.region, Games, 
 SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) as gold,
 SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) as silver,
 SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) as bronze
 FROM noc_regions$ n
 INNER JOIN athlete_events$ a
 ON n.noc = a.noc
 GROUP BY region, games
 ORDER BY Games

 -- 16. Identify which country won the most gold, most silver and most bronze medals in each olympic games
 -- Write SQL query to display for each Olympic Games, which country won the highest gold, silver and bronze medals

 with temp as 
 (
SELECT substring(games_country, 1,  11 ) as games,
substring(games_country, 13,  15 ) as country,
coalesce([Gold], 0) as Gold, --coalesce is to remove NULLS
coalesce([Silver], 0) as Silver,
coalesce([Bronze], 0) as Bronze

FROM
(
SELECT concat(games, '-', n.region) as games_country, Medal, COUNT(1) as tot_medals
FROM athlete_events$ a
INNER JOIN noc_regions$ n
ON a.noc = n.noc
WHERE Medal <> 'NA' -- excluding NA from our result
GROUP BY n.region, games, Medal
--ORDER BY n.region, Medal
) AS Source_table

PIVOT --converts rows into columns
( 
	SUM(tot_medals) 
	FOR[Medal] IN ([Gold], [Silver], [Bronze])
 ) AS Pivot_table

 )
 
 SELECT DISTINCT games , concat(first_value(country) over(partition by games order by gold desc), ' - ',
 
 first_value(gold) over(partition by games order by gold desc)) as Max_Gold,
 
 concat(first_value(country) over(partition by games order by silver desc), ' - ',
 
 first_value(silver) over(partition by games order by silver desc)) as Max_Silver,
 
 concat(first_value(country) over(partition by games order by bronze desc), ' - ',
 
 first_value(bronze) over(partition by games order by bronze desc)) as Max_Bronze
   
   FROM temp
    ORDER BY games;


--17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
--  Similar to the previous query, identify during each Olympic Games, which country won the highest gold, silver and bronze medals.
--Along with this, identify also the country with the most medals in each olympic games.

 with temp as 
 (
SELECT substring(games_country, 1,  11 ) as games,
substring(games_country, 13,  15 ) as country,
coalesce([Gold], 0) as Gold, --coalesce is to remove NULLS
coalesce([Silver], 0) as Silver,
coalesce([Bronze], 0) as Bronze

FROM
(
SELECT concat(games, '-', n.region) as games_country, Medal, COUNT(1) as tot_medals
FROM athlete_events$ a
INNER JOIN noc_regions$ n
ON a.noc = n.noc
WHERE Medal <> 'NA' -- excluding NA from our result
GROUP BY n.region, games, Medal
--ORDER BY n.region, Medal
) AS Source_table

PIVOT --converts rows into columns
( 
	SUM(tot_medals) 
	FOR[Medal] IN ([Gold], [Silver], [Bronze])
 ) AS Pivot_table

 ),

 tot_medals as
    		(SELECT games, nr.region as country, count(1) as total_medals
    		FROM athlete_events$ oh
    		JOIN noc_regions$ nr 
			ON nr.noc = oh.noc
    		where medal <> 'NA'
    		GROUP BY games,nr.region )
 
 SELECT DISTINCT t.games , concat(first_value(t.country) over(partition by t.games order by gold desc), ' - ',
 
 first_value(gold) over(partition by t.games order by gold desc)) as Max_Gold,
 
 concat(first_value(t.country) over(partition by t.games order by silver desc), ' - ',
 
 first_value(silver) over(partition by t.games order by silver desc)) as Max_Silver,
 
 concat(first_value(t.country) over(partition by t.games order by bronze desc), ' - ',
 
 first_value(bronze) over(partition by t.games order by bronze desc)) as Max_Bronze, 
   
   concat(first_value(tm.country) over (partition by tm.games order by total_medals desc)
    			, ' - '
    			, first_value(tm.total_medals) over(partition by tm.games order by total_medals desc)) as Max_Medals
   FROM temp t
   join tot_medals tm on tm.games = t.games and tm.country = t.country
    ORDER BY games;


 -- 18. Which countries have never won gold medal but have won silver/bronze medals?
 -- Write a SQL Query to fetch details of countries which have won silver or bronze medal but never won a gold medal


 with number_of_medals as 
 ( SELECT n.region,
 SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) as gold,
 SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) as silver,
 SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) as bronze

 from noc_regions$ n
 inner join athlete_events$ a
 on n.NOC = a.NOC
 group by region
)
SELECT region, gold, silver, bronze
from number_of_medals
where gold = 0
and (silver > 0 or bronze > 0 )
order by silver, bronze desc


-- 19. In which Sport/event, India has won highest medals
-- Write SQL Query to return the sport which has won India the highest no of medals

SELECT top 1 sport, count(medal) as tot_medals
from athlete_events$
where team = 'India'
and medal != 'NA'
group by sport
order by tot_medals desc

 -- 20. Break down all olympic games where India won medal for Hockey and how many medals in each olympic games
 -- Write an SQL Query to fetch details of all Olympic Games where India won medal(s) in hockey.

SELECT team, sport, games, count(medal) as total_medals
FROM athlete_events$
where sport = 'Hockey'
and team = 'India'
and medal != 'NA'
group by Team, Games, sport
order by total_medals desc

