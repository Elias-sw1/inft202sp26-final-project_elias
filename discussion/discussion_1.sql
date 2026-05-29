SELECT movie.title, movie_stats.vote_average, movie_stats.vote_count
FROM movie
JOIN movie_stats
ON movie.movie_id = movie_stats.movie_id
WHERE movie_stats.vote_average > 9 AND movie_stats.vote_count < 10;
