require("toggleterm").setup({
    size = 10,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    autochdir = false,
    shade_terminals = true,
    shading_factor = 30,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    -- 'vertical'、'horizontal'、'tab' or 'float'
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
})
