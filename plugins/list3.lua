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
if is_momod(msg) and matches[1]== "dels" then
return [[
❌#أومر_الحماية_بلحذف❌
❗️/k group - قفل المجموعة
❕/n group - فتح المجموعة
❗️/silent - تفعيل الصامت 
❕/n silent - فتح الصامت
❗️/k ads - قفل الاعلانات
❕/n ads - فتح الاعلانات
❗️/k pht - قفل صور
❕/n pht - فتح صور
❗️/k sticker - قفل ملصقات
❕/n sticker - فتح ملصقات
❗️/k file - قفل ملفات
❕/n file - فتح ملفات
❗️/k vid - قفل فيديوهات
❕/n vid - فتح فيديوهات
❗️/k aud - قفل صوتيات
❕/n aud -  فتح صوتيات
❗️/k gif - قفل صور متحركة
❕/n gif  - فتح صور متحركة
❗️/k fwd - قفل اعادة توجيه
❕/n fwd - فتح اعادة توجيه
❗️/k tag - منع الاشارة
❕/n tag - فتح الاشارة
❗️/k msg - منع الكلايش
❕/n msg - فتح الكلايش
❗️/k spm - قفل التكرار
❕/n spm - فتح  التكرار
❗️/n nme  - فتح جهات الاتصال
❕/k nme - منع جهات الاتصال
❗️/k bot - منع البوتات
❕/n bot - فتح لبوتات
❗️/k media - منع الميديا
❕/n media - فتح الميديا
❗️/k ar - منع العربة
❕/n ar - فتح العربية
❗️/k rep  - منع  الرد على الرسائل في المجموعة
❕/n rep  - فتح الرد على الرسائل في المجموعة 
❗️/k all  - منع الوسائط كافة 
❕/n all  - فتح الوسائط كافة
➖🔹➖🔸➖🔹➖
Bot twasl @ilwilbot 🔱
Channel: @iq_devloper 👾
]]
end

if not is_momod(msg) then
return "Only managers 😐⛔️"
end

end
return {
description = "Help list", 
usage = "Help list",
patterns = {
"[#!/](dels)"
},
run = run 
}
end
