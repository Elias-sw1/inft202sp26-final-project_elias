# Data Exploration: Expensive Movie Dataset

## File Explored

### `expensive_movie.csv`

This file contains 8,121 movie records. One row appears to represent one movie, with details such as title, release date, language, popularity, votes, runtime, budget, revenue, production companies, countries, and spoken languages.

## First Rows

| ID | Title | Original_Language | Release_Date | Popularity | Vote_Average | Runtime | Budget | Revenue | Status | Genres |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 969681 | Spider-Man: Brand New Day | en | 2026-07-29 | 81.5967 | 0.0 | 0 | 0 | 0 | Post Production | Science Fiction, Action, Adventure |
| 1242898 | Predator: Badlands | en | 2025-11-05 | 78.4384 | 7.704 | 107 | 105000000 | 184500000 | Released | Action, Science Fiction, Adventure |
| 11375 | Hollywood Homicide | en | 2003-06-09 | 62.2209 | 5.238 | 116 | 75000000 | 51142659 | Released | Action, Adventure, Comedy, Thriller |
| 7451 | xXx | en | 2002-08-09 | 61.1958 | 5.98 | 124 | 70000000 | 277448382 | Released | Action, Adventure, Thriller, Crime, Drama |

## Important Columns

| Column | What It Appears To Mean | Possible Type |
| --- | --- | --- |
| `ID` | Unique movie identifier | `INTEGER` |
| `Title` | Movie title | `TEXT` |
| `Original_Language` | Original language code, such as `en`, `ja`, or `zh` | `TEXT` |
| `Release_Date` | Date the movie was or will be released | `DATE` |
| `Popularity` | Popularity score | `NUMERIC` |
| `Vote_Average` | Average user rating | `NUMERIC` |
| `Vote_Count` | Number of votes | `INTEGER` |
| `Runtime` | Runtime in minutes | `INTEGER` |
| `Budget` | Production budget in dollars | `NUMERIC` or `INTEGER` |
| `Revenue` | Revenue in dollars | `NUMERIC` or `INTEGER` |
| `Status` | Production/release status | `TEXT` |
| `Genres` | One or more genres separated by commas | `TEXT`, or split into related rows |
| `Production_Companies` | One or more companies separated by commas | `TEXT`, or split into related rows |
| `Production_Countries` | One or more countries separated by commas | `TEXT`, or split into related rows |
| `Spoken_Languages` | One or more languages separated by commas | `TEXT`, or split into related rows |

## Row Counts and Uniqueness

- Total rows: 8,121
- Unique `ID` values: 8,121
- This makes `ID` a strong candidate for the primary key of a `movies` table.
- `Original_Language` has 70 unique values.
- `Status` has 6 unique values.
- `Genres`, `Production_Companies`, `Production_Countries`, and `Spoken_Languages` contain comma-separated lists, so they may be useful for separate related tables.

## Missing or Blank Values

- `Release_Date`: 361 blanks
- `Tagline`: 4,696 blanks
- `Overview`: 388 blanks
- `Genres`: 3 blanks
- `Production_Companies`: 1,527 blanks
- `Production_Countries`: 1,046 blanks
- `Spoken_Languages`: 876 blanks

The `Tagline` column has many blanks, so it may not be very useful for analysis. `Production_Companies`, `Production_Countries`, and `Spoken_Languages` also have missing values, but they still contain useful categories when present.

## Numeric Ranges

| Column | Minimum | Maximum | Average | Zero Values |
| --- | ---: | ---: | ---: | ---: |
| `Popularity` | 0.0 | 81.5967 | 1.22 | 112 |
| `Vote_Average` | 0.0 | 10.0 | 4.13 | 2,349 |
| `Vote_Count` | 0 | 38,855 | 469.18 | 2,343 |
| `Runtime` | 0 | 999 | 78.12 | 904 |
| `Budget` | 0 | 489,900,000 | 7,941,100.10 | 6,444 |
| `Revenue` | 0 | 2,923,706,026 | 23,403,263.67 | 6,812 |

Many `Budget`, `Revenue`, `Runtime`, `Vote_Average`, and `Vote_Count` values are `0`. For budget and revenue especially, `0` probably means the value is unknown or unavailable, not that the movie actually cost or earned zero dollars.

## Date Notes

- Earliest `Release_Date`: 1901-09-06
- Latest `Release_Date`: 2031-12-17
- Some release dates are in the future, so the dataset includes upcoming or planned movies as well as released movies.

## Common Categories

### Status

- `Released`: 7,805 rows
- `Planned`: 115 rows
- `In Production`: 107 rows
- `Post Production`: 45 rows
- `Rumored`: 27 rows
- `Canceled`: 22 rows

### Original Language

- `en`: 4,317 rows
- `ja`: 1,009 rows
- `zh`: 618 rows
- `es`: 298 rows
- `it`: 227 rows
- `ru`: 183 rows
- `fr`: 154 rows
- `cn`: 147 rows

### Production Companies

- Toei Company: 317 rows
- Universal Pictures: 158 rows
- Columbia Pictures: 152 rows
- Toei Animation: 120 rows
- Paramount Pictures: 117 rows
- Warner Bros. Pictures: 116 rows

## Candidate Keys and Relationships

### Candidate Primary Key

- `ID` looks like the best primary key for a main `movies` table because it is unique for every movie.

### Possible Related Tables

Because this dataset came as one CSV, we may need to split it into related tables ourselves. Good candidates:

- `movies`: one row per movie, using `ID` as the primary key.
- `movie_genres`: one row per movie-genre connection, using `movie_id` to connect back to `movies`.
- `movie_companies`: one row per movie-company connection, using `movie_id` to connect back to `movies`.

This would turn the comma-separated list columns into real relational tables.

## Data Quality Notes

- The dataset is large enough for analysis.
- The file is currently one CSV, not two separate related CSV files.
- Some columns contain lists inside one cell. These are useful, but they need careful table design.
- Several numeric columns use `0` where the true value may be unknown.
- Some movies are not released yet, so filtering by `Status` may matter in later analysis.

## Possible Analysis Questions

1. Which released movies with a known budget had the highest revenue?
2. How many movies are in each original language?
3. What is the average vote score for each movie status?
4. Which production companies appear most often in the dataset?
5. Do movies with higher budgets tend to have higher revenue?

