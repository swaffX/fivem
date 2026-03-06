-- Phone Invoices Tablosu Güvenli Düzeltme
-- Duplicate column hatası almamak için IF NOT EXISTS kullanılıyor

-- Önce tabloyu kontrol et
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Eksik kolonları güvenli şekilde ekle
SET @exist_candecline := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() 
    AND TABLE_NAME = 'phone_invoices' 
    AND COLUMN_NAME = 'candecline');

SET @exist_reason := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() 
    AND TABLE_NAME = 'phone_invoices' 
    AND COLUMN_NAME = 'reason');

SET @exist_sell_time := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() 
    AND TABLE_NAME = 'phone_invoices' 
    AND COLUMN_NAME = 'sell_time');

-- candecline kolonunu ekle (yoksa)
SET @sql_candecline = IF(@exist_candecline = 0,
    'ALTER TABLE `phone_invoices` ADD COLUMN `candecline` int(1) NOT NULL DEFAULT 1',
    'SELECT "candecline kolonu zaten var" AS Info');
PREPARE stmt FROM @sql_candecline;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- reason kolonunu ekle (yoksa)
SET @sql_reason = IF(@exist_reason = 0,
    'ALTER TABLE `phone_invoices` ADD COLUMN `reason` varchar(256) DEFAULT NULL',
    'SELECT "reason kolonu zaten var" AS Info');
PREPARE stmt FROM @sql_reason;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- sell_time kolonunu ekle (yoksa)
SET @sql_sell_time = IF(@exist_sell_time = 0,
    'ALTER TABLE `phone_invoices` ADD COLUMN `sell_time` timestamp NULL DEFAULT NULL',
    'SELECT "sell_time kolonu zaten var" AS Info');
PREPARE stmt FROM @sql_sell_time;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Başarı mesajı
SELECT 'phone_invoices tablosu başarıyla güncellendi!' AS Status;
