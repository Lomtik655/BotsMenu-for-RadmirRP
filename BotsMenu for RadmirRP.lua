-- Script head
script_name('BotsMenu for RadmirRP') -- �������� �������
script_author('QQSliverQQ') -- ����� �������
script_description('BotsMenu for RadmirRP') -- �������� �������

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

local script_vers = 60
local script_vers_text = "0.60"

local update_url = "https://github.com/Lomtik655/BotsMenu-for-RadmirRP/raw/refs/heads/main/update.ini"
local update_path = getWorkingDirectory() .. "/radmirBotsMenu.ini"

local script_url = "https://github.com/Lomtik655/BotsMenu-for-RadmirRP/raw/refs/heads/main/BotsMenu%20for%20RadmirRP.lua"
local script_path = thisScript().path

-- Functions
function main()
	if not isSampLoaded() or not isSampfuncsLoaded then return end
	while not isSampAvailable() do wait(100) end

	
	
	-- �������
	sampRegisterChatCommand("bm", bots_menu)
	
	-- ���������� �������
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("����� ������ {00ff00}BotsMenu {00b7ff}RadmirRP {f5a207}by QQSliverQQ! {FFFFFF}������� ��������...", -1)
				update_state = true
			else
				sampAddChatMessage("{00ff00}BotsMenu {00b7ff}for RadmirRP {f5a207}by QQSliverQQ. {ffffff}��������!", -1)
				sampAddChatMessage("��������� ---> {eefa05}/bm", -1)
			end
			os.remove(update_path)
		end
	end)

    while true do
        wait(0)
		-- ���������� �������
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{00ff00}BotsMenu {00b7ff}for RadmirRP {f5a207}by QQSliverQQ {0bff00}������� �������� :P", -1)
					thisScript():reload()
				end
			end)
			break
		end

    end
end

function bots_menu()
	sampAddChatMessage("���������� v2", -1)

end
