SELECT movie.title, movie.runtime, movie_stats.popularity
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
WHERE movie.runtime > 0
ORDER BY movie.runtime DESC;
