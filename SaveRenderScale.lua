local frame = CreateFrame("Frame")

local lastKnownRenderScale

local function ensureDB()
    if type(SaveRenderScaleDB) ~= "table" then
        SaveRenderScaleDB = {}
    end
end

local function toPercent(value)
    if value == nil then
        return nil
    end
    return math.floor(value * 100 + 0.5)
end

local function getLocaleText()
    local locale = GetLocale()
    if locale == "zhCN" or locale == "zhTW" then
        return {
            saved = "已保存渲染比例：%d%%（请正常下线以保存设置）",
            applied = "已应用渲染比例：%d%%",
        }
    end
    return {
        saved = "Render scale saved: %d%% (please log out normally to save settings)",
        applied = "Render scale applied: %d%%",
    }
end

local function logSaved(value)
    local percent = toPercent(value)
    if percent ~= nil then
        local text = getLocaleText()
        print(string.format("|cff00ff00" .. text.saved .. "|r", percent))
    end
end

local function logApplied(value)
    local percent = toPercent(value)
    if percent ~= nil then
        local text = getLocaleText()
        print(string.format("|cff00ff00" .. text.applied .. "|r", percent))
    end
end

local function getCurrentRenderScale()
    local value = GetCVar("renderScale")
    if value == nil then
        return nil
    end
    return tonumber(value)
end

local function setSavedRenderScale(value, shouldPrint)
    ensureDB()
    local numericValue = tonumber(value)
    if numericValue == nil then
        return
    end
    local previous = SaveRenderScaleDB.renderScale
    if previous == nil or tonumber(previous) ~= numericValue then
        SaveRenderScaleDB.renderScale = numericValue
        if shouldPrint then
            logSaved(numericValue)
        end
    end
end

local function applyOrSaveOnLogin()
    ensureDB()
    local saved = SaveRenderScaleDB.renderScale
    local current = getCurrentRenderScale()
    if saved ~= nil then
        if current ~= nil and tonumber(saved) ~= current then
            SetCVar("renderScale", tostring(saved))
            logApplied(saved)
        end
    else
        if current ~= nil then
            SaveRenderScaleDB.renderScale = current
            logSaved(current)
        end
    end
end

frame:SetScript("OnEvent", function(_, event, arg1, arg2)
    if event == "PLAYER_LOGIN" then
        applyOrSaveOnLogin()
        lastKnownRenderScale = getCurrentRenderScale()
        return
    end

    if event == "CVAR_UPDATE" and arg1 == "renderScale" then
        setSavedRenderScale(arg2, true)
        lastKnownRenderScale = getCurrentRenderScale()
    end
end)

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CVAR_UPDATE")

if C_CVar and C_CVar.RegisterCVarCallback then
    C_CVar.RegisterCVarCallback("renderScale", function(cvar, value)
        if cvar == "renderScale" then
            setSavedRenderScale(value, true)
            lastKnownRenderScale = getCurrentRenderScale()
        elseif value ~= nil then
            setSavedRenderScale(value, true)
            lastKnownRenderScale = getCurrentRenderScale()
        end
    end)
end

local function saveCurrentRenderScale()
    local current = getCurrentRenderScale()
    if current ~= nil then
        lastKnownRenderScale = current
        setSavedRenderScale(current, true)
    end
end

if SettingsPanel and SettingsPanel.HookScript then
    SettingsPanel:HookScript("OnHide", saveCurrentRenderScale)
end

if InterfaceOptionsFrame and InterfaceOptionsFrame.HookScript then
    InterfaceOptionsFrame:HookScript("OnHide", saveCurrentRenderScale)
end
