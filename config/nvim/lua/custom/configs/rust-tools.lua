local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

local dap = require("dap")

dap.defaults.fallback.exception_breakpoints = { 'all' }


dap.adapters.lldb = {
	type = "executable",
	command = codelldb_path,
	name = "lldb",
    args = {"--port", "0"},
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set("n", "<F1>", dap.step_into)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_out)
vim.keymap.set("n", "<F4>", dap.continue)

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>cb", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
end)
vim.keymap.set("n", "<leader>lb", function()
    dap.list_breakpoints()
    vim.cmd.copen()
end, { desc = "List breakpoints in quickfix list" })

vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔵', texthl='', linehl='', numhl=''})

local widgets = require("dap.ui.widgets")
vim.keymap.set("n", "<leader>i", widgets.hover, {desc = "DAP Inspect"})


require("nvim-dap-virtual-text").setup()

local file_exists = function (filename)
    local file = io.open(filename, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

local find_launch_json = function ()
    if file_exists("launch.json") then
        return "launch.json"
    end
    if file_exists(".vscode/launch.json") then
        return ".vscode/launch.json"
    end
    return nil
end

local load_launch_json = function ()
    local launchjs = find_launch_json()
    if launchjs then
        require('dap.ext.vscode').load_launchjs(launchjs, { rt_lldb = {'rust'}, cppdbg = {'c', 'cpp'} })
    end
end

vim.keymap.set("n", "<leader>lj", load_launch_json, {desc = "Load launch.json"})

-- load_launch_json()

local rt = require("rust-tools")
rt.setup(
{
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>rk", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    capabilities = capabilities,
    root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
    settings = {
      ["rust_analyzer"] = { cargo = { allFeatures = true}}
    },
    checkOnSave = {
      allFeatures = true,
      overrideCommand = {
        "cargo",
        "clippy",
        "--workspace",
        "--message-format=json",
        "--all-targets",
        "--all-features",
      },
    }
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  }
})
