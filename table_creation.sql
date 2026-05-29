-- INFT221 Final Project: Table Creation Worksheet
-- Database: final
--
-- Open Adminer at http://localhost:8080 and log in with:
-- System: PostgreSQL
-- Server: postgres
-- Username: postgres
-- Password: postgres
-- Database: final
--
-- Or use Beekeeper Studio:
-- Connection type: Postgres
-- Host: localhost
-- Port: 5432
-- User: postgres
-- Password: postgres
-- Default database: final
--
-- Important:
-- This file is a worksheet. You will write and run the actual SQL.
-- The database is the workspace; this SQL file is the set of instructions
-- you run inside that workspace.

-- ------------------------------------------------------------
-- Step 1: Drop tables if they already exist
-- ------------------------------------------------------------
-- Because movie_stats depends on movies, drop movie_stats first.
--
-- Write your DROP TABLE statements below.



-- ------------------------------------------------------------
-- Step 2: Create the movies table
-- ------------------------------------------------------------
-- One row should represent one movie.
--
-- Columns to include:
-- id             INTEGER, primary key
-- title          TEXT
-- release_date   DATE
-- runtime        INTEGER
--
-- Think about:
-- Which columns should be NOT NULL?
-- Should release_date allow blanks from the CSV?
--
-- Write your CREATE TABLE statement below.



-- ------------------------------------------------------------
-- Step 3: Create the movie_stats table
-- ------------------------------------------------------------
-- One row should represent the popularity, vote, budget, and revenue
-- information for one movie.
--
-- Columns to include:
-- movie_id       INTEGER, primary key, foreign key to movies(id)
-- popularity     NUMERIC
-- vote_average   NUMERIC
-- vote_count     INTEGER
-- budget         INTEGER
-- revenue        INTEGER
--
-- Think about:
-- How do you show that movie_stats.movie_id connects to movies.id?
-- Which column identifies one row in movie_stats?
--
-- Write your CREATE TABLE statement below.



