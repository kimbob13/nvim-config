local whitespace = "\u{2632} "

function trailing_whitespaces()
    local space = vim.fn.search([[\s\+$]], "nwc")
    return space ~= 0 and whitespace.."["..space.."]".."trailing" or ""
end

function mixed_indent()
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, "nwc")
    local tab_indent = vim.fn.search(tab_pat, "nwc")

    local mixed = (space_indent > 0 and tab_indent > 0)
    local mixed_same_line
    if not mixed then
        mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
        mixed = mixed_same_line > 0
    end

    if not mixed then return "" end
    if mixed_same_line ~= nil and mixed_same_line > 0 then
        return whitespace.."["..mixed_same_line.."]".."mix-indent"
    end

    local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
    local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
    if space_indent_cnt > tab_indent_cnt then
        return whitespace.."["..tab_indent.."]".."mix-indent"
    else
        return whitespace.."["..space_indent.."]".."mix-indent"
    end
end

function line_numbers()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local total_lines = vim.api.nvim_buf_line_count(0)
    local progress = math.floor((row / total_lines) * 100)

    col = col + 1

    local progress_str
    if row == 1 then
        progress_str = "Top "
    else
        progress_str = progress.."%% "
    end

    return progress_str.."\u{e0a1}:"..row.."/"..total_lines.."\u{2630} ".."\u{e0a3}:"..col
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
        options = {
            theme = "onedark",
        },
        sections = {
            lualine_c = { { "filename", path = 1 } },
            lualine_y = { line_numbers, "searchcount" },
            lualine_z = { trailing_whitespaces, mixed_indent },
        },
    }
}
