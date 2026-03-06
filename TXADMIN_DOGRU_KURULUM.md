# txAdmin DOĞRU KURULUM - SORUN ÇÖZÜLDÜ!

## SORUN NEYDİ?
txAdmin **ZATEN** FXServer ile birlikte geliyor! `/root/fivem/alpine/` içinde var.
Biz yanlış başlatıyorduk - `+exec server.cfg` ile başlatınca txAdmin devreye girmiyor.

## DOĞRU ÇÖZÜM

### 1. Mevcut Sunucuyu Durdur
```bash
ssh root@194.105.5.37
screen -S fivem -X quit
```

### 2. txAdmin Modunda Başlat (server.cfg OLMADAN)
```bash
cd /root/fivem/alpine
screen -S txadmin
./run.sh +set serverProfile nexora +set txAdminPort 40120
```

Bu komut:
- FXServer'ı **txAdmin monitor modunda** başlatır
- server.cfg kullanmaz (txAdmin kendi yönetir)
- Web arayüzü açılır: `http://194.105.5.37:40120`

### 3. İlk Kurulum (Web Arayüzü)
1. Tarayıcıda aç: `http://194.105.5.37:40120`
2. Terminal'de gösterilen PIN kodunu gir
3. Admin hesabı oluştur
4. "Import Existing Server" seç veya "Setup using Recipe"

### 4. Mevcut Sunucuyu Import Et
Eğer mevcut server.cfg ve resourceları kullanmak istersen:
- Server Data Folder: `/root/fivem/data`
- CFG Path: `/root/fivem/data/server.cfg`
- Resources Path: `/root/fivem/resources`

### 5. Ya da Sıfırdan Kur
- "Setup using Recipe" seç
- "QBCore" recipe'sini seç
- Otomatik kurulum yapsın
- Sonra mevcut resourceları kopyalarsın

## ÖNEMLİ NOTLAR
- txAdmin modunda başlatınca `+exec server.cfg` KULLANMA
- txAdmin kendi server.cfg'yi yönetir
- Tüm ayarlar web arayüzünden yapılır
- Screen'den çıkmak: `CTRL+A` sonra `D`

## txAdmin'e Bağlanma
- URL: `http://194.105.5.37:40120`
- İlk PIN: Terminal'de gösterilecek
- Admin kullanıcı adı/şifre: İlk kurulumda sen belirlersin
