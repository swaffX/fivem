-- codem-garage için düzeltilmiş SQL
-- Sadece eksik kolonları ekler, var olanları atlar

-- stored kolonu zaten varsa hata vermez
ALTER TABLE `player_vehicles`
  ADD COLUMN IF NOT EXISTS `stored` tinyint(4) NOT NULL DEFAULT 0;

-- parking kolonu ekle (yoksa)
ALTER TABLE `player_vehicles`
  ADD COLUMN IF NOT EXISTS `parking` varchar(60) DEFAULT 'Garage A';

-- favorite kolonu ekle (yoksa)
ALTER TABLE `player_vehicles`
  ADD COLUMN IF NOT EXISTS `favorite` varchar(60) DEFAULT '0';
