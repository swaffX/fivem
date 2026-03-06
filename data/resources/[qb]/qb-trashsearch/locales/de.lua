local Translations = {
    info = {
        search = 'Müll durchsu',
    },
    error = {
        cooldown = 'Du musst %{time} Sekunden warten, um erneut zu su',
        hasBeenSearched = "Dieser Mülleimer ist bereits durchsucht worden!",
        nothingFound = "Du hast nichts gefunden!",
    },
    progressbar = {
        searching = "Müll durchsu",
    },
    reward = {
        money = "Du hast %{amount}$ gefunden",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
