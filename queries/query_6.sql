SELECT movie.runtime, AVG(movie_stats.vote_average), COUNT(*)
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
GROUP BY movie.runtime
ORDER BY AVG(movie_stats.vote_average) DESC;
