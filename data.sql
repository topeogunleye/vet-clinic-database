/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
       ('Gabumon', '2018-11-15', 2, true, 8),
       ('Pikachu', '2021-01-07', 1, false, 13.04),
       ('Devimon', '2017-05-12', 5, true, 11),
       ('Charmander', '2020-02-08', 0, false, -11),
       ('Plantmon', '2021-11-15', 2, true, -5.7),
       ('Squirtle', '1993-04-02', 3, false, -12.13),
       ('Angemon', '2005-06-12', 1, true, -45),
       ('Boarmon', '2005-06-07', 7, true, 20.4),
       ('Blossom', '1998-10-13', 3, true, 17),
       ('Ditto', '2022-05-14', 4, true, 4);

-- begin the transaction
BEGIN;

-- update the animals table by setting the species column to unspecified
UPDATE animals
SET species = 'unspecified';

-- roll back the transaction
ROLLBACK;

-- begin the transaction
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name like '%mon';
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     13.04 | 
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
-- (4 rows)


-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
--   3 | Pikachu | 2021-01-07    |               1 | f        |     13.04 | pokemon
-- (4 rows)

-- commit the transaction
COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE
FROM animals;

ROLLBACK;

-- Inside a transaction: Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE
FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

-- rollback the transaction to the savepoint
ROLLBACK TO SAVEPOINT my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- commit the transaction
COMMIT;


INSERT INTO owners (fullname, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon

UPDATE animals
SET species_id = (SELECT specie_id
                  FROM species
                  WHERE name = 'Digimon')
WHERE name like '%mon';

UPDATE animals
SET species_id = (SELECT specie_id
                  FROM species
                  WHERE name = 'Pokemon')
WHERE name NOT like '%mon';

UPDATE animals
SET owners_id = (SELECT owner_id
                 FROM owners
                 WHERE fullname = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owners_id = (SELECT owner_id
                 FROM owners
                 WHERE fullname = 'Jennifer Orwell')
WHERE name = 'Gabumon'
   OR name = 'Pikachu';

UPDATE animals
SET owners_id = (SELECT owner_id
                 FROM owners
                 WHERE fullname = 'Bob')
WHERE name = 'Devimon'
   OR name = 'Plantmon';

UPDATE animals
SET owners_id = (SELECT owner_id
                 FROM owners
                 WHERE fullname = 'Melody Pond' -- or name = 'Charmander'
)
WHERE name = 'Charmander'
   OR name = 'Squirtle'
   OR name = 'Blossom';

UPDATE animals
SET owners_id = (SELECT owner_id
                 FROM owners
                 WHERE fullname = 'Dean Winchester')
WHERE name = 'Angemon'
   OR name = 'Boarmon';

INSERT INTO vets
    (name)
VALUES ('William Tatcher'),
       ('Maisy Smith'),
       ('Stephanie Mendez'),
       ('Jack Harkness');

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.

INSERT INTO specializations
    (specie_id, vet_id)
VALUES
    ((SELECT specie_id
      FROM species
      WHERE name = 'Pokemon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'William Tatcher')),
    ((SELECT specie_id
      FROM species
      WHERE name = 'Digimon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Stephanie Mendez')),
    ((SELECT specie_id
      FROM species
      WHERE name = 'Digimon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Jack Harkness'));

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.

INSERT INTO visits
    (animal_id, vet_id, visit_date)
VALUES
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Agumon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'William Tatcher'),
     '2020-05-24'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Agumon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Stephanie Mendez'),
     '2020-07-22'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Gabumon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Jack Harkness'),
     '2021-02-02'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Pikachu'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-01-05'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Pikachu'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-03-08'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Pikachu'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-05-14'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Devimon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Stephanie Mendez'),
     '2021-05-04'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Charmander'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Jack Harkness'),
     '2021-02-24'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Plantmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2019-12-21'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Plantmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'William Tatcher'),
     '2020-08-10'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Plantmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-04-07'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Squirtle'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Stephanie Mendez'),
     '2019-09-29'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Angemon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Jack Harkness'),
     '2020-10-03'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Angemon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Jack Harkness'),
     '2021-11-04'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Boarmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2019-01-24'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Boarmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2019-05-15'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Boarmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-02-27'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Boarmon'),
     (SELECT vet_id
      FROM vets
      WHERE name = 'Maisy Smith'),
     '2020-09-03'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Blossom '),
     (SELECT vet_id
      FROM vets
      WHERE name = ' Stephanie Mendez'),
     '2020-24-05'),
    ((SELECT animal_id
      FROM animals
      WHERE name = 'Blossom '),
     (SELECT vet_id
      FROM vets
      WHERE name = ' William Tatcher'),
     '2021-01-11');




