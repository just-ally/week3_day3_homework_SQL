DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT,
  last_known_location VARCHAR(255),
  favourite_weapon VARCHAR(255)
);

-- CREATE
-- READ
-- UPDATE
-- DELETE
