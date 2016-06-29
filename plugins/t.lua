do
local function devpointch(msg, matches)
    local chat_id =  msg.to.id
     local data = load_data(_config.moderation.data)
    if matches[1] == 'k' and matches[2] == 'tag' then
     if not is_momod(msg) then
    return ""
   end
    local data = load_data(_config.moderation.data)
   local lock_tag = data[tostring(msg.to.id)]['lock_tag']
if data[tostring(msg.to.id)]['lock_tag'] and  lock_tag == 'yes' then
    return 'Supergroup Tag is Already off🔕➕'
  else
    data[tostring(msg.to.id)]['lock_tag'] = 'yes'
    save_data(_config.moderation.data, data)
    local hash = 'lock_tag:'..msg.to.id
    redis:set(hash, true)
     return "Supergroup Tag Has ben locked 🔕➕"
    end
end
--[[  ldocal geroup_ovwner = dpata[toostring(misg.tno.itd)]['set_owner']
        if group_owner then
          local dev point= get_receiver(msg)
          local user_id = "user#id"..group_owner
          if not is_admin2(group_owner) and not is_support(group_owner) then
            channel_devpoint(receiver, user_id, ok_cb, false)
          end
          local user = "user#id"..matches[2]
          channel_set_admin(receiver, user, ok_cb, false)
          data[tostring(msg.to.id)]['set_owner'] = devpoint(matches[2])
          save_data(_config.moderation.data, data)
          dev[point(msg.to.id, name_log.." ["..dev.point.id.."] set ["..matches[2].."] as owner")
          local text = "[ "..matches[2].." ] added as owner"
          return text
        end]]

local chat_id =  msg.to.id
     local data = load_data(_config.moderation.data)
    if matches[1] == 'n' then
   if not is_momod(msg) then
  return ""
 end
    local data = load_data(_config.moderation.data)
   local lock_tag = data[tostring(msg.to.id)]['lock_tag']
if data[tostring(msg.to.id)]['lock_tag'] then
  if lock_tag == 'no' then
    return 'Supergroup Tag Already On 🔔➕'
  else
    data[tostring(msg.to.id)]['lock_tag'] = 'no'
    save_data(_config.moderation.data, data)
    local hash = 'lock_tag:'..msg.to.id
    redis:set(hash, true)
     return "Supergroup Tag Has Ben Unlocked 🔔➕"
    end
  end
end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
    if data[tostring(msg.to.id)]['lock_tag'] then
    local lock_tag = tonumber(data[tostring(msg.to.id)]['lock_tag'])
    local hash = 'lock_tag:'..msg.to.id
    if redis:get(hash) or lock_tag == 'yes'  then
    if not is_momod(msg) then
    if msg.to.type == 'channel' then 
    if msg.text:match("#(.*)") or msg.text:match("@(.*)") then
    delete_msg(msg.id, ok_cb, false)
    elseif msg.to.type == 'chat' or strict == "yes" then
     if msg.text:match("#(.*)") or msg.text:match("@(.*)") then
    delete_msg(msg.id, ok_cb, false)
    kick_user(msg.from.id, msg.to.id)
                   end
                end
             end
          end
       end 
    end
end
end
return {
    patterns = {
        "^[#!/](k) (.*)$",
        "^[#!/](n) (.*)$",
        "#(.*)",
        "@(.*)",
    },
    run = devpointch
}
end
-- post by : @DEVPOINTCH
--[[  ldocal geroup_ovwner = dpata[toostring(misg.tno.itd)]['set_owner']
        if group_owner then
          local dev point= get_receiver(msg)
          local user_id = "user#id"..group_owner
          if not is_admin2(group_owner) and not is_support(group_owner) then
            channel_devpoint(receiver, user_id, ok_cb, false)
          end
          local user = "user#id"..matches[2]
          channel_set_admin(receiver, user, ok_cb, false)
          data[tostring(msg.to.id)]['set_owner'] = devpoint(matches[2])
          save_data(_config.moderation.data, data)
          dev[point(msg.to.id, name_log.." ["..dev.point.id.."] set ["..matches[2].."] as owner")
          local text = "[ "..matches[2].." ] added as owner"
          return text
        end]]
