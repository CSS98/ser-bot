do

function run(msg, matches)
return "👋 اهلا بك يا : @"..msg.from.username.."\n\n"
.."أومر المساعدة الخاصة ببوت √SER BOT√ هية ".."\n"
.."➖🔹➖🔸➖🔹➖".."\n"
.." 👥- /helps — أومر المجموعة ".."\n"
.."❗️- /warns — أومر الحماية بلتحذير".."\n"
.."❌- /dels —  أومر الحماية بلحذف ".."\n"
.."➖🔹➖🔸➖🔹➖".."\n"
.."Bot twasl @ilwilbot 🔱".."\n"
.."Channel: Channel @iq_devloper 👾".."\n\n"
.."🗓  "..os.date("!%A, %B %d, %Y\n", timestamp)

end

return {
  description = "Shows bot help", 
  -- usage = /مساعدة: Shows bot help",
  patterns = {
    "^/help$"
  }, 
  run = run 
}

end
