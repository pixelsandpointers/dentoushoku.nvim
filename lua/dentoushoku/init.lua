-- lua/dentoushoku/init.lua
-- Unified entrypoint for the dentoushoku theme family.
--
-- Usage:
--   require("dentoushoku").load("oxblood-chassis")
--   require("dentoushoku").load("tiger-ink", { transparent = false })
--
-- Or just use plain Neovim colorscheme commands, which work too since each
-- theme still ships its own colors/*.lua entrypoint:
--   :colorscheme enji
--   :colorscheme oxblood-chassis
--   :colorscheme tiger-ink
--   :colorscheme tiger-oxblood

local M = {}

M.themes = { "oxblood-chassis", "tiger-ink", "tiger-oxblood", "enji" }

--- Load one of the three themes with optional setup opts.
---@param name string one of "enji" | "oxblood-chassis" | "tiger-ink" | "tiger-oxblood"
---@param opts table|nil { transparent = boolean }
function M.load(name, opts)
	if not vim.tbl_contains(M.themes, name) then
		vim.notify(
			("dentoushoku: unknown theme '%s' (expected one of: %s)"):format(name, table.concat(M.themes, ", ")),
			vim.log.levels.ERROR
		)
		return
	end

	local ok, theme = pcall(require, "dentoushoku." .. name)
	if not ok then
		vim.notify("dentoushoku: failed to load theme module '" .. name .. "'", vim.log.levels.ERROR)
		return
	end

	theme.setup(opts or {})
	vim.cmd.colorscheme(name)
end

--- Convenience setup, mirroring the common `require("plugin").setup()` pattern.
--- Call with a default theme name; falls back to "enji".
---@param opts table|nil { theme = string, transparent = boolean }
function M.setup(opts)
	opts = opts or {}
	M.load(opts.theme or "enji", { transparent = opts.transparent })
end

return M
