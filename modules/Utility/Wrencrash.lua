local WrenCrasher = {}

WrenCrasher.Name = "WrenCrasher"
WrenCrasher.Enabled = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local events = ReplicatedStorage:WaitForChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events")
local useAbility = events:WaitForChild("useAbility")

local THREAD_COUNT = 70   -- Slightly reduced for stability
local BATCH_SIZE = 70
local DURATION = 35

local threads = {}
local heartbeatConnection = nil
local stopTimer = nil

local function fire()
    useAbility:FireServer("close_black_market")
end

local function spamThread()
    while WrenCrasher.Enabled do
        for _ = 1, BATCH_SIZE do
            fire()
        end
        task.wait(0)
    end
end

local function onHeartbeat()
    if WrenCrasher.Enabled then
        fire()
    end
end

WrenCrasher.Run = function()
    WrenCrasher.Enabled = not WrenCrasher.Enabled

    if WrenCrasher.Enabled then
        print("✅ WrenCrasher Enabled")

        for i = 1, THREAD_COUNT do
            table.insert(threads, task.spawn(spamThread))
        end

        heartbeatConnection = RunService.Heartbeat:Connect(onHeartbeat)

        stopTimer = task.delay(DURATION, function()
            if WrenCrasher.Enabled then
                WrenCrasher.Run()  -- Auto disable
            end
        end)

    else
        print("❌ WrenCrasher Disabled")

        for _, t in pairs(threads) do
            pcall(task.cancel, t)
        end
        threads = {}

        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end

        if stopTimer then
            pcall(task.cancel, stopTimer)
            stopTimer = nil
        end
    end
end

return WrenCrasher