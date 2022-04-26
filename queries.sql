/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals
where name like '%mon';

 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |              10 | t        |         0
  2 | Gabumon | 2018-11-15    |               8 | t        |         2
  4 | Devimon | 2017-05-12    |              11 | t        |         5
(3 rows)
