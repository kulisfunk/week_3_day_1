DROP TABLE bitings;
DROP TABLE victims;
DROP TABLE zombies;

CREATE TABLE zombies (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255)
);

CREATE TABLE victims (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  run_speed INT
);

CREATE TABLE bitings (
  id SERIAL8 PRIMARY KEY,
  zombie_id INT8 REFERENCES zombies(id),
  victim_id INT8 REFERENCES victims(id),
  infected_on DATE NOT NULL
);


INSERT INTO zombies (name, type) VALUES ('John', 'Godfather');
INSERT INTO zombies (name, type) VALUES ('Ally', 'Runner');
INSERT INTO zombies (name, type) VALUES ('Steve', 'Clicker');

INSERT INTO victims (name, run_speed) VALUES ('Martin', 15);
INSERT INTO victims (name, run_speed) VALUES ('Louise', 22);
INSERT INTO victims (name, run_speed) VALUES ('Michael', 30);

INSERT INTO bitings (zombie_id, victim_id, infected_on) VALUES (1, 3, 'October 2 2017');
INSERT INTO bitings (zombie_id, victim_id, infected_on) VALUES (2, 1, 'October 2 2017');
INSERT INTO bitings (zombie_id, victim_id, infected_on) VALUES (3, 2, 'October 2 2017');
INSERT INTO bitings (zombie_id, victim_id, infected_on) VALUES (1, 1, 'October 2 2017');

SELECT * FROM zombies;
SELECT * FROM victims;
SELECT * FROM bitings;
