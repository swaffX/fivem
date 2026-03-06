local Translations = {
    success = {
        hunger_set = 'Fitbit: Açlık uyarısı ayarlandı %{hungervalue}%',
        thirst_set = 'Fitbit: Susuzluk uyarısı olarak ayarlandı %{thirstvalue}%',
    },
    warning = {
        hunger_warning = 'senin açlığın %{hunger}%',
        thirst_warning = 'senin susuzluğun %{thirst}%'
    },
    info = {
        fitbit = 'FITBIT '
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
