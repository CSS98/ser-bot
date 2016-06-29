#SerBot 🔱
# channel [Developr <[Nn]>](https://telegram.me/DevPointTeam)
* * *


# التنصيب

sh
# Install dependencies.
# Tested on Ubuntu 14.04. For other OSs, check out https://github.com/yagop/telegram-bot/wiki/Installation
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev

# Let's install the bot.
git clone https://github.com/set-bot/ser-bot
cd ser-bot
chmod +x launch.sh
./launch.sh install
./launch.sh # Enter a phone number & confirmation code.
* * *

### Realm configuration

After you run the bot for first time, send it !id. Get your ID and stop the bot.

Open ./data/config.lua and add your ID to the "sudo_users" section in the following format:
  sudo_users = {
    160808163,
    204378180
    0,
    YourID
  }
Then restart the bot.

Create a realm using the !createrealm command.

* * *

**Creating a LOG SuperGroup**
  -For GBan Log

  1. Create a group using the !creategroup command.
  2. Add two members or bots, then use #Tosuper to convert to a SuperSroup.
  3. Use the #addlog command and your ***LOG SuperGroup(s)*** will be set.
  Note: you can set multiple Log SuperGroups

* * *

# Support and development [Developr <[Nn]>](https://telegram.me/iq_devloper) 🐾

# Special thanks to [@teleseed](https://telegram.me/teleseedCH) ❤️

For managing on Telegram.
Development [@ilwil](https://telegram.me/ilwil) ❤️
Subscribe to Source channel [Developr <[Nn]>](https://telegram.me/iq_devloper) 💢
