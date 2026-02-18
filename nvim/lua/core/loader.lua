local M = {}

function M.load_dir(dir)
    local path = vim.fn.stdpath("config") .. "/lua/" .. dir
    local files = vim.fn.readdir(path)

    for _, file in ipairs(files) do
        if file:sub(-4) == ".lua" then
            local module = dir .. "." .. file:gsub("%.lua$", "")
            require(module)
        end
    end
end

return M
