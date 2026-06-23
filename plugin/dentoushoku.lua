-- plugin/mech-girl.lua
-- Auto-sourced by Neovim on startup (any file under plugin/ in the
-- runtimepath is loaded automatically). Registers a small convenience
-- command; entirely optional — :colorscheme <name> always works regardless.

if vim.g.loaded_dentoushoku then
	return
end
vim.g.loaded_dentoushoku = true

vim.api.nvim_create_user_command("Dentoushoku", function(cmd_opts)
	local name = cmd_opts.args
	if name == "" then
		name = "enji"
	end
	require("dentoushoku").load(name)
end, {
	nargs = "?",
	complete = function()
		return require("dentoushoku").themes
	end,
	desc = "Load a theme: enji | oxblood-chassis | tiger-ink | tiger-oxblood",
})
