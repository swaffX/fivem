local Translations = {
    error = {
        ["missing_something"] = "Bir şeyleri kaçırıyorsun gibi görünüyor...",
        ["not_enough_police"] = "Yetersiz Polis..",
        ["door_open"] = "Kapı zaten açık..",
        ["cancelled"] = "İşlem İptal Edildi..",
        ["didnt_work"] = "İşe yaramadı..",
        ["emty_box"] = "Kutu Boş..",
        ["injail"] = "%{Time} aydır hapistesiniz..",
        ["item_missing"] = "Bir Öğe eksik..",
        ["escaped"] = "Sen kaçtın... Defol buradan.!",
        ["do_some_work"] = "Cümle azaltma için biraz çalışın, anında iş: %{current job} ",
        ["security_activated"] = "En yüksek güvenlik seviyesi aktif, hücre bloklarıyla kalın!"
    },
    success = {
        ["found_phone"] = "bir telefon buldun..",
        ["time_cut"] = "Cezan için bir süre çalıştın.",
        ["free_"] = "Özgürsün! Tadını çıkar! :)",
        ["timesup"] = "Süren doldu! Ziyaretçi merkezinde kendinizi kontrol edin",
    },
    info = {
        ["timeleft"] = "Hala... %{JAILTIME} ay",
        ["lost_job"] = "işsizsin",
        ["job_interaction"] = "[E] Elektrik İşleri",
        ["job_interaction_target"] = "%{job} Çalışın",
        ["received_property"] = "Malını geri aldın..",
        ["seized_property"] = "Mülkünüze el konuldu, süreniz dolduğunda her şeyi geri alacaksınız..",
        ["cells_blip"] = "Hücreler",
        ["freedom_blip"] = "Hapishane Ön Büro",
        ["canteen_blip"] = "Kantin",
        ["work_blip"] = "Hapishane Çalışması",
        ["target_freedom_option"] = "Zamanı kontrol et",
        ["target_canteen_option"] = "Yiyecek al",
        ["police_alert_title"] = "Yeni Çağrı",
        ["police_alert_description"] = "Hapishane Salgını",
        ["connecting_device"] = "Cihaz Bağlanıyor",
        ["working_electricity"] = "Bağlantı Telleri"
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
