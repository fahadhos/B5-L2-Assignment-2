

-- Creating Table in rangers
CREATE Table rangers (
   
    ranger_id serial PRIMARY KEY  UNIQUE,
    "name" VARCHAR (50),
    region VARCHAR(50) 
)
 
--  creating table for species
CREATE Table species (
   
    species_id  SERIAL PRIMARY KEY   UNIQUE,
    common_name VARCHAR(50),
    scientific_name VARCHAR(80),
    discovery_date DATE,
    conservation_status VARCHAR(50)

)

-- Read from rangers
SELECT * from rangers

-- Creating table for sightings
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    species_id INTEGER REFERENCES species(species_id),
    sighting_time TIMESTAMP,
    "location" VARCHAR(50),
    notes VARCHAR(100) 
)

-- Inserting data in rangers
INSERT into rangers ("name", region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range')

--Inserting Sample data into species table
 
INSERT into species (common_name, scientific_name,discovery_date,conservation_status) VALUES
('Snow Leopard', 'Panthera uncia'    , '1775-01-01' , 'Endangered'),
('Bengal Tiger', 'Panthera tigris' , '1758-01-01', 'Endangered'),
( 'Red Panda'  , 'Ailurus fulgens'  , '1825-01-01' , 'Vulnerable'),       
( 'Asiatic Elephant'  , 'Elephas maximus indicus', '1758-01-01' , 'Endangered')   


SELECT * FROM species;

 
-- Inserting data in rangers
INSERT into sightings ( species_id, ranger_id,"location", sighting_time,notes) VALUES
(1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),
(3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
(1,2,'Snowfall Pass','2024-05-18 18:30:00', NULL )


SELECT * from sightings



-- Problem 1------------

INSERT into rangers ("name", region) VALUES
('Derek Fox', 'Coastal Plains')
-- ----------------------------------
 

-- Problem 2
SELECT count(DISTINCT(species_id)) as unique_species_count FROM sightings


-- Problem 3

SELECT * FROM sightings WHERE "location" ILIKE '%Pass'

SELECT * FROM rangers
-- Problem 4 ---

SELECT "name"  ,  count(sightings.ranger_id ) as total_sightings     from sightings  INNER join rangers on  (sightings.ranger_id = rangers.ranger_id) GROUP BY "name" ORDER BY "name" asc   

-- Problem 5 ---
 

SELECT common_name from species LEFT JOIN sightings on   (species.species_id = sightings.species_id )  WHERE sightings.species_id is NULL



-- Problem 6

SELECT common_name, sighting_time , "name" from sightings join species on sightings.species_id = species.species_id
JOIN rangers on sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time desc LIMIT 2


-- Problem 7

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01'

SELECT * from species

-- Problem 8

SELECT sighting_id, 'Morning' AS time_of_day
FROM sightings
WHERE EXTRACT(HOUR FROM sighting_time) < 12

UNION  

SELECT sighting_id, 'Afternoon' AS time_of_day
FROM sightings
WHERE EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) < 17

UNION  

SELECT sighting_id, 'Evening' AS time_of_day
FROM sightings
WHERE EXTRACT(HOUR FROM sighting_time) >= 17
ORDER BY sighting_id ASC


-- Problem 9
SELECT * FROM rangers

DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings)