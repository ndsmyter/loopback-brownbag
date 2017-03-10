CREATE TABLE mantis.dives (
  id          SERIAL PRIMARY KEY NOT NULL,
  name        VARCHAR(255)       NOT NULL,
  date        TIMESTAMP,
  location_id SERIAL REFERENCES mantis.locations (id)
);

INSERT INTO mantis.dives (name, date, location_id) VALUES
  ('Kerstduik', '2016-12-25 12:00:00', 1),
  ('Oudejaarsduik', '2016-12-31 23:00:00', 2),
  ('Nieuwjaarsduik', '2017-01-01 10:00:00', 3),
  ('Demoduik', '2017-03-17 12:00:00', 4);