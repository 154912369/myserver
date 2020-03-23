
DROP TABLE IF EXISTS `oauth_token`;

CREATE TABLE `oauth_token` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(128) NOT NULL,
  `access_token` varchar(128) NOT NULL,
  `refresh_token` varchar(128) DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `refresh_token_expire_time` datetime DEFAULT NULL,
  `roles` varchar(512) DEFAULT NULL,
  `permissions` varchar(512) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `oauth_token_key`;

CREATE TABLE `oauth_token_key` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token_key` varchar(128) NOT NULL COMMENT '生成token时的key',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `logrecord`;
CREATE TABLE `logrecord` (
                             `time` char(50) DEFAULT NULL,
                             `title` char(100) DEFAULT NULL,
                             `context` text,
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `user` char(50) NOT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8

DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
                            `user` char(50) DEFAULT NULL,
                            `passwords` char(50) DEFAULT NULL,
                            `randm_code` char(50) DEFAULT NULL,
                            `id` int(11) NOT NULL AUTO_INCREMENT,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8