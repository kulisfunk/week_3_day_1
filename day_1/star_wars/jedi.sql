DROP TABLE lightsabers;
DROP TABLE jedi; --deletes table to start with

CREATE TABLE jedi (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  darkside BOOLEAN,
  age INT
);

CREATE TABLE lightsabers (
  id SERIAL8 PRIMARY KEY, --gives unique id to rows
  hilt_metal VARCHAR(255) NOT NULL, -- don't accept any entries where data is missing
  colour VARCHAR(255) NOT NULL,
  owner INT8 REFERENCES jedi(id)--foreign key, makes this the id that links to jedi table
);




INSERT INTO jedi (name, darkside, age) VALUES ('luke', false, 21);
INSERT INTO jedi (name, darkside, age) VALUES ('vader', true, 100);
INSERT INTO jedi (name, age) VALUES ('obiwan', 33); --missing parameter set to null
INSERT INTO jedi (name, darkside, age) VALUES ('anakin', false, 12);
INSERT INTO jedi (name, darkside, age) VALUES ('obiwan', false, 32);

INSERT INTO lightsabers (hilt_metal, colour, owner) VALUES ('palladium', 'green', 1);--use id instead of name luke
INSERT INTO lightsabers (hilt_metal, colour, owner) VALUES ('gold', 'green', 3);


--UPDATE jedi SET darkside = true; --updates all darkside rows

UPDATE jedi SET darkside = true WHERE name = 'vader';
UPDATE jedi SET darkside = false WHERE name = 'obiwan';
UPDATE jedi SET darkside = true, age = 22 WHERE name = 'anakin';
UPDATE jedi SET age = 33 WHERE age = 32 AND name = 'obiwan';

--DELETE FROM jedi; --clears entire table contents
DELETE FROM jedi WHERE name = 'anakin';



SELECT * FROM jedi;
SELECT * FROM lightsabers;

--SELECT name, age FROM jedi; --read everything (*) or individual/multiple columns from jedi table

--SELECT COUNT(darkside) FROM jedi; --count everything (*) or individual/multiple columns
