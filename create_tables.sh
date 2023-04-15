#!/bin/bash

DB_NAME="universe"

echo "Creating tables in the $DB_NAME database"
psql -U freecodecamp -d $DB_NAME -f create_tables.sql

echo "Table creation complete"