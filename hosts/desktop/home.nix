{ pkgs, ... }:


{
  # necessary info
  home.username = "iago";
  home.homeDirectory = "/home/iago";

  # first verison of NixOs installed, (!!) not to be changed (!!)
  home.stateVersion = "24.11";

  # package management
  home.packages = [ ];

  # plain file management
  home.file = { };

  # environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # home-manager auto-management
  programs.home-manager.enable = true;

  #                #
  # window manager #
  #                #
  # @https://github.com/YaLTeR/niri/wiki
  programs.niri = {
    enable = true;

    # home-manager settings:
    # @https://github.com/sodiboo/niri-flake/blob/main/docs.md#homemodulesconfig
    settings = {

      input = {
        keyboard = {
          # repeat-delay = 600;
          # repeat-rate = 25;
          # track-layout = "window";
          xkb = {
            layout = "us, pt";
            options = "grp:win_space_toggle";
          };
        };
        touchpad = {
          # off = true
          # tap = false
          # dwt = true
          # dwtp = true
          # natural-scroll
          # accel-speed 0.2
          # accel-profile "flat"
          # scroll-method "two-finger"
          # disabled-on-external-mouse
        };
        mouse = {
          # off = true
          # natural-scroll = true
          # accel-speed = 0.2
          # accel-profile = "flat"
          # scroll-method = "no-scroll"
        };
        trackpoint = {
          # off = true
          # natural-scroll
          # accel-speed 0.2
          # accel-profile "flat"
          # scroll-method "on-button-down"
          # scroll-button 273
          # middle-emulation
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        # workspace-auto-back-and-forth = true;
      };

      outputs = {
        "HDMI-A-1" = {
          # off = true;
          mode = {
            width = 3440;
            height = 1440;
            refresh = 99.992;
          };
          # scale = 1;
          # transform = flipped;
          # position = {
          #   x = 0;
          #   y = 0;
          #};
        };
      };

      layout = {
        background-color = "transparent";
        gaps = 20;
        # center-focused-column = "on-overflow";
        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
          {proportion = 1.0;}
        ];

        # preset-window-heights = [{proportion = ...;}]

        default-column-width = {};

        # focused window
        focus-ring = {
          enable = false;
          width = 4;
          active.color = "#000000";
          inactive.color = "#000000";
          # active.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
          # inactive.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
        };

        border = {
          enable = false;
          width = 5;
          active.color = "#000000";
          inactive.color = "#000000";
          # active.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
          # inactive.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
        };

        shadow = {
          enable = false;
          # draw-behind-window = true;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 0;
          };
          color = "#000000";
        };

        # outer gaps
        struts = {
          left = 30;
          right = 30;
          top = 30;
          bottom = 30;
        };

      };

      spawn-at-startup = [
         { command = ["swww-daemon" ]; }
         { command = ["dunst" ]; }
         { command = ["xwayland-satellite" ]; }
         { argv = ["wlsunset" "-l" "43.2" "-L" "8.2"]; }
      ];

      screenshot-path = "~/mídia/capturas/%Y-%m-%d-%H-%M-%S.png";

      window-rules = [
        {
          # rounded corners
          geometry-corner-radius = {
            bottom-left = 18.0;
            bottom-right = 18.0;
            top-left = 18.0;
            top-right = 18.0;
          };
          clip-to-geometry = true;
        }
      ];

      overview = {
        workspace-shadow.enable = false;
      };

      layer-rules = [{
        matches = [{
          namespace = "^swww-daemon$";
        }];
        place-within-backdrop = true;
      }];

      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "x11";
        TERM = "kitty";
        TERMINAL = "kitty";
      };
      cursor = {
        size = 5;
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };

        "Mod+Slash".action.show-hotkey-overlay = { };

        "Mod+T".action.spawn = "kitty";
        "Mod+D".action.spawn = ["wofi" "--show" "run"];

        "Mod+Q".action.close-window = [];


        # audio
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };


        # window controls
        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+L".action.focus-column-right = { };

        "Mod+Ctrl+H".action.move-column-left = { };
        "Mod+Ctrl+J".action.move-window-down = { };
        "Mod+Ctrl+K".action.move-window-up = { };
        "Mod+Ctrl+L".action.move-column-right = { };

        "Mod+Ctrl+Home".action.move-column-to-first = { };
        "Mod+Ctrl+End".action.move-column-to-last = { };

        "Mod+Shift+H".action.set-column-width = "-10%";
        "Mod+Shift+L".action.set-column-width = "+10%";
        "Mod+Shift+J".action.set-window-height = "-10%";
        "Mod+Shift+K".action.set-window-height = "+10%";

        "Mod+Shift+Home".action.focus-column-first = { };
        "Mod+Shift+End".action.focus-column-last = { };

        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };


        # workspace controls
        "Mod+U".action.focus-workspace-down = { };
        "Mod+I".action.focus-workspace-up = { };

        "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
        "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

        "Mod+Shift+U".action.move-workspace-down = { };
        "Mod+Shift+I".action.move-workspace-up = { };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+Comma".action.consume-window-into-column = { };
        "Mod+Period".action.expel-window-from-column = { };

        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };

        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.reset-window-height = { };

        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };

        "Mod+C".action.center-window = { };

        "Mod+V".action.toggle-window-floating = { };
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };
        "Mod+W".action.toggle-column-tabbed-display = { };

        "Print".action.screenshot-screen = {write-to-disk = true;};
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Mod+Shift+E".action.quit = { };
        "Mod+Ctrl+Shift+E".action.quit = { skip-confirmation=true; };
        "Mod+Shift+P".action.power-off-monitors = { };
      };

    };

  };

  #          #
  # programs #
  #          #
  programs = {

    bash = {
      enable = true;
      initExtra = ''
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
    };

    kitty = {
      enable = true;
      settings = {
        background_opacity = "0.9";
        font_family = "Maple Mono NF";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = "12.5";
        window_padding_width = "4";
        disable_ligatures = "never";
        font_features = "MapleMono-NF-Regular +zero +calt +cv07 +cv08 +cv09 +cv10 +cv11 +cv65 +cv66 +ss03 +ss10 +ss11 +cv31 +cv32 +cv33 +cv38 +cv43";
      };
    };

    starship= {
      enable = true;
      enableBashIntegration = true;

      settings = {
        add_newline = false;
        command_timeout = 5000;
        format = ''
          ╭╴\\
          [ ](bg:#000000 fg:#FFFFFF)\\
          $directory\\
          $git_branch\\
          $git_status\\
          $git_metrics\\
          ╰─ '';
        directory = {
          truncation_length = 1;
          truncate_to_repo = false;
          truncation_symbol = "…/";
          format = "[ $path ]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_branch = {
          format = "[ $symbol$branch(:$remote_branch) ]($style)";
          symbol = " ";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_status = {
          format = "[$all_status]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_metrics = {
          format = "([+$added]($added_style))[]($added_style)";
          added_style = "fg:#FFFFFF bg:#000000";
          deleted_style = "fg:FFFFFF bg:000000";
          disabled = false;
        };
        cmd_duration = {
          format = "[  $duration ]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
      };
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      extraConfig = ''
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        set-option -g status-position top

        set -g status-bg black

        set -g @prefix_highlight_output_prefix "#[fg=brightcyan]#[bg=black]#[nobold]#[noitalics]#[nounderscore]#[bg=brightcyan]#[fg=black]"
        set -g @prefix_highlight_output_suffix ""
        set -g @prefix_highlight_copy_mode_attr "fg=brightcyan,bg=black,bold"

        set -g status-left "#[fg=brightblack,bg=black]#[fg=white,bg=brightblack,bold] #S #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
        set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack,nobold] #H #[fg=brightblack,bg=black,nobold]"

        set -g window-status-format "#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #I#[fg=white,bg=brightblack,nobold,noitalics,nounderscore]: #W #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"

        set -g window-status-current-format "#[fg=#5e81ac,bg=black]#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore] #I#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore]: #W #[fg=#5e81ac,bg=black,nobold,noitalics,nounderscore]"
        set -g window-status-separator " "

        # center window list (*centre)
        set -g status-justify centre

        set -g pane-active-border-style "bg=default fg=blue"
      '';
    };


    zathura = {
      enable = true;
      options = {
        recolor = "true";
        recolor-keephue = "true";
        scroll-page-aware = "true";
        font = "Maple Mono 12";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        local opt = vim.opt

        -- controls
        vim.g.mapleader = " "
        opt.mouse = ""

        -- tabs & indent
        opt.tabstop = 2
        opt.shiftwidth = 2
        opt.softtabstop = 2
        opt.smartindent = true
        opt.breakindent = true
        opt.expandtab = true
        opt.autoindent = true

        -- search & clip
        opt.incsearch = false
        opt.smartcase = true
        opt.iskeyword:append("-")
        opt.clipboard:append("unnamedplus")

        -- appearance
        opt.number = true
        opt.showmode = true
        opt.relativenumber = true
        opt.termguicolors  = true
        opt.cmdheight = 1
        opt.completeopt = "menuone,noinsert,noselect"
        opt.list = true
        opt.laststatus = 0
        opt.showmode = false

        -- blank indicators
        opt.listchars:append "space:⋅"
        vim.wo.fillchars ='eob: '
        opt.guicursor = ""

        -- behaviour
        opt.scrolloff = 10
        opt.hidden = true
        opt.errorbells = false
        opt.swapfile = false
        opt.backup = false
        opt.undofile = true
        opt.undodir = vim.fn.expand("~/.nvim/undodir")
        opt.backspace = "indent,eol,start"

        -- telescope keybinds
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      '';

      plugins = let
        nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins: with treesitter-plugins; [
          c
          nix
          python
          latex
          java
          gleam
          haskell
          ocaml
        ]);
      in
        with pkgs.vimPlugins; [
          {
            plugin = nvim-web-devicons;
            type = "lua";
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              local theme = require'lualine.themes.auto'
              theme.inactive.c.bg = '#00000000'
              theme.visual.c.bg = '#00000000'
              theme.replace.c.bg = '#00000000'
              theme.normal.c.bg = '#00000000'
              theme.insert.c.bg = '#00000000'
              theme.command.c.bg = '#00000000'
              require('lualine').setup{
                options = {
                  icons_enabled = true,
                  theme = theme,
                  component_separators = '|',
                  section_separators = { left = '', right = '' },
                  disabled_filetypes = {},
                  globalstatus = false,
                },
                sections = {
                  lualine_a = {{
                    'mode',
                    separator = { left = '', right = ''},
                  }},
                  lualine_b = {{
                    'filename',
                    color = {bg = '#00000000'},
                  }},
                  lualine_c = {{
                    'diff',
                    color = {bg = '#00000000'}
                  }},
                  lualine_x = {{
                    'diagnostics',
                    color = {bg = '#00000000'}
                  }},
                  lualine_y = {{
                    'progress',
                    color = {bg = '#00000000'},
                  }},
                  lualine_z = {{
                    'location',
                    separator = { left = '', right = ''},
                  }}
                },
                tabline = {},
                extensions = {}
                }
            '';
          }
          {
            plugin = gitsigns-nvim;
            type = "lua";
            config = ''require('gitsigns').setup({
              on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end)

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                  gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                  gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>td', gitsigns.toggle_deleted)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
              end
            })'';
          }
          {
            plugin = catppuccin-nvim;
            type = "lua";
            config = ''
              require('catppuccin').setup({
                transparent_background = true,
                color_overrides = {
                  mocha = {
                    text = "#ffffff",
                  },
                },
              })

              vim.cmd[[colorscheme catppuccin]]
              vim.cmd('hi Normal guibg=#00000000')

              vim.cmd [[
                hi DiagnosticUnderlineError gui=undercurl
                hi DiagnosticUnderlineWarn gui=undercurl
                hi DiagnosticUnderlineHint gui=undercurl
                hi DiagnosticUnderlineInfo gui=undercurl
              ]]
            '';
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = ''
              vim.lsp.enable('pyright')
              vim.lsp.enable('clangd')
              vim.lsp.enable('texlab')
              vim.lsp.enable('nil_ls')
              vim.lsp.enable('jdtls')
              vim.lsp.enable('gleam')
              vim.lsp.enable('hls')
              vim.lsp.enable('ocamllsp')

              -- lsp keybinds
              vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                  -- Enable completion triggered by <c-x><c-o>
                  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                  -- Buffer local mappings.
                  -- See `:help vim.lsp.*` for documentation on any of the below functions
                  local opts = { buffer = ev.buf }
                  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                  end, opts)
                  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                  vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                  end, opts)
                end,
              })

              vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
              vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
              vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
              vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            '';
          }
          {
            plugin = nvim-treesitter-with-plugins;
            type = "lua";
            config = ''require('nvim-treesitter.configs').setup({

              highlight = { enable = true, },

              incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "gnn",
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
                },
              },
            })
          '';

          }
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''require('telescope').setup({
              vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }),
              vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }),
              vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }),
              vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }),
                  })
            '';
          }
          {
            plugin = vimtex;
            type = "lua";
            config = '' vim.g.vimtex_view_method = "zathura" '';
          }
        ];
      };

    };

  programs.fastfetch = {
    enable=true;
    settings = {
      # what a pain in the ass
      display = {
        # ❯ char separator for display
        separator = " ";

        # title & keys coloration
        color = {
          keys = "00";
          title = "00";
        };

        # display bar style
        bar = {
          char = {
            elapsed = "■";
            total = " ";
          };

          width = 12;
        };
      };

      # all that shit
      modules = [

        {
          type = "custom";
          key = "╭───────────╮";
        }

        {
          type = "title";
          key = "│ {#cyan} ";
          format = "user   │ {#cyan}{1}  ";
        }

        {
          type = "os";
          key = "│ {#blue} ";
          format = "distro │ {#blue}{name} {version}";
        }
        {
          type = "packages";
          key = "│ {#magenta}󰏗 ";
          format = "pkgs   │ {#magenta}{9} (system) {10} (user)";
        }
        {
          type = "wm";
          key = "│ {#yellow} ";
          format = "comp   │ {#yellow}{1} ({3}) {4}";
        }
        {
          type = "terminal";
          key = "│ {#cyan} ";
          format = "term   │ {#cyan}{1} {6} (bash)";
        }
        {
          type = "cpu";
          key = "│ {#red} ";
          format = "chip   │ {#red}{1} @ {7}";
        }
        {
          type = "gpu";
          key = "│ {#green} ";
          format = "graph  │ {#green}{1} {2}";
          hideType = "Integrated";
        }
        {
          type = "memory";
          key = "│ {#yellow} ";
          format = "memory │ {#yellow}{1} | {2}";
        }
        {
          type = "disk";
          key = "│ {#blue} ";
          format = "disk   │ {#blue}{1} | {2} {10}";
        }
        {
          type = "custom";
          key = "├───────────┤";
        }
        {
          type = "colors";
          key = "│ {#green} {#white} colors │";
          symbol = "circle";
          block = {
            width = 4;
            height = 1;
          };
        }
        {
          type = "custom";
          key = "╰───────────╯";
        }
      ];
    };
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "gay-men";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.80;
      color_align.mode = "horizontal";
      backend = "fastfetch";
      pride_month_disable = false;
      custom_ascii_path = "/home/iago/dotfiles/media/ascii.txt";
    };
  };


  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        width = 300;
        height = 300;
        offset = "(30, 30)";
        origin = "top-right";
        frame_width = 2;
        show_age_threshold = -1;
        font = "Maple Mono NF 12";
        timeout = 600;
        format = ''<b>%s</b>\n%b'';
        frame_color = "#ffffff";
        separator_color = "frame";
        transparency = 10;
        corner_radius = 12;
        gap_size = 10;
        notification_limit = 7;
        word_wrap = true;
        indicate_hidden = true;
        background = "#ffffff";
        foreground = "#000000";
        highlight = "#000000";

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
      };
      volume = {
        summary = "Volume";
        set_stack_tag = "volume";
      };
      backlight = {
        summary = "Backlight";
        highlight = "#ffffff";
        set_stack_tag = "backlight";
      };
    };
  };
}
