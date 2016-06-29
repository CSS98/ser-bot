do
function run(msg, matches)
local reply_id = msg['id']
-- ❤️❤️❤️❤️❤️❤️❤️❤️
-- ❤️by @XxToFexX         ❤️
-- ❤️Thanks @iq_plus      ❤️
-- ❤️CH @OSCARBOTv2 ❤️
-- ❤️❤️❤️❤️❤️❤️❤️❤️
local id = ' 💭You name: '..msg.from.first_name..'\n'..'💭You 🆔 : '..msg.from.id..'\n'..'💭Username: @' ..msg.from.username..'\n'..'💭Group 🆔: '..msg.to.id..'\n'..'💭Phone 📱: '..(msg.from.phone or "لايوجد"  )..'\n\n'

reply_msg(reply_id, id, ok_cb, false)
end

return {
patterns = {
"^/id"
},
run = run
}

end
