/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals
where name like '%mon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |              10 | t        |         0
--   2 | Gabumon | 2018-11-15    |               8 | t        |         2
--   4 | Devimon | 2017-05-12    |              11 | t        |         5
-- (3 rows)


SELECT name
FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

--   name   
-- ---------
--  Gabumon
--  Devimon
-- (2 rows)


SELECT name
FROM animals
WHERE neutered is false AND escape_attempts < 3;

--   name   
-- ---------
--  Pikachu
-- (1 row)


SELECT date_of_birth
FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';
--  date_of_birth 
-- ---------------
--  2020-02-03
--  2021-01-07
-- (2 rows)

SELECT name, escape_attempts
FROM animals
WHERE weight_kg < 10.5;
--   name   | escape_attempts 
-- ---------+-----------------
--  Agumon  |               0
--  Gabumon |               2
-- (2 rows)


SELECT * 
FROM animals
WHERE neutered is true;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |              10 | t        |         0
--   2 | Gabumon | 2018-11-15    |               8 | t        |         2
--   4 | Devimon | 2017-05-12    |              11 | t        |         5
-- (3 rows)

SELECT *
FROM animals
WHERE name NOT like 'Gabumon';
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |              10 | t        |         0
--   3 | Pikachu | 2021-01-07    |              15 | f        |         1
--   4 | Devimon | 2017-05-12    |              11 | t        |         5
-- (3 rows)

SELECT *
FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   7 | Pikachu | 2021-01-07    |               1 | f        |     13.04
--   8 | Devimon | 2017-05-12    |               5 | t        |        11
-- (2 rows)


-- Write queries to answer the following questionsons:
-- How many animals are there?
SELECT COUNT(*)
FROM animals;
--  count 
-- -------
--      4
-- (1 row)

-- How many animals have never tried to escape
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;
--          avg         
-- ---------------------
--  10.5675000000000000
-- (1 row)

-- Who escapes the most, neutered or not neutered animals?
SELECT 
    neutered, MAX(escape_attempts)
FROM
    animals
GROUP BY neutered
ORDER BY MAX(escape_attempts) DESC LIMIT 1;
--  neutered | max 
-- ----------+-----
--  t        |   5
-- (1 row)

-- What is the minimum and maximum weight of each type of animal?
SELECT
    MIN(weight_kg), MAX(weight_kg)
FROM
    animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
    AVG(escape_attempts)
FROM
    animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31';

--  avg 
-- -----
    
-- (1 row)

