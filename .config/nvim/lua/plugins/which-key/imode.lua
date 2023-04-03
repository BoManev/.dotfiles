return {
  ["<C-G>"] = {
    name = "miscellaneous",
    ["?"] = "Show keymaps",
    ["c"] = "Toggle capslock",
    ["s"] = "Save document",
    ["x"] = "Open link",
  },
  -- Emacs-like motion in insert mode:
  ["<C-A>"] = "Start of line",
  ["<C-B>"] = "Backward char",
  ["<C-E>"] = "End of line",
  ["<C-F>"] = "Forward char",
  ["<C-N>"] = "Next line",
  ["<C-P>"] = "Previous line",
  -- Defaults worth noting
  ["<C-K>"] = "Digraph",
  ["<C-O>"] = "Switch to Normal mode for one command",
  ["<C-U>"] = "Clear to start of line",
}
