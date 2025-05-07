-- Autor : anonimovy
-- Stworzony na potrzeby serwera mpRPG
-- 150.43,-893.02,17.16

local dmZoneLS = createColRectangle(150.43, -893.02, 3049.10, -2872.71) -- Strefa w Los Santos
local dmZoneLV = createColRectangle(2000, 1500, 500, 500) -- Nowa strefa w okolicy Las Venturas


createBlip(150.43, -893.02, 17.16, 23, 2, 255, 0, 0, 255, 0, 99999.0) -- Blip LS
createBlip(2250, 1750, 0, 23, 2, 255, 0, 0, 255, 0, 99999.0) -- Blip LV


function giveDeagleOnEnterZone(player)
    if isElement(player) and getElementType(player) == "player" then
        giveWeapon(player, 24, 9999, true) -- ID 24 to dgl
        setElementData(player, "inDMZone", true)
        
        -- Komunikat w zależności od strefy
        if isElementWithinColShape(player, dmZoneLS) then
            outputChatBox("#FF0000[DM LS] #FFFFFFWitaj w strefie Deathmatch! Zabijaj innych graczy i zdobywaj $50 za każde zabójstwo!", player, 255, 255, 255, true)
        else
            outputChatBox("#FF0000[DM LV] #FFFFFFWitaj w strefie Deathmatch! Zabijaj innych graczy i zdobywaj $50 za każde zabójstwo!", player, 255, 255, 255, true)
        end
    end
end
addEventHandler("onColShapeHit", dmZoneLS, giveDeagleOnEnterZone)
addEventHandler("onColShapeHit", dmZoneLV, giveDeagleOnEnterZone)


function removeDeagleOnExitZone(player)
    if isElement(player) and getElementType(player) == "player" then
        takeWeapon(player, 24)
        setElementData(player, "inDMZone", false)
        

        if isElementWithinColShape(player, dmZoneLS) then
            outputChatBox("#FF0000[DM LS] #FFFFFFOpuściłeś strefę Deathmatch!", player, 255, 255, 255, true)
        else
            outputChatBox("#FF0000[DM LV] #FFFFFFOpuściłeś strefę Deathmatch!", player, 255, 255, 255, true)
        end
    end
end
addEventHandler("onColShapeLeave", dmZoneLS, removeDeagleOnExitZone)
addEventHandler("onColShapeLeave", dmZoneLV, removeDeagleOnExitZone)


addEventHandler("onPlayerWasted", root, function(_, killer)
    if killer and killer ~= source and getElementType(killer) == "player" then
        if getElementData(killer, "inDMZone") then
            local currentMoney = getPlayerMoney(killer)
            setPlayerMoney(killer, currentMoney + 50)
            

            outputChatBox("#FF0000[DM] #FFFFFFOtrzymałeś $50 za zabicie " .. getPlayerName(source), killer, 255, 255, 255, true)
            

            if isElementWithinColShape(killer, dmZoneLS) then
                outputChatBox("#FF0000[DM LS] #FFFFFF" .. getPlayerName(killer) .. " zabił " .. getPlayerName(source) .. " i otrzymał $50!", root, 255, 255, 255, true)
            else
                outputChatBox("#FF0000[DM LV] #FFFFFF" .. getPlayerName(killer) .. " zabił " .. getPlayerName(source) .. " i otrzymał $50!", root, 255, 255, 255, true)
            end
        end
    end
end)
