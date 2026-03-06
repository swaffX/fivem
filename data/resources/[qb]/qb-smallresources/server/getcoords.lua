-- Panoya kopyalama (opsiyonel, bazı sunucularda çalışmayabilir)
RegisterServerEvent('getcoords:copyToClipboard')
AddEventHandler('getcoords:copyToClipboard', function(text)
    -- Bu özellik client-side clipboard API gerektirir
    -- Şimdilik sadece console'a yazdırıyoruz
end)
