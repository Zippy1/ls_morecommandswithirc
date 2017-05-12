--This mod has been made by Zippy1 or iZacZip, and can be used in any way.
--Credit is helpful!

local countd_time=0
local countd_timer=0
local countd_timer_on=0

minetest.register_chatcommand("ipcheck", {
	params = "",
	description = "Get ip of player",
	privs={server=true},
	func = function(name, param)
	if minetest.get_player_by_name(param) then
	minetest.chat_send_player(name,minetest.get_player_ip(param))	
	end
end})

minetest.register_chatcommand("pretend", {
	params = "",
	description = "global chat",
	privs={server=true},
	func = function(name, param)
	minetest.chat_send_all(param)
        irc:say(param)
end})

minetest.register_chatcommand("countonseconds", {
	params = "",
	description = "Shutdown with a countdown - SECONDS",
	privs={server=true},
	func = function(name, param)
	local num=tonumber(param)
	if num==nil then return false end
	countd_timer=num
	countd_timer_on=1
end})

minetest.register_chatcommand("countonminutes", {
	params = "",
	description = "Shutdown with a countdown - MINUTES",
	privs={server=true},
	func = function(name, param)
	local num=tonumber(param)
	if num==nil then return false end
	countd_timer=num*60
	countd_timer_on=1
end})

minetest.register_globalstep(function(dtime)
if countd_timer_on==0 then return false end
countd_time=countd_time+dtime
if countd_time<1 then return false end
countd_time=0
countd_timer=countd_timer-1
local text=""
if countd_timer==60*10 then text="10m" end
if countd_timer==60*9 then text="9m" end
if countd_timer==60*8 then text="8m" end
if countd_timer==60*7 then text="7m" end
if countd_timer==60*6 then text="6m" end
if countd_timer==60*5 then text="5m" end
if countd_timer==60*4 then text="4m" end
if countd_timer==60*3 then text="3m" end
if countd_timer==60*2 then text="2m" end
if countd_timer==60 then text=countd_timer .. "s" end
if countd_timer==30 then text=countd_timer .. "s" end
if countd_timer==20 then text=countd_timer .. "s" end
if countd_timer<=10 then text=countd_timer end
if text~="" then
		minetest.chat_send_all("<Server> Server shutting down in " .. text)
                irc:say("<Server> Server shutting down in " .. text)
		print("Server shutting down in  " .. text)
end
if countd_timer<=-1 then
	minetest.chat_send_all("*** Server shutting down")
        irc:say("*** Server shutting down")
	countd_timer_on=0
		minetest.after(1, function()
			minetest.request_shutdown()
		end)
	end

end)
minetest.register_chatcommand("givemoderator", {
	params = "",
	description = "Default moderator",
	privs={privs=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
			local privs=minetest.get_player_privs(param)
			privs.kick=true
			privs.teleport=true
			privs.fly=true
			privs.fast=true
			privs.creative=true
			privs.worldedit=true
			privs.give=true
			privs.basic_privs=true
			minetest.set_player_privs(param,privs)
			--player:get_inventory():add_item("main","default:pick_diamond")
			minetest.chat_send_player(param, "You are now moderator.")
			minetest.chat_send_player(name, param .. " is now a moderator! -Server")
                        irc:say(name, param .. "is now a moderator! -Server")
			return true
		end
end})
