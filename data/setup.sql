CREATE DATABASE IF NOT EXISTS `${DBUP}`;

--CREATE USER '${newUser}'@'%' IDENTIFIED BY '${newDbPassword}';

GRANT USAGE ON *.* TO '${USERDB}'@'%' IDENTIFIED BY '${UPWDB}';

GRANT ALL privileges ON `${DBUP}`.* TO '${USERDB}'@'%';

FLUSH PRIVILEGES;

USE ${DBUP};

CREATE TABLE `test_content` (
  `id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `nulo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `test_content` (`id`, `mensaje`, `nulo`) VALUES
(1, 'All systems and containers working!', NULL);

ALTER TABLE `test_content`
  ADD PRIMARY KEY (`id`);
COMMIT;