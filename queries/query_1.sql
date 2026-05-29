SELECT movie.title, movie_stats.revenue
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
WHERE movie_stats.budget > 0
ORDER BY movie_stats.revenue DESC
LIMIT 10;
