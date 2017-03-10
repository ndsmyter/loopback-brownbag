CREATE TABLE mantis.participants (
  id      SERIAL PRIMARY KEY,
  dive_id SERIAL       NOT NULL REFERENCES mantis.dives (id),
  name    VARCHAR(255) NOT NULL,
  license VARCHAR(5)   NOT NULL
);

INSERT INTO mantis.participants (dive_id, name, license) VALUES
  (1, 'Nicolas De Smyter', '1*I'),
  (2, 'Nicolas De Smyter', '1*I'),
  (3, 'Nicolas De Smyter', '1*I'),
  (4, 'Nicolas De Smyter', '1*I'),
  (1, 'John Doe', '3*D'),
  (2, 'Jack Jones', '2*D'),
  (3, 'Mary Johnson', '1*D'),
  (4, 'Jane Jones', '2*D'),
  (1, 'Jack Jones', '2*D'),
  (2, 'Mary Jones', '2*I'),
  (3, 'Jane Doe', '2*D');