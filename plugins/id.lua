do
function run(msg, matches)
local reply_id = msg['id']
local id = 'الوقت ='..os_date()

reply_msg(reply_id, id, ok_cb, false)
end

return {
patterns = {
"^id"
},
run = run
}

end