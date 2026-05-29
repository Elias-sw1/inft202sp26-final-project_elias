SELECT movie.title, movie.release_date, movie.runtime, movie_stats.vote_average, movie_stats.vote_count
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id;
