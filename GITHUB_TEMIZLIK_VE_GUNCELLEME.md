# GitHub Temizlik ve Güncelleme Rehberi

## ⚠️ YAPILAN TEMİZLİKLER

### 1. Hassas Dosyalar .gitignore'a Eklendi
Aşağıdaki hassas dosyalar artık GitHub'a yüklenmeyecek:
- `txData/` - Oyuncu verileri ve admin bilgileri
- `txAdmin/` - Admin panel verileri
- `data/server.cfg` - License key ve hassas ayarlar içeriyor
- `**/admins.json` - Admin listesi
- `**/playersDB.json` - Oyuncu veritabanı
- `**/config.json` - Konfigürasyon dosyaları

### 2. Oluşturulan Güvenli Dosyalar
- `data/server.cfg.example` - Şablon config dosyası (hassas bilgiler yok)

## 🔄 ŞİMDİ YAPMAN GEREKENLER

### Adım 1: Git Cache'i Temizle
```bash
# Hassas dosyaları git geçmişinden kaldır
git rm -r --cached txData/
git rm -r --cached txAdmin/
git rm --cached data/server.cfg
```

### Adım 2: Değişiklikleri Commit Et
```bash
git add .gitignore
git add data/server.cfg.example
git add GITHUB_TEMIZLIK_VE_GUNCELLEME.md
git commit -m "Güvenlik: Hassas dosyalar kaldırıldı ve .gitignore güncellendi"
```

### Adım 3: GitHub'a Push Et
```bash
git push origin master
```

### Adım 4: GitHub'da License Key'i Değiştir
⚠️ **ÖNEMLİ**: `data/server.cfg` dosyasında license key'in GitHub'a yüklenmiş olması güvenlik riski!

1. https://keymaster.fivem.net adresine git
2. Mevcut key'i SİL veya DEVRE DIŞI BIRAK
3. YENİ bir license key oluştur
4. VPS'de yeni key'i kullan

## 📋 VPS'DE YAPILACAKLAR

### 1. Repository'yi Güncelle (VPS'de)
```bash
cd /root/fivem
git pull origin master
```

### 2. Server Config Dosyasını Oluştur
```bash
# Şablon dosyayı kopyala
cp data/server.cfg.example data/server.cfg

# Düzenle
nano data/server.cfg
```

**Düzenlemen gereken yerler:**
- `sv_licenseKey` - Yeni license key'ini yaz
- `mysql_connection_string` - Veritabanı bilgilerini yaz
- `rcon_password` - Güçlü bir şifre belirle
- `sv_hostname` - Sunucu adını yaz

### 3. MySQL Bağlantısını Ayarla
```bash
nano data/server.cfg
```

MySQL connection string formatı:
```
set mysql_connection_string "mysql://kullanici:sifre@localhost/veritabani?charset=utf8mb4"
```

Örnek:
```
set mysql_connection_string "mysql://fivem:GuclU_SiFrE123@localhost/fivem?charset=utf8mb4"
```

## 🔒 GÜVENLİK ÖNERİLERİ

### 1. Asla GitHub'a Yükleme:
- License key'ler
- Veritabanı şifreleri
- Rcon şifreleri
- Oyuncu verileri
- Admin bilgileri
- Steam API key'ler

### 2. Her Zaman Kullan:
- `.gitignore` dosyasını güncel tut
- `.example` uzantılı şablon dosyalar oluştur
- Environment variables kullan (opsiyonel)

### 3. Düzenli Kontrol:
```bash
# Hangi dosyaların commit edileceğini kontrol et
git status

# Hassas bilgi içeren dosyaları kontrol et
git diff
```

## 📝 ARTIFACTS KLASÖRÜ HAKKINDA

`artifacts/` klasörü FiveM server binary dosyalarını içeriyor (DLL, EXE dosyaları).
Bu dosyalar:
- ✅ GitHub'da kalabilir (zaten .gitignore'da bazıları var)
- ⚠️ Ama VPS'de yeniden indirmek daha iyi (güncel sürüm için)

**Önerim:** VPS'de FiveM server'ı sıfırdan indir:
```bash
cd /root
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz
tar xf fx.tar.xz
```

## 🎯 SONRAKI ADIMLAR

1. ✅ Git cache'i temizle
2. ✅ Commit ve push yap
3. ✅ Keymaster'dan yeni license key al
4. ✅ VPS'de server.cfg oluştur ve düzenle
5. ✅ MySQL bağlantısını ayarla
6. ✅ Sunucuyu başlat

## ❓ SORUN ÇÖZME

### "License key geçersiz" hatası:
- Keymaster'dan yeni key aldığından emin ol
- server.cfg'de doğru yazdığını kontrol et
- Key'de boşluk veya özel karakter olmamalı

### "MySQL bağlantı hatası":
- MySQL servisinin çalıştığını kontrol et: `systemctl status mariadb`
- Kullanıcı adı ve şifrenin doğru olduğunu kontrol et
- Veritabanının oluşturulduğunu kontrol et: `mysql -u root -p`

### "Resource bulunamadı" hatası:
- Tüm dosyaların doğru yüklendiğini kontrol et
- Klasör izinlerini kontrol et: `chmod -R 755 /root/fivem`
