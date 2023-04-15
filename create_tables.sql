CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  age_in_millions_of_years INT NOT NULL,
  distance_from_earth NUMERIC(10, 2) NOT NULL
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id),
  is_spherical BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  star_id INT REFERENCES star(star_id),
  has_life BOOLEAN NOT NULL,
  planet_type VARCHAR(255) NOT NULL
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  planet_id INT REFERENCES planet(planet_id),
  age_in_millions_of_years INT NOT NULL,
  distance_from_planet NUMERIC(10, 2) NOT NULL
);

CREATE TABLE asteroid (
  asteroid_id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  diameter_km NUMERIC(10, 2) NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  distance_from_earth NUMERIC(15, 2) NOT NULL
);