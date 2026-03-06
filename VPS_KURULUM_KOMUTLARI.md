# VPS'de FiveM Sunucu Kurulum Komutları

## 1. VPS'e Bağlan
```bash
ssh root@VPS_IP_ADRESI
```

## 2. Gerekli Paketleri Yükle
```bash
# Sistem güncellemesi
apt update && apt upgrade -y

# Git kurulumu
apt install git -y

# Screen kurulumu (sunucuyu arka planda çalıştırmak için)
apt install screen -y
```

## 3. FiveM Sunucu Dosyalarını İndir
```bash
# Ana dizine git
cd /root

# GitHub'dan projeyi clone'la
git clone https://github.com/swaffX/fivem.git

# Proje klasörüne gir
cd fivem
```

## 4. FiveM Server Binary İndir (Linux için)
```bash
# FiveM server dosyalarını indir
cd /root
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz

# Çıkart
tar xf fx.tar.xz

# Server dosyalarını proje klasörüne taşı
mv alpine /root/fivem/
```

## 5. Server.cfg Ayarları
```bash
# Server.cfg dosyasını düzenle
cd /root/fivem
nano server.cfg
```

**Önemli Ayarlar:**
- `sv_licenseKey` - FiveM keyforge'dan alacağın license key
- `sv_hostname` - Sunucu adı
- `sv_maxclients` - Max oyuncu sayısı
- `endpoint_add_tcp` ve `endpoint_add_udp` - Port ayarları (varsayılan 30120)

## 6. Veritabanı Kurulumu
```bash
# MySQL/MariaDB kurulumu
apt install mariadb-server -y

# MySQL'i başlat
systemctl start mariadb
systemctl enable mariadb

# MySQL güvenlik ayarları
mysql_secure_installation

# Veritabanı oluştur
mysql -u root -p
```

MySQL'de:
```sql
CREATE DATABASE fivem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'güçlü_şifre';
GRANT ALL PRIVILEGES ON fivem.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## 7. SQL Dosyalarını İçe Aktar
```bash
# SQL dosyalarını import et
cd /root/fivem/data
mysql -u fivem -p fivem < EKSIK_TABLOLAR_FIX.sql
mysql -u fivem -p fivem < PHONE_INVOICES_SAFE_FIX.sql
```

## 8. Sunucuyu Başlat
```bash
# Screen oturumu başlat
screen -S fivem

# Sunucuyu çalıştır
cd /root/fivem
./alpine/opt/cfx-server/ld-musl-x86_64.so.1 --library-path ./alpine/usr/lib/v8/:./alpine/lib/:./alpine/usr/lib/ -- ./alpine/opt/cfx-server/FXServer +set citizen_dir ./alpine/opt/cfx-server/citizen/ +set sv_licenseKey "BURAYA_LICENSE_KEY" +set gamename rdr3 +exec server.cfg

# Screen'den çıkmak için: CTRL+A+D
# Screen'e geri dönmek için: screen -r fivem
```

## 9. Firewall Ayarları
```bash
# UFW kurulumu
apt install ufw -y

# Gerekli portları aç
ufw allow 22/tcp      # SSH
ufw allow 30120/tcp   # FiveM TCP
ufw allow 30120/udp   # FiveM UDP
ufw allow 3306/tcp    # MySQL (sadece local erişim için)

# Firewall'u aktif et
ufw enable
```

## 10. Otomatik Başlatma (Opsiyonel)
```bash
# Systemd service dosyası oluştur
nano /etc/systemd/system/fivem.service
```

Service dosyası içeriği:
```ini
[Unit]
Description=FiveM Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/fivem
ExecStart=/root/fivem/alpine/opt/cfx-server/ld-musl-x86_64.so.1 --library-path /root/fivem/alpine/usr/lib/v8/:/root/fivem/alpine/lib/:/root/fivem/alpine/usr/lib/ -- /root/fivem/alpine/opt/cfx-server/FXServer +set citizen_dir /root/fivem/alpine/opt/cfx-server/citizen/ +set sv_licenseKey "LICENSE_KEY" +exec server.cfg
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
# Service'i aktif et
systemctl daemon-reload
systemctl enable fivem
systemctl start fivem

# Durumu kontrol et
systemctl status fivem
```

## Önemli Notlar

1. **License Key**: https://keymaster.fivem.net adresinden ücretsiz key alabilirsin
2. **Güvenlik**: Root kullanıcısı yerine ayrı bir kullanıcı oluşturman önerilir
3. **Backup**: Düzenli olarak veritabanı ve dosya yedekleri al
4. **Loglar**: `/root/fivem/` klasöründeki log dosyalarını kontrol et
5. **Güncelleme**: `cd /root/fivem && git pull` komutuyla güncelleyebilirsin

## Hızlı Komutlar

```bash
# Sunucuyu durdur
screen -r fivem
# CTRL+C ile durdur

# Sunucu loglarını izle
tail -f /root/fivem/server.log

# Veritabanı yedeği al
mysqldump -u fivem -p fivem > backup_$(date +%Y%m%d).sql

# Dosya yedeği al
tar -czf fivem_backup_$(date +%Y%m%d).tar.gz /root/fivem
```
