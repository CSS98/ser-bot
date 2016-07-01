do

local function DevPoint(msg, matches)
if is_sudo(msg) then 
        local text = "أنـت مـطـور الـبـؤت 🕵🔧".."\n".."- 🆔 أيـديــك : "..msg.from.id.."\n".."🏧- أســمـك : "..msg.from.first_name.."\n".."🚸- مــعــرفــك  : @"..msg.from.username.."\n".."©- أســم ألـمـجـمـوعـة   "..msg.to.title --@DevPointTeam
        return reply_msg(msg.id, text, ok_cb, false)
     end
if is_momod(msg) then 
        local text = "أنـت أدمــن ألـكـروب 🛳⚓️".."\n".."🆔- أيــديــك  : "..msg.from.id.."\n".."🏧- أســمـك : "..msg.from.first_name.."\n".."🚸- مــعــرفــك : @"..msg.from.username.."\n".."©- أســم ألـمـجـمـوعـة "..msg.to.title
        return reply_msg(msg.id, text, ok_cb, false)
     end
if not is_momod(msg) then 
        local text = "أنـت عـضـوو 😹💙".."\n".."🆔- أيـديــك : "..msg.from.id.."\n".."🏧- أســمـك : "..msg.from.first_name.."\n".."🚸- مــعــرفــك : @"..msg.from.username.."\n".."©- أسـم ألـمـجـمـوعـة "..msg.to.title
        return reply_msg(msg.id, text, ok_cb, false)
     end
if is_owner(msg) then 
        local text = "أنـت مــديــر ألـكـروب 🤖🤘🏼".."\n".."🆔- أيــديــك : "..msg.from.id.."\n".."🏧- أســمـك : "..msg.from.first_name.."\n".."🚸- مــعــرفــك  : @"..msg.from.username.."\n".."©- أســم ألـمـجـمـوعـة   "..msg.to.title
        return reply_msg(msg.id, text, ok_cb, false)
     end
     end

return {  
  patterns = {
       "^[!/](me)$",
  },
  run = DevPoint,
}

end
