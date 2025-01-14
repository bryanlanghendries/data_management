DELIMITER $$

CREATE TRIGGER validate_rating
    BEFORE INSERT
    ON user_reviews
    FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 10 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Rating must be between 1 and 10';
    END IF;
END $$

CREATE TRIGGER movie_update_audit
    AFTER UPDATE
    ON movies
    FOR EACH ROW
BEGIN
    INSERT INTO movie_audit_log (movie_id, old_title, new_title, update_date)
    VALUES (OLD.id, OLD.title, NEW.title, NOW());
END $$

DELIMITER ;
