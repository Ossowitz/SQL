CREATE TABLE company
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE CHECK ( date > '2000-01-01' AND date < '2023-05-07' )
);

INSERT INTO company (name, date)
VALUES ('Google', '2005-10-20'),
       ('Apple', '2007-08-14'),
       ('Facebook', '2002-05-09');

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    salary     INT,
    UNIQUE (first_name, last_name)
);

INSERT INTO employee (first_name, last_name, salary)
VALUES ('Ivan', 'Ivanov', 1000),
       ('Ivan', 'Sidorov', 500),
       ('Petr', 'Petrov', 2000),
       ('Sveta', 'Svetikova', 1500);