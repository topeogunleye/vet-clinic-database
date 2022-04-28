/* Database schema to keep the structure of entire database. */
-- CREATE DATABASE
CREATE DATABASE vet_clinic;

DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOL,
    weight_kg DECIMAL
);

ALTER TABLE animals 
ADD COLUMN species VARCHAR;

CREATE TABLE owners(
    owner_id INT GENERATED ALWAYS AS IDENTITY,
    fullname VARCHAR(100),
    age INT 
    PRIMARY KEY(customer_id)
)
