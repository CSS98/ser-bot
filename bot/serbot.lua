package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require("./BoTMasters/utils")

local f = assert(io.popen('/usr/bin/git describe --tags', 'r'))
VERSION = assert(f:read('*a'))
f:close()

-- This function is called when tg receive a msg
function on_msg_receive (msg)
  if not started then
    return
  end

  msg = backward_msg_format(msg)

  local receiver = get_receiver(msg)
  print(receiver)
  --vardump(msg)
  --vardump(msg)
  msg = pre_process_service_msg(msg)
  if msg_valid(msg) then
    msg = pre_process_msg(msg)
    if msg then
      match_plugins(msg)
      if redis:get("bot:markread") then
        if redis:get("bot:markread") == "on" then
          mark_read(receiver, ok_cb, false)
        end
      end
    end
  end
end

function ok_cb(extra, success, result)

end

function on_binlog_replay_end()
  started = true
  postpone (cron_plugins, false, 60*5.0)
  -- See plugins/isup.lua as an example for cron

  _config = load_config()

  -- load plugins
  plugins = {}
  load_plugins()
end

function msg_valid(msg)
  -- Don't process outgoing messages
  if msg.out then
    print('\27[36mNot valid: msg from us\27[39m')
    return false
  end

  -- Before bot was started
  if msg.date < os.time() - 5 then
    print('\27[36mNot valid: old msg\27[39m')
    return false
  end

  if msg.unread == 0 then
    print('\27[36mNot valid: readed\27[39m')
    return false
  end

  if not msg.to.id then
    print('\27[36mNot valid: To id not provided\27[39m')
    return false
  end

  if not msg.from.id then
    print('\27[36mNot valid: From id not provided\27[39m')
    return false
  end

  if msg.from.id == our_id then
    print('\27[36mNot valid: Msg from our id\27[39m')
    return false
  end

  if msg.to.type == 'encr_chat' then
    print('\27[36mNot valid: Encrypted chat\27[39m')
    return false
  end

  if msg.from.id == 777000 then
    --send_large_msg(*group id*, msg.text) *login code will be sent to GroupID*
    return false
  end

  return true
end

--
function pre_process_service_msg(msg)
   if msg.service then
      local action = msg.action or {type=""}
      -- Double ! to discriminate of normal actions
      msg.text = "!!tgservice " .. action.type

      -- wipe the data to allow the bot to read service messages
      if msg.out then
         msg.out = false
      end
      if msg.from.id == our_id then
         msg.from.id = 0
      end
   end
   return msg
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
  for name,plugin in pairs(plugins) do
    if plugin.pre_process and msg then
      print('Preprocess', name)
      msg = plugin.pre_process(msg)
    end
  end
  return msg
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
  for name, plugin in pairs(plugins) do
    match_plugin(plugin, name, msg)
  end
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
  local disabled_chats = _config.disabled_plugin_on_chat
  -- Table exists and chat has disabled plugins
  if disabled_chats and disabled_chats[receiver] then
    -- Checks if plugin is disabled on this chat
    for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
      if disabled_plugin == plugin_name and disabled then
        local warning = 'Plugin '..disabled_plugin..' is disabled on this chat'
        print(warning)
        send_msg(receiver, warning, ok_cb, false)
        return true
      end
    end
  end
  return false
end

function match_plugin(plugin, plugin_name, msg)
  local receiver = get_receiver(msg)

  -- Go over patterns. If one matches it's enough.
  for k, pattern in pairs(plugin.patterns) do
    local matches = match_pattern(pattern, msg.text)
    if matches then
      print("msg matches: ", pattern)

      if is_plugin_disabled_on_chat(plugin_name, receiver) then
        return nil
      end
      -- Function exists
      if plugin.run then
        -- If plugin is for privileged users only
        if not warns_user_not_allowed(plugin, msg) then
          local result = plugin.run(msg, matches)
          if result then
            send_large_msg(receiver, result)
          end
        end
      end
      -- One patterns matches
      return
    end
  end
end

-- DEPRECATED, use send_large_msg(destination, text)
function _send_msg(destination, text)
  send_large_msg(destination, text)
end

-- Save the content of _config to config.lua
function save_config( )
  serialize_to_file(_config, './data/config.lua')
  print ('saved config into ./data/config.lua')
