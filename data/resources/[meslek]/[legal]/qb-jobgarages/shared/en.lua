local Translations = {
    general = {
        blip = "Meslek Garajı"
    },
    logging = {
        creating_blips = "Tüm garajlar için blip oluşturuluyor",
        opening_menu = "Garaj menüsü açılıyor..",
        spawn_vehicle = "Aracı Çıkar",
        return_vehicle = "Aracı teslim et"
    },
    menu = {
        header = "Meslek Garajı",
        return_vehicle = "Aracı garaja koy",
        no_vehicles = "Araç yok"
    },
    notifications = {
        received_keys = "Aracın anahtarlarını aldınız!",
        returned_vehicle = "Aracı iade ettiniz!"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})