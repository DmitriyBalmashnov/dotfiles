local status, registry = pcall(require, "mason-registry")
if not status then return end

local function install_pylsp_plugins()
    local pkg_name = "python-lsp-server"
    
    -- Check if it's actually installed
    if not registry.is_installed(pkg_name) then
        return
    end

    -- Construct the path manually using stdpath("data")
    -- This is the standard location for Mason packages
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/" .. pkg_name
    
    -- Determine the correct python executable path for the venv
    local venv_python = mason_path .. "/venv/bin/python"
    if vim.fn.has("win32") == 1 then
        venv_python = mason_path .. "/venv/Scripts/python.exe"
    end

    -- Check if the venv actually exists before trying to run pip
    if vim.fn.executable(venv_python) ~= 1 then
        return
    end

    local plugins = { "python-lsp-ruff", "pylsp-rope" }

    -- Run in the background
    vim.fn.jobstart({venv_python, "-m", "pip", "install", unpack(plugins)}, {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                -- Optional: Notify only on first success
                -- vim.notify("pylsp plugins synced", vim.log.levels.INFO)
            end
        end,
    })
end

-- 1. Run whenever a package is successfully installed
registry:on("package:install:success", function(pkg)
    if pkg.name == "python-lsp-server" then
        -- Wait a tiny bit for the venv to be fully finalized by Mason
        vim.defer_fn(install_pylsp_plugins, 100)
    end
end)

-- 2. Run on startup
install_pylsp_plugins()
