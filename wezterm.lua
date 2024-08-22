local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local _domain = "unix"
local _font = wezterm.font({ family = 'Iosevka' })

local config = wezterm.config_builder()
config.default_prog = { '/usr/bin/fish', '-l' }
config.font = _font
config.font_size = 10

config.leader = {
  key = 'a',
  mods = 'CTRL',
  timeout_milliseconds = 2000,
}

local project_dir = wezterm.home_dir .. "/projects"

local function get_projects()
  local projects = { wezterm.home_dir }

  for _, dir in ipairs(wezterm.glob(project_dir .. '/*')) do
    table.insert(projects, dir)
  end

  return projects
end

local function choose_project()
  local choices = {}
  for _, value in ipairs(get_projects()) do
    table.insert(choices, { label = value })
  end

  return wezterm.action.InputSelector {
    title = "Projects",
    choices = choices,
    fuzzy = true,
    action = wezterm.action_callback(function(child_window, child_pane, id, label)
      if not label then return end

      child_window:perform_action(wezterm.action.SwitchToWorkspace {
        name = label:match("([^/]+)$"),
        spawn = { cwd = label },
      }, child_pane)
    end),
  }
end

config.keys = {
  {
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },
  {
    key = 'f',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },
  {
    key = 'n',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  {
    key = '&',
    mods = 'LEADER|SHIFT',
    action = act.CloseCurrentTab{ confirm = true },
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane{ confirm = true },
  },
  {
    key = 'a',
    mods = 'LEADER',
    action = act.AttachDomain(_domain),
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = act.DetachDomain { DomainName = _domain },
  },
  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  -- navigate
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  -- resize
  -- edit config
  {
    key = 'y',
    mods = "LEADER",
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { 'top' },
    },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- tables
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
      timeout_milliseconds = 1000,
    }
  },
  {
    key = 'P',
    mods = 'LEADER',
    action = choose_project(),
  },
}

config.key_tables = {
  resize_panes = {
    {
      key = "LeftArrow",
      action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
      key = "RightArrow",
      action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
      key = "DownArrow",
      action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
      key = "UpArrow",
      action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
  },
}

local function get_lightness(hsla_string)
  local l = string.match(hsla_string, "hsla%(%d+,%s*%d+%%,%s*(%d+)%%,")
  return tonumber(l)
end

local function set_lightness(hsla_string, new_lightness)
  local h, s, a = string.match(hsla_string, "hsla%((%d+),%s*(%d+%%),%s*(%d+)%%,%s*([%d%.]+)%)")
  return string.format("hsla(%s, %s, %s%%, %s)", h, s, new_lightness, a)
end

local function get_alpha(hsla_string)
  local a = string.match(hsla_string, "hsla%(%d+,%s*%d+%%,%s*%d+%%,%s*([%d%.]+)%)")
  return tonumber(a)
end

local function set_alpha(hsla_string, new_alpha)
  local h, s, l = string.match(hsla_string, "hsla%((%d+),%s*(%d+%%),%s*(%d+)%%,%s*[%d%.]+%)")
  return string.format("hsla(%s, %s, %s%%, %s)", h, s, l, new_alpha)
end

local colors = {
  foreground = 'hsla(270, 30%, 95%, 0)',   -- '#f2eff8'
  background = 'hsla(0, 0%, 12%, 1)',      -- '#202020'

  cursor_bg = 'hsla(270, 30%, 77%, 1)',    -- '#beb1da'
  cursor_fg = 'hsla(270, 100%, 3%, 1)',    -- '#0a0611'
  cursor_border = 'hsla(270, 30%, 77%, 1)',-- '#beb1da'

  selection_bg = 'hsla(96, 39%, 61%, 1)',  -- '#7aa860'
  selection_fg = 'hsla(270, 100%, 3%, 1)', -- '#0a0611'

  ansi = {
    'hsla(270, 100%, 3%, 1)',    -- black (hsl:235 100 50)
    'hsla(355, 52%, 66%, 1)',    -- red (hsl:355 52 66)
    'hsla(96, 39%, 61%, 1)',     -- green (hsl:96 39 61)
    'hsla(35, 45%, 53%, 1)',     -- yellow (hsl:35 45 53)
    'hsla(215, 53%, 65%, 1)',    -- blue (hsl:215 53 65)
    'hsla(285, 42%, 65%, 1)',    -- magenta (hsl:285 42 65)
    'hsla(180, 37%, 48%, 1)',    -- cyan (hsl:180 37 48)
    'hsla(270, 30%, 77%, 1)',    -- white (hsl:270 30 77)
  },

  brights = {
    'hsla(258, 22%, 35%, 1)',    -- black (bright) (hsl:258 22 35)
    'hsla(355, 64%, 74%, 1)',    -- red (bright) (hsl:355 64 74)
    'hsla(101, 43%, 65%, 1)',    -- green (bright) (hsl:101 43 65)
    'hsla(35, 54%, 60%, 1)',     -- yellow (bright) (hsl:35 54 60)
    'hsla(215, 60%, 71%, 1)',    -- blue (bright) (hsl:215 60 71)
    'hsla(285, 53%, 71%, 1)',    -- magenta (bright) (hsl:285 53 71)
    'hsla(180, 46%, 57%, 1)',    -- cyan (bright) (hsl:180 46 57)
    'hsla(270, 30%, 95%, 1)',    -- white (bright) (hsl:270 30 95)
  },
}

local tab_colors = {
  tab_bar = {
    background = 'rgba(0,0,0,0)'
  },
}

for k,v in pairs(tab_colors) do colors[k] = v end

config.colors = colors

-- tabs
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

-- appearance
config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

config.scrollback_lines = 5000

config.unix_domains = {
  {
    name = _domain,
  },
}

wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a) -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW }
  })
end)

wezterm.on('update-status', function(window)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  window:set_right_status(wezterm.format({
    -- arrow
    { Background = { Color = 'none' } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    -- text
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = ' ' .. wezterm.hostname() .. ' ' .. '(' .. mux.get_active_workspace() .. ')' },
  }))
end)

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

return config

-- TODO
-- feat(keys): toggle padding
-- config.window_padding = {
--   left = '1cell',
--   right = '1cell',
--   top = '0.5cell',
--   bottom = '0.5cell',
-- }
