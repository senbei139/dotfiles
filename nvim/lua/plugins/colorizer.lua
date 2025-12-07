return {
  {
    "norcalli/nvim-colorizer.lua",
    require("colorizer").setup(),
    opts = {
      user_default_options = {
        mode = "background",
        names = false,
      },
    },
  }
}
