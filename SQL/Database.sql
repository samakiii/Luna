 SET sql_mode = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `luna` DEFAULT CHARACTER SET latin1 COLLATE
latin1_swedish_ci;

USE `luna`;

DROP TABLE IF EXISTS `servers`;

DROP TABLE IF EXISTS `postcards`;

DROP TABLE IF EXISTS `puffles`;

DROP TABLE IF EXISTS `users`;

DROP TABLE IF EXISTS `igloos`;

DROP TABLE IF EXISTS `sales`;

DROP TABLE IF EXISTS `products`;

CREATE TABLE IF NOT EXISTS `servers`
  (
     `servtype` VARCHAR(10) NOT NULL DEFAULT 'game',
     `servport` INT(5) NOT NULL,
     `servname` CHAR(20) NOT NULL,
     `servip`   MEDIUMBLOB NOT NULL,
     `curpop`   INT(10) NOT NULL DEFAULT '0',
     PRIMARY KEY (`servtype`)
  )
engine=innodb
DEFAULT charset=latin1;

CREATE TABLE IF NOT EXISTS `products`
  (
     `pid`      INT(11) NOT NULL auto_increment,
     `product`  VARCHAR(255) NOT NULL,
     `price`    MEDIUMBLOB NOT NULL,
     `currency` VARCHAR(10) NOT NULL,
     PRIMARY KEY (`pid`)
  )
engine=myisam
DEFAULT charset=latin1
auto_increment=1;

INSERT INTO `products`
            (`product`,
             `price`,
             `currency`)
VALUES      ('isVIP',
             '3.00',
             'USD');

CREATE TABLE IF NOT EXISTS `sales`
  (
     `sid`           INT(11) auto_increment PRIMARY KEY,
     `pid`           INT(11),
     `uid`           INT(11),
     `saledate`      DATE,
     `transactionid` VARCHAR(125),
     FOREIGN KEY(uid) REFERENCES users(id),
     FOREIGN KEY(pid) REFERENCES products(pid)
  )
engine=myisam
DEFAULT charset=latin1;

CREATE TABLE IF NOT EXISTS `puffles`
  (
     `puffleid`     INT(11) NOT NULL auto_increment,
     `ownerid`      INT(2) NOT NULL,
     `pufflename`   CHAR(10) NOT NULL,
     `puffletype`   INT(2) NOT NULL,
     `puffleenergy` INT(3) NOT NULL DEFAULT '100',
     `pufflehealth` INT(3) NOT NULL DEFAULT '100',
     `pufflerest`   INT(3) NOT NULL DEFAULT '100',
     PRIMARY KEY (`puffleid`)
  )
engine=innodb
DEFAULT charset=latin1
auto_increment=1;

CREATE TABLE IF NOT EXISTS `postcards`
  (
     `postcardid`   INT(10) NOT NULL auto_increment,
     `recepient`    INT(10) NOT NULL,
     `mailername`   CHAR(12) NOT NULL,
     `mailerid`     INT(10) NOT NULL,
     `notes`        CHAR(12) NOT NULL,
     `timestamp`    INT(8) NOT NULL,
     `postcardtype` INT(5) NOT NULL,
     `isread`       INT(1) NOT NULL DEFAULT '0',
     PRIMARY KEY (`postcardid`)
  )
engine=innodb
DEFAULT charset=latin1
auto_increment=1;

INSERT INTO `postcards`
            (`recepient`,
             `mailername`,
             `mailerid`,
             `notes`,
             `timestamp`,
             `postcardtype`)
VALUES      ('1',
             'Luna',
             '0',
             'Welcome To Luna',
             Unix_timestamp(timestamp),
             '125');

CREATE TABLE IF NOT EXISTS `igloos`
  (
     `id`          INT(11) NOT NULL,
     `username`    CHAR(20) NOT NULL,
     `igloo`       INT(10) NOT NULL DEFAULT '1',
     `floor`       INT(10) NOT NULL DEFAULT '0',
     `music`       INT(10) NOT NULL DEFAULT '0',
     `furniture`   LONGBLOB NOT NULL,
     `ownedfurns`  LONGBLOB NOT NULL,
     `ownedigloos` LONGBLOB NOT NULL,
     PRIMARY KEY (`id`)
  )
