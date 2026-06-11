---@brief
--- https://biomejs.dev

-- Native helper to replace lspconfig.util.insert_package_json
local function insert_package_json(config_files, field, filename)
  local package_json = vim.fs.find('package.json', { path = filename, upward = true, type = 'file' })[1]
  if package_json then
    local file = io.open(package_json, 'r')
    if file then
      local content = file:read('*a')
      file:close()
      local ok, parsed = pcall(vim.json.decode, content)
      if ok and type(parsed) == 'table' then
        if
          parsed[field]
          or (type(parsed.dependencies) == 'table' and parsed.dependencies[field])
          or (type(parsed.devDependencies) == 'table' and parsed.devDependencies[field])
        then
          table.insert(config_files, 'package.json')
        end
      end
    end
  end
  return config_files
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'biome'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then
        cmd = local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, 'lsp-proxy' }, dispatchers)
  end,
  filetypes = {
    'astro',
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root_markers = {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock',
      'deno.lock',
    }

    local biome_config_files = { 'biome.json', 'biome.jsonc' }
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, biome_config_files, { '.git' } }
      or vim.list_extend(root_markers, vim.list_extend(biome_config_files, { '.git' }))

    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    local filename = vim.api.nvim_buf_get_name(bufnr)

    -- Using the new native helper function instead of lspconfig.util
    biome_config_files = insert_package_json(biome_config_files, 'biomejs', filename)

    -- Pro-tip: If 'biomejs' isn't matching because your package.json uses
    -- the scoped package name '@biomejs/biome', you might want to add a second check:
    -- biome_config_files = insert_package_json(biome_config_files, '@biomejs/biome', filename)

    local is_buffer_using_biome = vim.fs.find(biome_config_files, {
      path = filename,
      type = 'file',
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(project_root),
    })[1]

    if not is_buffer_using_biome then
      return
    end

    on_dir(project_root)
  end,
}
