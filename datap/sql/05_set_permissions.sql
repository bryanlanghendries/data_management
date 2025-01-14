DROP ROLE IF EXISTS 'admin_role';
DROP ROLE IF EXISTS 'contributor_role';
DROP ROLE IF EXISTS 'api_role';

CREATE ROLE 'admin_role';
CREATE ROLE 'contributor_role';
CREATE ROLE 'api_role';

GRANT ALL PRIVILEGES ON movies TO 'admin_role';
GRANT ALL PRIVILEGES ON genres TO 'admin_role';
GRANT ALL PRIVILEGES ON roles TO 'admin_role';
GRANT ALL PRIVILEGES ON user_reviews TO 'admin_role';
GRANT ALL PRIVILEGES ON movie_genres TO 'admin_role';
GRANT ALL PRIVILEGES ON movie_audit_log TO 'admin_role';

GRANT INSERT, UPDATE, DELETE ON movies TO 'contributor_role';
GRANT INSERT, UPDATE, DELETE ON genres TO 'contributor_role';
GRANT INSERT, UPDATE, DELETE ON roles TO 'contributor_role';
GRANT INSERT, UPDATE, DELETE ON user_reviews TO 'contributor_role';
GRANT INSERT, UPDATE, DELETE ON movie_genres TO 'contributor_role';

GRANT SELECT ON movies TO 'api_role';
GRANT SELECT ON genres TO 'api_role';

DROP USER IF EXISTS 'admin_user'@'localhost';
DROP USER IF EXISTS 'contributor_user'@'localhost';
DROP USER IF EXISTS 'api_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'contributor_user'@'localhost' IDENTIFIED BY 'contributor';
CREATE USER 'api_user'@'localhost' IDENTIFIED BY 'api';

GRANT 'admin_role' TO 'admin_user'@'localhost';
GRANT 'contributor_role' TO 'contributor_user'@'localhost';
GRANT 'api_role' TO 'api_user'@'localhost';
