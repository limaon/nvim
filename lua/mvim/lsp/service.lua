local M = {}

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

function M.list_registered_formatters(filetype)
  local methods = require("null-ls.methods")
  local method = methods.internal["FORMATTING"]
  local providers = M.list_registered_providers_names(filetype)
  return providers[method] or {}
end

function M.list_registered_linters(filetype)
  local methods = require("null-ls.methods")
  local method = methods.internal["DIAGNOSTICS"]
  local providers = M.list_registered_providers_names(filetype)
  return providers[method] or {}
end

function M.register_sources(configs, method)
  local null_ls = require("null-ls")
  local is_registered = require("null-ls.sources").is_registered

  local sources, registered_names = {}, {}

  for _, config in ipairs(configs) do
    local cmd = config.exe or config.command
    local name = config.nanme or cmd:gsub("-", "_")
    local type = method == null_ls.methods.CODE_ACTION and "code_actions" or null_ls.methods[method]:lower()
    local source = type and null_ls.builtins[type][name]

    if not source then
      vim.notify("Not a valid source: " .. name, vim.log.levels.ERROR)
    elseif is_registered({ name = source.name or name, method = method }) then
      vim.notify("Source: " .. name .. "had registered.", vim.log.levels.INFO)
    else
      local command = source._opts.command
      local compat_opts = vim.deepcopy(config)
      if config.args then
        compat_opts.extra_args = config.args or config.extra_args
        compat_opts.args = nil
      end
      local opts = vim.tbl_deep_extend("keep", { command = command }, compat_opts)
      table.insert(sources, source.with(opts))
      vim.list_extend(registered_names, { source.name })
    end
  end

  if #sources > 0 then
    null_ls.register({ sources = sources })
  end

  return registered_names
end

return M