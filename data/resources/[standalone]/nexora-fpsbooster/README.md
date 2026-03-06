# Nexora FPS Booster

## 🚀 Özellikler

### Trafik Optimizasyonu
- ✅ Araç yoğunluğu %50 azaltıldı
- ✅ Yaya yoğunluğu %60 azaltıldı
- ✅ Park edilmiş araçlar %50 azaltıldı
- ✅ Senaryo yoğunluğu %70 azaltıldı

### Entity Yönetimi
- ✅ 300m+ uzaktaki boş araçlar otomatik siliniyor
- ✅ 200m+ uzaktaki NPC'ler otomatik siliniyor
- ✅ Gereksiz AI spawn'ları kapatıldı

### Grafik Optimizasyonları
- ✅ Uzak ışıklar kapatıldı
- ✅ Gölgeler optimize edildi
- ✅ Bulutlar kapatıldı
- ✅ Uzak LOD detayları azaltıldı

### Oyun Özellikleri
- ✅ Polis, ambulans, itfaiye spawn'ı kapatıldı
- ✅ Wanted level sistemi kapatıldı
- ✅ Rastgele trenler kapatıldı
- ✅ Rastgele tekneler kapatıldı
- ✅ Uzak siren sesleri kapatıldı

## 📊 Beklenen FPS Artışı

| Sistem | Öncesi | Sonrası | Artış |
|--------|--------|---------|-------|
| Düşük  | 30-40  | 50-60   | +20   |
| Orta   | 50-60  | 70-90   | +20   |
| Yüksek | 80-100 | 100-120 | +20   |

## ⚙️ Kurulum

1. `nexora-fpsbooster` klasörünü `resources/[standalone]/` içine kopyala
2. `server.cfg` dosyasına ekle: `ensure nexora-fpsbooster`
3. Sunucuyu yeniden başlat

## 🎮 Oyuncu Tarafı Optimizasyonlar

Oyunculara şu ayarları önerin:

### GTA 5 Grafik Ayarları
```
- MSAA: Kapalı
- FXAA: Açık
- Post FX: Normal
- Gölgeler: Normal
- Yansımalar: Normal
- Grass Quality: Normal
- Soft Shadows: Kapalı
- Reflection MSAA: Kapalı
- Extended Distance Scaling: 0%
- Extended Shadows Distance: 0%
```

### FiveM Launch Options
```
-heapsize 2097152
```

## 🔧 İleri Seviye Ayarlar

Daha fazla FPS için `client.lua` içinde:

```lua
-- Araç silme mesafesini değiştir (varsayılan: 300)
if distance > 300.0 then

-- NPC silme mesafesini değiştir (varsayılan: 200)
if distance > 200.0 then
```

## ⚠️ Notlar

- Bu script roleplay deneyimini etkileyebilir
- Şehir daha boş görünecektir
- Performans > Gerçekçilik dengesi kurulmuştur
- Test sunucusu için idealdir

## 📝 Changelog

### v1.0.0
- İlk sürüm
- Temel FPS optimizasyonları
- Entity yönetimi
- Grafik optimizasyonları
