CREATE TABLE mantis.locations (
  id           SERIAL PRIMARY KEY NOT NULL,
  name         VARCHAR(255)       NOT NULL,
  location_lat DOUBLE PRECISION,
  location_lon DOUBLE PRECISION,
  country      CHARACTER VARYING(50)
);


INSERT INTO mantis.locations (name, location_lat, location_lon, country) VALUES
  ('De Parking Wemeldinge', 51.528629, 3.965017, 'Nederland'),
  ('Sas van Goes', 51.540010, 3.929044, 'Nederland'),
  ('Zeelandbrug', 51.629601, 3.914571, 'Nederland'),
  ('Put van Ekeren', 51.282813, 4.390315, 'Belgie');