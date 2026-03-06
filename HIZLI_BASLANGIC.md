# 🚀 Hızlı Başlangıç - Ubuntu VPS Kurulum

## Adım Adım Kurulum (5-10 dakika)

### 1️⃣ VPS'e Bağlan ve Hazırla
```bash
ssh root@VPS_IP_ADRESI
sudo apt update && sudo apt upgrade -y
sudo apt install -y git wget curl tar screen xz-utils mariadb-server
```

### 2️⃣ MySQL Kur ve Veritabanı Oluştur
```bash
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation  # Root şifresi belirle

# MySQL'e gir
sudo mysql -u root -p

# Veritabanı oluştur
CREATE DATABASE temelPaket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'GUVENLI_SIFRE';
GRANT ALL PRIVILEGES ON temelPaket.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 3️⃣ GitHub'dan Clone'la
```bash
cd /home
git clone https://github.com/swaffX/fivem.git
cd fivem
```

### 4️⃣ FXServer İndir
```bash
cd artifacts
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz
tar -xf fx.tar.xz
rm fx.tar.xz
chmod +x run.sh
cd ..
```

### 5️⃣ temelpaket.sql Yükle
```bash
# FileZilla ile temelpaket.sql dosyasını /home/fivem/ klasörüne yükle
# Sonra içe aktar:
mysql -u root -p temelPaket < /home/fivem/temelpaket.sql
mysql -u root -p temelPaket < /home/fivem/data/EKSIK_TABLOLAR_FIX.sql
mysql -u root -p temelPaket < /home/fivem/data/PHONE_INVOICES_SAFE_FIX.sql
```

### 6️⃣ Server.cfg Düzenle
```bash
nano /home/fivem/data/server.cfg
```

**Değiştirilecekler:**
- `sv_licenseKey` → Kendi key'in (https://keymaster.fivem.net)
- `mysql_connection_string` → `mysql://fivem:GUVENLI_SIFRE@localhost/temelPaket?charset=utf8mb4`
- `add_principal identifier.fivem:SENIN_ID group.admin`
- `add_principal identifier.discord:SENIN_DISCORD_ID group.admin`

### 7️⃣ Güvenlik Duvarı Aç
```bash
sudo apt install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 30120/tcp
sudo ufw allow 30120/udp
sudo ufw allow 40120/tcp
sudo ufw enable
```

### 8️⃣ Sunucuyu Başlat
```bash
screen -S fivem
cd /home/fivem/artifacts
./run.sh +set txAdminPort 40120
```

### 9️⃣ txAdmin Kur
1. Tarayıcıda aç: `http://VPS_IP_ADRESI:40120`
2. PIN kodunu gir (terminalde görünür)
3. "Custom" seç
4. Server Data Folder: `/home/fivem/data`
5. License Key gir
6. Admin hesabı oluştur
7. "Save & Start Server"

### 🎮 Bağlan
```
FiveM'i aç → F8 → connect VPS_IP_ADRESI:30120
```

---

## ⚡ Hızlı Komutlar

```bash
# Screen'e bağlan
screen -r fivem

# Screen'den çık (sunucu çalışmaya devam eder)
Ctrl+A+D

# Sunucu durumunu kontrol et
netstat -tulpn | grep 30120

# Logları izle
cd /home/fivem/data
tail -f server.log
```

---

## 🔧 Sorun Giderme

### Sunucu başlamıyor?
```bash
cd /home/fivem/data
cat server.log
```

### MySQL bağlantı hatası?
```bash
sudo systemctl status mariadb
mysql -u fivem -p temelPaket -e "SHOW TABLES;"
```

### Port kapalı?
```bash
sudo ufw status
sudo ufw allow 30120/tcp
sudo ufw allow 30120/udp
```

---

## 📝 Önemli Linkler

- **License Key:** https://keymaster.fivem.net
- **Steam API Key:** https://steamcommunity.com/dev/apikey
- **txAdmin Panel:** http://VPS_IP_ADRESI:40120
- **GitHub Repo:** https://github.com/swaffX/fivem
- **Discord:** discord.gg/Q6vcRA2VY9

---

## ⚠️ Unutma!

1. ✅ temelpaket.sql dosyasını yükle (GitHub'da yok)
2. ✅ License key'ini değiştir
3. ✅ MySQL şifresini güvenli yap
4. ✅ Admin ID'lerini güncelle
5. ✅ Düzenli yedek al

---

**Detaylı rehber için:** `UBUNTU_VPS_KURULUM_REHBERI.md`
