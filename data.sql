/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES 
        ('Agumon', '2020-02-03', 0, true, 10.23),
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
