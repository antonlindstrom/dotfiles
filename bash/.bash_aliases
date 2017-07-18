alias be='bundle exec'
alias backup='restic -r /var/tmp/backup backup'
alias snapshots='restic -r /var/tmp/backup snapshots'
alias sunset="curl -s 'http://api.sunrise-sunset.org/json?lat=57.708870&lng=11.974560&date=today&formatted=0' | jq .results.sunset"
alias daylength="curl -s 'http://api.sunrise-sunset.org/json?lat=57.708870&lng=11.974560&date=today&formatted=1' | jq .results.day_length"
alias moonsun="curl -s 'http://api.sunrise-sunset.org/json?lat=57.708870&lng=11.974560&date=today&formatted=0' | jq ."
alias btc='curl -s "https://api.coinbase.com/v2/prices/BTC-SEK/spot" | jq .data'
alias battery='acpi -b'
