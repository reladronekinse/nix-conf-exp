# ============================================================
# Neovim
# ============================================================
# Общий home-manager модуль. Импортируется и из home-nix/home.nix
# (пользователь reladronekinse), и из home-nix/root.nix (root),
# поэтому конфиг Neovim объявлен один раз и не дублируется.
{ pkgs, ... }:

{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;
  };

  # Тот же init.lua, что был у вас раньше — home-manager просто
  # кладёт его в ~/.config/nvim/init.lua (через symlink на /nix/store)
  # вместо того, чтобы вы держали файл руками.
  xdg.configFile."nvim/init.lua".text = ''
    -- ========================================================================== --
    -- 1. БАЗОВЫЕ НАСТРОЙКИ (Опции)                                               --
    -- ========================================================================== --
    vim.opt.number = true          -- Включаем нумерацию строк
    vim.opt.relativenumber = true  -- Относительные строки (удобно для навигации, можно убрать)
    vim.opt.termguicolors = true   -- Поддержка true color для красивых тем
    vim.opt.signcolumn = "yes"     -- Всегда показывать колонку слева (чтобы код не прыгал)
    vim.opt.tabstop = 4            -- Ширина табуляции
    vim.opt.shiftwidth = 4         -- Размер отступов
    vim.opt.expandtab = true       -- Превращать табы в пробелы
    vim.opt.smartindent = true     -- Умные отступы

    -- ========================================================================== --
    -- 2. ГОРЯЧИЕ КЛАВИШИ (Keymaps)                                               --
    -- ========================================================================== --
    vim.g.mapleader = " "          -- Пробел — наш главный Leader-ключ

    -- Переназначение ESC на ближние клавиши (двойное нажатие 'jj' или 'kk')
    vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
    vim.keymap.set('i', 'kk', '<Esc>', { noremap = true, silent = true })

    -- Отключаем стрелочки в Normal, Visual и Insert режимах
    local modes = { 'n', 'v', 'i' }
    local arrows = { '<Up>', '<Down>', '<Left>', '<Right>' }
    for _, mode in ipairs(modes) do
        for _, arrow in ipairs(arrows) do
            vim.keymap.set(mode, arrow, '<Nop>', { noremap = true, silent = true })
        end
    end

    -- Управление вкладками (сверху) с помощью Leader + цифра
    vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
    vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
    vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
    vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
    vim.keymap.set('n', '<leader>c', '<Cmd>bdelete<CR>', { silent = true }) -- Закрыть текущую вкладку

    -- Открытие/закрытие дерева файлов слева на Ctrl + n
    vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', { silent = true })

    -- ========================================================================== --
    -- 3. УСТАНОВКА И НАСТРОЙКА ПЛАГИНОВ (lazy.nvim)                              --
    -- ========================================================================== --
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        -- Пастельная тема Tokyo Night
        { 
            "folke/tokyonight.nvim", 
            lazy = false, 
            priority = 1000,
            config = function()
                require("tokyonight").setup({ style = "storm", transparent = false })
                vim.cmd([[colorscheme tokyonight]])
            end
        },

        -- Подсветка синтаксиса (настройки переехали сюда!)
        { 
            "nvim-treesitter/nvim-treesitter", 
            build = ":TSUpdate",
            config = function()
        -- Теперь setup вызывается напрямую у основного модуля
        require("nvim-treesitter").setup({
            ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json" },
            highlight = { enable = true },
        })
            end
        },

        -- Иерархия файлов (слева) + иконки
        { 
            "nvim-tree/nvim-tree.lua", 
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("nvim-tree").setup({
                    sort_by = "case_sensitive",
                    view = { width = 30, side = "left" },
                    renderer = {
                        group_empty = true,
                        icons = { show = { file = true, folder = true, folder_arrow = true, git = true } }
                    },
                })
            end
        },

        -- Вкладки (сверху)
        { 
            "akinsho/bufferline.nvim", 
            version = "*", 
            dependencies = "nvim-tree/nvim-web-devicons",
            config = function()
                require("bufferline").setup({
                    options = {
                        mode = "buffers",
                        diagnostics = "nvim_lsp",
                        offsets = {
                            {
                                filetype = "NvimTree",
                                text = "",
                                text_align = "left",
                                separator = true
                            }
                        },
                        show_buffer_close_icons = true,
                        show_close_icon = false,
                    }
                })
            end
        },

        -- Статус-строка (снизу)
        { 
            "nvim-lualine/lualine.nvim", 
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require('lualine').setup({ options = { theme = 'tokyonight' } })
            end
        }
    })

  '';
}
