-- Script head
script_name('BotsMenu for RadmirRP') -- название скрипта
script_authors('QQSliverQQ') -- автор скрипта
script_description('Боты для радмир рп') -- описание скрипта

require "lib.moonloader"
require "lib.sampfuncs"

-- Include
local sampev = require 'lib.samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = "CP1251"
u8 = encoding.UTF8
local keys = require 'vkeys'
local vector3d = require 'vector3d'
local inicfg = require 'inicfg'
local mem = require 'memory'

local sw, sh = getScreenResolution()

-- Update
local dlstatus = require('moonloader').download_status

update_state = false

local script_vers = 50
local script_vers_text = "0.50"

local update_url = "https://github.com/Lomtik655/SlivsMenu_for_RadmirRP/raw/refs/heads/main/update.ini"
local update_path = getWorkingDirectory() .. "/radmirSlivsMenu.ini"

local script_url = "https://github.com/Lomtik655/SlivsMenu_for_RadmirRP/raw/refs/heads/main/SlivsMenu%20for%20RadmirRP.lua"
local script_path = thisScript().path

-- Functions
function main()
	if not isSampLoaded() or not isSampfuncsLoaded then return end
	while not isSampAvailable() do wait(100) end

	-- Обновление скрипта
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("Вышла обнова {00ff00}SlivsMenu {00b7ff}RadmirRP {f5a207}by QQSliverQQ! {FFFFFF}Начинаю загрузку...", -1)
				update_state = true
			end
			os.remove(update_path)
		end
	end)

	if not update_state then -- чтобы 100 тыщ раз не выводило при обнове
		-- Шапка
		sampAddChatMessage("{00ff00}SlivsMenu {00b7ff}for RadmirRP {f5a207}by QQSliverQQ. {ffffff}Загружен!", -1)
		sampAddChatMessage("Активация ---> {eefa05}/sm", -1)
	end
	
	-- Команды
	sampRegisterChatCommand("bm", bots_menu)

	imgui.Process = false
    while true do
        wait(0)
		-- Обновление скрипта
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{00ff00}SlivsMenu {00b7ff}for RadmirRP {f5a207}by QQSliverQQ {0bff00}успешно обновлен :P", -1)
					thisScript():reload()
				end
			end)
			break
		end

    end
end
