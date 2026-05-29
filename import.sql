-- INFT221 Final Project: Import Movie Data
-- Run this in Adminer or Beekeeper Studio while connected to the Docker database `final`.
--
-- Adminer login:
-- System: PostgreSQL
-- Server: postgres
-- Username: postgres
-- Password: postgres
-- Database: final
--
-- The Docker PostgreSQL container sees this project folder at /project.

DROP TABLE IF EXISTS movie_import_staging;

CREATE TEMP TABLE movie_import_staging (
    id TEXT,
    title TEXT,
    original_language TEXT,
    release_date TEXT,
    popularity TEXT,
    vote_average TEXT,
    vote_count TEXT,
    runtime TEXT,
    budget TEXT,
    revenue TEXT,
    status TEXT,
    tagline TEXT,
    overview TEXT,
    genres TEXT,
    production_companies TEXT,
    production_countries TEXT,
    spoken_languages TEXT
);

COPY movie_import_staging (
    id,
    title,
    original_language,
    release_date,
    popularity,
    vote_average,
    vote_count,
    runtime,
    budget,
    revenue,
    status,
    tagline,
    overview,
    genres,
    production_companies,
    production_countries,
    spoken_languages
)
FROM '/project/expensive_movie.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO movie (
    movie_id,
    title,
    release_date,
    runtime
)
SELECT
    id::INTEGER,
    title,
    NULLIF(release_date, '')::DATE,
    NULLIF(runtime, '')::INTEGER
FROM movie_import_staging;

INSERT INTO movie_stats (
    movie_stats_id,
    movie_id,
    popularity,
    vote_average,
    vote_count,
    budget,
    revenue
)
SELECT
    id::INTEGER,
    id::INTEGER,
    NULLIF(popularity, '')::NUMERIC,
    NULLIF(vote_average, '')::NUMERIC,
    NULLIF(vote_count, '')::INTEGER,
    NULLIF(budget, '')::INTEGER,
    NULLIF(revenue, '')::BIGINT
FROM movie_import_staging;

DROP TABLE IF EXISTS movie_import_staging;

