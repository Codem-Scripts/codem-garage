ALTER TABLE `player_vehicles`
  ADD COLUMN `stored` tinyint(4) NOT NULL DEFAULT 0,
  ADD COLUMN  `parking` varchar(60) DEFAULT 'Garage A',
  ADD COLUMN `favorite` varchar(60) DEFAULT '0'
;