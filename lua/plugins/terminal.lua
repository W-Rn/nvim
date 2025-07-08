return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = { "<A-\\>" },
    opts = {
      size = 80,
      open_mapping = [[<A-\>]],
      direction = "vertical",
    },
  },
}
