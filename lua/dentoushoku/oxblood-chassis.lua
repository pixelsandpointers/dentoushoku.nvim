-- ============================================================================
-- oxblood-chassis.nvim
-- A dark, transparency-first colorscheme derived from white-mech / oxblood-
-- accent concept art: ivory plating -> foreground, near-black joints ->
-- background, oxblood horns/gun/boots -> primary accent, gold trim ->
-- secondary accent, icy cyan gem -> highlight/info color.
-- ============================================================================

local M = {}

M.palette = {
  -- base
  bg          = "#0e0d11", -- near-black mech plating
  bg_dim      = "#0a090c", -- floats / sidebars, slightly recessed
  bg_alt      = "#1a1820", -- statusline / popups / cursorline
  bg_alt2     = "#221f29", -- visual selection bg, pmenu sel
  surface     = "#2a2731", -- borders, subtle separators

  fg          = "#e9e4dc", -- ivory plating
  fg_dim      = "#c9c2b8", -- secondary text, comments base
  fg_muted    = "#8a8590", -- line numbers, inactive UI

  -- accents
  oxblood     = "#9b2c30", -- primary accent: keywords, errors
  oxblood_br  = "#c1393f", -- bright variant: diff-delete, urgent
  blood_deep  = "#5a1f24", -- selection bg, subtle danger fill

  gold        = "#c9a24b", -- secondary accent: strings, warnings
  gold_br     = "#e0bb5e",

  cyan        = "#6fa8a3", -- info, function names
  cyan_br     = "#8fd9d4", -- cursor, matched search, hints

  lavender    = "#7e8aa8", -- background atmosphere -> statements, hints
  lavender_br = "#a3b0d6",

  mauve       = "#8a6a8f", -- constants, numbers
  mauve_br    = "#b08bb8",

  sage        = "#7a8a6b", -- diff-add / success (kept desaturated, on theme)
  sage_br     = "#9bb389",

  -- diagnostics
  err  = "#c1393f",
  warn = "#e0bb5e",
  info = "#8fd9d4",
  hint = "#a3b0d6",

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
  vim.g.colors_name = "oxblood-chassis"

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
  hl("NormalNC",      { fg = p.fg, bg = bg_main })
  hl("NormalFloat",  { fg = p.fg, bg = bg_float })
  hl("FloatBorder",  { fg = p.surface, bg = bg_float })
  hl("FloatTitle",   { fg = p.cyan_br, bg = bg_float, bold = true })

  hl("Cursor",       { fg = p.bg, bg = p.cyan_br })
  hl("CursorLine",   { bg = p.bg_alt })
  hl("CursorLineNr", { fg = p.gold_br, bold = true })
  hl("CursorColumn", { bg = p.bg_alt })

  hl("LineNr",       { fg = p.fg_muted })
  hl("SignColumn",   { fg = p.fg_muted, bg = bg_main })
  hl("ColorColumn",  { bg = p.bg_alt })

  hl("Visual",       { bg = p.blood_deep })
  hl("VisualNOS",    { bg = p.blood_deep })

  hl("Search",       { fg = p.bg, bg = p.gold_br })
  hl("IncSearch",    { fg = p.bg, bg = p.cyan_br })
  hl("CurSearch",    { fg = p.bg, bg = p.cyan_br })

  hl("Pmenu",        { fg = p.fg, bg = p.bg_dim })
  hl("PmenuSel",     { fg = p.bg, bg = p.cyan_br, bold = true })
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

  hl("MatchParen",   { fg = p.cyan_br, bold = true, underline = true })
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
  hl("String",       { fg = p.gold })
  hl("Character",    { fg = p.gold })
  hl("Number",       { fg = p.mauve_br })
  hl("Boolean",      { fg = p.mauve_br, bold = true })
  hl("Float",        { fg = p.mauve_br })

  hl("Identifier",   { fg = p.fg })
  hl("Function",     { fg = p.cyan_br, bold = true })

  hl("Statement",    { fg = p.oxblood_br })
  hl("Conditional",  { fg = p.oxblood_br })
  hl("Repeat",       { fg = p.oxblood_br })
  hl("Label",        { fg = p.oxblood_br })
  hl("Operator",     { fg = p.lavender_br })
  hl("Keyword",      { fg = p.oxblood_br, bold = true })
  hl("Exception",    { fg = p.oxblood_br, bold = true })

  hl("PreProc",      { fg = p.lavender_br })
  hl("Include",      { fg = p.lavender_br })
  hl("Define",       { fg = p.lavender_br })
  hl("Macro",        { fg = p.lavender_br })
  hl("PreCondit",    { fg = p.lavender_br })

  hl("Type",         { fg = p.gold_br })
  hl("StorageClass",  { fg = p.gold_br })
  hl("Structure",    { fg = p.gold_br })
  hl("Typedef",      { fg = p.gold_br })

  hl("Special",      { fg = p.cyan })
  hl("SpecialChar",  { fg = p.cyan })
  hl("Tag",          { fg = p.oxblood_br })
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
  hl("@variable.builtin",    { fg = p.oxblood_br, italic = true })
  hl("@variable.parameter",  { fg = p.fg_dim })
  hl("@variable.member",     { fg = p.lavender_br })

  hl("@constant",            { fg = p.mauve_br })
  hl("@constant.builtin",    { fg = p.mauve_br, bold = true })
  hl("@string",              { fg = p.gold })
  hl("@string.escape",       { fg = p.cyan_br })
  hl("@string.special",      { fg = p.cyan })
  hl("@character",           { fg = p.gold })
  hl("@number",              { fg = p.mauve_br })
  hl("@boolean",             { fg = p.mauve_br, bold = true })

  hl("@function",            { fg = p.cyan_br, bold = true })
  hl("@function.builtin",    { fg = p.cyan_br, italic = true })
  hl("@function.call",       { fg = p.cyan_br })
  hl("@method",              { fg = p.cyan_br })
  hl("@method.call",         { fg = p.cyan_br })
  hl("@constructor",         { fg = p.gold_br })

  hl("@keyword",             { fg = p.oxblood_br, bold = true })
  hl("@keyword.function",    { fg = p.oxblood_br })
  hl("@keyword.return",      { fg = p.oxblood_br, bold = true })
  hl("@keyword.operator",    { fg = p.lavender_br })
  hl("@conditional",         { fg = p.oxblood_br })
  hl("@repeat",              { fg = p.oxblood_br })
  hl("@exception",           { fg = p.oxblood_br, bold = true })

  hl("@operator",            { fg = p.lavender_br })
  hl("@punctuation.delimiter", { fg = p.fg_dim })
  hl("@punctuation.bracket", { fg = p.fg_dim })
  hl("@punctuation.special", { fg = p.cyan })

  hl("@type",                { fg = p.gold_br })
  hl("@type.builtin",        { fg = p.gold_br, italic = true })
  hl("@attribute",           { fg = p.lavender_br })
  hl("@property",            { fg = p.lavender_br })
  hl("@namespace",           { fg = p.gold_br })

  hl("@comment",             { fg = p.fg_muted, italic = true })
  hl("@comment.todo",        { fg = p.bg, bg = p.gold_br, bold = true })
  hl("@comment.error",       { fg = p.bg, bg = p.err, bold = true })
  hl("@tag",                 { fg = p.oxblood_br })
  hl("@tag.attribute",       { fg = p.lavender_br })
  hl("@tag.delimiter",       { fg = p.fg_dim })

  hl("@markup.heading",      { fg = p.gold_br, bold = true })
  hl("@markup.strong",       { bold = true, fg = p.fg })
  hl("@markup.italic",       { italic = true, fg = p.fg_dim })
  hl("@markup.link",         { fg = p.cyan_br, underline = true })
  hl("@markup.link.url",     { fg = p.cyan, underline = true })
  hl("@markup.list",         { fg = p.oxblood_br })

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
  hl("LspReferenceWrite", { bg = p.blood_deep })
  hl("LspInlayHint",      { fg = p.fg_muted, bg = transparent and p.none or p.bg_alt, italic = true })
  hl("LspSignatureActiveParameter", { fg = p.gold_br, bold = true })

  -- ===========================================================================
  -- Diff / Git
  -- ===========================================================================
  hl("DiffAdd",    { fg = p.sage_br,    bg = p.none })
  hl("DiffChange", { fg = p.gold_br,    bg = p.none })
  hl("DiffDelete", { fg = p.oxblood_br, bg = p.none })
  hl("DiffText",   { fg = p.cyan_br,    bg = p.none, bold = true })

  hl("GitSignsAdd",    { fg = p.sage_br })
  hl("GitSignsChange", { fg = p.gold_br })
  hl("GitSignsDelete", { fg = p.oxblood_br })

  -- ===========================================================================
  -- Telescope
  -- ===========================================================================
  hl("TelescopeNormal",       { fg = p.fg, bg = bg_float })
  hl("TelescopeBorder",       { fg = p.surface, bg = bg_float })
  hl("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hl("TelescopePromptBorder", { fg = p.surface, bg = p.bg_alt })
  hl("TelescopePromptPrefix", { fg = p.oxblood_br })
  hl("TelescopeSelection",    { fg = p.fg, bg = p.bg_alt2, bold = true })
  hl("TelescopeMatching",     { fg = p.cyan_br, bold = true })
  hl("TelescopeTitle",        { fg = p.gold_br, bold = true })

  -- ===========================================================================
  -- nvim-cmp / blink.cmp
  -- ===========================================================================
  hl("CmpItemAbbrMatch",        { fg = p.cyan_br, bold = true })
  hl("CmpItemAbbrMatchFuzzy",   { fg = p.cyan_br, bold = true })
  hl("CmpItemKindFunction",     { fg = p.cyan_br })
  hl("CmpItemKindMethod",       { fg = p.cyan_br })
  hl("CmpItemKindVariable",     { fg = p.fg })
  hl("CmpItemKindKeyword",      { fg = p.oxblood_br })
  hl("CmpItemKindClass",        { fg = p.gold_br })
  hl("CmpItemKindInterface",    { fg = p.gold_br })
  hl("CmpItemKindText",         { fg = p.fg_dim })
  hl("CmpItemKindSnippet",      { fg = p.mauve_br })

  -- ===========================================================================
  -- Misc plugin scaffolding (safe even if plugin absent)
  -- ===========================================================================
  hl("NvimTreeNormal",     { fg = p.fg, bg = bg_float })
  hl("NvimTreeFolderIcon", { fg = p.gold_br })
  hl("NvimTreeFolderName", { fg = p.lavender_br })
  hl("NvimTreeRootFolder", { fg = p.oxblood_br, bold = true })
  hl("NvimTreeOpenedFile", { fg = p.cyan_br })
  hl("NvimTreeIndentMarker", { fg = p.surface })

  hl("IndentBlanklineChar",          { fg = p.surface })
  hl("IndentBlanklineContextChar",   { fg = p.oxblood })

  hl("WhichKeyFloat", { bg = bg_float })
  hl("WhichKey",       { fg = p.oxblood_br, bold = true })
  hl("WhichKeyGroup",  { fg = p.gold_br })
  hl("WhichKeyDesc",   { fg = p.fg })
end

return M
