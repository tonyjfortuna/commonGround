CommonGroundStartingItems = {}
CommonGroundStartingItems.modDir = g_currentModDirectory
CommonGroundStartingItems.loadedTools = {}
CommonGroundStartingItems.hasRequestedTools = false

local function onToolLoaded(_, handTool, loadingState)
    if handTool ~= nil and loadingState == HandToolLoadingState.OK then
        table.insert(CommonGroundStartingItems.loadedTools, handTool)
        Logging.info("[CG] Tool loaded and stored")
    else
        Logging.error("[CG] Tool failed to load")
    end
end

function CommonGroundStartingItems:giveStartingItems()
    if self.hasRequestedTools then
        return
    end

    local path = self.modDir .. "maps/mapUS/handTools/husqvarna/xp550/xp550.xml"

    Logging.info("[CG] Requesting chainsaw load: " .. tostring(path))

    local loadingData = HandToolLoadingData.new()
    loadingData:setFilename(path)
    loadingData:setOwnerFarmId(1)
    loadingData:setIsRegistered(true)
    loadingData:load(onToolLoaded, self)

    self.hasRequestedTools = true
end

function CommonGroundStartingItems:update(dt)
    if g_localPlayer ~= nil and #self.loadedTools > 0 then
        local farmId = g_localPlayer.farmId or 1

        for _, tool in ipairs(self.loadedTools) do
            tool:setOwnerFarmId(farmId)
            tool:setHolder(g_localPlayer)
            Logging.info("[CG] Tool assigned to player")
        end

        self.loadedTools = {}
    end
end

Mission00.loadMission00Finished = Utils.appendedFunction(
    Mission00.loadMission00Finished,
    function()
        Logging.info("[CG] Mission00 load finished, giving starting items")
        CommonGroundStartingItems:giveStartingItems()
    end
)

addModEventListener(CommonGroundStartingItems)