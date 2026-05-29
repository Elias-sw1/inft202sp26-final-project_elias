SELECT movie.runtime, COUNT(*)
FROM movie
GROUP BY movie.runtime
ORDER BY COUNT(*) DESC;
