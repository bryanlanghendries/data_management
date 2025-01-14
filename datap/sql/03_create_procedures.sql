DELIMITER $$

CREATE PROCEDURE add_movie(
    IN movie_title VARCHAR(255),
    IN movie_summary TEXT,
    IN movie_is_adult BOOLEAN,
    IN movie_release_date DATE,
    IN movie_runtime INT,
    IN genres_list JSON
)
BEGIN
    DECLARE movie_id INT;
    DECLARE genre_id INT DEFAULT NULL;
    DECLARE current_genre JSON;

    INSERT INTO movies (title, summary, is_adult, release_date, runtime_minutes)
    VALUES (movie_title, movie_summary, movie_is_adult, movie_release_date, movie_runtime);

    SET movie_id = LAST_INSERT_ID();

    WHILE JSON_LENGTH(genres_list) > 0
        DO
            SET current_genre = JSON_UNQUOTE(JSON_EXTRACT(genres_list, '$[0]'));
            SET genres_list = JSON_REMOVE(genres_list, '$[0]');

            SELECT id
            INTO genre_id
            FROM genres
            WHERE name = current_genre
            LIMIT 1;

            IF genre_id IS NULL THEN
                INSERT INTO genres (name) VALUES (current_genre);
                SET genre_id = LAST_INSERT_ID();
            END IF;

            IF NOT EXISTS (SELECT 1
                           FROM movie_genres
                           WHERE movie_id = movie_id
                             AND genre_id = genre_id) THEN
                INSERT INTO movie_genres (movie_id, genre_id)
                VALUES (movie_id, genre_id);
            END IF;
        END WHILE;
END $$

CREATE PROCEDURE add_crew(
    IN crew_name VARCHAR(255),
    IN crew_birth_year INT,
    IN crew_biography TEXT
)
BEGIN
    INSERT INTO crew (name, birth_year, biography)
    VALUES (crew_name, crew_birth_year, crew_biography);
END $$

CREATE PROCEDURE add_review(
    IN review_movie_title VARCHAR(255),
    IN review_user_name VARCHAR(255),
    IN review_rating INT,
    IN review_text TEXT
)
BEGIN
    DECLARE movie_id INT;
    DECLARE crew_id INT;

    SELECT id
    INTO crew_id
    FROM crew
    WHERE name = review_user_name
    LIMIT 1;

    IF crew_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Crew member does not exist';
    END IF;

    SELECT id
    INTO movie_id
    FROM movies
    WHERE title = review_movie_title
    LIMIT 1;

    IF movie_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Movie does not exist';
    END IF;

    INSERT INTO user_reviews (movie_id, crew_id, rating, review, review_date)
    VALUES (movie_id, crew_id, review_rating, review_text, CURRENT_DATE);
END $$

CREATE PROCEDURE add_role(
    IN role_movie_title VARCHAR(255),
    IN role_crew_name VARCHAR(255),
    IN role_role_type VARCHAR(255),
    IN role_character_name VARCHAR(255)
)
BEGIN
    DECLARE movie_id INT;
    DECLARE crew_id INT;

    SELECT id
    INTO movie_id
    FROM movies
    WHERE title = role_movie_title
    LIMIT 1;

    IF movie_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Movie does not exist';
    END IF;

    SELECT id
    INTO crew_id
    FROM crew
    WHERE name = role_crew_name
    LIMIT 1;

    IF crew_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'crew does not exist in crew table';
    END IF;

    INSERT INTO roles (movie_id, crew_id, role_type, character_name)
    VALUES (movie_id, crew_id, role_role_type, role_character_name);
END $$

DELIMITER ;
