CREATE TABLE movies
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(255),
    summary         TEXT,
    is_adult        BOOLEAN,
    release_date    DATE,
    runtime_minutes INT
);

ALTER TABLE movies
    AUTO_INCREMENT = 100000;

CREATE TABLE genres
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

ALTER TABLE genres
    AUTO_INCREMENT = 100000;

CREATE TABLE crew
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    birth_year INT,
    biography  TEXT
);

ALTER TABLE crew
    AUTO_INCREMENT = 100000;


CREATE TABLE roles
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    movie_id       INT NOT NULL,
    crew_id        INT NOT NULL,
    role_type      VARCHAR(255),
    character_name VARCHAR(255),
    FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE,
    FOREIGN KEY (crew_id) REFERENCES crew (id) ON DELETE CASCADE
);

ALTER TABLE roles
    AUTO_INCREMENT = 100000;

CREATE TABLE user_reviews
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    movie_id    INT NOT NULL,
    crew_id     INT NOT NULL,
    rating      INT,
    review      TEXT,
    review_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE,
    FOREIGN KEY (crew_id) REFERENCES crew (id) ON DELETE CASCADE
);

ALTER TABLE user_reviews
    AUTO_INCREMENT = 100000;


CREATE TABLE movie_genres
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE
);

ALTER TABLE movie_genres
    AUTO_INCREMENT = 100000;


CREATE TABLE movie_audit_log
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    movie_id    INT NOT NULL,
    old_title   VARCHAR(255),
    new_title   VARCHAR(255),
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE movie_audit_log
    AUTO_INCREMENT = 100000;
