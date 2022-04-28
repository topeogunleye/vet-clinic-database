/* Database schema to keep the structure of entire database. */
-- CREATE DATABASE
DROP DATABASE IF EXISTS vet_clinic;
CREATE DATABASE vet_clinic;

DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    animal_id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOL,
    weight_kg DECIMAL
);

ALTER TABLE animals 
ADD COLUMN species VARCHAR;

DROP TABLE IF EXISTS owners;
CREATE TABLE owners(
    owner_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fullname VARCHAR(100),
    age INT 
);

DROP TABLE IF EXISTS species;
CREATE TABLE species(
    specie_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);

ALTER TABLE animals 
ADD PRIMARY KEY (animal_id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species 
FOREIGN KEY (species_id) 
REFERENCES species (specie_id);

ALTER TABLE animals
ADD COLUMN owners_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners 
FOREIGN KEY (owners_id) 
REFERENCES owners (owner_id);