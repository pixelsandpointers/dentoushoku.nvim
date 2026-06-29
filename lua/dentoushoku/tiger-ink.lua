-- ============================================================================
-- tiger-ink.nvim
-- Sibling to oxblood-chassis, derived from the back-view of the same concept
-- art: grey tiger-tattoo linework over white plating -> structural greys,
-- gold lightning-bolt frame -> primary accent, red core gem -> secondary
-- accent, dual pistol glows (orange-red / cyan-blue) -> warm/cool accents.
-- Dark, transparency-first.
-- ============================================================================

local M = {}

M.palette = {
  -- base
  bg          = "#100f14", -- near-black gunmetal
  bg_dim      = "#0c0b0f", -- floats / sidebars, slightly recessed
  bg_alt      = "#1c1b22", -- statusline / popups / cursorline
  bg_alt2     = "#262430", -- visual selection bg, pmenu sel
  surface     = "#34323d", -- borders, subtle separators

  fg          = "#e7e6ea", -- ivory plating
  fg_dim      = "#c6c4cc", -- secondary text
  fg_muted    = "#8a8893", -- line numbers, inactive UI, tattoo linework grey

  -- accents
  gold        = "#d9b14a", -- primary accent: keywords, lightning-bolt frame
  gold_br     = "#f0c869",
  gold_deep   = "#7a6228", -- subtle fills, deep gold

  red         = "#c45a3d", -- secondary accent: core gem, errors
  red_br      = "#e0734f",
  red_deep    = "#5e2c1f", -- selection bg, danger fill

  cyan        = "#4fb3c2", -- cool pistol glow: info, strings
  cyan_br     = "#6fd6e6", -- cursor-adjacent, matched search, hints

  blue        = "#4a8fae", -- cool secondary: operators, namespaces
  blue_br     = "#6fb3d6",

  mauve       = "#9b6a7a", -- constants, numbers
  mauve_br    = "#bb8a9a",

  sage        = "#7a9a82", -- diff-add / success
  sage_br     = "#9bc2a3",

  -- diagnostics
  err  = "#e0734f",
  warn = "#f0c869",
  info = "#6fd6e6",
  hint = "#6fb3d6",

  none = "NONE",
}

