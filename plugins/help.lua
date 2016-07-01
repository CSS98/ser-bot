--[[
#
#ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
#:((
# For More Information ....! 
# Developer : Aziz < @TH3_GHOST > 
# our channel: @DevPointTeam
# Version: 1.1
#:))
#ــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ
#
]]
do

local function run(msg, matches)
if is_momod(msg) and matches[1]== "warns" then
return [[
💡#أومر_الحماية بلتحذير💡
🔇/fwd warn - تفعيل منع اعادة توجيه بلتحذير
🔊/fwd off - تعطيل منع اعادة توجيه بلتحذير
🔕/media warn - تفعيل منع الميديا بلتحذير
🔔/media off - تعطيل منع الميديا بلتحذير
📞/link warn - تفعيل منع الاعلانات  بلتحذير
🛢/link off - تعطيل منع الاعلانات بلتحذير
➖🔹➖🔸➖🔹➖
Bot twasl @ilwilbot 🔱
Channel: @iq_devloper 👾
]]
end

end
return {
description = "Help list", 
usage = "Help list",
patterns = {
"[#!/](warns)"
},
run = run 
}
end
