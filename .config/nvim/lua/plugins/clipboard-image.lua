return {
  'ekickx/clipboard-image.nvim',
  cmd = {'PasteImg'},
  config = {
    default = {
      img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
      img_dir = 'assets',
      img_dir_txt = '/home/bo/bohq/vault/assets',
      affix = '{file://%s}[]'
    }
  }
}
