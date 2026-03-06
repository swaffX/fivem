# Nexora Roleplay - FiveM Server

## 🎮 Sunucu Bilgileri

- **Sunucu Adı:** Nexora Roleplay Test Server
- **Framework:** QBCore
- **Maksimum Oyuncu:** 7
- **Dil:** Türkçe
- **Discord:** discord.gg/Q6vcRA2VY9

## 📋 Özellikler

### Core Sistemler
- ✅ QBCore Framework
- ✅ oxmysql Veritabanı
- ✅ ox_lib Kütüphane
- ✅ qb-inventory (Native)
- ✅ qb-target
- ✅ mHud (Özelleştirilmiş)

### Araç Sistemleri
- ✅ real-vehicleshop (92 araç)
- ✅ galer (Özel galeri sistemi)
- ✅ flaadev-rentcar (4 lokasyon)
- ✅ codem-garage

### Meslek Sistemleri
- ✅ 15+ Legal Meslek (Polis, Ambulans, Mekanik, vb.)
- ✅ 6 Illegal Sistem (Weed, Drugs, vb.)
- ✅ 6 Soygun Sistemi
- ✅ Çiftçilik ve Madencilik

### Optimizasyonlar
- ✅ FPS Booster (nexora-fpsbooster)
- ✅ NPC Yoğunluğu Optimize Edildi
- ✅ Araç Yoğunluğu Azaltıldı
- ✅ Entity Culling

## 🚀 Kurulum

### 1. Gereksinimler
- Ubuntu 20.04+ veya Windows Server
- MySQL 8.0+
- Git
- FXServer artifacts

### 2. Projeyi Klonlama
```bash
git clone https://github.com/swaffX/fivem.git
cd fivem
```

### 3. Veritabanı Kurulumu

⚠️ **ÖNEMLİ:** `temelpaket.sql` dosyası GitHub'da YOK (çok büyük). Bu dosyayı ayrıca yüklemeniz gerekiyor.

```bash
# MySQL'e bağlan
mysql -u root -p

# Veritabanı oluştur
CREATE DATABASE temelPaket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Ana SQL dosyasını çalıştır (önce yüklemeniz gerekiyor)
mysql -u root -p temelPaket < temelpaket.sql

# Düzeltme SQL dosyalarını çalıştır (GitHub'dan geliyor)
mysql -u root -p temelPaket < data/EKSIK_TABLOLAR_FIX.sql
mysql -u root -p temelPaket < data/PHONE_INVOICES_SAFE_FIX.sql
```

### 4. FXServer Artifacts İndirme

⚠️ **ÖNEMLİ:** Artifacts klasörü boş (gitignore'da). FXServer'ı manuel indirmeniz gerekiyor.

```bash
# Linux için
cd artifacts
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest/fx.tar.xz
tar -xf fx.tar.xz
rm fx.tar.xz
chmod +x run.sh

# Windows için
# https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
# adresinden en son sürümü indirin ve artifacts klasörüne çıkartın
```

### 5. Server.cfg Düzenleme
```bash
nano data/server.cfg

# Düzenlenecek satırlar:
# - sv_licenseKey (FiveM license key)
# - mysql_connection_string (veritabanı bilgileri)
# - sv_hostname (sunucu adı)
```

### 6. Sunucuyu Başlatma
```bash
# Linux
cd artifacts
./run.sh +exec ../data/server.cfg

# Windows
cd artifacts
FXServer.exe +exec ../data/server.cfg
```

## 📁 Proje Yapısı

```
fivem/
├── artifacts/              # FXServer binary dosyaları (gitignore)
├── data/
│   ├── resources/
│   │   ├── [alan]/        # Özel scriptler
│   │   ├── [cars]/        # Araç modları
│   │   ├── [meslek]/      # Meslek scriptleri
│   │   ├── [mlo]/         # MLO'lar
│   │   ├── [qb]/          # QBCore scriptleri
│   │   ├── [standalone]/  # Bağımsız scriptler
│   │   └── [voice]/       # Ses sistemi
│   ├── server.cfg         # Ana config
│   ├── EKSIK_TABLOLAR_FIX.sql
│   └── PHONE_INVOICES_SAFE_FIX.sql
├── .gitignore
└── README.md
```

## 🔧 Yapılandırma

### Admin Ekleme
`data/server.cfg` dosyasında:
```lua
add_principal identifier.fivem:YOUR_ID group.admin
add_principal identifier.discord:YOUR_DISCORD_ID group.admin
```

### Veritabanı Bağlantısı
`data/server.cfg` dosyasında:
```lua
set mysql_connection_string "mysql://root:password@localhost/temelPaket?charset=utf8mb4"
```

### License Key
`data/server.cfg` dosyasında:
```lua
sv_licenseKey "YOUR_LICENSE_KEY"
```

## 📊 Performans

### FPS Optimizasyonları
- Araç yoğunluğu: %40 azaltıldı
- Park edilmiş araçlar: %60 azaltıldı
- NPC yoğunluğu: %25 azaltıldı
- Beklenen FPS artışı: +5-15 FPS

### Maaş Sistemi
- Polis: 500-5,000 TL
- Ambulans: 500-3,000 TL
- Sheriff/SASP/FBI: 500-3,500 TL
- Mekanik: 400-2,000 TL
- Diğer meslekler: 300-2,000 TL

## 🐛 Bilinen Sorunlar

### Düzeltildi ✅
- ✅ Karakter oluşturma cinsiyet sorunu
- ✅ Tarih validasyonu
- ✅ Illegal mechanic blip hatası
- ✅ Rent-a-car ped görünmeme
- ✅ Galeri fuel sistemi
- ✅ mHud entegrasyonu
- ✅ CSS uyarıları
- ✅ SQL duplicate column hatası
- ✅ Maaş dengesizliği

### Kapalı Scriptler ❌
- ❌ qb-apartments (qb-clothing bağımlılığı)
- ❌ qb-crypto (mhacking bağımlılığı)
- ❌ qb-taxijob (SpawnPed hatası)
- ❌ cloud-shop (ox_target bağımlılığı)

## 📚 Dokümantasyon

Detaylı kurulum rehberi:
- `UBUNTU_VPS_KURULUM_REHBERI.md` - Ubuntu VPS kurulum rehberi (GitHub clone ile)

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📝 Lisans

Bu proje özel bir FiveM sunucusu için geliştirilmiştir.

## 📞 İletişim

- **Discord:** discord.gg/Q6vcRA2VY9
- **GitHub:** https://github.com/swaffX/fivem

## 🙏 Teşekkürler

- QBCore Framework
- FiveM Community
- Tüm script geliştiricileri

---

**Son Güncelleme:** 6 Mart 2026  
**Versiyon:** 1.0.0  
**Durum:** ✅ Production Ready
