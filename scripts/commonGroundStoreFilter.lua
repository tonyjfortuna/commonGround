CommonGroundStoreFilter = {}

local function cgHideStoreItem(storeItem)
    if storeItem == nil then
        return
    end

    storeItem.showInStore = false
end

function CommonGroundStoreFilter:loadMap(mapName)
    if g_storeManager == nil then
        return
    end

    if self.patched then
        return
    end

    self.patched = true

    -- Patch addItem so anything added to the store is hidden before registration/UI indexing
    g_storeManager.addItem = Utils.prependedFunction(g_storeManager.addItem, function(storeManager, storeItem)
        cgHideStoreItem(storeItem)
    end)

    -- Patch loadItem too, so loaded definitions are hidden as early as possible
    g_storeManager.loadItem = Utils.appendedFunction(g_storeManager.loadItem, function(storeManager, xmlFilename, baseDir, customEnvironment, isMod, isBundleItem, dlcTitle, storeDataXMLKey, ignoreAdd)
        local item = storeManager:getItemByXMLFilename(xmlFilename)
        if item ~= nil then
            cgHideStoreItem(item)
        end
    end)

    print("[CommonGround] StoreManager patched to hide store items before UI registration")
end

function CommonGroundStoreFilter:update(dt)
    if g_storeManager == nil or g_storeManager.items == nil then
        return
    end

    local hiddenCount = 0

    for _, item in pairs(g_storeManager.items) do
        if item ~= nil and item.showInStore ~= false then
            item.showInStore = false
            hiddenCount = hiddenCount + 1
        end
    end

    if hiddenCount > 0 then
        print("[CommonGround] Store items hidden after patch: " .. tostring(hiddenCount))
    end
end

addModEventListener(CommonGroundStoreFilter)