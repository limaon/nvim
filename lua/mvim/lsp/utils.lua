local M = {}

local null_ls = require("null-ls")

---@param fun function
---@return fun() @function that calls the provided fun, but with no args
function M.fn(fun)
  return function()
    return fun()
  end
end

---@param t table table
local function find(t, func)
  for _, entry in pairs(t) do
    if func(entry) then
      return entry
    end
  end
  return nil
end

---@param name string client name
function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()

  return find(clients, function(client)
    return client.name == name
  end)
end

---check if the manager autocmd has already been configured
---since some servers can take a while to initialize
---@param name string lsp client name
---@param ft string? filetype
---@return boolean
function M.client_is_configured(name, ft)
  ft = ft or vim.bo.filetype
  local active_autocmds = vim.api.nvim_get_autocmds({ event = "FileType", pattern = ft })
  for _, result in ipairs(active_autocmds) do
    if result.command:match(name) then
      return true
    end
  end
  return false
end

---list providers
---@param filetype string filetype
---@return table providers null-ls providers
function M.list_registered_providers_names(filetype)
  local sources = require("null-ls.sources")
  local available_sources = sources.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

---list registered formatters
---@param filetype string filetype
---@return string[] providers name of the providers
function M.list_registered_formatters(filetype)
  local method = null_ls.methods.FORMATTING
  local providers = M.list_registered_providers_names(filetype)
  return providers[method] or {}
end

local alternative_methods = {
  null_ls.methods.DIAGNOSTICS,
  null_ls.methods.DIAGNOSTICS_ON_OPEN,
  null_ls.methods.DIAGNOSTICS_ON_SAVE,
}

---list registered linters
---@param filetype string filetype
---@return string[] providers name of the providers
function M.list_registered_linters(filetype)
  local providers = M.list_registered_providers_names(filetype)
  local names = vim.tbl_flatten(vim.tbl_map(function(m)
    return providers[m] or {}
  end, alternative_methods))
  return names
end

return M
