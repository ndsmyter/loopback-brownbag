CREATE TABLE mantis.locations (
  id           SERIAL PRIMARY KEY NOT NULL,
  name         VARCHAR(255)       NOT NULL,
  location_lat DOUBLE PRECISION,
  location_lon DOUBLE PRECISION
);


INSERT INTO mantis.locations (name, location_lat, location_lon) VALUES
  ('De Parking Wemeldinge', 51.528629, 3.965017),
  ('Sas van Goes', 51.540010, 3.929044),
  ('Zeelandbrug', 51.629601, 3.914571),
  ('Put van Ekeren', 51.282813, 4.390315);