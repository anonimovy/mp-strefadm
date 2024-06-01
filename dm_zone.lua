-- Autor : anonimovy
-- Stworzony na potrzeby serwera mpRPG
-- 150.43,-893.02,17.16

-- Zdefiniuj strefę DM
local dmZone = createColRectangle(150.43,-893.02, 3049.10,-2872.71) -- dostosuj współrzędne i wymiary strefy

-- Funkcja dająca Deagle z 9999 amunicji
function giveDeagleOnEnterZone(player)
    if isElement(player) and getElementType(player) == "player" then
        giveWeapon(player, 24, 9999, true) -- ID broni 24 to Deagle
    end
end
addEventHandler("onColShapeHit", dmZone, giveDeagleOnEnterZone)

-- Funkcja zabierająca Deagle
function removeDeagleOnExitZone(player)
    if isElement(player) and getElementType(player) == "player" then
        takeWeapon(player, 24)
    end
end
addEventHandler("onColShapeLeave", dmZone, removeDeagleOnExitZone)