function M.setup(opts)
  opts = opts or {}
  local transparent = opts.transparent
  if transparent == nil then
    transparent = true
  end

  local p = M.palette

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "tiger-ink"

  local bg_main = transparent and p.none or p.bg
  local bg_float = transparent and p.none or p.bg_dim

  local hl = function(group, spec)
    spec.default = nil
    vim.api.nvim_set_hl(0, group, spec)
  end

  -- ===========================================================================
  -- Editor UI
  -- ===========================================================================
  hl("Normal",       { fg = p.fg, bg = bg_main })
  hl("NormalNC",     { fg = p.fg, bg = bg_main })
  hl("NormalFloat",  { fg = p.fg, bg = bg_float })
  hl("FloatBorder",  { fg = p.surface, bg = bg_float })
  hl("FloatTitle",   { fg = p.gold_br, bg = bg_float, bold = true })

  hl("Cursor",       { fg = p.bg, bg = p.gold_br })
  hl("CursorLine",   { bg = p.bg_alt })
  hl("CursorLineNr", { fg = p.gold_br, bold = true })
  hl("CursorColumn", { bg = p.bg_alt })

  hl("LineNr",       { fg = p.fg_muted })
  hl("SignColumn",   { fg = p.fg_muted, bg = bg_main })
  hl("ColorColumn",  { bg = p.bg_alt })

  hl("Visual",       { bg = p.red_deep })
  hl("VisualNOS",    { bg = p.red_deep })

  hl("Search",       { fg = p.bg, bg = p.gold_br })
  hl("IncSearch",    { fg = p.bg, bg = p.cyan_br })
  hl("CurSearch",    { fg = p.bg, bg = p.cyan_br })

  hl("Pmenu",        { fg = p.fg, bg = p.bg_dim })
  hl("PmenuSel",     { fg = p.bg, bg = p.gold_br, bold = true })
  hl("PmenuSbar",    { bg = p.bg_alt })
  hl("PmenuThumb",   { bg = p.surface })
  hl("PmenuBorder",  { fg = p.surface, bg = p.bg_dim })

  hl("StatusLine",   { fg = p.fg_dim, bg = p.bg_alt })
  hl("StatusLineNC", { fg = p.fg_muted, bg = p.bg_dim })
  hl("WinSeparator", { fg = p.surface, bg = bg_main })
  hl("VertSplit",    { fg = p.surface, bg = bg_main })

  hl("TabLine",      { fg = p.fg_muted, bg = p.bg_dim })
  hl("TabLineSel",   { fg = p.fg, bg = p.bg_alt, bold = true })
  hl("TabLineFill",  { bg = p.bg_dim })

  hl("Directory",    { fg = p.cyan_br })
  hl("Title",        { fg = p.gold_br, bold = true })

  hl("ErrorMsg",     { fg = p.err, bold = true })
  hl("WarningMsg",   { fg = p.warn })
  hl("MoreMsg",      { fg = p.cyan_br })
  hl("Question",     { fg = p.gold_br })
  hl("ModeMsg",      { fg = p.fg_dim })

  hl("MatchParen",   { fg = p.gold_br, bold = true, underline = true })
  hl("NonText",      { fg = p.surface })
  hl("Whitespace",   { fg = p.surface })
  hl("EndOfBuffer",  { fg = p.bg_alt })
  hl("Folded",       { fg = p.fg_dim, bg = p.bg_alt })
  hl("FoldColumn",   { fg = p.fg_muted, bg = bg_main })

  hl("WildMenu",     { fg = p.bg, bg = p.gold_br })
  hl("QuickFixLine", { bg = p.bg_alt2 })

  -- ===========================================================================
  -- Syntax (generic, also feeds Treesitter via @group -> Group fallback)
  -- ===========================================================================
  hl("Comment",      { fg = p.fg_muted, italic = true })

  hl("Constant",     { fg = p.mauve_br })
  hl("String",       { fg = p.cyan })
  hl("Character",    { fg = p.cyan })
  hl("Number",       { fg = p.mauve_br })
  hl("Boolean",      { fg = p.mauve_br, bold = true })
  hl("Float",        { fg = p.mauve_br })

  hl("Identifier",   { fg = p.fg })
  hl("Function",     { fg = p.gold_br, bold = true })

  hl("Statement",    { fg = p.gold })
  hl("Conditional",  { fg = p.gold })
  hl("Repeat",       { fg = p.gold })
  hl("Label",        { fg = p.gold })
  hl("Operator",     { fg = p.blue_br })
  hl("Keyword",      { fg = p.gold, bold = true })
  hl("Exception",    { fg = p.red_br, bold = true })

  hl("PreProc",      { fg = p.blue_br })
  hl("Include",      { fg = p.blue_br })
  hl("Define",       { fg = p.blue_br })
  hl("Macro",        { fg = p.blue_br })
  hl("PreCondit",    { fg = p.blue_br })

  hl("Type",         { fg = p.cyan_br })
  hl("StorageClass", { fg = p.cyan_br })
  hl("Structure",    { fg = p.cyan_br })
  hl("Typedef",      { fg = p.cyan_br })

  hl("Special",      { fg = p.red_br })
  hl("SpecialChar",  { fg = p.red_br })
  hl("Tag",          { fg = p.gold })
  hl("Delimiter",    { fg = p.fg_dim })
  hl("SpecialComment", { fg = p.fg_muted, italic = true })
  hl("Debug",        { fg = p.err })

  hl("Underlined",   { underline = true, fg = p.cyan_br })
  hl("Ignore",       { fg = p.fg_muted })
  hl("Error",        { fg = p.err, bold = true })
  hl("Todo",         { fg = p.bg, bg = p.gold_br, bold = true })

  -- ===========================================================================
  -- Treesitter (@captures) — explicit so it doesn't silently fall back
  -- ===========================================================================
  hl("@variable",            { fg = p.fg })
  hl("@variable.builtin",    { fg = p.red_br, italic = true })
  hl("@variable.parameter",  { fg = p.fg_dim })
  hl("@variable.member",     { fg = p.blue_br })

  hl("@constant",            { fg = p.mauve_br })
  hl("@constant.builtin",    { fg = p.mauve_br, bold = true })
  hl("@string",              { fg = p.cyan })
  hl("@string.escape",       { fg = p.gold_br })
  hl("@string.special",      { fg = p.red_br })
  hl("@character",           { fg = p.cyan })
  hl("@number",              { fg = p.mauve_br })
  hl("@boolean",             { fg = p.mauve_br, bold = true })

  hl("@function",            { fg = p.gold_br, bold = true })
  hl("@function.builtin",    { fg = p.gold_br, italic = true })
  hl("@function.call",       { fg = p.gold_br })
  hl("@method",              { fg = p.gold_br })
  hl("@method.call",         { fg = p.gold_br })
  hl("@function.method",     { fg = p.gold_br })
  hl("@function.method.call", { fg = p.gold_br })
  hl("@constructor",         { fg = p.cyan_br })

  hl("@keyword",                       { fg = p.gold, bold = true })
  hl("@keyword.function",              { fg = p.gold })
  hl("@keyword.return",                { fg = p.gold, bold = true })
  hl("@keyword.operator",              { fg = p.blue_br })
  hl("@keyword.modifier",              { fg = p.gold })
  hl("@keyword.type",                  { fg = p.cyan_br, italic = true })
  hl("@keyword.coroutine",             { fg = p.gold, bold = true })
  hl("@keyword.exception",             { fg = p.red_br, bold = true })
  hl("@keyword.repeat",                { fg = p.gold })
  hl("@keyword.conditional",           { fg = p.gold })
  hl("@keyword.conditional.ternary",   { fg = p.blue_br })
  hl("@keyword.import",                { fg = p.blue_br })
  hl("@keyword.directive",             { fg = p.blue_br })
  hl("@keyword.directive.define",      { fg = p.blue_br })
  hl("@conditional",         { fg = p.gold })
  hl("@repeat",              { fg = p.gold })
  hl("@exception",           { fg = p.red_br, bold = true })

  hl("@operator",            { fg = p.blue_br })
  hl("@punctuation.delimiter", { fg = p.fg_dim })
  hl("@punctuation.bracket", { fg = p.fg_dim })
  hl("@punctuation.special", { fg = p.red_br })

  hl("@type",                { fg = p.cyan_br })
  hl("@type.builtin",        { fg = p.cyan_br, italic = true })
  hl("@attribute",           { fg = p.blue_br })
  hl("@property",            { fg = p.blue_br })
  hl("@namespace",           { fg = p.cyan_br })
  hl("@module",              { fg = p.cyan_br })

  hl("@comment",             { fg = p.fg_muted, italic = true })
  hl("@comment.todo",        { fg = p.bg, bg = p.gold_br, bold = true })
  hl("@comment.error",       { fg = p.bg, bg = p.err, bold = true })
  hl("@tag",                 { fg = p.gold })
  hl("@tag.attribute",       { fg = p.blue_br })
  hl("@tag.delimiter",       { fg = p.fg_dim })

  hl("@markup.heading",      { fg = p.gold_br, bold = true })
  hl("@markup.strong",       { bold = true, fg = p.fg })
  hl("@markup.italic",       { italic = true, fg = p.fg_dim })
  hl("@markup.link",         { fg = p.cyan_br, underline = true })
  hl("@markup.link.url",     { fg = p.cyan, underline = true })
  hl("@markup.list",         { fg = p.gold })

  -- ===========================================================================
  -- LSP / Diagnostics
  -- ===========================================================================
  hl("DiagnosticError",            { fg = p.err })
  hl("DiagnosticWarn",             { fg = p.warn })
  hl("DiagnosticInfo",             { fg = p.info })
  hl("DiagnosticHint",             { fg = p.hint })
  hl("DiagnosticOk",               { fg = p.sage_br })

  hl("DiagnosticUnderlineError",   { undercurl = true, sp = p.err })
  hl("DiagnosticUnderlineWarn",    { undercurl = true, sp = p.warn })
  hl("DiagnosticUnderlineInfo",    { undercurl = true, sp = p.info })
  hl("DiagnosticUnderlineHint",    { undercurl = true, sp = p.hint })

  hl("DiagnosticVirtualTextError", { fg = p.err,  bg = p.none })
  hl("DiagnosticVirtualTextWarn",  { fg = p.warn, bg = p.none })
  hl("DiagnosticVirtualTextInfo",  { fg = p.info, bg = p.none })
  hl("DiagnosticVirtualTextHint",  { fg = p.hint, bg = p.none })

  hl("LspReferenceText",  { bg = p.bg_alt2 })
  hl("LspReferenceRead",  { bg = p.bg_alt2 })
  hl("LspReferenceWrite", { bg = p.red_deep })
  hl("LspInlayHint",      { fg = p.fg_muted, bg = transparent and p.none or p.bg_alt, italic = true })
  hl("LspSignatureActiveParameter", { fg = p.gold_br, bold = true })

  -- ===========================================================================
  -- Diff / Git
  -- ===========================================================================
  hl("DiffAdd",    { fg = p.sage_br, bg = p.none })
  hl("DiffChange", { fg = p.gold_br, bg = p.none })
  hl("DiffDelete", { fg = p.red_br,  bg = p.none })
  hl("DiffText",   { fg = p.cyan_br, bg = p.none, bold = true })

  hl("GitSignsAdd",    { fg = p.sage_br })
  hl("GitSignsChange", { fg = p.gold_br })
  hl("GitSignsDelete", { fg = p.red_br })

  -- ===========================================================================
  -- Telescope
  -- ===========================================================================
  hl("TelescopeNormal",       { fg = p.fg, bg = bg_float })
  hl("TelescopeBorder",       { fg = p.surface, bg = bg_float })
  hl("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hl("TelescopePromptBorder", { fg = p.surface, bg = p.bg_alt })
  hl("TelescopePromptPrefix", { fg = p.gold_br })
  hl("TelescopeSelection",    { fg = p.fg, bg = p.bg_alt2, bold = true })
  hl("TelescopeMatching",     { fg = p.cyan_br, bold = true })
  hl("TelescopeTitle",        { fg = p.gold_br, bold = true })

  -- ===========================================================================
  -- nvim-cmp / blink.cmp
  -- ===========================================================================
  hl("CmpItemAbbrMatch",        { fg = p.cyan_br, bold = true })
  hl("CmpItemAbbrMatchFuzzy",   { fg = p.cyan_br, bold = true })
  hl("CmpItemKindFunction",     { fg = p.gold_br })
  hl("CmpItemKindMethod",       { fg = p.gold_br })
  hl("CmpItemKindVariable",     { fg = p.fg })
  hl("CmpItemKindKeyword",      { fg = p.gold })
  hl("CmpItemKindClass",        { fg = p.cyan_br })
  hl("CmpItemKindInterface",    { fg = p.cyan_br })
  hl("CmpItemKindText",         { fg = p.fg_dim })
  hl("CmpItemKindSnippet",      { fg = p.mauve_br })

  -- ===========================================================================
  -- Misc plugin scaffolding (safe even if plugin absent)
  -- ===========================================================================
  hl("NvimTreeNormal",     { fg = p.fg, bg = bg_float })
  hl("NvimTreeFolderIcon", { fg = p.gold_br })
  hl("NvimTreeFolderName", { fg = p.blue_br })
  hl("NvimTreeRootFolder", { fg = p.gold_br, bold = true })
  hl("NvimTreeOpenedFile", { fg = p.cyan_br })
  hl("NvimTreeIndentMarker", { fg = p.surface })

  hl("IndentBlanklineChar",        { fg = p.surface })
  hl("IndentBlanklineContextChar", { fg = p.gold })

  hl("WhichKeyFloat", { bg = bg_float })
  hl("WhichKey",      { fg = p.gold_br, bold = true })
  hl("WhichKeyGroup", { fg = p.cyan_br })
  hl("WhichKeyDesc",  { fg = p.fg })
end

return M
