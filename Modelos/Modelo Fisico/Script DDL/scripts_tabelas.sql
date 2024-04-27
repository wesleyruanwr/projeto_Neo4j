CREATE DATABASE IF NOT EXISTS db_netflix;
use db_netflix;

CREATE TABLE IF NOT EXISTS Show_ (
show_id VARCHAR AUTO_INCREMENT PRIMARY KEY,
title VARCHAR (255) NOT NULL,
type_show VARCHAR (255) NOT NULL,
release_year INT NOT NULL,
data_added DATE NOT NULL,
duration INT (4) NOT NULL,
listed_in VARCHAR (255) NOT NULL,
rating VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Country (
acronym VARCHAR (3) PRIMARY KEY NOT NULL,
country_name VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Actor (
actor_id INT NOT NULL PRIMARY KEY,
actor_name VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Director (
director_id INT NOT NULL PRIMARY KEY,
director_name VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Country_show (
pk_country VARCHAR (3) NOT NULL,
pk_show INT NOT NULL,
FOREIGN KEY (pk_country)
REFERENCES Country(acronym),
FOREIGN KEY (pk_show)
REFERENCES Show_ (show_id)

);

CREATE TABLE IF NOT EXISTS Director_show (
pk_director INT NOT NULL,
pk_show INT NOT NULL,
FOREIGN KEY (pk_show)
REFERENCES Show_ (show_id),
FOREIGN KEY (pk_director)
REFERENCES Director (director_id)

);

CREATE TABLE IF NOT EXISTS Cast (
pk_actor INT NOT NULL,
pk_show INT NOT NULL,
FOREIGN KEY (pk_actor)
REFERENCES Actor (actor_id),
FOREIGN KEY (pk_show)
REFERENCES Show_ (show_id)

)
