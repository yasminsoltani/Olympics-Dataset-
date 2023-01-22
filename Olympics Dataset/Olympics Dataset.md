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
### Problem statement: Write a SQL query to find the total no of Olympic Games held as per the dataset.

```sql
SELECT COUNT(DISTINCT(Games)) as NumberOfGames 
FROM athlete_events$
```

#### 2. List down all Olympics games held so far.
### Problem statement: Write a SQL query to list down all the Olympic Games held so far

```sql
SELECT DISTINCT Year, Season, City
FROM athlete_events$
ORDER BY Year
```

#### 3. Mention the total no of nations who participated in each olympics game?
### Problem statement: SQL query to fetch total no of countries participated in each olympic games

```sql
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
```
