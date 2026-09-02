return {
    "neovim/nvim-lspconfig",
    commit = "effe4bf2e1afb881ea67291c648b68dd3dfc927a",
    config = function()
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("bashls")
        vim.lsp.enable("gopls")
        vim.lsp.enable("templ")
        vim.lsp.enable("asm-lsp")
        vim.lsp.enable("clangd")
        vim.lsp.enable("squawk")
        vim.lsp.config("asm-lsp", {
            cmd = { 'asm-lsp' },
            filetypes = { 'asm', 'vmasm' },
        })

        -- bash formatting is done through none-ls.
        vim.lsp.config("bashls", {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })

        -- squawk 2.64.0 lints with the default rules in server mode and ignores
        -- .squawk.toml, unlike the squawk CLI. Read excluded_rules here instead.
        local squawk_cache = {}

        local squawk_excluded = function(root)
            if not root then
                return {}
            end
            local path = vim.fs.joinpath(root, '.squawk.toml')
            local stat = vim.uv.fs_stat(path)
            if not stat then
                return {}
            end
            local hit = squawk_cache[path]
            if hit and hit.mtime == stat.mtime.sec then
                return hit.rules
            end
            local text = table.concat(vim.fn.readfile(path), '\n'):gsub('#[^\n]*', '')
            local rules = {}
            for rule in (text:match('excluded_rules%s*=%s*%[(.-)%]') or ''):gmatch('["\']([^"\']+)["\']') do
                rules[rule] = true
            end
            squawk_cache[path] = { mtime = stat.mtime.sec, rules = rules }
            return rules
        end

        vim.lsp.config("squawk", {
            cmd = { 'squawk', 'server' },
            filetypes = { 'sql' },
            root_markers = { '.squawk.toml', '.git' },
            -- sql formatting is done through none-ls with pg_format.
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
            end,
            handlers = {
                ['textDocument/diagnostic'] = function(err, result, ctx, cfg)
                    if result and result.items then
                        local client = vim.lsp.get_client_by_id(ctx.client_id)
                        local excluded = squawk_excluded(client and client.root_dir)
                        result.items = vim.tbl_filter(function(item)
                            return not excluded[item.code]
                        end, result.items)
                    end
                    return vim.lsp.handlers['textDocument/diagnostic'](err, result, ctx, cfg)
                end,
            },
        })

        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('<leader>fr', vim.lsp.buf.format, '[F]o[R]mat')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
    end
}
