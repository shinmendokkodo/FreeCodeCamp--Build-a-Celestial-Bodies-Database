#!/bin/bash

DB_NAME="universe"
TABLES=("galaxy" "star" "planet" "moon" "asteroid")

for table in "${TABLES[@]}"; do
  echo "Clearing the $table table"
  psql -U freecodecamp -d $DB_NAME -c "TRUNCATE TABLE $table CASCADE" &>/dev/null
done

echo "Inserting data into the galaxy table"
while IFS=, read -r name description age_in_millions_of_years distance_from_earth; do
  psql -U freecodecamp -d $DB_NAME -c "INSERT INTO galaxy (name, description, age_in_millions_of_years, distance_from_earth) VALUES ('$name', '$description', $age_in_millions_of_years, $distance_from_earth);" #&>/dev/null
  echo "Inserted galaxy: $name"
done < <(tail -n +2 galaxy.csv)

echo "Inserting data into the asteroid table"
while IFS=, read -r name diameter_km is_spherical distance_from_earth; do
  psql -U freecodecamp -d $DB_NAME -c "INSERT INTO asteroid (name, diameter_km, is_spherical, distance_from_earth) VALUES ('$name', $diameter_km, $is_spherical, $distance_from_earth);" #&>/dev/null
  echo "Inserted asteroid: $name"
done < <(tail -n +2 asteroid.csv)

echo "Inserting data into the star table"
while IFS=, read -r name galaxy_name is_spherical age_in_millions_of_years; do
  psql -U freecodecamp -d $DB_NAME -c "INSERT INTO star (name, galaxy_id, is_spherical, age_in_millions_of_years) VALUES ('$name', (SELECT galaxy_id FROM galaxy WHERE name='$galaxy_name'), $is_spherical, $age_in_millions_of_years);" &>/dev/null
  echo "Inserted star: $name in galaxy: $galaxy_name"
done < <(tail -n +2 star.csv)

echo "Inserting data into the planet table"
while IFS=, read -r name star_name has_life planet_type; do
  psql -U freecodecamp -d $DB_NAME -c "INSERT INTO planet (name, star_id, has_life, planet_type) VALUES ('$name', (SELECT star_id FROM star WHERE name='$star_name'), $has_life, '$planet_type');" &>/dev/null
  echo "Inserted planet: $name orbiting star: $star_name"
done < <(tail -n +2 planet.csv)

echo "Inserting data into the moon table"
while IFS=, read -r name planet_name age_in_millions_of_years distance_from_planet; do
  psql -U freecodecamp -d $DB_NAME -c "INSERT INTO moon (name, planet_id, age_in_millions_of_years, distance_from_planet) VALUES ('$name', (SELECT planet_id FROM planet WHERE name='$planet_name'), $age_in_millions_of_years, $distance_from_planet);" &>/dev/null
  echo "Inserted moon: $name orbiting planet: $planet_name"
done < <(tail -n +2 moon.csv)

echo "Data insertion complete"
