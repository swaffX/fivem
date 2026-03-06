# Ubuntu VPS'e FiveM Sunucusu Kurulum Rehberi (GitHub Clone)

## ⚠️ ÖNEMLİ NOTLAR
- Bu rehber GitHub'dan direkt clone yaparak kurulum yapar
- temelpaket.sql dosyası GitHub'da YOK (çok büyük), onu ayrıca yüklemeniz gerekecek
- Artifacts klasörü boş (gitignore'da), FXServer'ı manuel indireceğiz

## 1. VPS'e Bağlanma ve Hazırlık

```bash
# SSH ile VPS'e bağlan
ssh root@VPS_IP_ADRESI

# Sistemi güncelle
sudo apt update && sudo apt upgrade -y

# Gerekli paketleri kur
sudo apt install -y git wget curl tar screen xz-utils
```

## 2. MariaDB (MySQL) Kurulumu

```bash
# MariaDB kur
sudo apt install -y mariadb-server mariadb-client

# MariaDB'yi başlat ve otomatik başlatmayı aktif et
sudo systemctl start mariadb
sudo systemctl enable mariadb

# MariaDB güvenlik ayarları (root şifresi belirle)
sudo mysql_secure_installation
```

### Veritabanı Oluşturma ve SQL Dosyalarını İçe Aktarma

```bash
# MySQL'e giriş yap
sudo mysql -u root -p

# Veritabanı oluştur
CREATE DATABASE temelPaket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Kullanıcı oluştur ve yetki ver (güvenlik için)
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'GUVENLI_SIFRE';
GRANT ALL PRIVILEGES ON temelPaket.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### SQL Dosyalarını İçe Aktar

```bash
# Ana veritabanı dosyasını içe aktar (yüklediğiniz temelpaket.sql)
mysql -u root -p temelPaket < /home/fivem/temelpaket.sql

# GitHub'dan gelen düzeltme dosyalarını içe aktar
mysql -u root -p temelPaket < /home/fivem/data/EKSIK_TABLOLAR_FIX.sql
mysql -u root -p temelPaket < /home/fivem/data/PHONE_INVOICES_SAFE_FIX.sql

# Veritabanını kontrol et
mysql -u root -p temelPaket -e "SHOW TABLES;"
```

## 3. GitHub'dan Projeyi Clone'lama

```bash
# Home dizinine git
cd /home

# GitHub'dan projeyi clone'la
git clone https://github.com/swaffX/fivem.git

# Klasöre gir
cd fivem

# Klasör yapısını kontrol et
ls -la
```

## 4. FiveM Server Artifacts İndirme

```bash
# Artifacts klasörüne git
cd /home/fivem/artifacts

# En son FXServer artifacts'ı indir (Linux için)
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz

# Arşivi aç
tar -xf fx.tar.xz

# Arşiv dosyasını sil (yer kazanmak için)
rm fx.tar.xz

# İzinleri ayarla
chmod +x run.sh

# Ana dizine dön
cd /home/fivem
```

## 5. temelpaket.sql Dosyasını Yükleme

⚠️ **ÖNEMLİ:** temelpaket.sql dosyası GitHub'da yok (çok büyük). Bu dosyayı manuel olarak yüklemeniz gerekiyor.

### Yöntem 1: FileZilla ile Yükleme (Önerilen)
1. FileZilla'yı aç
2. Host: VPS_IP_ADRESI, Port: 22, Protocol: SFTP
3. Kullanıcı: root, Şifre: VPS_SIFRESI
4. Yerel bilgisayardan `temelpaket.sql` dosyasını `/home/fivem/` klasörüne sürükle

### Yöntem 2: SCP ile Yükleme
```bash
# Windows'tan (Git Bash veya PowerShell)
scp temelpaket.sql root@VPS_IP_ADRESI:/home/fivem/
```

### Yöntem 3: WinSCP ile Yükleme
1. WinSCP'yi aç
2. Bağlantı bilgilerini gir
3. temelpaket.sql dosyasını sürükle-bırak

## 5. txAdmin Kurulumu

```bash
cd /home/fivem/artifacts

# txAdmin'i başlat (ilk kurulum)
screen -S fivem
./run.sh +set txAdminPort 40120
```

### txAdmin İlk Kurulum Adımları:

1. Tarayıcıda aç: `http://VPS_IP_ADRESI:40120`
2. PIN kodunu terminalde göreceksin, gir
3. "Custom" seçeneğini seç (kendi dosyalarını kullan)
4. Server Data Folder: `/home/fivem/data`
5. CFX License Key: Kendi key'ini gir (https://keymaster.fivem.net)
6. Admin hesabı oluştur
7. "Save & Start Server" tıkla

### txAdmin'den Çıkma (Screen)
```bash
# Ctrl+A+D tuşlarına bas (screen'den ayrıl)
# Geri dönmek için:
screen -r fivem
```

## 6. Server.cfg Düzenlemeleri

⚠️ **ÖNEMLİ:** GitHub'daki server.cfg zaten hazır, sadece birkaç değeri değiştirmen yeterli.

```bash
nano /home/fivem/data/server.cfg
```

### Değiştirilmesi Gerekenler:

```properties
# 1. License Key'ini değiştir (https://keymaster.fivem.net)
sv_licenseKey "KENDI_LICENSE_KEYIN"

# 2. MySQL bağlantısını güncelle (eğer kullanıcı oluşturduysan)
set mysql_connection_string "mysql://fivem:GUVENLI_SIFRE@localhost/temelPaket?charset=utf8mb4"
# VEYA root kullanıyorsan:
set mysql_connection_string "mysql://root:ROOT_SIFRESI@localhost/temelPaket?charset=utf8mb4"

# 3. Sunucu adını değiştir (opsiyonel)
sv_hostname "Nexora Roleplay"
sets sv_projectName "Nexora Roleplay"

# 4. Maksimum oyuncu sayısı (opsiyonel)
sv_maxclients 32

# 5. Steam Web API Key (opsiyonel ama önerilen)
# https://steamcommunity.com/dev/apikey adresinden al
set steam_webApiKey "STEAM_API_KEY"

# 6. Admin bilgilerini güncelle
add_principal identifier.fivem:SENIN_FIVEM_ID group.admin
add_principal identifier.discord:SENIN_DISCORD_ID group.admin
```

### Kaydet ve Çık:
```bash
# Ctrl+X -> Y -> Enter
```

## 7. Güvenlik Duvarı Ayarları

```bash
# UFW güvenlik duvarını kur
sudo apt install -y ufw

# Gerekli portları aç
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 30120/tcp   # FiveM Server
sudo ufw allow 30120/udp   # FiveM Server
sudo ufw allow 40120/tcp   # txAdmin

# Güvenlik duvarını aktif et
sudo ufw enable
```

## 8. Sunucuyu Başlatma

### txAdmin ile (Önerilen):
```bash
# Screen oturumu başlat
screen -S fivem

# Artifacts klasörüne git
cd /home/fivem/artifacts

# txAdmin'i başlat
./run.sh +set txAdminPort 40120

# Screen'den çık: Ctrl+A+D
# Geri dön: screen -r fivem
```

### Manuel Başlatma (txAdmin olmadan):
```bash
screen -S fivem
cd /home/fivem/artifacts
./run.sh +exec ../data/server.cfg

# Screen'den çık: Ctrl+A+D
```

## 9. Otomatik Başlatma (Systemd Service)

```bash
# Service dosyası oluştur
sudo nano /etc/systemd/system/fivem.service
```

### Service içeriği:
```ini
[Unit]
Description=FiveM Server
After=network.target mariadb.service

[Service]
Type=simple
User=root
WorkingDirectory=/home/fivem/artifacts
ExecStart=/home/fivem/artifacts/run.sh +set txAdminPort 40120
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### Service'i aktif et:
```bash
sudo systemctl daemon-reload
sudo systemctl enable fivem
sudo systemctl start fivem

# Durumu kontrol et
sudo systemctl status fivem

# Logları izle
sudo journalctl -u fivem -f
```

## 10. Kontrol ve Test

```bash
# Sunucu loglarını izle
screen -r fivem

# MySQL bağlantısını test et
mysql -u fivem -p temelPaket -e "SHOW TABLES;"

# Port kontrolü
netstat -tulpn | grep 30120
```

## 11. Sorun Giderme

### Sunucu başlamıyorsa:
```bash
# Logları kontrol et
cd /home/fivem/data
cat server.log

# txAdmin logları
cat txData/logs/latest.log
```

### MySQL bağlantı hatası:
```bash
# MySQL çalışıyor mu?
sudo systemctl status mariadb

# Kullanıcı yetkilerini kontrol et
mysql -u root -p
SHOW GRANTS FOR 'fivem'@'localhost';
```

### Port kapalı hatası:
```bash
# Güvenlik duvarını kontrol et
sudo ufw status

# Portları tekrar aç
sudo ufw allow 30120/tcp
sudo ufw allow 30120/udp
```

## 12. Performans Optimizasyonu

```bash
# Swap alanı oluştur (düşük RAM için)
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## 13. Yedekleme

```bash
# Veritabanı yedeği
mysqldump -u root -p temelPaket > /home/backups/backup_$(date +%Y%m%d).sql

# Sunucu dosyaları yedeği (data klasörü)
tar -czf /home/backups/fivem_data_$(date +%Y%m%d).tar.gz /home/fivem/data

# Yedekleme klasörü oluştur
mkdir -p /home/backups
```

## 14. GitHub'dan Güncelleme Alma

```bash
# Sunucuyu durdur
sudo systemctl stop fivem

# Fivem klasörüne git
cd /home/fivem

# Güncellemeleri çek
git pull origin main

# Sunucuyu başlat
sudo systemctl start fivem
```

## Önemli Notlar:

1. **GitHub Clone:** Proje GitHub'dan direkt clone ediliyor, tüm scriptler hazır
2. **temelpaket.sql:** Bu dosya GitHub'da YOK (çok büyük), manuel yüklemeniz gerekiyor
3. **Artifacts:** FXServer dosyaları GitHub'da yok, manuel indirmeniz gerekiyor
4. **CFX License Key**: https://keymaster.fivem.net adresinden kendi key'inizi alın
5. **Steam API Key**: https://steamcommunity.com/dev/apikey adresinden alın (opsiyonel)
6. **Güvenlik**: Root kullanıcısı yerine ayrı bir kullanıcı oluşturmayı düşünün
7. **Yedekleme**: Düzenli veritabanı ve dosya yedekleri alın
8. **Güncelleme**: `git pull` ile GitHub'dan güncellemeleri çekebilirsiniz

## Hızlı Komutlar:

```bash
# Sunucuyu başlat
sudo systemctl start fivem

# Sunucuyu durdur
sudo systemctl stop fivem

# Sunucuyu yeniden başlat
sudo systemctl restart fivem

# Sunucu durumunu kontrol et
sudo systemctl status fivem

# Logları izle
sudo journalctl -u fivem -f

# Screen'e bağlan
screen -r fivem
```

## Bağlantı Bilgileri:

- **FiveM Server**: `connect VPS_IP_ADRESI:30120`
- **txAdmin Panel**: `http://VPS_IP_ADRESI:40120`
- **SSH**: `ssh root@VPS_IP_ADRESI`
