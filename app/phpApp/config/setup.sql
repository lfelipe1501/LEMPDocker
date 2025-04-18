-- Create the table if it doesn't exist
CREATE TABLE IF NOT EXISTS `test_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mensaje` varchar(255) NOT NULL,
  `nulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample data if the table is empty
INSERT INTO `test_content` (`mensaje`, `nulo`)
SELECT 'Welcome to the LEMP System', 'Example 1'
WHERE NOT EXISTS (SELECT 1 FROM `test_content` LIMIT 1);

INSERT INTO `test_content` (`mensaje`, `nulo`)
SELECT 'This is a sample application', NULL
WHERE NOT EXISTS (SELECT 1 FROM `test_content` LIMIT 1, 1);

INSERT INTO `test_content` (`mensaje`, `nulo`)
SELECT 'Developed with PHP, MariaDB and Docker', 'Example 3'
WHERE NOT EXISTS (SELECT 1 FROM `test_content` LIMIT 2, 1); 