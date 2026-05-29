# Movie Performance Database Project

## Dataset

This project uses `expensive_movie.csv`, a movie dataset with 8,121 rows. One row represents one movie and includes information such as title, release date, runtime, popularity, vote average, vote count, budget, and revenue.

The dataset was provided as a local CSV file for this project. During exploration, the main focus became movie performance: how runtime, voting, popularity, budget, and revenue relate to one another.

## Data Exploration Summary

The data exploration showed that `ID` uniquely identifies each movie, making it a strong primary key candidate. Several numeric columns contain many `0` values, especially `budget`, `revenue`, `runtime`, `vote_average`, and `vote_count`, so some `0` values may represent unknown data rather than true zero values.

The dataset also includes future release dates and movies with different production statuses. For this project, the schema focuses on the selected performance columns instead of using every column from the original CSV.

## Database Schema

The data was split into two related tables.

### `movie`

One row represents one movie.

| Column | Type | Description |
| --- | --- | --- |
| `movie_id` | `INTEGER` | Primary key from the CSV `ID` column |
| `title` | `TEXT` | Movie title |
| `release_date` | `DATE` | Movie release date |
| `runtime` | `INTEGER` | Runtime in minutes |

### `movie_stats`

One row represents the performance statistics for one movie.

| Column | Type | Description |
| --- | --- | --- |
| `movie_stats_id` | `INTEGER` | Primary key for the stats row |
| `movie_id` | `INTEGER` | Foreign key connected to `movie.movie_id` |
| `popularity` | `NUMERIC` | Popularity score |
| `vote_average` | `NUMERIC` | Average vote score |
| `vote_count` | `INTEGER` | Number of votes |
| `budget` | `INTEGER` | Movie budget |
| `revenue` | `BIGINT` | Movie revenue, using `BIGINT` because some revenue values are above the regular integer limit |

## Guided SQL Queries

1. `queries/query_1.sql` - Finds the 10 highest-revenue movies with a known budget.
2. `queries/query_2.sql` - Counts how many movies appear for each runtime length.
3. `queries/query_3.sql` - Calculates average revenue for each runtime length using known revenue values.
4. `queries/query_4.sql` - Filters runtime groups to those with average revenue above 100 million dollars.
5. `queries/query_5.sql` - Shows movie titles, release dates, runtimes, vote averages, and vote counts together.
6. `queries/query_6.sql` - Finds runtime lengths with the highest average vote scores and counts movies in each runtime group.

## Discussion Queries

### High Ratings With Low Vote Counts

This query finds movies with very high vote averages but very low vote counts.

Student explanation: Yes, its on par with Cinemascore, and how Letterboxd users rate. When only a few people vote, it can limit the variety of opinions. This could be misleading because it could be due to influence culture.

### Runtime and Popularity

This query explores whether longer movies tend to have higher popularity scores.

Student explanation: The longest movies also high popularity either its a superhero film or a indie epic. The pattern is diverse and mixed. That suggest that no more the runtime or popularity, a movie can be popularity or not, regetless of the runtime.

## Web App

The Flask web app includes:

- A dashboard with summary stats and Chart.js charts
- A browse page with search and pagination
- An insights page showing the two discussion queries and explanations

## Setup Instructions

Start the database and Adminer:

```bash
python3 scripts/setup_check.py
```

Adminer is available at:

```text
http://127.0.0.1:8080
```

Adminer login:

| Field | Value |
| --- | --- |
| System | `PostgreSQL` |
| Server | `postgres` |
| Username | `postgres` |
| Password | `postgres` |
| Database | `final` |

Beekeeper Studio connection:

| Field | Value |
| --- | --- |
| Connection type | `Postgres` |
| Host | `localhost` |
| Port | `5432` |
| User | `postgres` |
| Password | `postgres` |
| Default database | `final` |

Run the Flask dashboard:

```bash
docker compose --profile app up --build
```

The app runs at:

```text
http://127.0.0.1:5001
```

Port `5001` is used because port `5000` was already in use on this machine.

## Files

- `data_exploration.md` - dataset observations and data quality notes
- `schema_plan.md` - planned relational design
- `table_creation.sql` - worksheet for table creation
- `import.sql` - import helper using a staging table
- `queries/` - six guided SQL challenge queries
- `discussion/` - two student-selected analysis queries
- `app.py` and `templates/` - Flask dashboard

## GitHub Note

The `.env` file is listed in `.gitignore` so database connection settings do not get committed to GitHub.
