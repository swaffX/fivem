# 🎯 ŞİMDİ NE YAPMALISIN - ADIM ADIM REHBERİ

## ✅ TAMAMLANAN İŞLEMLER

1. ✅ Hassas dosyalar GitHub'dan kaldırıldı (txData, server.cfg)
2. ✅ .gitignore güncellendi
3. ✅ server.cfg.example şablon dosyası oluşturuldu
4. ✅ Değişiklikler GitHub'a push edildi

## ⚠️ ACİL: LICENSE KEY GÜVENLİĞİ

**ÖNEMLİ:** `data/server.cfg` dosyasında license key'in GitHub'a yüklenmiş!

### 1. Hemen Yeni License Key Al
```
1. https://keymaster.fivem.net adresine git
2. FiveM hesabınla giriş yap
3. Mevcut key'i BUL ve SİL veya DEVRE DIŞI BIRAK
4. "Create New Server" butonuna tıkla
5. Yeni bir license key oluştur
6. Key'i KOPYALA ve güvenli bir yere kaydet
```

## 🖥️ VPS'DE YAPILACAKLAR

### Adım 1: VPS'e Bağlan
```bash
ssh root@194.105.5.37
```

### Adım 2: Gerekli Paketleri Kur
```bash
# Sistem güncellemesi
apt update && apt upgrade -y

# Git kurulumu
apt install git screen mariadb-server -y
```

### Adım 3: Projeyi Clone'la
```bash
# Ana dizine git
cd /root

# Eğer daha önce clone yaptıysan, sil
rm -rf fivem

# GitHub'dan yeni haliyle clone'la
git clone https://github.com/swaffX/fivem.git

# Klasöre gir
cd fivem
```

### Adım 4: FiveM Server Binary İndir
```bash
# Ana dizine dön
cd /root

# FiveM server'ı indir (Linux için)
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz

# Çıkart
tar xf fx.tar.xz

# Proje klasörüne taşı
mv alpine /root/fivem/
```

### Adım 5: Server Config Oluştur
```bash
cd /root/fivem

# Şablon dosyayı kopyala
cp data/server.cfg.example data/server.cfg

# Düzenle
nano data/server.cfg
```

**Düzenlemen gereken satırlar:**

1. **License Key (Satır 14):**
```
sv_licenseKey "BURAYA_YENİ_LICENSE_KEY_YAZIN"
```

2. **MySQL Connection (Satır 44):**
```
set mysql_connection_string "mysql://fivem:GuclU_SiFrE123@localhost/fivem?charset=utf8mb4"
```

3. **Rcon Password (Satır 109):**
```
rcon_password "BaSkA_GuClU_SiFrE456"
```

**Kaydet ve çık:** CTRL+X, sonra Y, sonra ENTER

### Adım 6: MySQL Veritabanı Kur
```bash
# MySQL'i başlat
systemctl start mariadb
systemctl enable mariadb

# Güvenlik ayarları (root şifresi belirle)
mysql_secure_installation
```

**Sorulara cevaplar:**
- Switch to unix_socket authentication? **N**
- Change the root password? **Y** (güçlü bir şifre belirle)
- Remove anonymous users? **Y**
- Disallow root login remotely? **Y**
- Remove test database? **Y**
- Reload privilege tables? **Y**

### Adım 7: Veritabanı Oluştur
```bash
# MySQL'e gir (az önce belirlediğin root şifresini gir)
mysql -u root -p
```

MySQL içinde:
```sql
CREATE DATABASE fivem CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'GuclU_SiFrE123';
GRANT ALL PRIVILEGES ON fivem.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Adım 8: SQL Dosyalarını İçe Aktar
```bash
cd /root/fivem/data

# SQL dosyalarını import et
mysql -u fivem -p fivem < EKSIK_TABLOLAR_FIX.sql
mysql -u fivem -p fivem < PHONE_INVOICES_SAFE_FIX.sql
```

Şifre: `GuclU_SiFrE123` (veya senin belirlediğin)

### Adım 9: Firewall Ayarları
```bash
# UFW kur ve ayarla
apt install ufw -y

# Gerekli portları aç
ufw allow 22/tcp      # SSH
ufw allow 30120/tcp   # FiveM TCP
ufw allow 30120/udp   # FiveM UDP

# Firewall'u aktif et
ufw enable
```

### Adım 10: Sunucuyu Başlat
```bash
# Screen oturumu başlat
screen -S fivem

# Sunucuyu çalıştır
cd /root/fivem
./alpine/opt/cfx-server/ld-musl-x86_64.so.1 \
  --library-path ./alpine/usr/lib/v8/:./alpine/lib/:./alpine/usr/lib/ \
  -- ./alpine/opt/cfx-server/FXServer \
  +set citizen_dir ./alpine/opt/cfx-server/citizen/ \
  +set sv_licenseKey "BURAYA_YENİ_LICENSE_KEY" \
  +exec data/server.cfg
```

**Screen komutları:**
- Screen'den çıkmak için: **CTRL+A+D**
- Screen'e geri dönmek için: `screen -r fivem`
- Sunucuyu durdurmak için: Screen'e gir ve **CTRL+C**

## 🎮 SUNUCUYA BAĞLANMA

FiveM'i aç ve F8'e bas, sonra:
```
connect 194.105.5.37:30120
```

## 📝 HIZLI KOMUTLAR

### Sunucu Durumunu Kontrol Et
```bash
screen -r fivem
```

### Sunucuyu Durdur
```bash
screen -r fivem
# CTRL+C ile durdur
```

### Sunucuyu Yeniden Başlat
```bash
screen -r fivem
# CTRL+C ile durdur
# Yukarı ok tuşu ile son komutu getir
# ENTER ile başlat
```

### Logları İzle
```bash
cd /root/fivem
tail -f server.log
```

### Veritabanı Yedeği Al
```bash
mysqldump -u fivem -p fivem > backup_$(date +%Y%m%d).sql
```

## ❓ SORUN ÇÖZME

### "License key geçersiz" hatası:
- Keymaster'dan yeni key aldığından emin ol
- server.cfg'de doğru yazdığını kontrol et
- Key'de boşluk olmamalı

### "MySQL bağlantı hatası":
```bash
# MySQL çalışıyor mu kontrol et
systemctl status mariadb

# Çalışmıyorsa başlat
systemctl start mariadb

# Bağlantıyı test et
mysql -u fivem -p fivem
```

### "Resource bulunamadı" hatası:
```bash
# Dosya izinlerini düzelt
chmod -R 755 /root/fivem

# Git pull ile güncel hali çek
cd /root/fivem
git pull origin master
```

### Sunucu açılmıyor:
```bash
# Port kullanımda mı kontrol et
netstat -tulpn | grep 30120

# Eğer kullanımdaysa, o process'i öldür
kill -9 PID_NUMARASI
```

## 📞 YARDIM

Sorun yaşarsan:
1. Screen loglarını kontrol et: `screen -r fivem`
2. Server loglarını kontrol et: `tail -f /root/fivem/server.log`
3. MySQL loglarını kontrol et: `tail -f /var/log/mysql/error.log`

## 🎯 SONRAKI ADIMLAR

1. ✅ Keymaster'dan yeni license key al
2. ✅ VPS'e bağlan ve kurulumu yap
3. ✅ Sunucuyu başlat
4. ✅ FiveM'den bağlan ve test et
5. ✅ Admin yetkilerini ayarla
6. ✅ Oyuncuları davet et!

**Başarılar! 🚀**
