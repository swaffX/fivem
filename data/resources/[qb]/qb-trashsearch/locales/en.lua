local Translations = {
    info = {
        search = 'Çöp Karıştır',
    },
    error = {
        cooldown = 'Tekrar karıştırmak için %{time} saniye beklemen gerek!',
        hasBeenSearched = "Burayı baskası karıstırmıs...",
        nothingFound = "Hiç bişey bulamadın...",
    },
    progressbar = {
        searching = "Çöp karıştırılıyor...",
    },
    reward = {
        money = "Buldun! %{amount}$",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})