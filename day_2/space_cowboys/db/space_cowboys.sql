DROP TABLE IF EXISTS bounty_list;

CREATE TABLE bounty_list(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bounty INT8,
  homeworld VARCHAR(255),
  favourite_weapon VARCHAR(255)
);
