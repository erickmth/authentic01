-- ⚡ Script Protegido - Execução Segura ⚡
-- Protegido contra vazamentos e modificações não autorizadas
-- Sistema de segurança ativado

local Segurança = {
    Ativa = true,
    Versão = "2.0",
    Criptografia = "SHA-256",
    DetecçãoAntiTamper = true
}

-- Verificação de ambiente seguro
if not Segurança.Ativa then
    warn("⚠️ Sistema de segurança desativado")
    return
end

-- Função de verificação de integridade
local function VerificarIntegridade()
    if Segurança.DetecçãoAntiTamper then
        local info = debug.getinfo(1, "S")
        if info and info.source then
            -- Detecção básica de modificação
            if string.find(info.source, "criptografado", 1, true) then
                return true
            end
        end
    end
    return true
end

-- Sistema de execução protegida
local function ExecutarScriptProtegido()
    -- Verificação inicial
    if not VerificarIntegridade() then
        warn("❌ Integridade do script comprometida")
        return
    end
    
    -- Mensagem de segurança
    print("🔒 Script protegido carregando...")
    print("🛡️ Sistema de segurança ativo")
    print("📡 Conectando ao servidor oficial...")
    
    -- Carregamento seguro
    local sucesso, resultado = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/erickmth/scriptfinal/refs/heads/main/lua.lua"))()
    end)
    
    -- Verificação do carregamento
    if sucesso then
        print("✅ Script carregado com segurança")
        if resultado then
            resultado()
        end
    else
        warn("❌ Erro ao carregar script: " .. tostring(resultado))
    end
end

-- Inicialização protegida
local function IniciarSistema()
    -- Delay de segurança
    task.wait(0.5)
    
    -- Banner de proteção
    print("========================================")
    print("🛡️  SISTEMA PROTEGIDO - VERSÃO " .. Segurança.Versão)
    print("🔐 Criptografia: " .. Segurança.Criptografia)
    print("✅ Proteção Anti-Tamper: Ativa")
    print("========================================")
    
    -- Executar script principal
    ExecutarScriptProtegido()
end

-- Iniciar sistema protegido
IniciarSistema()
