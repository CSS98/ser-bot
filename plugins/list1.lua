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
if is_momod(msg) and matches[1]== "helps" then
return [[
❗️ /kick : لطرد العضو
❕ /ban : لحظر العظر
❗️/unban : فتح الخظر عن العضو
❕ /kickme : للخروج من المجموعة
❗️/setadmin : رفع ادمن في المجموعة
❕ /setowner رفع مالك
❗️/deadmin : حذف ادمن في المجوعة
❕ /promote : رفع ادمن
❗️/demote : حذف ادمن
❕ /spromote : اضافة #مدير
❗️/modlist : لاظهار ادمنية المجموعة
❕ /admins : اضهار اداريين المجموعه
❗️/rules : لاضهار القوانين
❕/about : لاضهار الوصف
❗️/setphoto : لوضع صورة
❕ /setrules : لاظافة القوانين
❗️/setname : لوضع اسم 
❕ /setabout : لاظافة الوصف
❗️ /setusername : لوضع معرف للكروب
❕/setw - وضع رسالة ترحيب 
❗️/setb - وضع رسالة وداع
❕/id : لاظهار الايدي
❗️ /settings : اضهار اعدادات المجموعة
❕ /newlink : لصنع الرابط او تغيرة
❗️ /c about :: تنظيف الوصف
❕ /c rules :: تنظيف القوانين
❗️/c modlist :: تنظيف المشرفين
❕  /c mutelist :: تنظيف المكتومين
❗️/c username :: حذف معرف المجموعة
❕ /c words - حذف جميع الكلمات
❗️/c w - مسح رسالة الترحيب
❕ /c b - مسح رسالة الوداع
❗️/kword - منع كلمة
❕ /nword - السماح بلكلمة
❗️/words - الكلمات المحضورة
❕ /muteuser : لتفعيل الصامت على احد الاعضاء
❗️ /mutelist: قائمة المكتومين
❕/bots - معرفة البوتات الي بالمجموعة
❗️/tagall - عمل اشارة للجميع
❕/app - بحث عن تطبيق
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
"[#!/](helps)"
},
run = run 
}
end
