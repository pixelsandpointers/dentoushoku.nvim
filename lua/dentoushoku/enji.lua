-- ============================================================================
-- enji.nvim — 臙脂
-- Sibling to oxblood-chassis, with the palette renamed to the traditional
-- Japanese color names its hex values actually land closest to:
--   enji (臙脂) cochineal red       -- primary accent, nearly exact match
--   yamabuki (山吹) golden yellow   -- secondary accent
--   mizu (水) water blue            -- cursor / info highlight
--   asagi (浅葱) light blue          -- cool secondary
--   fuji (藤) wisteria               -- constants / numbers
--   yanagi (柳鼠) willow grey        -- success / diff-add
--   rikyū (利休鼠) Rikyū grey        -- muted structural text, comments
--   shironeri (白練) unbleached silk -- foreground
-- Dark, transparency-first — same structure as oxblood-chassis, renamed
-- to its color lineage.
-- ============================================================================

local M = {}

M.palette = {
  -- base
  bg          = "#0e0d11", -- 黒色-adjacent near-black
  bg_dim      = "#0a090c",
  bg_alt      = "#1a1820",
  bg_alt2     = "#221f29",
  surface     = "#2a2731",

  fg          = "#e9e4dc", -- 白練 shironeri, unbleached silk
  fg_dim      = "#c9c2b8",
  fg_muted    = "#8a8590", -- 利休鼠 rikyū-nezumi region

  -- accents
  enji        = "#9b2c30", -- 臙脂 enji-iro, cochineal red — primary accent
  enji_br     = "#c1393f",
  enji_deep   = "#5a1f24", -- selection bg, danger fill

  yamabuki    = "#c9a24b", -- 山吹 yamabuki-iro, golden yellow — secondary accent
  yamabuki_br = "#e0bb5e",

  mizu        = "#8fd9d4", -- 水 mizu, water blue — cursor / matched search
  asagi       = "#6fa8a3", -- 浅葱 asagi-iro, light blue — info / function names

  fuji        = "#7e8aa8", -- 藤 fuji-iro, wisteria — operators / hints
  fuji_br     = "#a3b0d6",
  murasaki    = "#8a6a8f", -- 紫/藤鼠-adjacent — constants, numbers
  murasaki_br = "#b08bb8",

  yanagi      = "#7a8a6b", -- 柳鼠 yanaginezumi, willow grey — diff-add / success
  yanagi_br   = "#9bb389",

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
  vim.g.colors_name = "enji"

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
  hl("FloatTitle",   { fg = p.mizu, bg = bg_float, bold = true })

  hl("Cursor",       { fg = p.bg, bg = p.mizu })
  hl("CursorLine",   { bg = p.bg_alt })
  hl("CursorLineNr", { fg = p.yamabuki_br, bold = true })
  hl("CursorColumn", { bg = p.bg_alt })

  hl("LineNr",       { fg = p.fg_muted })
  hl("SignColumn",   { fg = p.fg_muted, bg = bg_main })
  hl("ColorColumn",  { bg = p.bg_alt })

  hl("Visual",       { bg = p.enji_deep })
  hl("VisualNOS",    { bg = p.enji_deep })

  hl("Search",       { fg = p.bg, bg = p.yamabuki_br })
  hl("IncSearch",    { fg = p.bg, bg = p.mizu })
  hl("CurSearch",    { fg = p.bg, bg = p.mizu })

  hl("Pmenu",        { fg = p.fg, bg = p.bg_dim })
  hl("PmenuSel",     { fg = p.bg, bg = p.mizu, bold = true })
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

  hl("Directory",    { fg = p.mizu })
  hl("Title",        { fg = p.yamabuki_br, bold = true })

  hl("ErrorMsg",     { fg = p.err, bold = true })
  hl("WarningMsg",   { fg = p.warn })
  hl("MoreMsg",      { fg = p.mizu })
  hl("Question",     { fg = p.yamabuki_br })
  hl("ModeMsg",      { fg = p.fg_dim })

  hl("MatchParen",   { fg = p.mizu, bold = true, underline = true })
  hl("NonText",      { fg = p.surface })
  hl("Whitespace",   { fg = p.surface })
  hl("EndOfBuffer",  { fg = p.bg_alt })
  hl("Folded",       { fg = p.fg_dim, bg = p.bg_alt })
  hl("FoldColumn",   { fg = p.fg_muted, bg = bg_main })

  hl("WildMenu",     { fg = p.bg, bg = p.yamabuki_br })
  hl("QuickFixLine", { bg = p.bg_alt2 })

  -- ===========================================================================
  -- Syntax
  -- ===========================================================================
  hl("Comment",      { fg = p.fg_muted, italic = true })

  hl("Constant",     { fg = p.murasaki_br })
  hl("String",       { fg = p.yamabuki })
  hl("Character",    { fg = p.yamabuki })
  hl("Number",       { fg = p.murasaki_br })
  hl("Boolean",      { fg = p.murasaki_br, bold = true })
  hl("Float",        { fg = p.murasaki_br })

  hl("Identifier",   { fg = p.fg })
  hl("Function",     { fg = p.mizu, bold = true })

  hl("Statement",    { fg = p.enji_br })
  hl("Conditional",  { fg = p.enji_br })
  hl("Repeat",       { fg = p.enji_br })
  hl("Label",        { fg = p.enji_br })
  hl("Operator",     { fg = p.fuji_br })
  hl("Keyword",      { fg = p.enji_br, bold = true })
  hl("Exception",    { fg = p.enji_br, bold = true })

  hl("PreProc",      { fg = p.fuji_br })
  hl("Include",      { fg = p.fuji_br })
  hl("Define",       { fg = p.fuji_br })
  hl("Macro",        { fg = p.fuji_br })
  hl("PreCondit",    { fg = p.fuji_br })

  hl("Type",         { fg = p.yamabuki_br })
  hl("StorageClass", { fg = p.yamabuki_br })
  hl("Structure",    { fg = p.yamabuki_br })
  hl("Typedef",      { fg = p.yamabuki_br })

  hl("Special",      { fg = p.asagi })
  hl("SpecialChar",  { fg = p.asagi })
  hl("Tag",          { fg = p.enji_br })
  hl("Delimiter",    { fg = p.fg_dim })
  hl("SpecialComment", { fg = p.fg_muted, italic = true })
  hl("Debug",        { fg = p.err })

  hl("Underlined",   { underline = true, fg = p.mizu })
  hl("Ignore",       { fg = p.fg_muted })
  hl("Error",        { fg = p.err, bold = true })
  hl("Todo",         { fg = p.bg, bg = p.yamabuki_br, bold = true })

  -- ===========================================================================
  -- Treesitter (@captures)
  -- ===========================================================================
  hl("@variable",            { fg = p.fg })
  hl("@variable.builtin",    { fg = p.enji_br, italic = true })
  hl("@variable.parameter",  { fg = p.fg_dim })
  hl("@variable.member",     { fg = p.fuji_br })

  hl("@constant",            { fg = p.murasaki_br })
  hl("@constant.builtin",    { fg = p.murasaki_br, bold = true })
  hl("@string",              { fg = p.yamabuki })
  hl("@string.escape",       { fg = p.mizu })
  hl("@string.special",      { fg = p.asagi })
  hl("@character",           { fg = p.yamabuki })
  hl("@number",              { fg = p.murasaki_br })
  hl("@boolean",             { fg = p.murasaki_br, bold = true })

  hl("@function",            { fg = p.mizu, bold = true })
  hl("@function.builtin",    { fg = p.mizu, italic = true })
  hl("@function.call",       { fg = p.mizu })
  hl("@method",              { fg = p.mizu })
  hl("@method.call",         { fg = p.mizu })
  hl("@function.method",     { fg = p.mizu })
  hl("@function.method.call", { fg = p.mizu })
  hl("@constructor",         { fg = p.yamabuki_br })

  hl("@keyword",                       { fg = p.enji_br, bold = true })
  hl("@keyword.function",              { fg = p.enji_br })
  hl("@keyword.return",                { fg = p.enji_br, bold = true })
  hl("@keyword.operator",              { fg = p.fuji_br })
  hl("@keyword.modifier",              { fg = p.enji_br })
  hl("@keyword.type",                  { fg = p.enji_br })
  hl("@keyword.coroutine",             { fg = p.enji_br, bold = true })  -- co_await, co_yield, co_return
  hl("@keyword.exception",             { fg = p.enji_br, bold = true })  -- try, catch, throw, noexcept
  hl("@keyword.repeat",                { fg = p.enji_br })           -- for, while, do
  hl("@keyword.conditional",           { fg = p.enji_br })           -- if, else, switch, case
  hl("@keyword.conditional.ternary",   { fg = p.fuji_br })           -- ? :
  hl("@keyword.import",                { fg = p.fuji_br })           -- #include
  hl("@keyword.directive",             { fg = p.fuji_br })           -- #if, #ifdef, #endif, etc.
  hl("@keyword.directive.define",      { fg = p.fuji_br })           -- #define
  hl("@conditional",         { fg = p.enji_br })
  hl("@repeat",              { fg = p.enji_br })
  hl("@exception",           { fg = p.enji_br, bold = true })

  hl("@operator",            { fg = p.fuji_br })
  hl("@punctuation.delimiter", { fg = p.fg_dim })
  hl("@punctuation.bracket", { fg = p.fg_dim })
  hl("@punctuation.special", { fg = p.asagi })

  hl("@type",                { fg = p.yamabuki_br })
  hl("@type.builtin",        { fg = p.yamabuki_br, italic = true })
  hl("@type.qualifier",      { fg = p.enji_br })
  hl("@keyword.storage",     { fg = p.enji_br })
  hl("@attribute",           { fg = p.fuji_br })
  hl("@property",            { fg = p.fuji_br })
  hl("@namespace",           { fg = p.yamabuki_br })
  hl("@module",              { fg = p.yamabuki_br })

  hl("@comment",             { fg = p.fg_muted, italic = true })
  hl("@comment.todo",        { fg = p.bg, bg = p.yamabuki_br, bold = true })
  hl("@comment.error",       { fg = p.bg, bg = p.err, bold = true })
  hl("@tag",                 { fg = p.enji_br })
  hl("@tag.attribute",       { fg = p.fuji_br })
  hl("@tag.delimiter",       { fg = p.fg_dim })

  hl("@markup.heading",      { fg = p.yamabuki_br, bold = true })
  hl("@markup.strong",       { bold = true, fg = p.fg })
  hl("@markup.italic",       { italic = true, fg = p.fg_dim })
  hl("@markup.link",         { fg = p.mizu, underline = true })
  hl("@markup.link.url",     { fg = p.asagi, underline = true })
  hl("@markup.list",         { fg = p.enji_br })

  -- ===========================================================================
  -- LSP / Diagnostics
  -- ===========================================================================
  hl("DiagnosticError",            { fg = p.err })
  hl("DiagnosticWarn",             { fg = p.warn })
  hl("DiagnosticInfo",             { fg = p.info })
  hl("DiagnosticHint",             { fg = p.hint })
  hl("DiagnosticOk",               { fg = p.yanagi_br })

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
  hl("LspReferenceWrite", { bg = p.enji_deep })
  hl("LspInlayHint",      { fg = p.fg_muted, bg = transparent and p.none or p.bg_alt, italic = true })
  hl("LspSignatureActiveParameter", { fg = p.yamabuki_br, bold = true })

  -- ===========================================================================
  -- Diff / Git
  -- ===========================================================================
  hl("DiffAdd",    { fg = p.yanagi_br, bg = p.none })
  hl("DiffChange", { fg = p.yamabuki_br, bg = p.none })
  hl("DiffDelete", { fg = p.enji_br, bg = p.none })
  hl("DiffText",   { fg = p.mizu, bg = p.none, bold = true })

  hl("GitSignsAdd",    { fg = p.yanagi_br })
  hl("GitSignsChange", { fg = p.yamabuki_br })
  hl("GitSignsDelete", { fg = p.enji_br })

  -- ===========================================================================
  -- Telescope
  -- ===========================================================================
  hl("TelescopeNormal",       { fg = p.fg, bg = bg_float })
  hl("TelescopeBorder",       { fg = p.surface, bg = bg_float })
  hl("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hl("TelescopePromptBorder", { fg = p.surface, bg = p.bg_alt })
  hl("TelescopePromptPrefix", { fg = p.enji_br })
  hl("TelescopeSelection",    { fg = p.fg, bg = p.bg_alt2, bold = true })
  hl("TelescopeMatching",     { fg = p.mizu, bold = true })
  hl("TelescopeTitle",        { fg = p.yamabuki_br, bold = true })

  -- ===========================================================================
  -- nvim-cmp / blink.cmp
  -- ===========================================================================
  hl("CmpItemAbbrMatch",        { fg = p.mizu, bold = true })
  hl("CmpItemAbbrMatchFuzzy",   { fg = p.mizu, bold = true })
  hl("CmpItemKindFunction",     { fg = p.mizu })
  hl("CmpItemKindMethod",       { fg = p.mizu })
  hl("CmpItemKindVariable",     { fg = p.fg })
  hl("CmpItemKindKeyword",      { fg = p.enji_br })
  hl("CmpItemKindClass",        { fg = p.yamabuki_br })
  hl("CmpItemKindInterface",    { fg = p.yamabuki_br })
  hl("CmpItemKindText",         { fg = p.fg_dim })
  hl("CmpItemKindSnippet",      { fg = p.murasaki_br })

  -- ===========================================================================
  -- Misc plugin scaffolding
  -- ===========================================================================
  hl("NvimTreeNormal",     { fg = p.fg, bg = bg_float })
  hl("NvimTreeFolderIcon", { fg = p.yamabuki_br })
  hl("NvimTreeFolderName", { fg = p.fuji_br })
  hl("NvimTreeRootFolder", { fg = p.enji_br, bold = true })
  hl("NvimTreeOpenedFile", { fg = p.mizu })
  hl("NvimTreeIndentMarker", { fg = p.surface })

  hl("IndentBlanklineChar",        { fg = p.surface })
  hl("IndentBlanklineContextChar", { fg = p.enji })

  hl("WhichKeyFloat", { bg = bg_float })
  hl("WhichKey",       { fg = p.enji_br, bold = true })
  hl("WhichKeyGroup",  { fg = p.yamabuki_br })
  hl("WhichKeyDesc",   { fg = p.fg })
end

return M
