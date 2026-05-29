# Schema Plan: Movie Performance Dataset

## Dataset Focus

This project will focus on movie performance using the columns the student selected:

- title
- release date
- popularity
- vote average
- vote count
- runtime
- budget
- revenue

The goal is to keep the database simple, readable, and relational by splitting the data into two connected tables.

## Table 1: `movie`

One row in this table represents one movie.

| Column | Suggested PostgreSQL Type | Notes |
| --- | --- | --- |
| `movie_id` | `INTEGER` | The movie ID from the CSV. This should identify one movie. |
| `title` | `TEXT` | The movie title. |
| `release_date` | `DATE` | The movie's release date. Some rows have blank dates, so this may need to allow null values. |
| `runtime` | `INTEGER` | Runtime in minutes. Some rows contain `0`, which may mean unknown. |

### Key

- Suggested primary key: `movie_id`
- Reason: The `ID` column is unique for every row in the CSV.

## Table 2: `movie_stats`

One row in this table represents the rating, popularity, and money information for one movie.

| Column | Suggested PostgreSQL Type | Notes |
| --- | --- | --- |
| `movie_stats_id` | `INTEGER` | Primary key for each stats row. |
| `movie_id` | `INTEGER` | Connects each stats row back to one row in `movies`. |
| `popularity` | `NUMERIC` | Popularity includes decimal values. |
| `vote_average` | `NUMERIC` | Vote average includes decimal values. |
| `vote_count` | `INTEGER` | Number of votes. Useful for understanding how reliable the average rating might be. |
| `budget` | `INTEGER` | Budget values are whole numbers in the CSV. |
| `revenue` | `BIGINT` | Revenue values are whole numbers, and some values are too large for regular `INTEGER`. |

### Key

- Suggested primary key: `movie_stats_id`
- Suggested foreign key: `movie_id` points to `movie.movie_id`
- Reason: There should be one stats row for each movie, and that stats row should connect to the matching movie.

## Relationship

The relationship is:

- `movie.movie_id` connects to `movie_stats.movie_id`

This lets the database keep movie identity information in one table and movie performance measurements in another table. Later, queries can combine the two tables when a question needs both the title and the stats.

## Columns Not Used

The original CSV also includes columns such as:

- `Original_Language`
- `Status`
- `Tagline`
- `Overview`
- `Genres`
- `Production_Companies`
- `Production_Countries`
- `Spoken_Languages`

These are interesting, but they are outside this project's chosen focus. Leaving them out keeps the schema easier to understand and keeps the analysis centered on movie performance.

## Data Quality Notes

- `release_date` has some blank values.
- `runtime`, `budget`, and `revenue` sometimes contain `0`. These may represent unknown values rather than true zero values.
- `budget` is stored as a whole number and fits in `INTEGER`.
- `revenue` is stored as a whole number but needs `BIGINT` because some values are above the regular PostgreSQL integer limit.
