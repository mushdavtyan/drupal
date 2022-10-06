-- create the databases
CREATE DATABASE IF NOT EXISTS drupal;

-- create the users for each database
CREATE USER 'drupal'@'drupal' IDENTIFIED BY 'drupal';
GRANT ALL privileges ON `drupal`.* TO 'drupal'@'drupal';

FLUSH PRIVILEGES;
