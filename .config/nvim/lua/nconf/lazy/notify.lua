return {
  'rcarriga/nvim-notify',

  config = function()
    require('notify').setup({
      background_colour = function()
        local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)
        if normal_hl and normal_hl.background then
          return string.format('#%06x', normal_hl.background)
        else
          return '#000000'
        end
      end,
      fps = 30,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      level = 2,
      minimum_width = 50,
      render = 'default',
      stages = 'fade_in_slide_out',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 3000,
      top_down = true,
    })
  end,
}