end

-- Returns the config from config.lua file.
-- If file doesn't exist, create it.
function load_config( )
  local f = io.open('./data/config.lua', "r")
  -- If config.lua doesn't exist
  if not f then
    print ("Created new config file: data/config.lua")
    create_config()
  else
    f:close()
  end
  local config = loadfile ("./data/config.lua")()
  for v,user in pairs(config.sudo_users) do
    print("Sudo user: " .. user)
  end
  return config
end

-- Create a basic config.json file and saves it.
function create_config( )
  -- A simple config with basic plugins and ourselves as privileged user
  config = {
    enabled_plugins = {
    "admin",
    "onservice",
    "inrealm",
    "ingroup",
    "inpm",
    "banhammer",
    "stats",
    "anti_spam",
    "owners",
    "arabic_lock",
    "set",
    "get",
    "broadcast",
    "invite",
    "all",
    "leave_ban",
    "supergroup",
    "whitelist",
    "msg_checks",
    "m",
    "f",
    "group",
    "t",
    "r",
    "id",
    "em",
    "b",
    "rm",
    "dd",
    "dd2",
    "dd3",
    "list",
    "help",
    "list1",
    "list3",
    "store",
    "tagall",
    "setwelcome",
    "setbye",
    "getbye",
    "getwelcome",
    "word",
    "mute"

    },
    sudo_users = { 0,tonumber(our_id)},--Sudo users
    moderation = {data = 'data/moderation.json'},
    about_text = [[! Masters Bot 2.1v ًں”°
The advanced administration bot based on Tg-Cli. ًںŒگ
It was built on a platform TeleSeed after it has been modified.ًں”§ًںŒگ
https://github.com/MastersDev
Programmerًں”°
@iDev1
Special thanks toًںک‹â‌¤ï¸ڈ
TeleSeed Team
Mico 
Mouamle
Oscar
Our channels ًںکچًں‘چًںڈ¼
@MastersDev ًںŒڑâڑ ï¸ڈ
@OSCARBOTv2 ًںŒڑًں”Œ
@MouamleAPI ًںŒڑًں”©
@Malvoo ًںŒڑًں”§
 
My YouTube Channel
https://www.youtube.com/channel/UCKsJSbVGNGyVYvV5B2LrUkA]],
    help_text = [[ط§ط±ط³ظ„ ط§ظ„ط§ظ…ط± 
         !shelp 
         ط§ظˆ 
         !pv help 
        طھط¬ظٹظƒ ط®ط§طµ
        ظ‚ظ†ط§ط© ط§ظ„ط³ظˆط±ط³ @MastersDev]],
	help_text_super =[[ًں”° The Commands in Super ًں”°
ًں’­ ط§ظˆط§ظ…ط± ط§ظ„ط·ط±ط¯ ظˆط§ظ„ط­ط¶ط± ظˆط§ظ„ط§ظٹط¯ظٹ
ًںژ©!block ًںڑ© ظ„ط·ط±ط¯ ط§ظ„ط¹ط¶ظˆ
ًں’²!ban  ًںڑ©ًں”‍ ظ„ط­ط¸ط± ط§ظ„ط¹ط¶ظˆ
ًںژ©!banlist ًں†” ظ‚ط§ط¦ظ…ط© ط§ظ„ظ…ط­ط¶ظˆط±ظٹظ†
ًں’²!unban â„¹ï¸ڈ ظپطھط­ ط§ظ„ط­ط¸ط±
ًںژ©!id   ًں†” ط¹ط±ط¶ ط§ظ„ط§ظٹط¯ظٹ
ًں’²!kickme ًں’‹ ظ„ظ„ط®ط±ظˆط¬ ظ…ظ† ط§ظ„ظƒط±ظˆط¨
ًںژ©!kickinactive âœ‹ط·ط±ط¯ ط§ظ„ظ…ظ…طھظپط§ط¹ظ„
ًں’²!id from ًں†”ط§ظ„ط§ظٹط¯ظٹ ظ…ظ† ط§ط¹ط§ط¯ط© طھظˆط¬ظٹط©
ًںژ©!muteuser @ ًں‘‍ ظƒطھظ… ط¹ط¶ظˆ ظ…ط­ط¯ط¯
ًں’²!del ًںژˆ ط­ط°ظپ ط§ظ„ط±ط³ط§ظ„ظ‡ ط¨ط§ظ„ط±ط¯
ًں’­ ط§ظ„ط§ط³ظ… ظˆط§ظ„طµظˆط±ظ‡ ظپظٹ ط§ظ„ط³ظˆط¨ط± ظ…ظ‚ظپظˆظ„ط©
ًں””!lock member ًں”’ظ‚ظپظ„ ط§ظ„ط§ط¶ط§ظپط©
ًں”•!unlock member ًں”“ظپطھط­ ط§ظ„ط§ط¶ط§ظپط©
ًں’­ ط§ظˆط§ظ…ط± ط§ظ„ظ…ظ†ط¹
ًںڈپ!lock linksًں”— ظ‚ظپظ„ ظ…ظ†ط¹ ط§ظ„ط±ظˆط§ط¨ط·
âڑ½ï¸ڈ!unlock links ًں”— ظپطھط­ ظ…ظ†ط¹ ط§ظ„ط±ظˆط§ط¨ط·
ًںڈپ!lock stickerâœ´ï¸ڈ ظ‚ظپظ„ ط§ظ„ظ…ظ„طµظ‚ط§طھ
âڑ½ï¸ڈ!unlock sticker âœ´ï¸ڈ  ظپطھط­ ط§ظ„ظ…ظ„طµظ‚ط§طھ
ًںڈپ!lock strict ًں›‚ ط§ظ„ظ‚ظپظ„ ط§ظ„طµط§ط±ظ… 
âڑ½ï¸ڈ!unlock strict ًں›‚ ظپطھط­ ط§ظ„ظ‚ظپظ„ ط§ظ„طµط§ط±ظ…
ًںڈپ!lock flood ًںڑ¦ًںڑ§ ظ‚ظپظ„ ط§ظ„طھظƒط±ط§ط±
âڑ½ï¸ڈ!unlock flood ًںڑ¦ًںڑ§ ظپطھط­ ط§ظ„طھظƒط±ط§ط±
ًںڈپ!setflood 5>20 ظ„طھط­ط¯ظٹط¯ ط§ظ„طھظƒط±ط§ط±
âڑ½ï¸ڈ!lock fwd ًںژƒ ظ‚ظپظ„ ط§ط¹ط§ط¯ط© ط§ظ„طھظˆط¬ظٹظ‡
ًںڈپ!unlock fwd ًںژƒ ظپطھط­ ظ‚ظپظ„ ط§ط¹ظ„ط§ظ‡
âڑ½ï¸ڈ!bot lock ًں’‰ ظ‚ظپظ„ ط§ظ„ط¨ظˆطھط§طھ
ًںڈپ!bot unlock ًں’‰ ظپطھط­ ظ‚ظپظ„ ط§ظ„ط¨ظˆطھط§طھ
ًں’­ ط§ظˆط§ظ…ط± ط§ظ„ظƒطھظ… 
ًںƒڈ!mute gifs ًں—؟ ظƒطھظ… ط§ظ„طµظˆط± ط§ظ„ظ…طھط­ط±ظƒط©
ًں€„ï¸ڈ!umute gifs ًں—؟ ظپطھط­ ظƒطھظ… ط§ظ„ظ…طھط­ط±ظƒط©
ًںƒڈ!mute photo ًں—¼ ظƒطھظ… ط§ظ„طµظˆط± 
ًں€„ï¸ڈ!unmute photo ًں—¼ ظپطھط­ ظƒطھظ… ط§ظ„طµظˆط±
ًںƒڈ!mute video ًںژ¬ ظƒطھظ… ط§ظ„ظپظٹط¯ظٹظˆ
ًں€„ï¸ڈ!unmute video ًںژ¬ظپطھط­ ظƒطھظ… ط§ظ„ظپظٹط¯ظٹظˆ
ًںƒڈ!mute audio ًں”• ظƒطھظ… ط§ظ„ط¨طµظ…ط§طھ
ًں€„ï¸ڈ!unmute audioًں””ظپطھط­ ط§ظ„ط¨طµظ…ط§طھ
ًںƒڈ!mute all â‍؟ ظƒطھظ… ط§ظ„ظƒظ„ ط£ط¹ظ„ط§ظ‡
ًں€„ï¸ڈ!unmute all â‍؟ ظپطھط­ ظƒطھظ… ط§ظ„ظƒظ„ ط£ط¹ظ„ط§ظ‡
ًں’­ ط§ظˆط§ظ…ط± ط§ظ„طھظ†ط¸ظٹظپ
ًںژ§!clean rules م€½ï¸ڈ طھظ†ط¸ظٹظپ ط§ظ„ظ‚ظˆط§ظ†ظٹظ†
ًںژ­!clean about م€½ï¸ڈ طھظ†ط¸ظٹظپ ط§ظ„ظˆطµظپ
ًںژ§!clean modlist م€½ï¸ڈ طھظ†ط¸ظٹظپ ط§ظ„ط§ط¯ظ…ظ†ظٹط©
ًںژ­!clean mutelist طھظ†ط¸ظٹظپ ط§ظ„ظ…ظƒطھظˆظ…ظٹظ†
 ًں”— ط§ظ„ط±ط§ط¨ط· ظپظٹ ط§ظ„ظ…ط¬ظ…ظˆط¹ط©ًں†—âœ‹
ًں’³!newlink ًںڑ«ًں”—طھط؛ظٹظٹط± ط§ظ„ط±ط§ط¨ط·
ًں’°!link ًں”— ط§ط³طھط®ط±ط§ط¬ ط§ظ„ط±ط§ط¨ط·
 ًں”— ط§ظ„ط±ط§ط¨ط· ظپظٹ ط§ظ„ط®ط§طµًں†—âœ‹
ًں’³!linkpv ًں”—  ط§ظ„ط±ط§ط¨ط· ظپظٹ ط§ظ„ط®ط§طµ
ًں’­ ط§ظˆط§ظ…ط± ط§ظ„ظˆط¶ط¹ ظˆ ط§ظ„طھط؛ظٹظٹط±
ًں“¼!setname (ط§ظ„ط§ط³ظ…) ًں’،طھط؛ظٹظٹط± ط§ظ„ط§ط³ظ…
ًں“¼!setphoto طھط¹ظٹظٹظ† طµظˆط±ظ‡ ظ„ظ„ظ…ظ…ط¬ظ…ظˆط¹ط©
ًں“¼!setrules (ظ…ط³ط§ظپظ‡ ط¨ط¹ط¯ظ‡ط§ ط§ظ„ظ‚ظˆط§ظ†ظٹظ†)
ًں“¼!setabout (ظ…ط³ط§ظپظ‡ ط¨ط¹ط¯ظ‡ط§ ظˆط§ظ„ظˆطµظپ)
ًں’­ ط§ظˆط§ظ…ط± ط±ظپط¹ ظˆط®ظپط¶ ط§ط¯ظ…ظ†
ًںŒں!promote â™»ï¸ڈ ط±ظپط¹ ط§ط¯ظ…ظ† 
â­گï¸ڈ!demote â™»ï¸ڈ ط®ظپط¶ ط§ط¯ظ…ظ† 
ًں’­ظ‡ط°ط§ ط§ظ„ط§ظ…ط± ظٹظ‚ظˆظ… ط¨ط§ط¶ط§ظپظ‡ ط§ظٹط¯ظٹ ط§ظ„ظ…ط¬ظ…ظˆط¹ظ‡ ط§ظ„ظ‰ ظ‚ط§ط¦ظ…ظ‡ ط§ظ„ط§ظ…ط± chats!
ًں’¸!public yes ظ„ط¬ط¹ظ„ ط§ظ„ظ…ط¬ظ…ظˆط¹ظ‡ ط¹ط§ظ…ظ‡ 
ًں’¸!public no ظ„ط¬ط¹ظ„ ط§ظ„ظ…ط¬ظ…ظˆط¹ظ‡ ط®ط§طµظ‡
ًں’­ ط§ظˆط§ظ…ط± ظ…ط¹ظ„ظˆظ…ط§طھظٹظ‡
ًں”§!muteslist ًںڑ§ ظ…ط¹ظ„ظˆظ…ط§طھ ط§ظ„ظƒطھظ… 
ًں”¨!info ًںگ¸ ظ…ط¹ظ„ظˆظ…ط§طھ ط§ظ„ظ…ط¬ظ…ظˆط¹ط©
ًں”©!res ًں†” ظ„ط¹ط±ط¶ ظ…ط¹ظ„ظˆظ…ط§طھ ط§ظ„ط§ظٹط¯ظٹ
ًں”§!rules ًں‘€ ظ„ط¹ط±ط¶ ط§ظ„ظ‚ظˆط§ظ†ظٹظ†
ًں”¨!modlist ًں”§ًں”© ظ„ط§ط¶ظ‡ط§ط± ط§ظ„ط§ط¯ظ…ظ†
ًں”© me â“‚ï¸ڈ ط±طھط¨طھظƒ ط¨ط§ظ„ظƒط±ظˆط¨
ًں”§!echo (ط§ظ„ظƒظ„ظ…ظ‡) â‍؟ ط­طھظ‰ ظٹطھظƒظ„ظ…
ًں”¨!owner ًں’¯ًں’® ظ…ط´ط±ظپ ط§ظ„ظ…ط¬ظ…ظˆط¹ظ‡
ًں”©!wholist ًں†” ط§ظٹط¯ظٹط§طھ ط§ظ„ظ…ط¬ظ…ظˆط¹ط©
ًں”§!who ًں†” ط§ظٹط¯ظٹط§طھ ط§ظ„ظ…ط¬ظ…ظˆط¹ظ‡ ط¨ظ…ظ„ظپ
ًں”¨!settings ًں”¨ط§ط¹ط¯ط§ط¯طھ ط§ظ„ظ…ط¬ظ…ظˆط¹ط©
ًں”©!bots ًںڑ¯ ظ„ط§ط¶ظ‡ط§ط± ط¨ظˆطھط§طھ ط§ظ„ظ…ط¬ظ…ظˆط¹ط©
ًں”§!mutelist ًںڑ§ ظ‚ط§ط¦ظ…ط©ط§ظ„ظ…ظƒطھظˆظ…ظٹظ†
ًں’ م€°م€°م€°م€°م€°م€°م€°م€°م€°ًں’ 
âڑ ï¸ڈظ‚ظ†ط§ط© ط§ظ„ط¨ظˆطھ ط§ط´طھط±ظƒظˆ ط¨ظٹظ‡ط§
@MastersDev 
ظ…ط¬ظ…ظˆط¹ط© ط¯ط¹ظ… ط§ظ„ط¨ظˆطھ
@idev8
â™»ï¸ڈم€°م€°م€°م€°م€°م€°م€°م€°م€°â™»ï¸ڈ
          ًں’  Pro :- @iDev1 ًں’ ]],
help_text_realm = [[ط§ط±ط³ظ„ ط§ظ„ط§ظ…ط± 
         !shelp 
         ط§ظˆ 
         !pv help 
        طھط¬ظٹظƒ ط®ط§طµ
        ظ‚ظ†ط§ط© ط§ظ„ط³ظˆط±ط³ @MastersDev]],
  }
  serialize_to_file(config, './data/config.lua')
  print('saved config into ./data/config.lua')
end

function on_our_id (id)
  our_id = id
end

function on_user_update (user, what)
  --vardump (user)
end

function on_chat_update (chat, what)
  --vardump (chat)
end

function on_secret_chat_update (schat, what)
  --vardump (schat)
end

function on_get_difference_end ()
end

-- Enable plugins in config.json
function load_plugins()
  for k, v in pairs(_config.enabled_plugins) do
    print("Loading plugin", v)

    local ok, err =  pcall(function()
      local t = loadfile("plugins/"..v..'.lua')()
      plugins[v] = t
    end)

    if not ok then
      print('\27[31mError loading plugin '..v..'\27[39m')
	  print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
      print('\27[31m'..err..'\27[39m')
    end

  end
end

-- custom add
function load_data(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)

	return data

end

function save_data(filename, data)

	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end


-- Call and postpone execution for cron plugins
function cron_plugins()

  for name, plugin in pairs(plugins) do
    -- Only plugins with cron function
    if plugin.cron ~= nil then
      plugin.cron()
    end
  end

  -- Called again in 2 mins
  postpone (cron_plugins, false, 120)
end

-- Start and load values
our_id = 0
now = os.time()
math.randomseed(now)
started = false
