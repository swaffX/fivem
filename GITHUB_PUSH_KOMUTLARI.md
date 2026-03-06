# GitHub'a Push Etme Komutları

## 1. Git Başlatma ve İlk Commit

```bash
# Git repository'yi başlat
git init

# Tüm dosyaları stage'e ekle
git add .

# İlk commit
git commit -m "Initial commit: Nexora Roleplay FiveM Server v1.0.0

- QBCore framework kurulumu
- 92 araç eklendi (real-vehicleshop)
- 15+ legal meslek sistemi
- 6 illegal sistem
- 6 soygun sistemi
- FPS optimizasyonları
- mHud özelleştirmesi
- Maaş sistemi dengelendi
- Tüm bug'lar düzeltildi
- Production ready"
```

## 2. GitHub Remote Ekleme

```bash
# GitHub remote'u ekle
git remote add origin https://github.com/swaffX/fivem.git

# Remote'u kontrol et
git remote -v
```

## 3. Branch Oluşturma ve Push

```bash
# Ana branch'i main olarak ayarla
git branch -M main

# GitHub'a push et
git push -u origin main
```

## 4. Eğer Hata Alırsan

### Hata: "failed to push some refs"
```bash
# GitHub'daki değişiklikleri çek
git pull origin main --allow-unrelated-histories

# Tekrar push et
git push -u origin main
```

### Hata: "Authentication failed"
```bash
# GitHub Personal Access Token kullan
# Settings > Developer settings > Personal access tokens > Generate new token
# Token'ı şifre olarak kullan
```

### Hata: "Repository not found"
```bash
# Remote URL'i kontrol et
git remote -v

# Yanlışsa düzelt
git remote set-url origin https://github.com/swaffX/fivem.git
```

## 5. Büyük Dosyalar İçin Git LFS (Opsiyonel)

Eğer büyük dosyalar varsa (>100MB):

```bash
# Git LFS kur
git lfs install

# Büyük dosya tiplerini track et
git lfs track "*.dll"
git lfs track "*.exe"
git lfs track "*.ytd"
git lfs track "*.yft"

# .gitattributes'u commit et
git add .gitattributes
git commit -m "Add Git LFS tracking"
git push
```

## 6. VPS'e Çekme Komutları

VPS'de çalıştırılacak komutlar:

```bash
# Repository'yi klonla
cd /home/fivem
git clone https://github.com/swaffX/fivem.git
cd fivem

# Artifacts indir (Linux)
cd artifacts
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/[BUILD_NUMBER]/fx.tar.xz
tar -xf fx.tar.xz
rm fx.tar.xz
cd ..

# Veritabanını kur
mysql -u root -p temelPaket < data/EKSIK_TABLOLAR_FIX.sql
mysql -u root -p temelPaket < data/PHONE_INVOICES_SAFE_FIX.sql

# Server.cfg'yi düzenle
nano data/server.cfg
# License key, veritabanı bilgileri, vb. düzenle

# Sunucuyu başlat
cd artifacts
./run.sh +exec ../data/server.cfg
```

## 7. Güncellemeleri Push Etme

Gelecekte değişiklik yaptığında:

```bash
# Değişiklikleri stage'e ekle
git add .

# Commit yap
git commit -m "Fix: [Açıklama]"

# Push et
git push origin main
```

## 8. VPS'de Güncelleme Çekme

```bash
# VPS'de
cd /home/fivem/fivem

# Sunucuyu durdur
# CTRL+C veya screen/tmux'tan çık

# Güncellemeleri çek
git pull origin main

# Sunucuyu tekrar başlat
cd artifacts
./run.sh +exec ../data/server.cfg
```

## 9. Branch Stratejisi (Önerilen)

```bash
# Development branch oluştur
git checkout -b development

# Değişiklikleri development'ta yap
git add .
git commit -m "Feature: Yeni özellik"
git push origin development

# Test ettikten sonra main'e merge et
git checkout main
git merge development
git push origin main
```

## 10. Faydalı Git Komutları

```bash
# Durum kontrolü
git status

# Commit geçmişi
git log --oneline

# Son commit'i geri al (dikkatli!)
git reset --soft HEAD~1

# Değişiklikleri geri al
git checkout -- .

# Branch listesi
git branch -a

# Uzak branch'leri güncelle
git fetch --all

# Belirli bir dosyayı geri al
git checkout HEAD -- dosya.lua
```

## 11. .gitignore Kontrolü

Push etmeden önce kontrol et:

```bash
# Hangi dosyaların ignore edildiğini gör
git status --ignored

# Büyük dosyaları bul
find . -type f -size +50M

# Cache dosyalarını temizle
git rm -r --cached data/cache/
```

## 12. Güvenlik Kontrolleri

Push etmeden önce:

```bash
# Hassas bilgileri kontrol et
grep -r "password" data/
grep -r "licenseKey" data/
grep -r "mysql://" data/

# Server.cfg'de hassas bilgileri temizle (VPS'de düzenlenecek)
# - License key
# - Veritabanı şifresi
# - Admin ID'leri (opsiyonel)
```

---

## ✅ Checklist

Push etmeden önce kontrol et:

- [ ] .gitignore dosyası oluşturuldu
- [ ] README.md hazırlandı
- [ ] Hassas bilgiler temizlendi
- [ ] Büyük dosyalar kontrol edildi
- [ ] Git init yapıldı
- [ ] İlk commit yapıldı
- [ ] Remote eklendi
- [ ] Push edildi
- [ ] GitHub'da görünüyor mu?

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 6 Mart 2026
