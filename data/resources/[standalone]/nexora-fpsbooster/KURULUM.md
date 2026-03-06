# 🚀 Nexora FPS Booster - Kurulum Rehberi

## ✅ Kurulum Tamamlandı!

FPS Booster başarıyla kuruldu ve yapılandırıldı.

## 🎮 Nasıl Kullanılır?

### Sunucu Tarafı
1. Sunucuyu başlat veya yeniden başlat
2. Console'da şu mesajı göreceksin:
   ```
   [Nexora FPS Booster] FPS optimizasyonu aktif!
   ```

### Oyuncu Tarafı
1. Oyuna gir
2. **F10** tuşuna bas
3. Sol üst köşede FPS bilgilerini göreceksin:
   - Anlık FPS
   - Ortalama FPS
   - 100m içindeki araç sayısı
   - 100m içindeki NPC sayısı

## 📊 Yapılan Optimizasyonlar

### ✅ Trafik Yoğunluğu
- Araçlar: %50 azaltıldı
- Yayalar: %60 azaltıldı
- Park edilmiş araçlar: %50 azaltıldı
- Senaryolar: %70 azaltıldı

### ✅ Entity Yönetimi
- 300m+ uzaktaki boş araçlar otomatik siliniyor
- 200m+ uzaktaki NPC'ler otomatik siliniyor

### ✅ AI Sistemleri
- Polis spawn: Kapalı
- Ambulans spawn: Kapalı
- İtfaiye spawn: Kapalı
- Wanted level: Kapalı
- Rastgele trenler: Kapalı
- Rastgele tekneler: Kapalı

### ✅ Grafik Optimizasyonları
- Uzak ışıklar: Kapalı
- Gölgeler: Optimize edildi
- Bulutlar: Kapalı
- Uzak LOD: Azaltıldı

### ✅ Server Optimizasyonları
- OneSync Infinity: Aktif
- Entity Culling: 250m
- Network: Optimize edildi

## 🎯 Beklenen Sonuçlar

| Durum | FPS Artışı |
|-------|-----------|
| Şehir Merkezi | +15-20 FPS |
| Otoyol | +20-25 FPS |
| Kırsal Alan | +25-30 FPS |

## ⚙️ İleri Seviye Ayarlar

### Daha Az Trafik İstiyorsan
`qb-smallresources/config.lua` dosyasında:
```lua
Config.Density = {
    parked = 0.3,   -- Daha az park edilmiş araç
    vehicle = 0.4,  -- Daha az trafik
    peds = 0.2,     -- Daha az yaya
}
```

### Daha Fazla Trafik İstiyorsan
```lua
Config.Density = {
    parked = 0.8,
    vehicle = 0.8,
    peds = 0.6,
}
```

### Entity Silme Mesafesini Değiştir
`nexora-fpsbooster/client.lua` dosyasında:
```lua
-- Araçlar için (varsayılan: 300m)
if distance > 300.0 then

-- NPC'ler için (varsayılan: 200m)
if distance > 200.0 then
```

## 🔧 Sorun Giderme

### FPS Artmadı?
1. Sunucuyu tamamen yeniden başlat
2. `refresh` komutunu çalıştır
3. `restart nexora-fpsbooster` komutunu çalıştır
4. `restart qb-smallresources` komutunu çalıştır

### Şehir Çok Boş?
- `Config.Density` değerlerini artır (0.6-0.8 arası)

### Hala Lag Var?
- Oyuncuların GTA 5 grafik ayarlarını düşürmelerini söyle
- MSAA'yı kapatın
- Extended Distance Scaling'i 0% yapın

## 📝 Komutlar

| Tuş | Açıklama |
|-----|----------|
| F10 | FPS göstergesini aç/kapat |

## 💡 Oyunculara Öneriler

### GTA 5 Grafik Ayarları
```
MSAA: Kapalı
FXAA: Açık
Post FX: Normal
Gölgeler: Normal
Yansımalar: Normal
Grass Quality: Normal
Soft Shadows: Kapalı
Reflection MSAA: Kapalı
Extended Distance Scaling: 0%
Extended Shadows Distance: 0%
```

### FiveM Launch Options
Steam'de FiveM'e sağ tık > Özellikler > Başlatma Seçenekleri:
```
-heapsize 2097152
```

## 📞 Destek

Sorun yaşıyorsan:
1. Console loglarını kontrol et
2. F8 açıp hata var mı bak
3. `resmon` komutu ile resource kullanımını kontrol et

## 🎉 Başarılı Kurulum!

Artık sunucun daha performanslı çalışacak. İyi oyunlar!
