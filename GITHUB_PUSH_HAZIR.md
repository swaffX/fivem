# ✅ GitHub Push Hazır

## Yapılan Temizlik

### Silinen Dosyalar (23 adet)
- ✅ 17 gereksiz .md dosyası (root dizinden)
- ✅ 6 gereksiz .md dosyası (data klasöründen)
- ✅ 5 gereksiz .sh dosyası

### Oluşturulan Dosyalar
- ✅ `UBUNTU_VPS_KURULUM_REHBERI.md` - Detaylı kurulum rehberi
- ✅ `HIZLI_BASLANGIC.md` - Hızlı başlangıç rehberi
- ✅ `GITHUB_PUSH_HAZIR.md` - Bu dosya

### Güncellenen Dosyalar
- ✅ `README.md` - GitHub repo açıklaması güncellendi
- ✅ `.gitignore` - Gereksiz dosyalar ignore edildi

## GitHub'a Push Etme

```bash
# Değişiklikleri kontrol et
git status

# Tüm değişiklikleri ekle
git add .

# Commit yap
git commit -m "Temizlik: Gereksiz dosyalar kaldırıldı, VPS kurulum rehberi eklendi"

# GitHub'a push et
git push origin main
```

## VPS'e Kurulum İçin

### Yöntem 1: GitHub Clone (Önerilen)
```bash
cd /home
git clone https://github.com/swaffX/fivem.git
cd fivem
```

### Yöntem 2: Manuel Yükleme
- FileZilla, WinSCP veya SCP ile dosyaları yükle

## ⚠️ Önemli Notlar

### GitHub'da OLMAYAN Dosyalar (Manuel Yükleme Gerekli)
1. **temelpaket.sql** - Ana veritabanı dosyası (çok büyük)
2. **artifacts/** - FXServer binary dosyaları (VPS'de indirilecek)
3. **data/cache/** - Cache dosyaları (VPS'de oluşacak)
4. **txData/** - txAdmin verileri (VPS'de oluşacak)

### GitHub'da OLAN Dosyalar
1. ✅ **data/resources/** - Tüm scriptler
2. ✅ **data/server.cfg** - Server config (VPS'de düzenlenecek)
3. ✅ **data/EKSIK_TABLOLAR_FIX.sql** - SQL düzeltmeleri
4. ✅ **data/PHONE_INVOICES_SAFE_FIX.sql** - SQL düzeltmeleri
5. ✅ **README.md** - Proje açıklaması
6. ✅ **UBUNTU_VPS_KURULUM_REHBERI.md** - Detaylı kurulum
7. ✅ **HIZLI_BASLANGIC.md** - Hızlı başlangıç

## VPS Kurulum Adımları (Özet)

1. **VPS Hazırlık**
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install -y git wget curl tar screen mariadb-server
   ```

2. **MySQL Kurulum**
   ```bash
   sudo mysql_secure_installation
   mysql -u root -p
   CREATE DATABASE temelPaket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

3. **GitHub Clone**
   ```bash
   cd /home
   git clone https://github.com/swaffX/fivem.git
   cd fivem
   ```

4. **FXServer İndir**
   ```bash
   cd artifacts
   wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz
   tar -xf fx.tar.xz && rm fx.tar.xz
   chmod +x run.sh
   ```

5. **temelpaket.sql Yükle**
   ```bash
   # FileZilla ile yükle, sonra:
   mysql -u root -p temelPaket < /home/fivem/temelpaket.sql
   mysql -u root -p temelPaket < /home/fivem/data/EKSIK_TABLOLAR_FIX.sql
   mysql -u root -p temelPaket < /home/fivem/data/PHONE_INVOICES_SAFE_FIX.sql
   ```

6. **Server.cfg Düzenle**
   ```bash
   nano /home/fivem/data/server.cfg
   # License key, MySQL bağlantısı, admin ID'leri değiştir
   ```

7. **Güvenlik Duvarı**
   ```bash
   sudo ufw allow 22/tcp
   sudo ufw allow 30120/tcp
   sudo ufw allow 30120/udp
   sudo ufw allow 40120/tcp
   sudo ufw enable
   ```

8. **Başlat**
   ```bash
   screen -S fivem
   cd /home/fivem/artifacts
   ./run.sh +set txAdminPort 40120
   ```

9. **txAdmin Kur**
   - Tarayıcı: `http://VPS_IP:40120`
   - Custom seç
   - Data folder: `/home/fivem/data`
   - License key gir

10. **Bağlan**
    ```
    FiveM → F8 → connect VPS_IP:30120
    ```

## 📚 Dokümantasyon

- **Detaylı Rehber:** `UBUNTU_VPS_KURULUM_REHBERI.md`
- **Hızlı Başlangıç:** `HIZLI_BASLANGIC.md`
- **Proje Bilgisi:** `README.md`

## 🔗 Linkler

- **GitHub:** https://github.com/swaffX/fivem
- **License Key:** https://keymaster.fivem.net
- **Steam API:** https://steamcommunity.com/dev/apikey
- **Discord:** discord.gg/Q6vcRA2VY9

---

**Durum:** ✅ GitHub'a push etmeye hazır  
**Tarih:** 6 Mart 2026  
**Versiyon:** 1.0.0