engine=innodb
DEFAULT charset=latin1;

INSERT INTO `igloos`
            (`id`,
             `username`)
VALUES      ('1',
             'Isis');

CREATE TABLE IF NOT EXISTS `users`
  (
     `id`             INT(11) NOT NULL auto_increment,
     `username`       CHAR(20) NOT NULL,
     `nickname`       CHAR(20) NOT NULL,
     `password`       CHAR(32) NOT NULL,
     `spin`           INT(6) NOT NULL,
     `loginkey`       CHAR(32) NOT NULL,
     `ipaddr`         MEDIUMBLOB NOT NULL,
     `email`          MEDIUMBLOB NOT NULL,
     `age`            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     `lastlogin`      TIMESTAMP,
     `active`         INT(1) NOT NULL DEFAULT '1',
     `bitmask`        INT(1) NOT NULL DEFAULT '1',
     `isbanned`       VARCHAR(10) NOT NULL DEFAULT '0',
     `bancount`       INT(1) NOT NULL DEFAULT '0',
     `invalidlogins`  INT(3) NOT NULL DEFAULT '0',
     `inventory`      LONGBLOB NOT NULL,
     `head`           INT(10) NOT NULL DEFAULT '0',
     `face`           INT(10) NOT NULL DEFAULT '0',
     `neck`           INT(10) NOT NULL DEFAULT '0',
     `body`           INT(10) NOT NULL DEFAULT '0',
     `hand`           INT(10) NOT NULL DEFAULT '0',
     `feet`           INT(10) NOT NULL DEFAULT '0',
     `photo`          INT(10) NOT NULL DEFAULT '0',
     `flag`           INT(10) NOT NULL DEFAULT '0',
     `colour`         INT(10) NOT NULL DEFAULT '1',
     `coins`          INT(11) NOT NULL,
     `ismuted`        INT(1) NOT NULL DEFAULT '0',
     `isvip`          INT(1) NOT NULL DEFAULT '0',
     `isstaff`        INT(1) NOT NULL DEFAULT '0',
     `isadmin`        INT(1) NOT NULL DEFAULT '0',
     `rank`           INT(1) NOT NULL DEFAULT '1',
     `buddies`        LONGBLOB NOT NULL,
     `ignored`        LONGBLOB NOT NULL,
     `isepf`          INT(1) NOT NULL DEFAULT '0',
     `fieldopstatus`  INT(1) NOT NULL DEFAULT '0',
     `epfpoints`      INT(10) NOT NULL DEFAULT '20',
     `totalepfpoints` INT(10) NOT NULL DEFAULT '100',
     `stamps`         LONGBLOB NOT NULL,
     `cover`          LONGBLOB NOT NULL,
     `restamps`       LONGBLOB NOT NULL,
     `nameglow`       MEDIUMBLOB NOT NULL,
     `namecolour`     MEDIUMBLOB NOT NULL,
     `bubbletext`     MEDIUMBLOB NOT NULL,
     `bubblecolour`   MEDIUMBLOB NOT NULL,
     `ringcolour`     MEDIUMBLOB NOT NULL,
     `chatglow`       MEDIUMBLOB NOT NULL,
     `penguinglow`    MEDIUMBLOB NOT NULL,
     `bubbleglow`    MEDIUMBLOB NOT NULL,
     `moodglow`    MEDIUMBLOB NOT NULL,
     `moodcolor`    MEDIUMBLOB NOT NULL,
     `speed`          INT(3) NOT NULL DEFAULT '4',
     `mood`           CHAR(100) NOT NULL,
     `ismirror`       INT(1) NOT NULL DEFAULT '0',
     `iscloneable`    INT(1) NOT NULL DEFAULT '1',
     `outfits`        LONGBLOB NOT NULL,
     PRIMARY KEY (`id`)
  )
engine=myisam
DEFAULT charset=latin1
auto_increment=1;

INSERT INTO `users`
            (`username`,
             `nickname`,
             `password`,
             `colour`,
             `stamps`)
VALUES      ('Isis',
             'Isis',
             'f666dc0363010318799f42c48de7a41a',
             '4',
             '31|7|33|8|32|35|34|36|290|358|448');  
