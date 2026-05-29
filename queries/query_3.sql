SELECT movie.runtime, AVG(movie_stats.revenue)
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
WHERE movie_stats.revenue > 0
GROUP BY movie.runtime
ORDER BY AVG(movie_stats.revenue) DESC;
