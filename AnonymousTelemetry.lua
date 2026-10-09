task.spawn(function()
    pcall(function()
        local HttpService = game:GetService("HttpService")
        local MarketplaceService = game:GetService("MarketplaceService")

        local requestFunc = (syn and syn.request) or (http and http.request) or http_request or request
        if not requestFunc then return end

        local executorName = identifyexecutor and identifyexecutor() or "Unknown"
        local placeName = "Unknown"
        pcall(function()
            local info = MarketplaceService:GetProductInfo(game.PlaceId)
            if info and info.Name then placeName = info.Name end
        end)

        local payload = {
            placeName = placeName,
            placeId = tostring(game.PlaceId),
            executor = executorName
        }

        requestFunc({
            Url = "https://telemetry.sosiskomras.workers.dev/",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end)
