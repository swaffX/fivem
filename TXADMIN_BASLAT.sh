#!/bin/bash
# txAdmin ile FiveM Server Başlatma

echo "==================================="
echo "txAdmin Başlatılıyor..."
echo "==================================="

cd /root/fivem/alpine/opt/cfx-server

# Cache klasörü oluştur
[ -d cache ] || mkdir cache

# txAdmin modunda başlat (direkt FXServer binary)
./FXServer +set serverProfile nexora +set txAdminPort 40120 +set txAdminInterface 0.0.0.0

# NOT: Bu komut çalıştığında terminal'de bir PIN kodu gösterilecek
# Bu PIN'i tarayıcıda http://194.105.5.37:40120 adresinde kullanacaksınız
