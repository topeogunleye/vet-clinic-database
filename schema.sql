/* Database schema to keep the structure of entire database. */
-- CREATE DATABASE
-- DROP DATABASE IF EXISTS vet_clinic;
-- CREATE DATABASE vet_clinic;

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

CREATE TABLE vets(
    vet_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations(
  specie_id INT GENERATED ALWAYS AS IDENTITY,
  species_id INT REFERENCES species(specie_id),
  vets_id INT REFERENCES vets(vet_id),
  PRIMARY KEY(specie_id)
);

CREATE TABLE visits(
  visit_id INT GENERATED ALWAYS AS IDENTITY,
  animals_id INT REFERENCES animals(animal_id),
  vets_id INT REFERENCES vets(vet_id),
  date_of_visit DATE,
  PRIMARY KEY(visit_id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ON visits (animals_id)
CREATE INDEX ON visits (vets_id)
CREATE INDEX ON owners (email);
