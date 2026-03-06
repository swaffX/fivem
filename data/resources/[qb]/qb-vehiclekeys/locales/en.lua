local Translations = {
    notify = {
        ydhk = 'Bu aracın anahtarları sizde yok.',
        nonear = 'Yakınlarda anahtarları teslim edecek kimse yok',
        vlock = 'Araç kilitli!',
        vunlock = 'Araç kilidi açıldı!',
        vlockpick = 'Kapı kilidini açmayı başardın!',
        fvlockpick = 'Anahtarları bulamıyor ve sinirleniyorsunuz.',
        vgkeys = 'sen anahtarları teslim et.',
        vgetkeys = 'Aracın anahtarlarını aldın!',
        fpid = 'Oyuncu kimliğini ve Plaka argümanlarını doldurun',
        cjackfail = 'Araba hırsızlığı başarısız oldu!',
    },
    progress = {
        takekeys = 'Vücuttan anahtar alıyorsun...',
        hskeys = 'Araba anahtarları aranıyor...',
        acjack = 'Araba hırsızlığına teşebbüs...',
    },
    info = {
        skeys = '~g~[H]~w~ - Anahtarları Ara',
        tlock = 'Araç Kilitlerini Aç/Kapat',
        palert = 'Araç hırsızlığı devam ediyor. Tip: ',
        engine = 'Motoru Aç/Kapat',
    },
    addcom = {
        givekeys = 'Anahtarları birine teslim edin. Kimlik yoksa en yakın kişiye veya araçtaki herkese verir.',
        givekeys_id = 'id',
        givekeys_id_help = 'Oyuncu ID',
        addkeys = 'Birisi için bir araca anahtarlar ekler.',
        addkeys_id = 'id',
        addkeys_id_help = 'Oyuncu ID',
        addkeys_plate = 'Plaka',
        addkeys_plate_help = 'Plaka',
        rkeys = 'Birisi için bir aracın anahtarlarını çıkarın.',
        rkeys_id = 'id',
        rkeys_id_help = 'Oyuncu ID',
        rkeys_plate = 'Plaka',
        rkeys_plate_help = 'Plaka',
    }

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
