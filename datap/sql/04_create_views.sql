CREATE VIEW top_movies_per_genre AS
SELECT g.name         AS genre_name,
       m.title        AS movie_title,
       AVG(ur.rating) AS average_rating,
       COUNT(ur.id)   AS number_of_reviews
FROM movies m
         JOIN movie_genres mg ON m.id = mg.movie_id
         JOIN genres g ON mg.genre_id = g.id
         LEFT JOIN user_reviews ur ON m.id = ur.movie_id
GROUP BY g.name, m.title
ORDER BY g.name, average_rating DESC;

CREATE VIEW highest_rated_movies AS
SELECT m.title        AS movie_title,
       m.release_date,
       AVG(ur.rating) AS average_rating,
       COUNT(ur.id)   AS number_of_reviews
FROM movies m
         LEFT JOIN user_reviews ur ON m.id = ur.movie_id
GROUP BY m.id, m.title, m.release_date
HAVING COUNT(ur.id) > 0
ORDER BY average_rating DESC, number_of_reviews DESC;
