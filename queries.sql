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

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?

-- What animals belong to Melody Pond
SELECT
  animals.name
FROM
  animals
JOIN
  owners
ON
  animals.owners_id = owners.owner_id
WHERE
  owners.fullname = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  animals.name
FROM
  animals
JOIN
  species
ON
  animals.species_id = species.specie_id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  name
FROM
  owners
  JOIN animals
  ON owners.owner_id = animals.owners_id;

-- How many animals are there per species
SELECT
  species.name, COUNT(*)
FROM
  animals
JOIN
  species
ON
  animals.species_id = species.specie_id
GROUP BY
  species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT
  animals.name
FROM
  animals
JOIN
  owners
ON
  animals.owners_id = owners.owner_id
WHERE
  owners.fullname = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT
  animals.name
FROM
  animals
JOIN
  owners
ON
  animals.owners_id = owners.owner_id
WHERE
  owners.fullname = 'Dean Winchester' AND animals.escape_attempts = 0;


-- Who owns the most animals
SELECT
  owners.fullname, COUNT(*)
FROM
  owners
  JOIN animals
  ON owners.owner_id = animals.owners_id
GROUP BY
  owners.fullname
ORDER BY
  COUNT(*) DESC
LIMIT 1;

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?

SELECT
  owners.fullname
FROM
  owners
  JOIN animals
  ON owners.owner_id = animals.owners_id
  JOIN visits
  ON animals.animal_id = visits.animals_id
WHERE
  owners.fullname = 'William Tatcher'
  ORDER BY
  visits.date_of_visit DESC
  LIMIT 1;

  -- How many different animals did Stephanie Mendez see?
SELECT
  COUNT(DISTINCT animals.name)
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
WHERE
  vets.name = 'Vet Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties
SELECT
  vets.name, species.name AS specialty
FROM
  vets
JOIN
  specializations
ON
  vets.vet_id = specializations.vets_id
JOIN
  species
ON
  specializations.species_id = species.specie_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020

SELECT
  animals.name
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
WHERE
  vets.name = 'Vet Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets
SELECT
  animals.name, COUNT(*)
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
GROUP BY
  animals.name
ORDER BY
  COUNT(*) DESC LIMIT 1;


--  Who was Maisy Smith's first visit
SELECT
  animals.name
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
WHERE
  vets.name = 'Vet Maisy Smith'
ORDER BY
  visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT
  animals.name, vets.name, visits.date_of_visit
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
ORDER BY
  visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(*)
FROM
  visits
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
WHERE
  vets.vet_id NOT IN (
    SELECT
      vets.vet_id
    FROM
      vets
    JOIN
      specializations
    ON
      vets.vet_id = specializations.vets_id
    JOIN
      animals
    ON
      specializations.species_id = animals.species_id
    WHERE
      animals.name = 'pokemon'
  );

--  What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  species.name
FROM
  animals
JOIN
  visits
ON
  animals.animal_id = visits.animals_id
JOIN
  vets
ON
  visits.vets_id = vets.vet_id
JOIN
  specializations
ON
  vets.vet_id = specializations.vets_id
JOIN
  species
ON
  specializations.species_id = species.specie_id
WHERE
  vets.name = 'Vet Maisy Smith'
GROUP BY
  species.name
ORDER BY
  COUNT(*) DESC LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;

explain analyze SELECT * FROM visits where vets_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

