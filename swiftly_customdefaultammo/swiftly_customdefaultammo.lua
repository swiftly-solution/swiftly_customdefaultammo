function SetAmmoFromConfig(player, weapon, weaponname)
    local normalizedWeaponName = string.lower(weaponname)
    
    local weaponsToIgnore = {
        "weapon_knife",
        "weapon_knife_t",
        "weapon_flashbang",
        "weapon_hegrenade",
        "weapon_smokegrenade",
        "weapon_molotov",
        "weapon_decoy",
        "weapon_incgrenade",
        "weapon_taser",
    }

    local shouldIgnore = false
    for _, ignoredWeapon in ipairs(weaponsToIgnore) do
        if ignoredWeapon == normalizedWeaponName then
            shouldIgnore = true
            break
        end
    end

    if shouldIgnore then
        return
    end

    if config:Exists("customdefaultammo.Weapons." .. normalizedWeaponName) then
        local weaponfromconfig = config:Fetch("customdefaultammo.Weapons." .. normalizedWeaponName)
        weapon:SetClipAmmo(weaponfromconfig)
    end
end

events:on("OnWeaponSpawned", function(playerid, weaponid)
    local player = GetPlayer(playerid)
    if not player then return end

    local weapon = player:weapons():GetWeapon(weaponid)
    if not weapon or weapon:Exists() == 0 then return end
    
    local weaponname = weapon:GetName()

    SetAmmoFromConfig(player, weapon, weaponname)
end)

commands:Register("cdm_reload", function(playerid, args, argsCount, silent)
    if playerid == -1 then
        config:Reload("customdefaultammo")
    else
        local player = GetPlayer(playerid)
        if not player then return end
        config:Reload("customdefaultammo")
    end
end)

function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "v1.0.0"
end

function GetPluginName()
    return "Swiftly Custom Default Ammo"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/swiftly_customdefaultammo"
end
