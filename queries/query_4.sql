SELECT movie.runtime, AVG(movie_stats.revenue)
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
WHERE revenue > 0
GROUP BY movie.runtime
HAVING AVG(movie_stats.revenue) > 100000000;
